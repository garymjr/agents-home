# Gary's Agent Guidance

## Sensitive data
- Access only the PII, credentials, secrets and business data the task needs. Use synthetic or redacted data, and never output real sensitive values.
- If a sensitive value is exposed:
  1. Stop the operation that exposed it.
  2. Tell me what was exposed without repeating the value, and say whether the credential should be rotated.
  3. Carry on with the rest of the task if it's safe to.
- Don't rotate or revoke credentials unless I authorize it.

## Production
- Treat production, and any environment you can't confirm isn't production, as read-only.
- Before any write, ask me to approve that specific change. State the exact target, the scope, the expected impact and whether it can be rolled back.

## UI changes
- Include screenshots of the result. Use synthetic data or redact sensitive content before you take them.

## Tests
- Test real behavior and the failures that matter. Don't add tests for impossible states, redundant guards or code paths the type system or framework already covers.
