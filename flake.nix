{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # 与当前 flake 的 inputs.nixpkgs 保持一致
      # 避免依赖的 nixpkgs 版本不一致导致问题
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur-moraxyc = {
      url = "github:Moraxyc/nur-packages/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcp-nixos = {
      url = "github:utensils/mcp-nixos/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixified-ai = {
      url = "github:nixified-ai/flake/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    daeuniverse = {
      url = "github:daeuniverse/flake.nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hermes-agent = {
      url = "github:NousResearch/hermes-agent/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opencode-flake = {
      url = "github:noblepayne/opencode-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: import ./outputs inputs;
}
