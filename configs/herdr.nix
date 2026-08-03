{ ... }:

{
  xdg.configFile."herdr/config.toml".text = ''
    onboarding = false

    [theme]
    name = "vesper"

    [keys]
    remove_worktree = "prefix+backspace"
    last_pane = "prefix+left"
  '';
}
