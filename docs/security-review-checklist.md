# Security review checklist

Use this checklist when reviewing small documentation or maintenance changes.

## Basic checks

- Confirm that no secrets were added.
- Confirm that no personal data was added.
- Confirm that no machine-specific paths are required.
- Confirm that no token, password, or private key appears in the diff.

## Process checks

- Confirm that the pull request scope is clear.
- Confirm that security-sensitive changes are not hidden in cleanup.
- Confirm that examples use placeholder values only.
- Confirm that follow-up risks are documented instead of ignored.

## Final review

- Review the final diff before approval.
- Keep security review separate from cosmetic changes.
- Do not approve unclear changes just because they are small.
- Leave the repository safer and easier to audit.
