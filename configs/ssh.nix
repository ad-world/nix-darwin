{ ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      jarvis = {
        hostname = "jarvis";
        user = "aryaman";
        identityFile = "~/.ssh/id_ed25519";
      };

    };
  };
}
