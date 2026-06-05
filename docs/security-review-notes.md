# Security review notes

Use these notes before merging small security-adjacent documentation or template changes.

## Review focus

- Check that no secrets, tokens, logs or private data were added.
- Avoid documenting real credentials or private infrastructure.
- Keep examples generic and safe.
- Prefer least-privilege wording in setup notes.
- Flag risky changes for a separate review.

## Before merge

- Review the changed file list.
- Confirm that CI has passed.
- Confirm that the pull request scope matches the title.
- Leave larger hardening work for a dedicated branch.
