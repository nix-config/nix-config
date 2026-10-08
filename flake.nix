{
  inputs = {
    # ==================== nixos ====================
    flake-compat.url = "github:NixOS/flake-compat/master";
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixpkgs-nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-staging.url = "github:NixOS/nixpkgs/staging";
    # ==================== nix-community ====================
    disko = {
      url = "github:nix-community/disko/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nur = {
      url = "github:nix-community/NUR/main";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    # ==================== trhird-party ====================
    flake-parts = {
      url = "github:hercules-ci/flake-parts/main";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    hermes-agent = {
      url = "github:NousResearch/hermes-agent/main";
      inputs = {
        flake-parts.follows = "flake-parts";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/master";
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs-staging";
      };
    };
    sops-nix = {
      url = "github:Mic92/sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ==================== self ====================
    nixpkgs-knightfemale.url = "github:knightfemale/nixpkgs/knightfemale";
    nur-knightfemale = {
      url = "github:knightfemale/nur-packages/master";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
  outputs = inputs: import ./outputs inputs;
}
