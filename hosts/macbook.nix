{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  networking.hostName = "macbook";

  # Laptop-specific tweaks (trackpad, battery, etc.) go here
  # system.defaults = {
  #   trackpad.Clicking = true;
  # };
}
