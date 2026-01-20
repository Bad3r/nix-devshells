# devshells

Reusable Nix flake-based development environments (devshells).

## Usage

Enter a development shell:

```bash
nix develop github:bad3r/devshells?dir=node-electron
```

Or clone locally and run:

```bash
nix develop ./node-electron
```

## Available Devshells

### node-electron

Development environment for Node.js and Electron applications.

**Includes:**

- Node.js 20
- Bun
- Python 3 with setuptools (for native module compilation)
- SQLite (for better-sqlite3 and similar packages)
- Electron with all required system libraries (X11, GTK, Mesa, etc.)
- fpm for electron-builder .deb packaging

**Environment setup:**

- `PYTHON` set for native module builds
- `LD_LIBRARY_PATH` configured for Electron runtime
- `USE_SYSTEM_FPM=true` for electron-builder

## Adding a New Devshell

1. Create a new directory with a `flake.nix`
2. Follow the existing pattern (see `node-electron/flake.nix`)
3. Use `nixos-config/nixpkgs` for package consistency
