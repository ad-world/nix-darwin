{ config, pkgs, ... }:

let
  sshKeys = import ../configs/ssh-keys.nix;
in
{
  imports = [ ./common.nix ];

  networking.hostName = "jarvis";

  users.users.aryaman.openssh.authorizedKeys.keys = [
    sshKeys.aryaman.macbook
  ];

  # Host-specific Home Manager config.
  home-manager.users.aryaman = { config, pkgs, ... }: {
    home.packages = [ pkgs.opencode ];

    programs.zsh.initContent = ''
      # When jarvis is reached over SSH, copy back to the client terminal's
      # clipboard via OSC 52 instead of jarvis's local macOS clipboard.
      pbcopy() {
        if [[ -n ''${SSH_CONNECTION:-} || -n ''${SSH_TTY:-} ]]; then
          local buffer
          buffer=$(base64 | tr -d '\r\n')
          printf '\033]52;c;%s\a' "$buffer"
        else
          command pbcopy "$@"
        fi
      }
    '';

    home.file.".local/share/opencode/logs/.keep".text = "";

    launchd.agents.opencode-server = {
      enable = true;
      config = {
        Label = "ai.opencode.server";
        ProgramArguments = [
          "${pkgs.opencode}/bin/opencode"
          "serve"
          "--port"
          "4096"
          "--print-logs"
        ];
        RunAtLoad = true;
        KeepAlive = true;
        WorkingDirectory = "${config.home.homeDirectory}/jarvis";
        StandardOutPath = "${config.home.homeDirectory}/.local/share/opencode/logs/opencode.out.log";
        StandardErrorPath = "${config.home.homeDirectory}/.local/share/opencode/logs/opencode.err.log";
        ThrottleInterval = 30;
        EnvironmentVariables = {
          HOME = config.home.homeDirectory;
          PATH = "${config.home.profileDirectory}/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin";
        };
        ProcessType = "Interactive";
      };
    };
  };
}