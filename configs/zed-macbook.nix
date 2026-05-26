{ ... }:

{
  programs.zed-editor.userSettings.ssh_connections = [
    {
      host = "jarvis";
      username = "aryaman";
      args = [ ];
      projects = [
        { paths = [ "/Users/aryaman/code" ]; }
        { paths = [ "/Users/aryaman/code/clankolas" ]; }
        { paths = [ "/Users/aryaman/code/scar" ]; }
        { paths = [ "/Users/aryaman/code/skills/." ]; }
      ];
    }
  ];
}
