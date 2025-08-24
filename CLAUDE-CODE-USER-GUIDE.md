# Claude Code Starter Template: Complete User Guide

This comprehensive guide covers every tool, MCP server, agent, and slash command included in your Claude Code starter template. Master these features to maximize your AI-assisted development workflow.

## Table of Contents
1. [Quick Start Workflow](#quick-start-workflow)
2. [Memory Bank System](#memory-bank-system)
3. [MCP Servers Deep Dive](#mcp-servers-deep-dive)
4. [Specialized Agents](#specialized-agents)
5. [Slash Commands Reference](#slash-commands-reference)
6. [Advanced Workflows](#advanced-workflows)
7. [Troubleshooting](#troubleshooting)

---

## Quick Start Workflow

### Initial Setup (First Time in New Project)
1. **Initialize Memory Bank**: Run `/init` to analyze codebase and populate memory bank
2. **Update Project Overview**: Edit `CLAUDE.md` with your project specifics
3. **Test MCP Servers**: Try "use context7" in a prompt to verify installation
4. **Explore Agents**: Use "Use code-searcher to find authentication logic"

### Daily Development Routine
```
Morning: /update-memory-bank → Review CLAUDE-activeContext.md
Coding: Use specialized agents + MCP servers as needed
Evening: Update CLAUDE-decisions.md with any architectural choices
```

---

## Memory Bank System

The memory bank keeps Claude informed about your project across sessions. Four key files work together:

### CLAUDE.md - Central Command
**Purpose**: Main project overview and MCP usage instructions
**Best Practices**:
- Update the "Project Overview" section with your actual project details
- Keep MCP server usage examples relevant to your tech stack
- Add project-specific coding standards in the "Development Guidelines" section

**Example customization**:
```markdown
## Project Overview
**Project**: E-commerce Platform API
**Tech Stack**: Node.js, Express, PostgreSQL, Redis
**Architecture**: Microservices with Docker
**Current Phase**: MVP development - user authentication and product catalog
```

### CLAUDE-patterns.md - Code Conventions
**Purpose**: Document your team's coding patterns and conventions
**When to update**: 
- After establishing new coding standards
- When adopting new libraries or frameworks
- After code reviews reveal common patterns

**Template sections to customize**:
```markdown
## API Design Patterns
- RESTful endpoints: `/api/v1/resource`
- Error responses: `{ error: "message", code: "ERROR_CODE" }`
- Authentication: JWT tokens in Authorization header

## Database Patterns
- Table naming: snake_case (e.g., `user_profiles`)
- Foreign keys: `{table}_id` (e.g., `user_id`)
- Indexes: Always on foreign keys and search fields
```

### CLAUDE-decisions.md - Architecture Decisions
**Purpose**: Track important technical decisions and their rationale
**When to use**:
- Choosing between technology options
- Architectural changes
- Performance optimization decisions
- Security implementation choices

**Example entry**:
```markdown
## Decision: Use Redis for Session Storage
**Date**: 2024-01-15
**Context**: Need scalable session management for multi-server deployment
**Options**: 
1. Memory (not scalable)
2. Database (too slow)
3. Redis (fast, scalable)
**Decision**: Redis with 30-minute TTL
**Rationale**: Performance + horizontal scaling capability
**Impact**: Requires Redis infrastructure, but enables load balancing
```

### CLAUDE-activeContext.md - Session State
**Purpose**: Track current work and maintain continuity between Claude sessions
**Best Practices**:
- Update at start/end of each coding session
- Be specific about current blockers
- Note what you learned or discovered

**Template usage**:
```markdown
## Current Task
Implementing user authentication with JWT tokens

## Progress Made
- ✅ Created User model with bcrypt password hashing
- ✅ Implemented registration endpoint
- 🔄 Working on login endpoint validation
- ⏳ Need to implement JWT token generation

## Next Steps
1. Complete login endpoint with proper error handling
2. Create middleware for JWT verification
3. Add refresh token mechanism

## Current Blockers
- Deciding between storing JWT secrets in env vs database
- Need to research token expiration best practices
```

---

## MCP Servers Deep Dive

### Context7 - Real-time Library Documentation

**What it does**: Provides up-to-date, version-specific documentation for any library or framework.

**How to use**:
```
Basic: "Create a Next.js API route. use context7"
Specific: "Show me Prisma query examples for many-to-many relationships. use context7"
Version-specific: "How to use React 18's useId hook. use context7"
```

**Pro Tips**:
- Always include "use context7" when asking about library-specific features
- Specify versions when working with older codebases
- Great for exploring new APIs or checking breaking changes
- Use with unfamiliar libraries to get instant examples

**Best Use Cases**:
- Learning new frameworks
- Checking API changes between versions
- Getting copy-paste ready code examples
- Understanding library best practices

**Example Workflow**:
```
You: "I need to implement file upload with Multer in Express. use context7"
Claude: [Gets latest Multer docs and provides current best practices]

You: "How to handle validation errors in the latest version of express-validator. use context7"
Claude: [Shows most recent error handling patterns]
```

### Playwright - Browser Automation

**What it does**: Controls browsers programmatically without taking screenshots, using accessibility tree navigation.

**Core capabilities**:
- Navigate websites
- Fill forms and click buttons
- Extract data from pages
- Test web applications
- Automate repetitive web tasks

**How to use**:
```
Navigation: "Navigate to login page and fill in credentials"
Testing: "Test the shopping cart flow on the staging site"
Data extraction: "Extract all product prices from the catalog page"
Form automation: "Fill out the contact form with test data"
```

**Pro Tips**:
- Playwright works with the accessibility tree, making it more reliable than pixel-based tools
- Great for testing responsive designs across different viewports
- Can handle modern SPAs with dynamic content loading
- Supports multiple browsers (Chrome, Firefox, Safari)

**Example Use Cases**:
```
E2E Testing: "Create a test that logs in, adds items to cart, and completes checkout"
Data Scraping: "Extract competitor pricing data from their product pages"
QA Automation: "Test all form validations on the signup page"
Performance Testing: "Navigate through the app and measure page load times"
```

### Serena - Semantic Code Analysis

**What it does**: Provides deep code understanding through Language Server Protocol integration.

**Key features**:
- `find_symbol`: Locate function, class, or variable definitions
- `find_referencing_symbols`: Find all places where a symbol is used
- Semantic navigation across your codebase
- Understanding code relationships and dependencies

**How to use**:
```
Find definitions: "Find where the authenticateUser function is defined"
Find usage: "Show me all places where the User model is imported"
Code exploration: "What functions call the database connection method?"
Refactoring help: "Find all references to the old API endpoint structure"
```

**Pro Tips**:
- Works automatically with your current project
- Especially powerful for large codebases
- Helps understand unfamiliar code quickly
- Great for safe refactoring by finding all usages

**Example Workflows**:
```
Code Review: "Find all functions that use the deprecated payment method"
Bug Hunting: "Show me everywhere the user session is accessed"
Refactoring: "Find all components that import the old Button component"
Architecture: "Map out all the database models and their relationships"
```

### Zen - Multi-Model AI Orchestration

**What it does**: Orchestrates multiple AI models to work together on complex tasks.

**Available tools**:
- `codereview`: Multi-model code review with different perspectives
- `debug`: Collaborative debugging using multiple AI approaches
- `planner`: Project planning with multiple AI viewpoints
- Multi-model consensus for complex decisions

**How to use**:
```
Code review: "Use zen to review this authentication implementation"
Debugging: "Help debug this performance issue using multiple approaches"
Planning: "Create a project plan for the new feature using different perspectives"
Decision making: "Get multiple AI opinions on this architecture choice"
```

**Pro Tips**:
- Requires Gemini API key during setup
- Best for complex problems where multiple perspectives add value
- Great for code reviews and architectural decisions
- Use when you want more thorough analysis

**Example Use Cases**:
```
Architecture Review: "Use zen to evaluate these three database design options"
Performance Analysis: "Debug why this API endpoint is slow using multiple approaches"
Code Quality: "Get a comprehensive review of this critical payment processing code"
```

---

## Specialized Agents

### code-searcher - Intelligent Codebase Navigation

**Purpose**: Efficiently search and understand your codebase with Chain of Draft (CoD) mode.

**How to use**:
```
"Use code-searcher to find authentication logic"
"Use code-searcher to locate error handling patterns"
"Use code-searcher to understand the user registration flow"
```

**Best for**:
- Understanding unfamiliar codebases
- Finding specific functionality
- Locating patterns and conventions
- Code exploration and discovery

**Pro Tips**:
- More efficient than manual file browsing
- Provides context along with search results
- Great for onboarding to new projects

### memory-bank-synchronizer - Documentation Maintenance

**Purpose**: Keeps your memory bank files in sync with actual code changes.

**When to use**:
- After major code changes
- When patterns or conventions change
- Before important coding sessions
- After refactoring work

**How to use**:
```
"Use memory-bank-synchronizer to update project documentation"
"Sync memory bank after the recent API refactoring"
```

**Benefits**:
- Ensures Claude has current project information
- Prevents outdated assumptions
- Maintains documentation quality

### get-current-datetime - Brisbane Timezone Utilities

**Purpose**: Provides accurate timestamp and timezone handling for Brisbane/Australia.

**Use cases**:
- Logging with proper timestamps
- Scheduling features
- Time-based calculations
- Audit trails

**How to use**:
```
"Use get-current-datetime for logging timestamps"
"Get current Brisbane time for the audit log"
```

### ux-design-expert - Design and Styling Guidance

**Purpose**: Provides expert guidance on Tailwind CSS and Highcharts implementations.

**Specialties**:
- Tailwind CSS best practices
- Component design patterns
- Responsive design
- Data visualization with Highcharts

**How to use**:
```
"Use ux-design-expert to design a responsive dashboard layout"
"Get Tailwind CSS suggestions for this component"
"Create a Highcharts configuration for sales data"
```

**Best for**:
- Frontend development
- Dashboard creation
- Data visualization
- Responsive design challenges

---

## Slash Commands Reference

### Core Commands

#### `/update-memory-bank`
**Purpose**: Refresh all memory bank files with current project state
**When to use**: Start of coding sessions, after major changes
**Example**: `/update-memory-bank` (no parameters needed)

#### `/cleanup-context`
**Purpose**: Reduce token usage by cleaning up verbose documentation
**When to use**: When hitting context limits, before important discussions
**Example**: `/cleanup-context`

### Development Commands

#### `/check-best-practices`
**Purpose**: Analyze code quality and suggest improvements
**When to use**: Code reviews, before commits, quality audits
**Example**: `/check-best-practices` (analyzes current codebase)

#### `/refactor-code`
**Purpose**: Generate systematic refactoring plans
**When to use**: Technical debt cleanup, performance improvements
**Example**: `/refactor-code` (provides step-by-step refactoring guidance)

### Documentation Commands

#### `/create-readme-section`
**Purpose**: Generate specific README sections
**When to use**: Documentation updates, project onboarding
**Usage**: Follow prompts to specify section type and content

#### `/explain-architecture-pattern`
**Purpose**: Get detailed explanations of architectural patterns
**When to use**: Learning, architecture discussions, documentation
**Example**: `/explain-architecture-pattern` (choose from common patterns)

### Productivity Commands

#### `/ccusage-daily`
**Purpose**: Analyze Claude Code usage and costs
**When to use**: Budget monitoring, usage optimization
**Example**: `/ccusage-daily`

#### `/apply-thinking-to`
**Purpose**: Enhance prompts with structured thinking approaches
**When to use**: Complex problems, systematic analysis needed
**Example**: `/apply-thinking-to` (follow prompts for thinking framework)

### Advanced Prompt Engineering

#### `/convert-to-todowrite-tasklist-prompt`
**Purpose**: Transform requests into systematic task lists
**When to use**: Complex projects, systematic execution needed
**Example**: `/convert-to-todowrite-tasklist-prompt`

#### `/batch-operations-prompt`
**Purpose**: Optimize for parallel operations and efficiency
**When to use**: Multiple related tasks, performance optimization
**Example**: `/batch-operations-prompt`

#### `/convert-to-test-driven-prompt`
**Purpose**: Restructure requests using TDD methodology
**When to use**: Test-first development, quality assurance focus
**Example**: `/convert-to-test-driven-prompt`

---

## Advanced Workflows

### 1. New Feature Development

**Step-by-step process**:
```
1. Planning Phase:
   - "Use zen to create a development plan for [feature]"
   - Document decisions in CLAUDE-decisions.md
   - Update CLAUDE-activeContext.md with current task

2. Research Phase:
   - "Use context7" for any library-specific requirements
   - "Use code-searcher to find similar implementations"
   - Check existing patterns in CLAUDE-patterns.md

3. Implementation Phase:
   - Use TDD: "/convert-to-test-driven-prompt"
   - Break down: "/convert-to-todowrite-tasklist-prompt"
   - Code with MCP assistance as needed

4. Review Phase:
   - "/check-best-practices"
   - "Use zen for code review"
   - Update memory bank: "/update-memory-bank"
```

### 2. Bug Investigation and Fixing

**Systematic debugging approach**:
```
1. Understanding:
   - "Use code-searcher to find error handling in [module]"
   - "Use serena to find all references to [problematic function]"

2. Analysis:
   - "Use zen to debug this issue with multiple approaches"
   - Check CLAUDE-decisions.md for relevant past decisions

3. Testing:
   - Use Playwright for reproducing UI bugs
   - "/convert-to-test-driven-prompt" for systematic testing

4. Documentation:
   - Update CLAUDE-decisions.md with findings
   - Update CLAUDE-patterns.md if patterns change
```

### 3. Code Refactoring

**Large-scale refactoring workflow**:
```
1. Assessment:
   - "/refactor-code" for systematic analysis
   - "Use serena to find all symbol references"
   - "/check-best-practices" for quality baseline

2. Planning:
   - "/convert-to-todowrite-tasklist-prompt"
   - Document approach in CLAUDE-decisions.md

3. Execution:
   - "/batch-operations-prompt" for parallel changes
   - Use serena for safe symbol renaming
   - Test incrementally with "/check-best-practices"

4. Verification:
   - "Use zen for comprehensive code review"
   - "/update-memory-bank" to reflect changes
```

### 4. Learning New Technology

**Systematic learning approach**:
```
1. Overview:
   - "Explain [technology] architecture. use context7"
   - Document key concepts in CLAUDE-patterns.md

2. Hands-on:
   - "Create a simple [technology] example. use context7"
   - Use Playwright to test web-based technologies

3. Integration:
   - "How to integrate [technology] with [your stack]. use context7"
   - "Use code-searcher to find integration points"

4. Best Practices:
   - "What are [technology] best practices. use context7"
   - Update CLAUDE-patterns.md with new patterns
```

### 5. Performance Optimization

**Performance improvement workflow**:
```
1. Analysis:
   - "Use serena to find performance-critical functions"
   - Use Playwright to measure page performance
   - "/check-best-practices" for optimization opportunities

2. Research:
   - "Performance optimization techniques for [technology]. use context7"
   - "Use zen to analyze multiple optimization strategies"

3. Implementation:
   - "/batch-operations-prompt" for multiple optimizations
   - Document trade-offs in CLAUDE-decisions.md

4. Verification:
   - Use Playwright for performance testing
   - Compare before/after metrics
```

---

## Troubleshooting

### MCP Server Issues

**Context7 not working**:
- Check API key if using premium features
- Verify internet connection
- Restart Claude Code: `claude mcp list` to check status

**Playwright issues**:
- Ensure Node.js is available
- Check if target websites are accessible
- Some sites may block automation

**Serena not finding symbols**:
- Ensure language servers are installed for your language
- Check if project root is correctly detected
- Large codebases may take time to index

**Zen requiring API key**:
- Ensure Gemini API key was entered during setup
- Check `.mcp.json` file for correct configuration
- API key may need billing enabled

### Memory Bank Issues

**Outdated information**:
- Run `/update-memory-bank` regularly
- Manually update CLAUDE.md project overview
- Check if file paths changed

**Context limits**:
- Use `/cleanup-context` to reduce verbosity
- Focus memory bank on current work areas
- Remove outdated sections from templates

### Agent and Command Issues

**Commands not found**:
- Check `.claude/commands/` directory exists
- Verify file permissions
- Restart Claude Code

**Agents not responding**:
- Check `.claude/agents/` directory
- Verify agent file format
- Try reloading Claude Code

### General Tips

**Best practices for smooth operation**:
- Keep memory bank files under 10KB each
- Update CLAUDE-activeContext.md at session start/end
- Use specific, detailed prompts with MCP servers
- Combine tools: "Use code-searcher and serena to find..."
- Document workflows that work well for your team

**Performance optimization**:
- Use `/batch-operations-prompt` for multiple related tasks
- Combine MCP server requests when possible
- Keep memory bank focused on current work
- Regular cleanup with `/cleanup-context`

---

## Conclusion

This starter template provides a comprehensive AI-assisted development environment. The key to success is:

1. **Consistent memory bank maintenance** - Keep Claude informed
2. **Strategic MCP server usage** - Right tool for the right job
3. **Systematic workflows** - Use slash commands for routine tasks
4. **Documentation discipline** - Record decisions and patterns

Experiment with combining different tools and find workflows that match your development style. The more you use these features together, the more powerful your AI-assisted development becomes.

Remember: The goal is not just to code faster, but to code smarter with better context, documentation, and systematic approaches to complex problems.