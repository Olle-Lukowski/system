{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    options = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };

    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        action = "<cmd>Oil<CR>";
	key = "<leader>pv";
      }
      {
        action = ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>";
	key = "<C-+>";
	options = {
	  silent = true;
	};
      }
      {
	action = ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>";
	key = "<C-->";
	options = {
	  silent = true;
	};
      }
      {
	action = ":lua vim.g.neovide_scale_factor = 1<CR>";
	key = "<C-0>";
	options = {
	  silent = true;
	};
      }
    ];

    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };

    plugins = {
      lualine = {
        enable = true;

	globalstatus = true;
      };

      bufferline = {
        enable = true;
      };

      telescope = {
	enable = true;

	keymaps = {
	  "<leader>fg" = "live_grep";
	  "<leader>ff" = "find_files";
	  "<leader>fb" = "buffers";
	  "<leader>fh" = "help_tags";
	};
      };

      oil = {
        enable = true;
      };

      copilot-lua = {
        enable = true;

	suggestion.autoTrigger = true;
      };

      treesitter.enable = true;
      luasnip.enable = true;

      lsp-format.enable = true;

      lsp = {
        enable = true;

	servers = {
	  rust-analyzer.enable = true;
	  zls.enable = true;
	  zls.package = null;
	  clangd.enable = true;
	  cmake.enable = true;
	  nixd.enable = true;
	};

	keymaps.lspBuf = {
	  K = "hover";
	  gd = "definition";
	  "<leader>ca" = "code_action";
	  "<leader>rn" = "rename";
	  "<C-h>" = "signature_help";
	};
      };

      cmp = {
        enable = true;

	autoEnableSources = true;
	settings = {
	  sources = [
	    {name = "nvim_lsp";}
	    {name = "path";}
	    {name = "buffer";}
	  ];

	  mapping = {
	    "<C-Space>" = "cmp.mapping.complete()";
	    "<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })";
	    "<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })";
	    "<C-y>" = "cmp.mapping.confirm({ select = true })";
	  };

	  snippet.expand = ''
	    function(args)
	      require('luasnip').lsp_expand(args.body)
	    end
	  '';
	};
      };
    };
  };
}
