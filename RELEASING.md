# Releasing VeoWork Agent Skills

## Publish a tagged release

Maintainers need GitHub CLI access to push tags and publish releases. Commit the release files and push `main` before running the release command.

```sh
npm run release -- v2026.11.231
```

The command checks that the plugin version matches the tag and that your clean local `main` matches `origin/main`. It then pushes an annotated tag and creates the GitHub release with generated notes. If creating the release fails after the tag is pushed, rerun the same command from the same commit on `main`.

## Verify the Copilot plugin

The repository also serves as the portable Agent Plugins package. The format expects `plugin.json`, `mcp.json`, and `skills/` at the package root, so the marketplace entry points to `./` and packages the existing skill folders directly. [Agent Plugins layout](https://code.visualstudio.com/docs/agents/reference/agent-plugin-reference#_package-structure)

Validate the root manifests against the Agent Plugins 1.0 [plugin schema](https://agent-plugins.org/schemas/1.0.0/plugin.schema.json) and [MCP schema](https://agent-plugins.org/schemas/1.0.0/mcp.schema.json). Confirm the marketplace entry resolves to the repository root and the install includes both skill folders with their license and reference files.

Use a clean configuration in VS Code, Copilot CLI, and the GitHub Copilot desktop app. Install the proposed checkout or use a test marketplace that resolves to the proposed revision. Check that both skills and one VeoWork MCP server appear. Complete Microsoft sign-in with a VeoWork test organization, then ask Copilot to find yesterday’s active work items and review last week’s timesheet. Confirm that both prompts call VeoWork read tools. Record each client version, sign-in result, and workflow result in the pull request before merging.

The [Copilot install guide](docs/github-copilot.md) uses the repository’s default branch. Once the changes merge, include the plugin in the next tagged release.
