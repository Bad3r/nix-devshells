{
  description = "Node.js/Electron development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
        buildInputs = with pkgs; [
          bun
          nodejs_20
          (python3.withPackages (ps: [ ps.setuptools ]))
          pkg-config

          # For native modules (better-sqlite3, etc.)
          sqlite

          # For Electron
          electron
          libGL
          xorg.libX11
          xorg.libXcomposite
          xorg.libXdamage
          xorg.libXext
          xorg.libXfixes
          xorg.libXrandr
          xorg.libxcb
          mesa
          alsa-lib
          nss
          nspr
          atk
          cups
          dbus
          expat
          glib
          gtk3
          pango
          cairo
          gdk-pixbuf
          libdrm

          # For electron-builder .deb packaging
          fpm
        ];

        shellHook = ''
          export PYTHON="${pkgs.python3.withPackages (ps: [ ps.setuptools ])}/bin/python3"
          export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
            pkgs.sqlite
            pkgs.libGL
            pkgs.xorg.libX11
            pkgs.xorg.libXcomposite
            pkgs.xorg.libXdamage
            pkgs.xorg.libXext
            pkgs.xorg.libXfixes
            pkgs.xorg.libXrandr
            pkgs.xorg.libxcb
            pkgs.mesa
            pkgs.alsa-lib
            pkgs.nss
            pkgs.nspr
            pkgs.atk
            pkgs.cups
            pkgs.dbus
            pkgs.expat
            pkgs.glib
            pkgs.gtk3
            pkgs.pango
            pkgs.cairo
            pkgs.gdk-pixbuf
            pkgs.libdrm
          ]}:$LD_LIBRARY_PATH"
          export USE_SYSTEM_FPM=true
        '';
        };
      });
    };
}
