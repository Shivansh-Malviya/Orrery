"""
Antigravity PreToolCallDecideHook — BROS file ownership guard.

Deploy this to your Antigravity agent configuration as a
PreToolCallDecideHook to enforce BROS file locking on write-like tools.

Usage:
  from antigravity.hooks import register_hook
  register_hook( BrosFileOwnershipGuard() )

Requires:
  - $env:BROS_SYSTEM to point to the BROS installation root
  - file-locks.json at <BROS_SYSTEM>/hooks/state/file-locks.json
"""

import os
import json
import time
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


WRITE_LIKE_TOOLS = [
    "write",
    "create",
    "patch",
    "delete",
    "rename",
    "replace",
    "edit",
    "multi_replace",
    "apply_patch",
]


def _is_write_tool(tool_name: str) -> bool:
    lower = tool_name.lower()
    return any(token in lower for token in WRITE_LIKE_TOOLS)


def _extract_paths(tool_args: dict) -> list[str]:
    """Recursively extract absolute paths from tool arguments."""
    paths: list[str] = []
    seen: set[int] = set()

    def _walk(value: Any) -> None:
        if id(value) in seen:
            return
        seen.add(id(value))

        if isinstance(value, str):
            # Match Windows absolute paths (e.g., C:\, F:\)
            if value.startswith("/") or (len(value) > 2 and value[1] == ":"):
                try:
                    p = Path(value)
                    if p.is_absolute():
                        paths.append(str(p.resolve()))
                except Exception:
                    pass
        elif isinstance(value, dict):
            for v in value.values():
                _walk(v)
        elif isinstance(value, (list, tuple)):
            for item in value:
                _walk(item)

    _walk(tool_args)
    return paths


def _load_locks(lock_file: Path) -> dict:
    if not lock_file.exists():
        return {}
    try:
        data = lock_file.read_text(encoding="utf-8")
        return json.loads(data) if data.strip() else {}
    except (json.JSONDecodeError, OSError):
        return {}


def _save_locks(lock_file: Path, locks: dict) -> None:
    lock_file.parent.mkdir(parents=True, exist_ok=True)
    lock_file.write_text(
        json.dumps(locks, indent=2, default=str),
        encoding="utf-8",
    )


class BrosFileOwnershipGuard:
    """Antigravity PreToolCallDecideHook for BROS file locking."""

    TTL_MINUTES = 120
    LOCK_FILE_REL = "hooks/state/file-locks.json"

    def __init__(self):
        bros_root = os.environ.get("BROS_SYSTEM")
        if not bros_root:
            raise RuntimeError(
                "BROS_SYSTEM environment variable not set. "
                "Cannot initialize file ownership guard."
            )
        self.bros_root = Path(bros_root).resolve()
        self.lock_file = self.bros_root / self.LOCK_FILE_REL

    def __call__(self, context: Any) -> dict:
        """
        Hook entry point. Called by Antigravity before tool execution.

        Returns a dict with:
          - allow: bool
          - reason: str
          - message: str (optional, shown to user)
        """
        tool_name = getattr(context, "tool_name", "") or ""
        if not _is_write_tool(tool_name):
            return {
                "allow": True,
                "reason": "Non-write tool; file ownership guard not required.",
            }

        tool_args = getattr(context, "tool_args", {}) or {}
        paths = _extract_paths(tool_args)

        # Filter to BROS-scoped paths
        bros_paths = []
        for p in paths:
            try:
                pp = Path(p).resolve()
                if str(pp).startswith(str(self.bros_root)):
                    bros_paths.append(str(pp))
            except Exception:
                continue

        if not bros_paths:
            return {
                "allow": True,
                "reason": "No BROS-scoped file paths found in tool payload.",
            }

        session_id = getattr(context, "session_id", "") or ""
        if not session_id:
            session_id = f"unknown-session-{os.environ.get('USER', 'unknown')}"

        locks = _load_locks(self.lock_file)
        now = datetime.now(timezone.utc)
        conflicts = []

        for path in bros_paths:
            key = path.lower()
            existing = locks.get(key)
            if existing:
                owner = existing.get("owner", "")
                updated_str = existing.get("updatedUtc", "")
                is_active = False
                if updated_str:
                    try:
                        updated = datetime.fromisoformat(updated_str)
                        if (now - updated).total_seconds() / 60 <= self.TTL_MINUTES:
                            is_active = True
                    except ValueError:
                        pass
                if is_active and owner and owner != session_id:
                    conflicts.append(f"{path} (owned by {owner})")
                    continue

            locks[key] = {
                "owner": session_id,
                "updatedUtc": now.isoformat(),
                "tool": tool_name,
            }

        if conflicts:
            return {
                "allow": False,
                "reason": f"Potential concurrent edit detected: {'; '.join(conflicts)}",
                "message": (
                    f"File ownership conflict: "
                    f"{'; '.join(conflicts)}. "
                    f"Confirm before mutating these files."
                ),
            }

        _save_locks(self.lock_file, locks)
        return {
            "allow": True,
            "reason": "No active conflicting file ownership detected.",
        }
