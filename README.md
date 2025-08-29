# Windsurf Flake

A Nix flake for installing [Windsurf](https://codeium.com/windsurf), an AI-powered code editor.

## Usage

### With Home Manager

Add this flake to your Home Manager configuration:

```nix
{
  inputs = {
    windsurf-flake.url = "github:MichaelFisher1997/windsurf-flake";
  };

  outputs = { self, home-manager, windsurf-flake, ... }: {
    homeConfigurations.yourusername = home-manager.lib.homeManagerConfiguration {
      modules = [
        {
          home.packages = [ windsurf-flake.packages.x86_64-linux.windsurf ];
        }
      ];
    };
  };
}
```

### With NixOS Configuration

Add to your NixOS configuration:

```nix
{
  inputs = {
    windsurf-flake.url = "github:MichaelFisher1997/windsurf-flake";
  };

  outputs = { self, nixpkgs, windsurf-flake, ... }: {
    nixosConfigurations.yourhostname = nixpkgs.lib.nixosSystem {
      modules = [
        {
          environment.systemPackages = [ windsurf-flake.packages.x86_64-linux.windsurf ];
        }
      ];
    };
  };
}
```

### Direct Installation

You can also install it directly:

```bash
nix profile install github:MichaelFisher1997/windsurf-flake
```

### Running Without Installation

```bash
nix run github:yourusername/windsurf-flake
```

## Building Locally

```bash
git clone https://github.com/MichaelFisher1997/windsurf-flake.git
cd windsurf-flake
nix build
```

## Notes

- This package is marked as unfree due to Windsurf's license
- The flake automatically handles the unfree license configuration
- Supports x86_64-linux only
- Includes all necessary runtime dependencies for GUI functionality

## Version

Current package version: Windsurf 1.12.3
