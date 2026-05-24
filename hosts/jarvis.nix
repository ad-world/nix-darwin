{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  networking.hostName = "jarvis";

  # Host-specific system config goes here
}
