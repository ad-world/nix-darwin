{ config, pkgs, ... }:

let
  yfin-cli = pkgs.callPackage ./packages/yfin-cli.nix { };
in
{
  home.username = "aryaman";
  home.homeDirectory = "/Users/aryaman";

  # ── User packages ───────────────────────────────
  home.packages = with pkgs; [
    # Runtimes
    bun
    uv
    yfin-cli
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
    wget
    cloudflared
    sqlite

    # Dev tools (global for now, move to per-project devShells later)
    go
    gcc
    cmake
    gnumake

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
      settings = {
        user.name = "ad-world";
        user.email = "aryamandhingra@gmail.com";
        init.defaultBranch = "main";
        pull.rebase = true;
        lfs.enable = true;
        core.autocrlf = "input";
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = ''
        # Show Apple logo on terminal start
        fastfetch -l macos

        # OrbStack integration
        source ~/.orbstack/shell/init.zsh 2>/dev/null || :

        # Google Cloud SDK
        if [ -f '/Users/aryaman/google-cloud-sdk/path.zsh.inc' ]; then
          . '/Users/aryaman/google-cloud-sdk/path.zsh.inc'
        fi
        if [ -f '/Users/aryaman/google-cloud-sdk/completion.zsh.inc' ]; then
          . '/Users/aryaman/google-cloud-sdk/completion.zsh.inc'
        fi
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
        gcloud.disabled = true;
        scala.disabled = true;

        nodejs = {
          disabled = false;
          format = "via [$symbol($version )]($style)";
        };

        python = {
          disabled = false;
          format = "via [$symbol$pyenv_prefix($version )(\\($virtualenv\\) )]($style)";
        };

        time = {
          disabled = false;
          format = "at [$time]($style) ";
        };
      };
    };
  };

  home.sessionPath = [ "/Users/aryaman/.bun/bin" "/opt/homebrew/bin" ];

  home.stateVersion = "24.11";
}