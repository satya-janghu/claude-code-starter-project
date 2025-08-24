# Claude Code Starter Template

## Setup
1. Run setup script → copies template + installs MCP servers
2. Edit `CLAUDE.md` for project context
3. Launch Claude Code, run `/init`

## MCP Servers
* **Context7** - Real-time library docs (add `use context7` to prompts)
* **Playwright** - Browser automation via accessibility tree  
* **Serena** - LSP-based code analysis (`find_symbol`, `find_referencing_symbols`)
* **Zen** - AI orchestration (`chat`, `thinkdeep`, `planner`, `codereview`, `debug`)

## Agents
* `memory-bank-synchronizer` - Syncs docs with code
* `code-searcher` - Codebase search with CoD mode  
* `get-current-datetime` - Brisbane timezone utilities
* `ux-design-expert` - Tailwind CSS + Highcharts design

## Key Commands
* `/update-memory-bank` - Refresh memory files
* `/cleanup-context` - Reduce token usage
* `/check-best-practices` - Code quality scan
* `/refactor-code` - Generate refactoring plans

## Memory Bank Files
- `CLAUDE.md` - Main AI guidance
- `CLAUDE-activeContext.md` - Session state  
- `CLAUDE-patterns.md` - Code patterns
- `CLAUDE-decisions.md` - Architecture decisions

## MCP Usage Examples

**Context7**: `Create a Next.js API route with error handling. use context7`

**Playwright**: `Take a screenshot of github.com and navigate to login page`

**Serena**: `Find all references to getUserData function and show symbol overview of user.py`

**Zen**: `Use zen to codereview this file with gemini pro, then debug with o3`