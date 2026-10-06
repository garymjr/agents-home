# agents-home

One canonical [`AGENTS.md`](AGENTS.md) for Gary's Codex agents. Edit that file to
change shared guidance; keep project-specific instructions in project repositories.

## Connect a cloud environment

1. Open **Settings > Codex Cloud > Environments** and edit the environment.
2. Add `garymjr/agents-home` to its repositories so the loader is available.
3. Prepend the instructions in [`cloud/START.md`](cloud/START.md) to the existing
   **Start skill**, preserving its service startup steps. Adjust the checkout path
   if necessary.
4. Test the loader in the configuration workspace, then save and republish the
   environment through the configuration workflow.
5. Start a fresh cloud task and ask: "Which shared instructions revision did you
   load?" Confirm the task ran the loader, reports the expected commit, and
   identifies the document title, `Gary’s Agent Guidance`.

Repeat this one-time connection for each environment, including new ones.
Initializing this repository alone does not connect existing environments.

## How loading works

[`scripts/load.sh`](scripts/load.sh) fetches the current `main` from GitHub in a
temporary Git repository. It writes an atomic snapshot to
`/workspace/shared/agents-home/AGENTS.md` and prints the full instructions with
their commit revision so the Start skill can explicitly read and apply them.
Git, Bash, read access to this repository, and write access to the snapshot
directory are required. The repository is currently public; no new credential is
needed to read it. Restricted environments must allow access to `github.com`.

Fetching occurs when the Start skill runs. It avoids relying on an install script
rerunning or the snapshot of files captured when an environment was published.
Changes to `AGENTS.md` on `main` are picked up on the next loader invocation;
already-running tasks retain what they read until explicitly refreshed. Changes
to the loader or Start skill itself should be retested and republished as needed.

A failed fetch, missing file, or empty file exits unsuccessfully before printing
instructions. The Start skill must report that failure instead of proceeding
with a stale snapshot. The loader does not modify project checkouts.

Optional environment variables:

| Variable | Default | Purpose |
| --- | --- | --- |
| `AGENTS_HOME_REPOSITORY` | `https://github.com/garymjr/agents-home.git` | Source Git repository |
| `AGENTS_HOME_REF` | `refs/heads/main` | Branch or other fetchable Git ref; use a full ref to pin a tag |
| `AGENTS_HOME_SNAPSHOT_DIRECTORY` | `/workspace/shared/agents-home` | Directory for the instruction snapshot |

## Local Codex

For local Codex, install a copy of the canonical `AGENTS.md` into the active Codex
home, `${CODEX_HOME:-$HOME/.codex}/AGENTS.md`. Review and preserve any existing
instructions first. An `AGENTS.override.md` there can take precedence. Start a new
Codex session after updating the file.

The cloud loader uses explicit reading through the Start skill. It does not assume
that a remote cloud harness automatically discovers the executor's `CODEX_HOME`,
and it does not change that runtime variable or overwrite files there.

## References

- [Codex instruction discovery](https://learn.chatgpt.com/docs/agent-configuration/agents-md)
- [Cloud environment setup and saved state](https://learn.chatgpt.com/docs/environments/cloud-environments)
