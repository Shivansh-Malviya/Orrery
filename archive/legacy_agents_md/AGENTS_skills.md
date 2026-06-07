# BROS Shared Skills

Place shared skill definitions here. Platforms can discover these by adding
`.agents/skills` to their skill search path.

## Usage

### VS Code Copilot
Add to `copilot-instructions.md`:
```
Skill path: .agents/skills
```

### OpenCode
Skills registered in `system/scheduler/skill-registry.yaml` can reference
skills in this directory.

### Antigravity
Reference workflows that invoke skills from `.agents/skills`.
