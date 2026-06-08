#!/usr/bin/env python3
"""Run a command and emit a JSON evidence record.

Usage:
  python tools/evidence_capture.py --claim-id C1 --evidence-id E1 --cwd . -- <command> [args...]

The script is intentionally dependency-free. It only runs the command supplied by the operator; use read-only verification commands unless a destructive check is explicitly authorized.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import shlex
import subprocess
import sys
import time
from datetime import datetime, timezone
from typing import Sequence


def sha256_text(text: str) -> str:
    return hashlib.sha256(text.encode("utf-8", errors="replace")).hexdigest()


def utc_now() -> str:
    return datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def run_command(command: Sequence[str], cwd: str | None, timeout: float | None) -> dict:
    started = time.monotonic()
    try:
        completed = subprocess.run(
            list(command),
            cwd=cwd,
            text=True,
            capture_output=True,
            timeout=timeout,
            check=False,
        )
        duration = time.monotonic() - started
        return {
            "exit_code": completed.returncode,
            "stdout": completed.stdout,
            "stderr": completed.stderr,
            "duration_seconds": round(duration, 4),
            "timed_out": False,
            "execution_error": None,
        }
    except subprocess.TimeoutExpired as exc:
        duration = time.monotonic() - started
        stdout = exc.stdout or ""
        stderr = exc.stderr or ""
        if isinstance(stdout, bytes):
            stdout = stdout.decode("utf-8", errors="replace")
        if isinstance(stderr, bytes):
            stderr = stderr.decode("utf-8", errors="replace")
        return {
            "exit_code": None,
            "stdout": stdout,
            "stderr": stderr + f"\nTIMEOUT after {timeout} seconds",
            "duration_seconds": round(duration, 4),
            "timed_out": True,
            "execution_error": None,
        }
    except OSError as exc:
        duration = time.monotonic() - started
        return {
            "exit_code": None,
            "stdout": "",
            "stderr": f"EXECUTION_ERROR: {exc.__class__.__name__}: {exc}",
            "duration_seconds": round(duration, 4),
            "timed_out": False,
            "execution_error": exc.__class__.__name__,
        }


def main(argv: Sequence[str]) -> int:
    parser = argparse.ArgumentParser(description="Capture command evidence as JSON")
    parser.add_argument("--claim-id", required=True)
    parser.add_argument("--evidence-id", required=True)
    parser.add_argument("--cwd", default=os.getcwd())
    parser.add_argument("--timeout", type=float, default=120.0)
    parser.add_argument("--source", default=None, help="Override source field. Defaults to exact command.")
    parser.add_argument("--omit-raw-output", action="store_true", help="Emit hashes and summaries but omit raw stdout/stderr fields.")
    parser.add_argument("--max-raw-chars", type=int, default=200000, help="Maximum raw characters to include per stream when raw output is emitted.")
    parser.add_argument("command", nargs=argparse.REMAINDER)
    args = parser.parse_args(argv)

    command = args.command
    if command and command[0] == "--":
        command = command[1:]
    if not command:
        parser.error("command is required after --")
    if args.max_raw_chars < 0:
        parser.error("--max-raw-chars must be non-negative")

    cwd = os.path.abspath(args.cwd)
    exact_command = shlex.join(command)
    result = run_command(command, cwd=cwd, timeout=args.timeout)

    stdout = result["stdout"]
    stderr = result["stderr"]
    exit_code = result["exit_code"]

    record = {
        "evidence_id": args.evidence_id,
        "claim_id": args.claim_id,
        "type": "command",
        "source": args.source or exact_command,
        "locator": "n/a",
        "method": "local command execution via tools/evidence_capture.py",
        "captured_at_utc": utc_now(),
        "result_summary": "command timed out" if result["timed_out"] else f"command exited with {exit_code}",
        "raw_output_sha256": sha256_text(stdout + "\n--- STDERR ---\n" + stderr),
        "stable_pointer": None,
        "limitations": "Command output proves only this execution in this cwd/environment. It does not prove semantic correctness beyond the selected check.",
        "command": {
            "cwd": cwd,
            "exact_command": exact_command,
            "argv": list(command),
            "exit_code": exit_code,
            "stdout_sha256": sha256_text(stdout),
            "stderr_sha256": sha256_text(stderr),
            "duration_seconds": result["duration_seconds"],
        },
        "omitted_raw_output": bool(args.omit_raw_output),
    }

    if not args.omit_raw_output:
        record["stdout"] = stdout[: args.max_raw_chars]
        record["stderr"] = stderr[: args.max_raw_chars]
        if len(stdout) > args.max_raw_chars or len(stderr) > args.max_raw_chars:
            record["limitations"] += " Raw output was truncated in the evidence record, but hashes cover the full streams."

    if result.get("execution_error"):
        record["result_summary"] = f"command could not execute: {result['execution_error']}"


    print(json.dumps(record, indent=2, ensure_ascii=False))
    return 124 if result["timed_out"] else (exit_code if isinstance(exit_code, int) else 1)


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
