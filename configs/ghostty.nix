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
    };
  };
}
