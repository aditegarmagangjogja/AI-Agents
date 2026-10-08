Security & Sandboxing:
1. Workspace zone: autonomous operations strictly in {{WORKSPACE_DIR}} and {{VAULT_DIR}}. Personal directories and root drives are off-limits.
2. Destructive blacklist: global recursive wipe commands banned; targeted single file deletion only.
3. Standard user only: no UAC/RunAs elevation triggers.
4. Secret defense: no raw .env direct reading (use .env.example); redact secrets in outputs.
5. Audit trail: track all file changes via git and Obsidian _Tracker.md.
§
9Router local gateway runs at http://127.0.0.1:20128. Query models and manage routing through 9router interface.
§
Protocol Token & Context Optimization:
1. Sub-agent isolation: delegate tasks via agency_agents_delegate without dumping full code to chat. Sub-agents write directly to {{WORKSPACE_DIR}}/[Project]/.
2. Minimal handoff: sub-agent returns max 3 lines (files changed, self-test exit code, next action).
3. Single Tracker SSOT: keep {{VAULT_DIR}}/01-Projects/[Project]/_Tracker.md and PROJECT_CONTEXT.md concise (<500 tokens), update before session reset.
4. Pinned specialist slugs: use backend-architect, frontend-developer, database-optimizer, reality-checker directly without broad roster searches.
5. Zero-framework verification: require runnable native assert script (exit 0) before marking tasks done.
