{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  networking.hostName = "jarvis";

  # Host-specific system or home config goes here
  # home-manager.users.aryaman = { ... };
}