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
      "openclaw/tap/goplaces"
      "yakitrak/yakitrak/obsidian-cli"
    ];
    taps = [
      "steipete/tap"
      "openclaw/tap"
      "yakitrak/yakitrak"
    ];
    casks = [
      "ghostty"
      "orbstack"
      "tailscale-app"
      "rectangle"
      "1password"
    ];
    onActivation = {
      autoUpdate = true;
      cleanup = "none";  # change to "zap" once you've verified everything works
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