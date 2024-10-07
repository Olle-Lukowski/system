{ inputs, pkgs, config, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard

		# For telescope
		fd
		ripgrep
  ];

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    vimdiffAlias = true;
    viAlias = true;
    vimAlias = true;

    opts = {
      updatetime = 100;

      number = true;
      relativenumber = true;

      shiftwidth = 2;
      tabstop = 2;

			smartindent = true;
			expandtab = true;
    };

    globals = {
      mapleader = " ";
    };

		keymaps = [
		  {
			  action = "<CMD>Oil<CR>";
				key = "-";
			}
			{
			  action = "<CMD>Lspsaga incoming_calls<CR>";
				key = "<leader>ci";
				options = {
				  desc = "Show incoming calls (LSP)";
				};
			}
			{
			  action = "<CMD>Lspsaga outgoing_calls<CR>";
				key = "<leader>co";
				options = {
				  desc = "Show outgoing calls (LSP)";
				};
			}
			{
			  action = "<CMD>Lspsaga code_action<CR>";
				key = "<leader>ca";
				options = {
				  desc = "Show code actions (LSP)";
				};
			}
			{
			  action = "<CMD>Lspsaga peek_definition<CR>";
				key = "<leader>pd";
				options = {
				  desc = "Peek definition (LSP)";
				};
			}
			{
			  action = "<CMD>Lspsaga goto_definition<CR>";
				key = "<leader>gd";
				options = {
				  desc = "Goto definition (LSP)";
				};
			}
			{
			  action = "<CMD>Lspsaga diagnostic_jump_next<CR>";
				key = "<leader>dn";
				options = {
				  desc = "Next diagnostic (LSP)";
				};
			}
			{
			  action = "<CMD>Lspsaga diagnostic_jump_prev<CR>";
				key = "<leader>dp";
				options = {
				  desc = "Previous diagnostic (LSP)";
				};
			}
			{
			  action = "<CMD>Lspsaga finder<CR>";
				key = "<leader>lf";
				options = {
				  desc = "Show finder (LSP)";
				};
			}
			{
			  action = "<CMD>Lspsaga hover_doc<CR>";
				key = "K";
				options = {
				  desc = "Hover documentation (LSP)";
				};
			}
			{
			  action = "<CMD>Lspsaga rename<CR>";
				key = "<leader>rn";
				options = {
				  desc = "Rename symbol (LSP)";
				};
			}
		];

    plugins = {
			which-key.enable = true;
			web-devicons.enable = true;
			bufferline.enable = true;
			oil.enable = true;
			nvim-autopairs.enable = true;
			luasnip.enable = true;
			markdown-preview.enable = true;
			lsp-format.enable = true;
      leap.enable = true;

			lualine = {
			  enable = true;

				settings.options.globalstatus = true;
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

      treesitter = {
        enable = true;

	      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
	        nix toml markdown regex rust json asm
	      ];

        settings = {
          indent.enable = true;
        };
      };

			lsp = {
			  enable = true;

				servers = {
				  rust-analyzer = {
					  enable = true;

						# This will be handled per project
						package = null;
						cargoPackage = null;
						rustcPackage = null;
						installCargo = false;
						installRustc = false;

						settings = {
						  imports = {
							  preferNoStd = true;
								preferPrelude = true;
							};
						};
					};

					nixd.enable = true;
				};
			};

			lspsaga = {
			  enable = true;

				lightbulb = {
				  sign = false;
				};
			};

			cmp = {
			  enable = true;

				autoEnableSources = true;

				settings = {
				  sources = [
					  { name = "nvim_lsp"; }
					  { name = "path"; }
					];

					mapping = {
					  "<C-Space>" = "cmp.mapping.complete()";
					  "<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })";
					  "<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })";
					  "<C-y>" = "cmp.mapping.confirm({ select = true })";
					};

					snippet.expand = ''
					  function(args)
						  require 'luasnip'.lsp_expand(args.body)
						end
					'';
				};
			};
    };

		extraPlugins = with pkgs.vimPlugins; [
		  base16-nvim
		];

		extraConfigLua = with config.colorScheme.palette; ''
		  require 'base16-colorscheme'.setup {
			  base00 = '#${base00}',
			  base01 = '#${base01}',
			  base02 = '#${base02}',
			  base03 = '#${base03}',
			  base04 = '#${base04}',
			  base05 = '#${base05}',
			  base06 = '#${base06}',
			  base07 = '#${base07}',
			  base08 = '#${base08}',
			  base09 = '#${base09}',
			  base0A = '#${base0A}',
			  base0B = '#${base0B}',
			  base0C = '#${base0C}',
			  base0D = '#${base0D}',
			  base0E = '#${base0E}',
			  base0F = '#${base0F}',
			}
		'';
  };
}
