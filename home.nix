{ config, lib, osConfig, pkgs, ... }:

let
  yfin-cli = pkgs.callPackage ./packages/yfin-cli.nix { };
  hostName = osConfig.networking.hostName or "";
in
{
  imports = [
    ./configs/zed.nix
    ./configs/ghostty.nix
    ./configs/gh.nix
    ./configs/pi.nix
  ];

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
    texlab

    # DB
    postgresql_18
  ];

  # ── Services ───────────────────────────────────
  services.syncthing = {
    enable = true;
    overrideDevices = false;
    overrideFolders = false;
    settings = {
      options = {
        urAccepted = -1;
      };
      devices = {
        jarvis.id = "WQWKHAZ-AHCHPR6-Z4WJY7P-PSHCN6I-7SBA5TW-4DGJGK2-7LRCD62-ATSM7AZ";
        macbook.id = "NZBFZVS-KDSB7LY-UDRMIXD-QYKIRDI-ZHJRWOG-OL6CGZK-X7UIPTY-VMKPSQJ";
      };
      folders.brain = {
        id = "brain";
        label = "brain";
        path = "~/brain";
        devices = lib.optionals (hostName == "jarvis") [ "macbook" ]
          ++ lib.optionals (hostName == "macbook") [ "jarvis" ];
      };
    };
  };

  # ── Programs config ────────────────────────────
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    helix = {
      enable = true;
      settings = {
        theme = "dark_high_contrast";
      };
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

        # Homebrew CLI tools. Append so Nix-provided tools keep precedence.
        path+=(/opt/homebrew/bin /opt/homebrew/sbin)

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

  # Keep Bun globals (notably `pi`) available, but do not put Homebrew ahead of Nix.
  home.sessionPath = [
    "/Users/aryaman/.bun/bin"
    "/Library/TeX/texbin"
  ];

  home.stateVersion = "24.11";
}