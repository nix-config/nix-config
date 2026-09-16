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
    # TODO: Mic92/sops-nix#984
    sops-nix.url = "github:c2fc2f/sops-nix/buildGo126Module";
    # ==================== self ====================
    nixpkgs-comfyui.url = "github:knightfemale/nixpkgs/comfyui";
    nixpkgs-openlist.url = "github:knightfemale/nixpkgs/openlist";
    nur-knightfemale.url = "github:knightfemale/nur-packages/master";
    # nur-knightfemale.url = ./repositories/knightfemale/nur-packages;
  };
  outputs = inputs: import ./outputs inputs;
}
