# Cloud start skill addition

Add this repository (`garymjr/agents-home`) to the environment's repositories, then
prepend the following instructions to its existing Start skill. Preserve the
environment's existing service startup and readiness checks.

---

Before working on the task, load Gary's shared agent instructions:

```bash
bash /workspace/agents-home/scripts/load.sh
```

Read the full command output and apply the shared `AGENTS.md` as user-maintained
defaults, subject to higher-priority instructions. Then read the applicable
repository and directory `AGENTS.md` files for the task; their more specific
guidance takes precedence over the shared defaults.

If the loader fails, report the error and resolve access or configuration before
continuing work that depends on these instructions. Do not silently substitute a
previous snapshot.

If asked which shared instructions were loaded, report the revision printed by
the loader and the document title from the file.

---

The checkout path above assumes the repository is at `/workspace/agents-home`.
Adjust it to the environment's actual checkout path when configuring the skill.
