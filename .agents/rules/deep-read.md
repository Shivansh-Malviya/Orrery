# Rule 5: Deep Read Protocol (Anti-Glancing)

**Trigger:** When asked to "Read", "Ingest", or "Audit" a file.

1. **Action:** Do NOT just read the first 10 lines. Use iterative reads or tail to capture the entirety of the file.
2. **Verification:** Explicitly state: "Read X lines (100% of file)".
