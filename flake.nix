{
  description = "DrackThor's macOS system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # TODO bin noch zu blöd dafür..
    # nixvim.url = "github:nix-community/nixvim";
    # nixvim.inputs.nixpkgs.follows = "nixpkgs";
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew, homebrew-core, homebrew-cask, ... }:
  let
        hostname = "DrackBook";
        user = "drackthor";
        arch = "aarch64-darwin";
  in
  {
      darwinConfigurations.${hostname} =
        nix-darwin.lib.darwinSystem {
          system = arch;

          modules = [
            ./darwin.nix
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                # Install Homebrew under the default prefix
                enable = true;

                # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
                enableRosetta = true;

                # User owning the Homebrew prefix
                user = user;

                # Automatically migrate existing Homebrew installations
                autoMigrate = true;
              };
            }
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = import ./home.nix;
              # TODO zu dumm auch für das
#              home-manager.programs.ssh = {
#                  knownHosts = [
#                    {
#                        hostNames = [ "ddrke2-1" "192.168.103.10" ];
#                        publicKeyFile = /Users/drackthor/.ssh/id_ecdsa.pub;
#                    }
#                    {
#                        hostNames = [ "ddrke2-2" "192.168.103.11" ];
#                        publicKeyFile = /Users/drackthor/.ssh/id_ecdsa.pub;
#                    }
#                    {
#                        hostNames = [ "ddrke2-3" "192.168.103.12" ];
#                        publicKeyFile = /Users/drackthor/.ssh/id_ecdsa.pub;
#                    }
#                  ];
#              };
            }
          ];
        };
        darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
      };
  }
