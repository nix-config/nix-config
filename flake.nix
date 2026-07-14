{
  inputs = {
    # self.submodules = true;
    # ==================== nixpkgs ====================
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixpkgs-nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ==================== vendor ====================
    daeuniverse.url = "github:daeuniverse/flake.nix/main";
    hermes-agent.url = "github:NousResearch/hermes-agent/main";
    nixified-ai.url = "github:nixified-ai/flake/master";
    noctalia.url = "github:noctalia-dev/noctalia/main";
    sops-nix.url = "github:Mic92/sops-nix/master";
    # ==================== self ====================
    nixpkgs-rustdesk-flutter.url = "github:knightfemale/nixpkgs/rustdesk-flutter";
    nur-knightfemale.url = "github:knightfemale/nur-packages/master";
    # nur-knightfemale.url = ./repositories/knightfemale/nur-packages;
  };
  outputs = inputs: import ./outputs inputs;
}
