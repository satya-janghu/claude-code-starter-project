# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## AI Guidance

* Ignore GEMINI.md and GEMINI-*.md files
* To save main context space, for code searches, inspections, troubleshooting or analysis, use code-searcher subagent where appropriate - giving the subagent full context background for the task(s) you assign it.
* After receiving tool results, carefully reflect on their quality and determine optimal next steps before proceeding. Use your thinking to plan and iterate based on this new information, and then take the best next action.
* For maximum efficiency, whenever you need to perform multiple independent operations, invoke all relevant tools simultaneously rather than sequentially.
* Before you finish, please verify your solution
* Do what has been asked; nothing more, nothing less.
* NEVER create files unless they're absolutely necessary for achieving your goal.
* ALWAYS prefer editing an existing file to creating a new one.
* NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.
* When you update or modify core context files, also update markdown documentation and memory bank
* When asked to commit changes, exclude CLAUDE.md and CLAUDE-*.md referenced memory bank system files from any commits. Never delete these files.

## Memory Bank System

This project uses a structured memory bank system with specialized context files. Always check these files for relevant information before starting work:

### Core Context Files

* **CLAUDE-activeContext.md** - Current session state, goals, and progress (if exists)
* **CLAUDE-patterns.md** - Established code patterns and conventions (if exists)
* **CLAUDE-decisions.md** - Architecture decisions and rationale (if exists)
* **CLAUDE-troubleshooting.md** - Common issues and proven solutions (if exists)
* **CLAUDE-config-variables.md** - Configuration variables reference (if exists)
* **CLAUDE-temp.md** - Temporary scratch pad (only read when referenced)

**Important:** Always reference the active context file first to understand what's currently being worked on and maintain session continuity.

### Memory Bank System Backups

When asked to backup Memory Bank System files, you will copy the core context files above and @.claude settings directory to directory @/path/to/backup-directory. If files already exist in the backup directory, you will overwrite them.

## MCP Server Integration

This project includes 4 MCP servers for enhanced development capabilities:

### Context7 - Library Documentation
- **Purpose**: Real-time, version-specific library documentation
- **Usage**: Add `use context7` to prompts requiring library documentation
- **Example**: "Create a Next.js API route with validation. use context7"

### Playwright - Browser Automation  
- **Purpose**: Web automation using accessibility tree (fast, no screenshots)
- **Usage**: Direct commands for browser interactions
- **Example**: "Take a screenshot of the homepage and test the login form"

### Serena - Semantic Code Analysis
- **Purpose**: LSP-based code operations and symbol-level analysis
- **Key tools**: `find_symbol`, `find_referencing_symbols`, `get_symbols_overview`
- **Usage**: Project auto-activated, use for code navigation and analysis
- **Example**: "Find all references to handleSubmit and show symbol overview of UserService"

### Zen - AI Orchestration
- **Purpose**: Multi-model collaboration and specialized workflows
- **Key tools**: `chat`, `thinkdeep`, `planner`, `codereview`, `debug`, `precommit`
- **Usage**: Delegate specialized tasks to other AI models
- **Example**: "Use zen to codereview this file with gemini pro, then debug with o3"

### Multi-MCP Workflows
Combine servers for powerful workflows:
```
"Use context7 for React patterns, then serena to find existing components, 
and zen to plan the implementation with consensus from multiple models"
```

## Project Overview

**⚠️ TEMPLATE NOTICE**: This is a starter template. Update this section with your actual project information as development progresses.

### Tech Stack
- **Language**: [Update with primary language - Python, TypeScript, etc.]
- **Framework**: [Update with framework - React, Next.js, FastAPI, etc.]
- **Database**: [Update with database - PostgreSQL, MongoDB, etc.]
- **Infrastructure**: [Update with deployment - Docker, AWS, Vercel, etc.]

### Key Directories
```
[Update with your actual structure]
src/
├── components/     # [Description]
├── services/       # [Description]  
├── utils/          # [Description]
└── types/          # [Description]
```

### Development Commands
- **Setup**: [Update with setup command - npm install, pip install, etc.]
- **Dev Server**: [Update with dev command - npm run dev, python app.py, etc.]
- **Build**: [Update with build command - npm run build, docker build, etc.]
- **Test**: [Update with test command - npm test, pytest, etc.]
- **Lint**: [Update with lint command - npm run lint, black ., etc.]

### Environment Setup
- **Required Tools**: [List required tools - Node.js 18+, Python 3.10+, etc.]
- **Environment Variables**: [Document required env vars]
- **Configuration Files**: [List important config files]

### Key Features & Components
- [Update with main features of your project]
- [List core components or modules]
- [Note any architectural patterns used]

### Development Workflow
1. [Update with your development process]
2. [Include testing requirements]
3. [Note deployment procedures]
4. [Document code review process]

### Integration Points
- **APIs**: [List external APIs used]
- **Services**: [List external services integrated]
- **Dependencies**: [Note critical dependencies]

### Performance & Scaling
- [Document performance considerations]
- [Note scaling requirements or limits]
- [List optimization strategies used]

### Troubleshooting
- See `CLAUDE-troubleshooting.md` for common issues (create when needed)
- [Add project-specific troubleshooting notes]

---

**For AI Agents**: This project overview should be updated as the project evolves to maintain accuracy for effective AI assistance. Include enough detail for context without overwhelming token usage.