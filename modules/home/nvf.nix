{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        # Basic Options (AstroCore alignment)
        options = {
          shiftwidth = 4;
          tabstop = 4;
          expandtab = true;
          relativenumber = true;
          number = true;
          wrap = false;
          spell = false;
        };

        # Keymaps (AstroCore alignment)
        maps.normal = {
          "<leader>bl" = {
            action = "<cmd>Telescope buffers<CR>";
            desc = "List Buffers";
          };
          "<S-h>" = {
            action = "<cmd>bprevious<CR>";
            desc = "Previous Buffer";
          };
          "<S-l>" = {
            action = "<cmd>bnext<CR>";
            desc = "Next Buffer";
          };
        };

        lsp = {
          formatOnSave = false; # Disabled per AstroLSP config
          lightbulb.enable = true;
          lspsaga.enable = false;
          nvim-docs-view.enable = true;
        };

        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          markdown.enable = true;
          html.enable = true;
          css.enable = true;
          ts.enable = true;
          lua.enable = true;
          zig.enable = true;
          python.enable = true;
          rust.enable = true;
          clang.enable = true;
          tailwind.enable = true;
        };

        statusline.lualine.enable = true;

        telescope = {
          enable = true;
          setupOpts = {
            defaults = {
              vimgrep_arguments = [
                "rg"
                "--color=never"
                "--no-heading"
                "--with-filename"
                "--line-number"
                "--column"
                "--smart-case"
                "--hidden"
                "--glob=!.git/"
              ];
            };
            pickers = {
              find_files = {
                hidden = true;
                no_ignore = true;
              };
            };
          };
        };

        autocomplete.nvim-cmp.enable = true;
        autopairs.nvim-autopairs.enable = true;

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
        };

        utility = {
          ccc.enable = true;
          diffview-nvim.enable = true;
          motion.hop.enable = true;
        };

        notes.todo-comments.enable = true;

        filetree.nvimTree = {
          enable = true;
        };
      };
    };
  };
}

