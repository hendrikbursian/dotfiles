{ pkgs, config, lib, ... }:

let
  unstable = import <nixos-unstable> { };
in
{

  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink ./.config/nvim;
    recursive = true;
  };


  home.activation.installNvimPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${unstable.neovim-unwrapped}/bin/nvim --headless "+Lazy! restore" +qa
  '';

  programs.neovim = {
    enable = true;
    package = unstable.neovim-unwrapped;
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
      python3

      # LSP
      # nodePackages_latest.intelephense 
      ccls
      delve
      gopls
      htmx-lsp
      lemminx
      llvmPackages_18.clang-tools
      lua-language-server
      nodePackages_latest.graphql-language-service-cli
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
