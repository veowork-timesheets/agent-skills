#!/usr/bin/env bash
set -euo pipefail

repository=veowork-timesheets/agent-skills
tag_pattern='^v[1-9][0-9]{3}\.([1-9]|1[0-2])\.([1-9]|[12][0-9]|3[01])[0-9]$'
origin_pattern="^(https://github\.com/|git@github\.com:|ssh://git@github\.com/)$repository(\.git)?$"
usage='Usage: npm run release -- v2026.11.231'

fail() {
  printf '%s\n' "$*" >&2
  exit 1
}

if [[ ${1:-} == --help && $# == 1 ]]; then
  printf '%s\n' "$usage"
  exit 0
fi
if [[ $# != 1 || ! $1 =~ $tag_pattern ]]; then
  printf '%s\n' "$usage" >&2
  fail 'Use the Marketplace date-based tag format.'
fi

release_tag=$1
tag_ref=refs/tags/$release_tag
cd "$(dirname "$0")/.."

command -v gh >/dev/null || fail 'Install GitHub CLI before releasing.'
[[ $(git symbolic-ref --quiet --short HEAD) == main ]] || fail 'Switch to main before releasing.'
worktree_status=$(git status --porcelain)
[[ -z $worktree_status ]] || fail 'Commit your changes before releasing.'

release_version=${release_tag#v}
plugin_version=$(node -p 'require("./plugin.json").version')
[[ $plugin_version == "$release_version" ]] ||
  fail "Set the version in plugin.json to $release_version before releasing (found $plugin_version)."

fetch_url=$(git remote get-url --all origin)
push_url=$(git remote get-url --push --all origin)
[[ $fetch_url =~ $origin_pattern && $push_url =~ $origin_pattern ]] ||
  fail "Set origin to the $repository GitHub repository before releasing."

head_commit=$(git rev-parse --verify HEAD)
remote_refs=$(git ls-remote origin refs/heads/main "$tag_ref" "$tag_ref^{}")
remote_ref() {
  awk -v ref="$1" '$2 == ref { print $1 }' <<< "$remote_refs"
}

[[ $(remote_ref refs/heads/main) == "$head_commit" ]] ||
  fail 'Local main must match origin/main. Sync main before releasing.'

# Prefer the commit behind an annotated tag. A lightweight tag points there directly.
remote_commit=$(remote_ref "$tag_ref^{}")
remote_commit=${remote_commit:-$(remote_ref "$tag_ref")}
[[ -z $remote_commit || $remote_commit == "$head_commit" ]] ||
  fail "Remote tag $release_tag already points to a different commit."

if git show-ref --verify --quiet "$tag_ref"; then
  [[ $(git rev-parse --verify "$tag_ref^{commit}") == "$head_commit" ]] ||
    fail "Local tag $release_tag already points to a different commit."
elif [[ -z $remote_commit ]]; then
  git tag -a "$release_tag" "$head_commit" -m "VeoWork Agent Skills $release_tag"
fi

if [[ -z $remote_commit ]]; then
  git push --no-follow-tags origin "$tag_ref"
fi

gh release create "$release_tag" --repo "github.com/$repository" --verify-tag --latest \
  --title "VeoWork Agent Skills $release_tag" --generate-notes
