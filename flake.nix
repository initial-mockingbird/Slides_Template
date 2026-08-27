{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [];

      perSystem = { self', pkgs, config, ... }: {
        devShells.default = let 
          tex = pkgs.texliveFull;
          texmakerConf = import ./texmaker_config.nix;
          texmakerConfFile = pkgs.writeText "texmaker.conf" texmakerConf.raw;
        in pkgs.mkShell {
          name = "latex-template";
          meta.description = "Latex development environment";
          inputsFrom = [
          ];
          buildInputs =
            
            [ 
              tex 
              pkgs.inkscape
              pkgs.coreutils
            ];
          nativeBuildInputs = 
            [ 
              tex
              pkgs.inkscape
              pkgs.just
              pkgs.texmaker
            
            ];
          shellHook = ''
            export GIT_PS1_SHOWDIRTYSTATE=1
            export PS1='\[\033[1;32m\]\h\[\033[00m\]:\[\033[1;34m\]\w\[\033[00m\] \[\033[38;2;135;0;255m\](nix)\[\033[00m\]\[\033[1;32m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
            export OSFONTDIR=".:$OSFONTDIR:"
            export TEXINPUTS=".:$TEXINPUTS:"
            export XDG_CONFIG_HOME="$PWD/.nix-config/xm1"
            mkdir -p "$XDG_CONFIG_HOME/xm1"
            cp -f ${texmakerConfFile} "$XDG_CONFIG_HOME/xm1/texmaker.ini"
            chmod +w "$XDG_CONFIG_HOME/xm1/texmaker.ini"
          '';
        };
      };
    };
}

