"""
Antigravity PreToolCallDecideHook — BROS commit attribution guard.

Validates that git commit commands include:
  - Platform prefix (AG- for Antigravity)
  - Actor attribution (implemented-by / reviewed-by)

Deploy this to your Antigravity agent configuration:
  from antigravity.hooks import register_hook
  register_hook( BrosCommitGuard() )
"""

import os
import re
from typing import Any


def _detect_platform() -> str:
    """Detect which platform agent is running."""
    if os.environ.get("ANTIGRAVITY_TRAJECTORY_ID") or os.environ.get(
        "ANTIGRAVITY_EDITOR_APP_ROOT"
    ):
        return "AG"
    if os.environ.get("VSCODE_PID"):
        return "VSC"
    return "U"


class BrosCommitGuard:
    """Validates commit messages meet BROS attribution standards."""

    def __call__(self, context: Any) -> dict:
        tool_name = getattr(context, "tool_name", "") or ""
        tool_lower = tool_name.lower()

        # Only check git commit tools
        if "commit" not in tool_lower and "git" not in tool_lower:
            return {"allow": True, "reason": "Not a git commit tool."}

        tool_args = getattr(context, "tool_args", {}) or {}
        payload_str = json.dumps(tool_args) if "json" in dir() else str(tool_args)
        lower = payload_str.lower()

        # Check for attribution
        has_attribution = bool(
            re.search(
                r"implemented-by|reviewed-by|co-authored-by|by\s*:",
                lower,
            )
        )

        platform = _detect_platform()
        has_prefix = bool(
            re.search(rf"git\s+commit[^\n]*\-m\s+.*\b{platform}-", payload_str)
        )

        issues = []
        if not has_attribution:
            issues.append("missing actor attribution (implemented-by/reviewed-by)")
        if not has_prefix:
            issues.append(
                f"commit subject should start with {platform}- for this platform"
            )

        if issues:
            return {
                "allow": True,  # Advisory, not blocking
                "reason": f"Commit guard advisory: {'; '.join(issues)}",
                "message": f"Commit issue: {'; '.join(issues)}",
            }

        return {"allow": True, "reason": "Commit guard checks passed."}
