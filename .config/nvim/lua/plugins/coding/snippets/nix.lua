return {
	"L3MON4D3/LuaSnip",
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local c = ls.choice_node

        -- stylua: ignore
        ls.add_snippets("nix", {
            s('init', {
                t({'{'}),
                t({'', '  inputs.flake-utils.url = "github:numtide/flake-utils";'}),
                t({'', '  outputs ='}),
                t({'', '    { nixpkgs, flake-utils, ... }:'}),
                t({'', '    flake-utils.lib.eachDefaultSystem ('}),
                t({'', '      system:'}),
                t({'', '      let'}),
                t({'', '        pkgs = nixpkgs.legacyPackages.${system};'}),
                t({'', '      in'}),
                t({'', '      {'}),
                t({'', '        devShells.default = pkgs.mkShell {'}),
                t({'', '          # hardeningDisable = ["fortify" ];'}),
                t({'', '          nativeBuildInputs = with pkgs; ['}),
                t({'', '            go'}),
                t({'', '            libGL'}),
                t({'', '            xorg.libX11'}),
                t({'', '            xorg.libXrandr'}),
                t({'', '            xorg.libXcursor'}),
                t({'', '            xorg.libXinerama'}),
                t({'', '            xorg.libXi'}),
                t({'', '            xorg.libXxf86vm'}),
                t({'', '          ];'}),
                t({'', ''}),
                t({'', '        };'}),
                t({'', '      }'}),
                t({'', '    );'}),
                t({'', '}'}),
            })
        })
	end,
}
