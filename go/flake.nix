{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
  };

  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.buildGoModule {
          pname = "go-flake";
          version = "0.1.0";

          src = ./.;

          # Adjust if your go.mod is not in the root
          vendorHash = null; # Set this to the hash after first build attempt or use `lib.fakeSha256`

          # optional: subPackages if not at root
          # subPackages = [ "cmd/mybinary" ];
        };

        devShell = with pkgs; mkShell {
          buildInputs = [ go ];
        };
      }
    );
}
