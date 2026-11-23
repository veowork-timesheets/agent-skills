# Install VeoWork Timesheets in GitHub Copilot

The VeoWork Timesheets plugin bundles the MCP connection and both skills. Use a local Copilot session and an Azure DevOps Services organization with VeoWork Timesheets access.

## VS Code

[Install VeoWork Timesheets in VS Code](https://vscode.dev/redirect?url=vscode%3A%2F%2Fchat-plugin%2Finstall%3Fsource%3Dveowork-timesheets%252Fagent-skills%26plugin%3Dveowork-timesheets) and confirm the installation in the Copilot agent harness. If the link is unavailable, open **Agent Customizations**, add `veowork-timesheets/agent-skills` as a marketplace, and install `veowork-timesheets`. [VS Code plugin guide](https://code.visualstudio.com/docs/agent-customization/agent-plugins)

## Copilot CLI

Register the VeoWork Timesheets marketplace once, then install the plugin.

```sh
copilot plugin marketplace add veowork-timesheets/agent-skills
copilot plugin install veowork-timesheets@veowork-timesheets
```

CLI versions that still support direct installs also accept `copilot plugin install veowork-timesheets/agent-skills`. [Copilot CLI plugin guide](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/plugins-finding-installing)

## GitHub Copilot desktop app

Open **Customize** and use the settings control next to the marketplace dropdown to add `https://github.com/veowork-timesheets/agent-skills`. In **Browse**, find `veowork-timesheets` in the `veowork-timesheets` marketplace and select **Install**. [GitHub Copilot app guide](https://docs.github.com/en/copilot/how-tos/github-copilot-app/customize-github-copilot-app#adding-a-plugin-marketplace)

## Sign in to VeoWork

Start a new Copilot session and ask, “Use VeoWork to review my timesheet for last week.” Follow any prompts to enable the server and sign in with Microsoft, then choose the Azure DevOps organization you want to connect. If the CLI shows that the server needs authentication, find its name in `/mcp` and run `/mcp auth <server-name>`. Each connection is scoped to one organization and uses your VeoWork permissions. [Copilot CLI MCP commands](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-command-reference#oauth-re-authentication)

If you previously set up VeoWork in Copilot by hand, disable your standalone VeoWork MCP entry and move the standalone VeoWork skill folders out of Copilot’s skill search paths. Start a new session and sign in to the plugin’s connection.

## Manual MCP setup in VS Code

You can [install the skills separately](../README.md#install-the-skills) and add the MCP server from the Command Palette.

1. Open a workspace and select **Copilot** as the session target in Chat.
2. Run **MCP: Add Server** from the Command Palette. Choose **HTTP (HTTP or Server-Sent Events)** and enter `https://mcp.veowork.io/mcp`.
3. Enter `veowork` as the server ID. Choose **Global**, then **Copilot Global** if prompted.
4. Open a new Copilot chat and ask, “Use VeoWork to review my timesheet for last week.” Follow any prompts to start the server and sign in, then confirm that Copilot calls a VeoWork tool.
