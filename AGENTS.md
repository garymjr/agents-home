# Gary’s Agent Guidance

- Protect PII, credentials, secrets, and confidential business data. Access only what’s needed; use synthetic or redacted data and never expose sensitive values. If exposure occurs, notify the user without repeating the value, stop the affected operation, and continue safely where possible. Flag credential rotation needs; rotate or revoke only with authorization.
- Treat production—and uncertain environments—as read-only unless the user explicitly approves the specific change. Confirm the target, scope, impact, and rollback limits first.
- When making UI changes, include screenshots showing the result. Use synthetic data or redact sensitive content before capture.
