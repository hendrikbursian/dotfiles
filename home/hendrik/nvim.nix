{ pkgs, config, lib, ... }:

{
  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.dotfilesHome}/.config/nvim";
    recursive = true;
  };

  home.activation.installNvimPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PATH="${pkgs.git}/bin" ${pkgs.unstable.neovim-unwrapped}/bin/nvim --headless "+Lazy! restore" +qa
  '';

  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    vimAlias = true;
    extraPackages = with pkgs;[
      # Languages
      zig
      go
      nodejs_22
      corepack_22
      typescript
      rustc
      cargo
      python3

      # LSP
      ccls
      delve
      gopls
      htmx-lsp
      lemminx
      llvmPackages_18.clang-tools
      lua-language-server
      nodePackages_latest.graphql-language-service-cli
      nodePackages_latest.intelephense

      nodePackages_latest.typescript-language-server
      nodePackages_latest.vls
      rust-analyzer
      tailwindcss-language-server
      templ
      vscode-langservers-extracted
      yaml-language-server

      # Formatters
      nixpkgs-fmt
      nodePackages_latest.eslint_d
      nodePackages_latest.prettier
      nodePackages_latest.sql-formatter
      php83Packages.php-codesniffer
      prettierd
      rustfmt
      shfmt
      stylua
      lua54Packages.jsregexp
    ];
  };
}
