# Change scope checklist

Use this checklist before opening a small maintenance pull request.

## Scope questions

- Does the change have one clear purpose?
- Are all changed files related to that purpose?
- Can the change be reviewed without extra context?
- Would splitting the change make review safer?

## Keep out of scope

- Unrelated formatting changes.
- Opportunistic cleanup in files not touched by the main change.
- Experimental automation.
- Personal notes, secrets, tokens, or environment-specific data.

## Ready to submit

- The branch name matches the change.
- The commit message describes the change.
- The pull request body states the scope clearly.
- The final diff is small enough to audit.
