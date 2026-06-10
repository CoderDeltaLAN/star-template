# Dependency review notes

Use these notes when reviewing small dependency or tooling updates.

## Before changing dependencies

- Confirm why the dependency change is needed.
- Confirm whether the change affects runtime, tests, or documentation only.
- Confirm that the update does not introduce unrelated files.
- Confirm that the lockfile change matches the dependency change.

## Review focus

- Check the source and purpose of the dependency.
- Check whether the update changes supported versions.
- Check whether the change affects install or build commands.
- Check whether documentation needs to mention the update.

## Follow-up

- Keep dependency updates separate from feature work.
- Record any manual verification that was needed.
- Do not hide security-sensitive changes inside routine cleanup.
- Leave the repository easy to audit after the update.
