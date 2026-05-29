{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  networking.hostName = "macbook";

  # Host-specific Home Manager config.
  home-manager.users.aryaman.imports = [
    ../configs/zed-macbook.nix
    ../configs/ssh.nix
  ];
}