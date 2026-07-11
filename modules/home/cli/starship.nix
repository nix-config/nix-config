{
  ...
}:
{
  config = {
    programs.starship = {
      enable = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";
        format =
          ""
          + "[ ](#FF69B4)"
          + "$os"
          + "$username"
          + "$hostname"
          + "[](bg:#FF87C3 fg:#FF69B4)"
          + "$directory"
          + "[](bg:#FFA5D2 fg:#FF87C3)"
          + "$git_branch"
          + "$git_status"
          + "[](bg:#FFC3E1 fg:#FFA5D2)"
          + "$c"
          + "$conda"
          + "$cpp"
          + "$elixir"
          + "$elm"
          + "$golang"
          + "$gradle"
          + "$haskell"
          + "$java"
          + "$julia"
          + "$nodejs"
          + "$nim"
          + "$rust"
          + "$scala"
          + "[](bg:#FFFFFF fg:#FFC3E1)"
          + "$time"
          + "[ ](fg:#FFFFFF)";
        os = {
          style = "bg:#FF69B4 fg:#FFFFFF";
          disabled = false;
          symbols = {
            NixOS = " ";
          };
        };
        username = {
          show_always = true;
          style_user = "bg:#FF69B4 fg:#FFFFFF";
          style_root = "bg:#FF69B4 fg:#FFFFFF";
          format = "[$user@]($style)";
          disabled = false;
        };
        hostname = {
          ssh_only = false;
          style = "bg:#FF69B4 fg:#FFFFFF";
          format = "[$hostname ]($style)";
          disabled = false;
        };
        directory = {
          style = "bg:#FF87C3 fg:#FFFFFF";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            Documents = "󰈙 ";
            Downloads = " ";
            Music = " ";
            Pictures = " ";
          };
        };
        git_branch = {
          symbol = "";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol $branch ]($style)";
        };
        git_status = {
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[$all_status$ahead_behind ]($style)";
        };
        c = {
          symbol = " ";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        conda = {
          symbol = "🅒 ";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol$environment]($style)";
        };
        cpp = {
          symbol = " ";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        elixir = {
          symbol = " ";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        elm = {
          symbol = " ";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        golang = {
          symbol = " ";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        gradle = {
          symbol = " ";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        haskell = {
          symbol = " ";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        java = {
          symbol = " ";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        julia = {
          symbol = " ";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        nodejs = {
          symbol = "";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        nim = {
          symbol = "󰆥 ";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        rust = {
          symbol = "";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        scala = {
          symbol = " ";
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:#FFFFFF fg:#FF87C3";
          format = "[  $time ]($style)";
        };
      };
    };
  };
}
