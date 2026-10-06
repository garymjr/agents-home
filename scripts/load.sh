#!/usr/bin/env bash
set -euo pipefail

repository=${AGENTS_HOME_REPOSITORY:-https://github.com/garymjr/agents-home.git}
ref=${AGENTS_HOME_REF:-refs/heads/main}
snapshot_directory=${AGENTS_HOME_SNAPSHOT_DIRECTORY:-/workspace/shared/agents-home}
temporary_directory=$(mktemp -d)
snapshot_temporary_file=

cleanup() {
  rm -rf -- "$temporary_directory"
  if [[ -n "$snapshot_temporary_file" ]]; then
    rm -f -- "$snapshot_temporary_file"
  fi
}
trap cleanup EXIT

git init --quiet "$temporary_directory"
git -C "$temporary_directory" fetch --quiet --depth=1 --no-tags "$repository" "$ref"
revision=$(git -C "$temporary_directory" rev-parse --verify FETCH_HEAD)
git -C "$temporary_directory" show "$revision:AGENTS.md" > "$temporary_directory/AGENTS.md"
if [[ ! -s "$temporary_directory/AGENTS.md" ]]; then
  printf 'Shared AGENTS.md is empty; instructions were not loaded.\n' >&2
  exit 1
fi

mkdir -p -- "$snapshot_directory"
snapshot_temporary_file=$(mktemp "$snapshot_directory/.AGENTS.md.XXXXXX")
cat "$temporary_directory/AGENTS.md" > "$snapshot_temporary_file"
chmod 0644 "$snapshot_temporary_file"
mv -f -- "$snapshot_temporary_file" "$snapshot_directory/AGENTS.md"
snapshot_temporary_file=

printf 'Shared instructions revision: %s\n' "$revision"
printf 'Shared instructions snapshot: %s/AGENTS.md\n\n' "$snapshot_directory"
cat "$snapshot_directory/AGENTS.md"
