# Fork maintenance notes

Use these notes when maintaining a fork that is used for small pull requests.

## Keep the fork aligned

- Fetch the upstream main branch before starting new work.
- Create each pull request branch from the current upstream main branch.
- Avoid stacking unrelated pull requests on top of older branches.
- Keep the fork available while recent collaboration history is being reviewed.

## Before opening a pull request

- Confirm that the branch contains only the intended commit.
- Confirm that the pull request targets the upstream main branch.
- Confirm that the branch name describes the change.
- Confirm that no local-only files were included.

## After merge

- Update from upstream main before starting another branch.
- Clean old branches only after the merge is verified.
- Do not delete fork history while contribution tracking is still settling.
