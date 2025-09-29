{
  description = "Windsurf Editor - AI-powered code editor";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        packages = {
          windsurf = pkgs.stdenv.mkDerivation rec {
            pname = "windsurf";
            version = "1.12.12";

            src = pkgs.fetchurl {
              url = "https://windsurf-stable.codeiumdata.com/linux-x64/stable/146732d0c28fe6d8f982f1ebf7ab4101ece88c63/Windsurf-linux-x64-1.12.12.tar.gz";
              sha256 = "1p2ml3hvflqj1pa54l44irq5cdzkbsq1g23j5mkg6ygayf0j70wz";
            };

            nativeBuildInputs = with pkgs; [
              autoPatchelfHook
              wrapGAppsHook
            ];

            buildInputs = with pkgs; [
              stdenv.cc.cc.lib
              gtk3
              cairo
              pango
              gdk-pixbuf
              glib
              dbus
              atk
              at-spi2-atk
              libdrm
              xorg.libX11
              xorg.libXcomposite
              xorg.libXdamage
              xorg.libXrandr
              xorg.libXext
              xorg.libXfixes
              xorg.libXrender
              xorg.libxcb
              xorg.libXi
              xorg.libXScrnSaver
              xorg.libXcursor
              xorg.libXtst
              xorg.libxshmfence
              xorg.libxkbfile
              nss
              nspr
              alsa-lib
              cups
              fontconfig
              freetype
              libuuid
              expat
              zlib
              mesa
              libxkbcommon
              wayland
            ];

            runtimeDependencies = with pkgs; [
              (lib.getLib systemd)
              libnotify
              libudev0-shim
              curl
              xdg-utils
              libGL
              libglvnd
            ];

            unpackPhase = ''
              tar -xzf $src
            '';

            installPhase = ''
              runHook preInstall

              mkdir -p $out/opt/windsurf
              cp -r Windsurf/* $out/opt/windsurf/

              mkdir -p $out/bin
              ln -s $out/opt/windsurf/windsurf $out/bin/windsurf

              mkdir -p $out/share/applications
              cat > $out/share/applications/windsurf.desktop << EOF
              [Desktop Entry]
              Name=Windsurf
              Comment=AI-powered code editor
              Exec=$out/bin/windsurf %F
              Icon=$out/opt/windsurf/resources/app/resources/linux/code.png
              StartupNotify=true
              NoDisplay=false
              StartupWMClass=windsurf
              Type=Application
              Categories=Development;IDE;
              MimeType=text/plain;inode/directory;
              Keywords=windsurf;editor;ide;development;
              EOF

              runHook postInstall
            '';

            meta = with pkgs.lib; {
              description = "Windsurf Editor - AI-powered code editor";
              homepage = "https://codeium.com/windsurf";
              license = licenses.unfree;
              platforms = [ "x86_64-linux" ];
              maintainers = [ ];
            };
          };

          default = self.packages.${system}.windsurf;
        };

        apps = {
          windsurf = flake-utils.lib.mkApp {
            drv = self.packages.${system}.windsurf;
            exePath = "/bin/windsurf";
          };

          default = self.apps.${system}.windsurf;
        };
      });
}
