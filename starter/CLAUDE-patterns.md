# Code Patterns & Conventions

*This template should be updated with your project's specific patterns as they emerge.*

## Naming Conventions

### Files & Directories
- [Update with your naming patterns]
- Example: `kebab-case` for files, `PascalCase` for components

### Variables & Functions  
- [Update with your conventions]
- Example: `camelCase` for variables, `UPPER_SNAKE_CASE` for constants

### Classes & Interfaces
- [Update with your patterns]
- Example: `PascalCase` for classes, `I` prefix for interfaces

## File Organization

### Directory Structure
```
[Update with your actual structure]
src/
├── components/
├── services/
├── utils/
└── types/
```

### Import Patterns
- [Document your import organization]
- Example: External imports first, then internal by path depth

## Common Patterns

### Error Handling
```javascript
// [Update with your error handling pattern]
try {
  // operation
} catch (error) {
  logger.error('Operation failed', { error, context });
  throw new AppError('User-friendly message', error);
}
```

### Configuration Management
- [Document how config is handled]
- Example: Environment variables, config objects, validation

### Testing Patterns
- [Document test organization and patterns]
- Example: Unit tests co-located, integration tests separate

## Anti-Patterns (Avoid)

### Code Smells
- [List patterns to avoid in your codebase]
- Example: God classes, magic numbers, nested callbacks

### Architecture Anti-Patterns
- [Document architectural decisions to avoid]
- Example: Tight coupling, circular dependencies

## Framework-Specific Patterns

### [Framework Name]
- [Document framework-specific conventions]
- Component structure, state management, lifecycle patterns

## Notes for AI Agents

- Always follow established patterns when creating new code
- If unclear about a pattern, ask for clarification before proceeding
- Update this file when introducing new patterns
- Use existing code as reference for pattern consistency