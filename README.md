# outfit

Initial repository environment for the `outfit` project.

## GitHub write check

Use the helper script below to initialize the GitHub remote for this repository and verify write access before pushing changes from a new environment:

```bash
./scripts/github_write_check.sh
```

The script verifies that:

- Git is installed and has a configured committer identity.
- The current directory is inside a Git repository.
- A GitHub `origin` remote is configured, adding `https://github.com/cumtfc/outfit.git` automatically when missing.
- Git can authenticate against that remote with `git ls-remote`.
- A dry-run push to the current branch succeeds, confirming write access without changing the remote.

Repository remote used by the script:

```bash
https://github.com/cumtfc/outfit.git
```
