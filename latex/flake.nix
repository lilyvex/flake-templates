{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in 
      {
        packages.default = pkgs.stdenvNoCC.mkDerivation rec {
          name = "latex-flake";
          src = ./src;
          buildInputs = with pkgs; [ coreutils texliveFull ];
          phases = ["unpackPhase" "buildPhase" "installPhase"];
          buildPhase = ''
            export PATH="${pkgs.lib.makeBinPath buildInputs}"
            mkdir -p texmf-cache/texmf-var
            TEXMFHOME=$PWD/texmf-cache TEXMFVAR=$PWD/texmf-cache/texmf-var \
              latexmk -pdf -lualatex -interaction=nonstopmode document.tex          
          '';
          installPhase = ''
            mkdir -p $out
            cp document.pdf $out/
          '';
        };

        devShell = with pkgs; mkShell {
          buildInputs = [ texliveFull ];
        };
      }
    );
}
