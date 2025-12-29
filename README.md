# Coding Agents Dev Workflow

A structured, research-driven development workflow for AI coding assistants. This repository contains command templates and utilities to systematically approach software development with AI agents.

## Philosophy

**Research → Plan → Implement**

Rather than jumping straight into code changes, this workflow emphasizes:
1. **Research**: Thoroughly understand the codebase as-is
2. **Plan**: Design the implementation with full context
3. **Implement**: Execute with clear guidance and validation

## Prerequisites

- Git
- [uv](https://docs.astral.sh/uv/) (Python package manager)
- ruff (linting/formatting) - typically installed via `uv`
- basedpyright (type checking) - typically installed via `uv`

## Structure

```
codingagents-dev-workflow/
├── claude/          # Claude Code workflow commands
├── shared/          # Reserved for shared utilities (future use)
└── README.md        # This file
```

## Claude Code Workflow

Located in `claude/`, these are slash command templates for Claude Code (copy them to `.claude/commands/`):

### Commands

- **`do_research.md`** - Document and understand codebase as-is
  - Spawns parallel research agents
  - Creates structured research documents in `./research/`
  - Focuses on "what exists" not "what should be"

- **`do_plan.md`** - Create detailed implementation plans
  - Reads research outputs first
  - Validates findings and fills gaps
  - Produces actionable implementation plans in `./plan/`

- **`do_implement.md`** - Execute implementation plans
  - Follows the plan step-by-step
  - Runs automated verification (`uv run ruff check`, `uv run basedpyright`)
  - Pauses for manual confirmation

- **`spec_metadata.sh`** - Collect git/timestamp metadata
  - Used by research and plan commands
  - Captures current commit, branch, date

### Installation (Claude Code)

1. Copy the `claude/` contents to your Claude Code commands directory:
   ```bash
   mkdir ~/.claude/commands/; cp claude/* ~/.claude/commands/
   ```

2. Make the metadata script executable:
   ```bash
   chmod +x ~/.claude/commands/spec_metadata.sh
   ```

3. Ensure the script path in commands matches your setup:
   - Default: `~/spec_metadata.sh`
   - Adjust in `do_research.md` and `do_plan.md` if needed

### Usage Example

```bash
# 1. Research a feature/bug first
/research
# User: "How does authentication work across the system?"
# Output: ./research/2025-01-10-authentication-flow.md

# 2. Create implementation plan
/plan tickets/add-oauth.md ./research/2025-01-10-authentication-flow.md
# Output: ./plan/2025-01-10-add-oauth.md

# 3. Implement the plan
/implement ./plan/2025-01-10-add-oauth.md
# At each phase, automated verification runs:
#   - uv run ruff check (linting/formatting)
#   - uv run basedpyright (type checking)
# Then pauses for manual verification before proceeding
```

## Key Features

### Research Command
- **Parallel agent orchestration**: Multiple specialized agents research concurrently
- **Structured output**: YAML frontmatter + markdown with code references
- **Read-only focus**: Document what exists without suggesting changes
- **Permanent references**: GitHub permalinks when possible

### Plan Command
- **Research integration**: Validates and builds on existing research
- **Gap analysis**: Only researches what's missing
- **Phased approach**: Breaks work into testable increments
- **Success criteria**: Both automated and manual verification steps

### Implement Command
- **Plan-driven**: Follows the implementation plan exactly
- **Validation gates**: Automated checks at each phase (ruff, basedpyright)
- **Human-in-loop**: Pauses for manual confirmation before proceeding
- **Error handling**: Stops and reports issues clearly

## Future: Multi-Agent Support

This repository is designed to support multiple AI coding assistants:

```
codingagents-dev-workflow/
├── claude/          # Claude Code commands
├── cursor/          # Cursor IDE workflows (future)
├── aider/           # Aider CLI workflows (future)
├── windsurf/        # Windsurf workflows (future)
└── shared/          # Common utilities
```

Each tool may have different command formats but shares the same research → plan → implement philosophy.

## Contributing

Contributions welcome! Areas of interest:
- Workflows for other AI coding tools
- Shared utilities in `shared/`
- Improvements to existing commands
- Documentation and examples

## License

MIT License - See LICENSE file for details

## Credits

- [Created to bring systematic, research-driven development to AI-assisted coding.](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/ace-fca.md)

