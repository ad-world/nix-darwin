{ config, pkgs, ... }:

{
  home.username = "aryaman";
  home.homeDirectory = "/Users/aryaman";

  # ── User packages ───────────────────────────────
  home.packages = with pkgs; [
    # Runtimes
    bun
    uv
    nodejs_22

    # Shell & CLI
    direnv
    helix
    lazygit
    gh
    ripgrep
    fd
    jq
    fzf
    zoxide
    eza
    bat
    starship
    fastfetch

    # DB
    postgresql_18
  ];

  # ── Programs config ────────────────────────────
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      userName = "ad-world";
      userEmail = "aryamandhingra@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        # Show Apple logo on terminal start
        fastfetch -l macos
      '';
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = true;

        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
          vimcmd_symbol = "[❮](bold green)";
        };

        directory = {
          truncation_length = 3;
          truncate_to_repo = true;
          style = "bold cyan";
        };

        git_branch = {
          format = "on [$branch]($style) ";
          style = "bold purple";
        };

        git_status = {
          format = "[$all_status$ahead_behind]($style) ";
          style = "bold purple";
          conflicted = "🏳";
          ahead = "⇡";
          behind = "⇣";
          diverged = "⇕";
          up_to_date = "";
          untracked = "?";
          stashed = "$";
          modified = "!";
          staged = "+";
          renamed = "»";
          deleted = "✘";
        };

        cmd_duration = {
          format = "took [$duration]($style) ";
          style = "bold yellow";
        };

        nix_shell = {
          format = "via [$symbol$state]($style) ";
          symbol = "❄️  ";
        };

        nodejs = {
          format = "via [$symbol$version]($style) ";
          symbol = "⬢ ";
          style = "bold green";
        };

        python = {
          format = "via [🐍 $version]($style) ";
          style = "bold yellow";
        };

        rust = {
          format = "via [🦀 $version]($style) ";
          style = "bold red";
        };

        time = {
          disabled = false;
          format = "at [$time]($style) ";
          style = "bold dimmed white";
        };
      };
    };
  };

  # Ensure bun global bin is on PATH
  home.sessionPath = [ "$HOME/.bun/bin" ];

  home.stateVersion = "24.11";
}
