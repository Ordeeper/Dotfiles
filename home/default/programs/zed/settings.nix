{
  pkgs,
  lib,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "html"
      "toml"
      "dockerfile"
      "php"
      "sql"
      "vue"
      "material-icon-theme"
      "make"
      "scss"
      "dart"
      "csv"
      "ini"
    ];
    extraPackages = [ pkgs.nixd ];

    userSettings = {
      auto_install_extensions = true;
      vim_mode = true;
      show_edit_predictions = false;
      telemetry = {
	diagnostics = false;
      	metrics = false;
      };
      ui_font_size = lib.mkForce 18;
      buffer_font_size = lib.mkForce 17;
      file_finder = {
        modal_width = "medium";
      };
      autosave = {
      	after_delay.milliseconds = 1000;
      };
      tabs = {
        show_diagnostics = "errors";
      };
      git_panel = {
      	dock = "right";
      };
      git = {
      	inline_blame = {
	  enabled = false;
	};
      };
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };
      # centered_layout = {
      #   left_padding = "0.15";
      #   right_padding = "0.15";
      # };
      inlay_hints = {
        enabled = true;
      };
      auto_update = false;
      terminal = {
        env = {
          EDITOR = "zed --wait";
          TERM = "kitty";
        };
        line_height = "comfortable";
        button = true;
      };
      theme = {
        mode = "dark";
        dark = "Catppuccin Mocha";
      };
      buffer_font_family = "Maple Mono NF";
      icon_theme = "Material Icon Theme";
      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };
      };
    };
  };
}
