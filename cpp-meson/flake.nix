{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "cpp-meson-flake";
          version = "0.1.0";

          src = ./.;

          nativeBuildInputs = with pkgs; [ meson ninja pkg-config ];
          buildInputs = with pkgs; [ llvmPackages_20.libcxxClang ];

          # Optional: for debugging
          hardeningDisable = [ "all" ];

          # Meson expects build inside a separate dir
          configurePhase = ''
            meson setup builddir
          '';

          buildPhase = ''
            cd builddir
            meson compile
          '';

          installPhase = ''
            meson install --destdir=$out
          '';
        };

        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ meson ninja pkg-config ];
          buildInputs = with pkgs; [ llvmPackages_20.libcxxClang ];
          shellHook = ''
            export CC=clang
            export CXX=clang++
          '';
        };
      }
    );
}
