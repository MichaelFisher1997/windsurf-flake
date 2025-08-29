# AGENTS.md - Windsurf Flake

## Build Commands
- `nix build` - Build the flake package
- `nix flake check` - Validate flake configuration and run checks
- `nix run` - Run the package directly

## Test Commands
- `nix flake check` - Run all flake checks (equivalent to running tests)
- No individual test files - this is a Nix packaging project

## Code Style Guidelines

### Nix Language Conventions
- Use 2-space indentation
- Use `inherit` for attribute sets when possible
- Follow the Nixpkgs style guide
- Use descriptive variable names
- Group related attributes together

### File Structure
- `flake.nix` - Main flake definition
- `flake.lock` - Lock file (auto-generated)
- Keep flake.nix under 200 lines when possible

### Error Handling
- Use `lib.throwIf` or `lib.throwIfNot` for validation
- Provide clear error messages
- Handle missing dependencies gracefully

### Naming Conventions
- Use camelCase for variable names
- Use descriptive names that explain purpose
- Follow Nixpkgs naming conventions for packages

### Imports and Dependencies
- Group inputs logically in flake.nix
- Use `with pkgs;` sparingly, prefer explicit paths
- Keep dependency lists organized alphabetically

### Formatting
- Run `nix fmt` to format Nix files
- Use consistent spacing and alignment
- Break long lines appropriately

### Security
- Mark unfree packages explicitly
- Include proper meta attributes
- Validate checksums for downloaded sources