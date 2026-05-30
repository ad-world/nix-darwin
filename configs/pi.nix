{ ... }:

{
  # Pi's global settings live here. Project `.pi/settings.json` files only apply
  # when running pi from that project; keep shared packages global instead.
  home.file.".pi/agent/settings.json".source = ./pi/settings.json;
}
