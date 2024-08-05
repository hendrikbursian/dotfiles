{ pkgs, config, ... }:

{
  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink ./.config/nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    extraPackages = with pkgs; [

      # Languages
      zig
      go
      nodejs_22
      corepack_22
      typescript
      rustc
      cargo

      # LSP
      ccls
      gopls
      htmx-lsp
      lemminx
      llvmPackages_18.clang-tools
      lua-language-server
      rust-analyzer
      tailwindcss-language-server
      templ
      vscode-langservers-extracted
      yaml-language-server
      delve
      nodePackages_latest.graphql-language-service-cli
      # nodePackages_latest.intelephense 
      nodePackages_latest.typescript-language-server
      nodePackages_latest.vls

      # Formatters
      nixpkgs-fmt
      stylua
      php83Packages.php-codesniffer
      prettierd
      shfmt
      stylua
      nodePackages_latest.eslint_d
      nodePackages_latest.prettier
      nodePackages_latest.sql-formatter

    ];
  };
}
