{ inputs, ... }: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        debugMode = {
          enable = false;
          level = 20;
          logFile = "/tmp/nvf.log";
        };


        lsp = {
          formatOnSave = true;
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
        telescope.enable = true;
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
