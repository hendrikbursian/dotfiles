{ config, pkgs, inputs, lib, ... }:

{
  # Zathura
  programs.zathura.extraConfig = builtins.readFile (config.scheme inputs.base16-zathura);

  # Mako
  services.mako.extraConfig = builtins.readFile (config.scheme inputs.base16-mako);

  # Foot
  xdg.configFile."foot/foot.ini" = {
    source = pkgs.writeTextFile {
      name = "foot.ini";
      text = ''
        [main]
        shell=themed-shell-wrapper
        # font=BlexMono Nerd Font Text:size=12
        font=Monospace:size=12
      '' + builtins.readFile (config.scheme inputs.base16-foot);
    };
  };

  # Zsh + fzf
  programs.zsh.initExtra = ''
    . ${config.scheme {
        templateRepo = inputs.base16-shell;
        target = "base16";
      }}
    . ${config.scheme {
        templateRepo = inputs.base16-fzf;
        target = "base16-default";
      }}
  '';

  # Tmux
  programs.tmux.extraConfig = ''
    source-file ${config.scheme { templateRepo = inputs.base16-tmux; target = "base16"; }};
  '';

  # Nvim
  xdg.configFile."nvim/colors/base16-scheme.vim".source = config.scheme inputs.base16-vim;
  programs.neovim = {
    extraLuaConfig = ''
      require("config.options")
      require("modules.lazy").setup()
      require("config.keymaps")
      require("config.autocommands")
      require("config.filetypes")

      vim.cmd("colorscheme base16-scheme")
      require("modules.ui").refreshColorTheme()
    '';
  };

}








