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
