{ pkgs, config, lib, ... }:

{
  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.dotfilesHome}/.config/nvim";
    recursive = true;
  };

  home.activation.initNeoconfJson =
    let
      neoconfJson = "${config.xdg.configHome}/nvim/neoconf.json";
    in
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [[ -f neoconf.json ]]; then
        jq '.volar.typescript_path = "${pkgs.typescript}"' ${neoconfJson} > ${neoconfJson}.tmp
        mv ${neoconfJson}.tmp ${neoconfJson}
      else
        echo "{ \"volar\": { \"typescript_path\": \"${pkgs.typescript}\" } }" | jq > ${neoconfJson}
      fi
    '';

  home.activation.installNvimPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PATH="${pkgs.git}/bin" ${pkgs.unstable.neovim-unwrapped}/bin/nvim --headless "+Lazy! restore" +qa
  '';

  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    vimAlias = true;
    extraPackages = with pkgs;[
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
      unstable.vue-language-server
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
