{ pkgs, ... }:
{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {  }).customize{
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.plug.plugins = with pkgs.vimPlugins; 

      [ ];


      vimrcConfig.customRC = ''
        " your custom vimrc

  " Plugin Loading
call plug#begin('~/.vim/plugged')
Plug 'Yggdroot/indentLine' " zorgt voor duidelijke indents
Plug 'SirVer/ultisnips' " snippets
Plug 'honza/vim-snippets'
Plug 'vim-scripts/AutoComplPop' " autocompletion
Plug 'davidhalter/jedi-vim' " python type suggestion
Plug 'tpope/vim-fugitive'
" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop'}
Plug 'jceb/vim-scrollcenter'

Plug 'itchyny/lightline.vim' "Highlights lines
Plug 'joshdick/onedark.vim' "The One Dark Theme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' "Fuzzy find plugin
Plug 'junegunn/goyo.vim' "Removes Line numbers for focusing
Plug 'mbbill/undotree' "Creates an undo tree
Plug 'preservim/nerdtree' "File browser inside vim
Plug 'godlygeek/tabular' "Auto formatting
Plug 'plasticboy/vim-markdown' "Markdown syntax highlighting
Plug 'ryanoasis/vim-devicons' "Cool icons for nerd tree
Plug 'Xuyuanp/nerdtree-git-plugin' "nerd tree customization
Plug '907th/vim-auto-save' "auto saves files as you edit
Plug 'jdhao/better-escape.vim' "remaps esc key to jj
call plug#end() 

	" Startup Settings
	syntax on
  let mapleader=" " "Maps Leader to space
  let NERDTreeShowHidden=1
  let g:auto_save = 1
  let g:auto_save_events = ["InsertLeave", "TextChanged"]
  let $FZF_DEFAULT_COMMAND = 'fdfind --type f --hidden --follow --exclude .git --ignore-file ~/.ignore'
  " set mouse=a "Allows mouse usage inside vim. Great for noobs.
  set clipboard=unnamedplus "Remaps default copy paste to system clipboard
  set cursorline
  highlight CursorLine ctermbg=Yellow cterm=bold guibg=#2b2b2b
	set noerrorbells
  set splitbelow splitright
	set tabstop=2 softtabstop=2
	set shiftwidth=2
	set expandtab
	set smartindent
  set nofoldenable
	set nowrap
	set smartcase
	set noswapfile
	set nobackup
	set incsearch
	set history=5000
	set nocompatible
  set number relativenumber
  colorscheme onedark
  set background=dark
  set termguicolors
	filetype plugin on
	set encoding=utf-8
	set wildmenu
	set wildmode=longest,list,full
	set laststatus=2
	if !has('gui_running')
	  set t_Co=256
	endif
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
	" set spell spelllang=en_us
  filetype indent on
  set ignorecase

  " Plugin Shortcuts
	map <Leader>f :NERDTreeToggle<CR>
	map <C-\> :Goyo<CR>
  nnoremap <F5> :UndotreeToggle<CR> :UndotreeFocus<CR>
  nnoremap <C-f> :Files!<CR>
  nnoremap <Leader>l :Tabularize /
  let g:better_escape_shortcut = 'jj'
  let g:better_escape_interval = 250

" General Shortcuts
  nnoremap S :%s//g<Left><Left>
  nmap <Leader>r :w<CR>:so %<CR>
  map <Leader>e $

" Persistent_undo
	set undodir=~/.vim/undodir"
	set undofile
	let g:undotree_WindowLayout = 2

" Tabedit keybinds
  nnoremap <Leader>1 1gt<CR>
  nnoremap <Leader>2 2gt<CR>
  nnoremap <Leader>3 3gt<CR>
  nnoremap <Leader>4 4gt<CR>
  nnoremap <Leader>5 5gt<CR>
  nnoremap <Leader>t :tabnew<CR>
  nnoremap <Leader>c :tabclose<CR>

  " Markdown Edits
  let g:vim_markdown_autowrite = 1
  let g:vim_markdown_no_extensions_in_markdown = 1
  let g:vim_markdown_conceal = 0
  let g:vim_markdown_override_foldtext = 0
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_new_list_item_indent = 0

" Markdown auto format tables
        inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a


" transparent bg
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE


let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:ultiSnipsBackwardTrigger="<c-z>"
let g:indentLine_char = '|'

autocmd BufNewFile *.sh normal ggO#!/bin/bash
autocmd BufNewFile *.py normal ggO#!/bin/pyhton3

set pastetoggle=<F2>

let g:pymode_lint_cwindow = 0 " zet python errors onderaan
        " ...
      '';
    }
  )];
}
