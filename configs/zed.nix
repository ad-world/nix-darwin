{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "zed" ''
      exec ${pkgs.zed-editor}/bin/zeditor "$@"
    '')
  ];

  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;

    mutableUserSettings = false;
    mutableUserKeymaps = false;

    extensions = [ "latex" ];

    userSettings = {
      project_panel.dock = "left";
      outline_panel.dock = "left";
      collaboration_panel.dock = "left";
      agent = {
        dock = "right";
        favorite_models = [ ];
        model_parameters = [ ];
      };
      git_panel.dock = "left";
      features.edit_prediction_provider = "zed";
      ui_font_size = 16;
      buffer_font_size = 16;
      theme = {
        mode = "system";
        light = "One Light";
        dark = "Vercel Dark";
      };
      autosave.after_delay.milliseconds = 100;
      lsp.texlab.settings.texlab.build = {
        executable = "/Library/TeX/texbin/latexmk";
        args = [
          "-pdf"
          "-interaction=nonstopmode"
          "-synctex=1"
          "%f"
        ];
      };
    };

    userKeymaps = [
      {
        context = "Workspace";
        bindings = { };
      }
      {
        context = "Editor && vim_mode == insert";
        bindings = { };
      }
    ];
  };
}
