# Releasing VeoWork Agent Skills

Maintainers need GitHub CLI access to push tags and publish releases. Commit the release files and push `main` before running the release command.

```sh
npm run release -- v2026.11.191
```

Use the Marketplace date-based tag for the version you intend to publish. For example, `v2026.11.191` is November 19, 2026, revision 1. The command checks that your clean local `main` matches `origin/main`, then pushes an annotated tag and creates the GitHub release with generated notes. If creating the release fails after the tag is pushed, rerun the same command from the same commit on `main`.
