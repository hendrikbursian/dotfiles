{ pkgs, config, lib, ... }:

{
  xdg.configFile."nvim/after" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.dotfilesHome}/.config/nvim/after";
    recursive = true;
  };

  xdg.configFile."nvim/lua" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.dotfilesHome}/.config/nvim/lua";
    recursive = true;
  };
  xdg.configFile."nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfilesHome}/.config/nvim/lazy-lock.json";

  home.activation.installVueLsp =
    let
      vueLspVersion = "latest";
      neoconfJson = "${config.xdg.configHome}/nvim/neoconf.json";
      pnpm = "${pkgs.nodePackages_latest.pnpm}/bin/pnpm";
    in
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="$PNPM_HOME:$PATH"
      ${pnpm} --version

      ${pnpm} add --prefer-offline --global @vue/language-server@${vueLspVersion} @vue/typescript-plugin@${vueLspVersion}
      store_path=$(${pnpm} root --global)
      typescript_plugin="''${store_path}/@vue/typescript-plugin"
      typescript_lib="${pkgs.typescript}/lib/node_modules/typescript/lib"
      language_server="''$PNPM_HOME/vue-language-server"

      if [[ ! -f ${neoconfJson} ]]; then
        echo {} > ${neoconfJson}
      fi

      jq --arg typescript_plugin "$typescript_plugin" \
         --arg typescript_lib "$typescript_lib" \
         --arg language_server "$language_server" \
         '.vue.typescript_lib = $typescript_lib | 
           .vue.typescript_plugin = $typescript_plugin | 
           .vue.language_server = $language_server' < ${neoconfJson} > ${neoconfJson}.tmp

      mv ${neoconfJson}.tmp ${neoconfJson}
    '';

  # home.activation.installNvimPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   PATH="${pkgs.git}/bin" ${config.programs.neovim.package}/bin/nvim --headless "+Lazy! restore" +qa
  # '';

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
      rust-analyzer
      tailwindcss-language-server
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
