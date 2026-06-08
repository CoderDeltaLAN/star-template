# CI review notes

Use these notes when reviewing pull requests that depend on automated checks.

## Before relying on CI

- Confirm that the workflow belongs to the expected repository.
- Confirm that the workflow ran for the current pull request head.
- Confirm that the commit SHA matches the reviewed change.
- Confirm that no required check is still pending.

## Review limits

- Passing CI does not replace human review.
- Passing CI does not prove that the change is correct.
- Passing CI only confirms the checks that are actually configured.
- Missing checks should be treated as a process gap, not as approval.

## Merge guidance

- Do not merge while required checks are pending.
- Do not merge when the reviewed commit has changed unexpectedly.
- Keep the CI trail clear enough for future maintainers to audit.
