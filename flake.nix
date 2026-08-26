{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    ghc-wasm.url = "gitlab:haskell-wasm/ghc-wasm-meta?host=gitlab.haskell.org";

  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [];

      perSystem = { self', pkgs, config, ... }: {
        devShells.default = let tex = pkgs.texliveFull;
        in pkgs.mkShell {
          name = "latex-template";
          meta.description = "Latex development environment";
          inputsFrom = [
          ];
          buildInputs =
            
            [ 
              tex 
              pkgs.coreutils
            ];
          nativeBuildInputs = 
            [ 
              tex
              pkgs.just
              pkgs.texmaker
            
            ];
          shellHook = ''
            export GIT_PS1_SHOWDIRTYSTATE=1
            export PS1='\[\033[1;32m\]\h\[\033[00m\]:\[\033[1;34m\]\w\[\033[00m\] \[\033[38;2;135;0;255m\](nix)\[\033[00m\]\[\033[1;32m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
            export OSFONTDIR=".:$OSFONTDIR:"
            export TEXINPUTS=".:$TEXINPUTS:"
          '';
        };
      };
    };
}

