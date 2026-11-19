# VeoWork Timesheets Agent Skills

[VeoWork Timesheets](https://marketplace.visualstudio.com/items?itemName=VeoWork.timesheets) is an Azure DevOps extension for time tracking, timesheet approvals, budgets, and reporting. Your team can enter time in calendar and timesheet views or connect an AI assistant to help prepare and review timesheets. [Learn more about VeoWork Timesheets](https://veowork.io/).

These skills use VeoWork’s Model Context Protocol (MCP) server. Your AI assistant follows saved VeoWork instructions and works within your existing permissions.

- [Log time](skills/veowork-log-time/SKILL.md) helps you find the work items you were active on and fill gaps in your timesheet while preserving the time you already logged.
- [Timesheet approvals](skills/veowork-timesheet-approvals/SKILL.md) helps you review and submit your own timesheets or withdraw a submission. Approval managers can flag entries that need follow-up, approve submissions, or reopen timesheets.

## Install the skills

Choose one method and run the command for your client. Both CLI installers make the skills available across your projects.

### With npx

If you have Node.js and npm, use the [Vercel skills CLI](https://github.com/vercel-labs/skills/blob/main/docs/commands.md#skills-add).

```sh
# Codex
npx skills add veowork-timesheets/agent-skills --global --agent codex --skill '*'

# Claude Code
npx skills add veowork-timesheets/agent-skills --global --agent claude-code --skill '*'

# GitHub Copilot in VS Code
npx skills add veowork-timesheets/agent-skills --global --agent github-copilot --skill '*'
```

### With GitHub CLI

Use a [version of GitHub CLI that supports `gh skill install`](https://cli.github.com/manual/gh_skill_install).

```sh
# Codex
gh skill install veowork-timesheets/agent-skills --all --agent codex --scope user

# Claude Code
gh skill install veowork-timesheets/agent-skills --all --agent claude-code --scope user

# GitHub Copilot in VS Code
gh skill install veowork-timesheets/agent-skills --all --agent github-copilot --scope user
```

### Manual installation

Download the source archive for the latest release from the [release page](https://github.com/veowork-timesheets/agent-skills/releases). Copy both complete folders from `skills/` into your client's personal skills directory. Keep the reference files and license notices with their skill folders.

| Client                    | Directory            |
| ------------------------- | -------------------- |
| Codex                     | `~/.agents/skills/`  |
| Claude Code               | `~/.claude/skills/`  |
| GitHub Copilot in VS Code | `~/.copilot/skills/` |

## Connect to VeoWork

You need access to VeoWork Timesheets in an Azure DevOps Services organization. The production MCP endpoint is `https://mcp.veowork.io/mcp`.

For Codex CLI, add the endpoint and start OAuth sign-in.

```sh
codex mcp add veowork --url https://mcp.veowork.io/mcp
codex mcp login veowork
```

For Claude Code, add the endpoint, then open a session and use `/mcp` to authenticate the VeoWork connection.

```sh
claude mcp add --transport http --scope user veowork https://mcp.veowork.io/mcp
```

In GitHub Copilot for VS Code, add the endpoint from the Command Palette.

1. Open a workspace and select **Copilot** as the session target in Chat.
2. Run **MCP: Add Server** from the Command Palette. Choose **HTTP (HTTP or Server-Sent Events)** and enter `https://mcp.veowork.io/mcp`.
3. Enter `veowork` as the server ID. Choose **Global**, then **Copilot Global** if prompted.
4. Open a new Copilot chat and ask, “Use VeoWork to review my timesheet for last week.” Follow any prompts to start the server and sign in, then confirm that Copilot calls a VeoWork tool.

When the browser opens, sign in with Microsoft and select the Azure DevOps organization you want to use. Each connection is scoped to one organization. Your VeoWork permissions determine which timesheets and actions are available. Start a new session after installing the skills.

See the client guides for [Codex MCP setup](https://learn.chatgpt.com/docs/extend/mcp?surface=cli), [Claude Code MCP setup](https://code.claude.com/docs/en/mcp), and [VS Code MCP setup](https://code.visualstudio.com/docs/agent-customization/mcp-servers#_add-a-server-by-url-or-command).

## Try a workflow

- “Log 45 minutes today on Azure DevOps work item 123.”
- “I worked eight hours yesterday. Find my active work items and help fill the gaps in my timesheet. Keep the time I already logged.”
- “Review my timesheet for last week.”
- “Review last week’s timesheets sent to me for approval and flag any entries I should follow up on.”

Watch the [VeoWork demos for time entry and timesheet review](https://veowork.io/#ai-workflows).

## License and service terms

The skill files in this repository are available under the [MIT License](LICENSE). Access to the hosted VeoWork service is governed by the applicable [Master Service Agreement](https://veowork.io/msa). See the [VeoWork Privacy Policy](https://veowork.io/privacy) for information about the service.

The assistant you connect receives data returned by VeoWork MCP tools, which may include timesheets and Azure DevOps work item details. Use a client approved by your organization and review that client's data handling terms.
