{ ... }:

{
  programs.ghostty = {
    enable = true;
    # ghostty is not available from nixpkgs on aarch64-darwin; manage config only.
    package = null;
    settings = {
      theme = "Flexoki Dark";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 14;
      copy-on-select = "clipboard";
      clipboard-read = "allow";
      clipboard-write = "allow";
      ssh-integration = true;
      keybind = [
        "alt+backspace=text:\\x1b\\x7f"
        "insert=text:\\x02"
      ];
    };
  };
}
