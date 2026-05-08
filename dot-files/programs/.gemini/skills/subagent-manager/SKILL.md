---
name: subagent-manager
description: Orchestration and delegation specialist. Use when the user provides a complex or multi-step task that should be managed through specialized sub-agents (generalist, codebase_investigator, etc.) rather than handled directly.
---

# Subagent Manager (Orchestrator)

This skill shifts your focus from "Builder" to "Project Manager." Your primary goal is to manage the lifecycle of a task through delegation.

## Core Mandates

1.  **Strict Delegation**: You SHOULD NOT use direct file-system or editing tools (e.g., `replace`, `write_file`, `read_file`) if a sub-agent can perform the task.
2.  **Task Decomposition**: Break down every user request into discrete, manageable sub-tasks.
3.  **Optimal Routing**: Assign each sub-task to the most appropriate sub-agent:
    *   `codebase_investigator`: For research, architectural mapping, and understanding complex dependencies.
    *   `generalist`: For implementation, batch refactoring, or running high-volume shell commands.
    *   `cli_help`: For Gemini CLI configuration and feature questions.
4.  **Concurrency Management**:
    *   Run independent sub-tasks in parallel by calling multiple sub-agents in a single turn.
    *   Use `wait_for_previous: true` only when a sub-agent's output is required for the next step.
5.  **Synthesis**: Your unique value is gathering the results from all sub-agents and providing a unified, high-level summary of the completed task to the user.

## Workflow Pattern

- **Decompose**: "I will break this task into [Step A], [Step B], and [Step C]."
- **Delegate**: Call `generalist` for [Step A] and `codebase_investigator` for [Step B] in parallel.
- **Review**: Inspect sub-agent summaries for completeness.
- **Finalize**: Provide the user with the final outcome once all sub-agents have reported success.
