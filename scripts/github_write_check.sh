#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '[github-write-check] %s\n' "$*"
}

fail() {
  printf '[github-write-check] ERROR: %s\n' "$*" >&2
  exit 1
}

DEFAULT_REMOTE_URL='https://github.com/cumtfc/outfit.git'

command -v git >/dev/null 2>&1 || fail 'git is not installed or is not on PATH'

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || fail 'current directory is not inside a Git repository'

git config user.name >/dev/null 2>&1 || fail 'git user.name is not configured'
git config user.email >/dev/null 2>&1 || fail 'git user.email is not configured'

origin_url="$(git remote get-url origin 2>/dev/null || true)"
if [[ -z "$origin_url" ]]; then
  log "origin remote is not configured; adding $DEFAULT_REMOTE_URL"
  git remote add origin "$DEFAULT_REMOTE_URL"
  origin_url="$DEFAULT_REMOTE_URL"
fi

branch="$(git branch --show-current)"
[[ -n "$branch" ]] || fail 'current HEAD is detached; checkout a branch before checking write access'

log "origin: $origin_url"
log "branch: $branch"

log 'checking remote authentication with git ls-remote'
git ls-remote --exit-code origin HEAD >/dev/null || fail 'cannot read from origin; check credentials and remote URL'

log 'checking write access with a dry-run push'
git push --dry-run origin "HEAD:$branch" >/dev/null || fail 'dry-run push failed; check GitHub write permissions for this repository'

log 'GitHub write access check passed'
