#!/bin/sh
set -euo pipefail

WORKING_BRANCH="$1"

# WCP="$(jj log --no-graph -r @ -T 'parents.map(|c| "-d " ++ c.commit_id().short()).join(" ")')"

if [ -n "$(jj diff --summary)" ]; then
  jj squash --into private_env .envrc shell.nix .helix push.sh
fi

if [ -n "$(jj diff --summary)" ]; then
  jj squash --into "$WORKING_BRANCH"
fi

for remote in "${@:2}"; do
  jj git push --config git.sign-on-push=false --remote "$remote" --allow-empty-description --allow-private --all --deleted
  ssh "$remote" "cd src/lalamo && jj rebase -r @ -d private_env -d $WORKING_BRANCH"
done
