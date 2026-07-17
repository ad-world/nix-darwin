{ config, pkgs, ... }:

{
  # ── Users ──────────────────────────────────────
  users.users.aryaman = {
    name = "aryaman";
    home = "/Users/aryaman";
  };

  # ── System packages (available to all users) ────
  environment.systemPackages = with pkgs; [
    git
    python3
  ];

  # ── Nix settings ────────────────────────────────
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    max-jobs = "auto";
    extra-trusted-substituters = [ "https://cache.lix.systems" ];
    extra-trusted-public-keys = [
      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
    ];
  };

  # ── Primary user (required for defaults) ────────
  system.primaryUser = "aryaman";

  # ── Fonts ──────────────────────────────────────
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # ── Homebrew (brew-only packages not in nixpkgs) ─
  homebrew = {
    enable = true;
    brews = [
      "gogcli"
      "summarize"
      "steipete/tap/spogo"
      "steipete/tap/remindctl"
      "steipete/tap/imsg"
      "yakitrak/yakitrak/obsidian-cli"
      "jnsahaj/lumen/lumen"
      "herdr"
    ];
    taps = [
      {
        name = "steipete/tap";
        trusted = true;
      }
      {
        name = "openclaw/tap";
        trusted = true;
      }
      {
        name = "yakitrak/yakitrak";
        trusted = true;
      }
      {
        name = "jnsahaj/lumen";
        trusted = true;
      }
    ];
    casks = [
      "ghostty"
      "orbstack"
      "tailscale-app"
      "rectangle"
      "1password"
      "mactex"
      "openclaw/tap/goplaces"
    ];
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      # Homebrew now requires explicit confirmation/force when cleanup is enabled.
      extraFlags = [ "--force-cleanup" ];
    };
  };

  # ── macOS defaults ──────────────────────────────
  system.defaults = {
    dock = {
      autohide = false;
      mru-spaces = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXPreferredViewStyle = "Nlsv";
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      "com.apple.swipescrolldirection" = false;
    };
  };

  system.stateVersion = 6;
}