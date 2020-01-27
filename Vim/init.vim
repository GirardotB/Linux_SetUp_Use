" (N)VIM PLUG -----------------------------------------------------
" --------------------------------------------------------------
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" THE Git wrapper 
Plug 'tpope/vim-fugitive'

" Seems hard to handle with but looks nice 
Plug 'junegunn/vim-easy-align'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Nerdtree 
Plug 'https://github.com/preservim/nerdtree'

" YCM & supertab 
Plug 'https://github.com/ycm-core/YouCompleteMe'
Plug 'https://github.com/ervandew/supertab' 

" Polygot (languages highlighting/synthaxing) 
Plug 'https://github.com/sheerun/vim-polyglot'

" (Color) themes 
" Gruvbox 
Plug 'morhetz/gruvbox'
" Onedark
Plug 'https://github.com/joshdick/onedark.vim'

" vim-airline 
Plug 'vim-airline/vim-airline'

" NERD commenter (not yet used ot it) 
" :help nerdcommenter
" examples of uses 
Plug 'scrooloose/nerdcommenter'

" vim-markdown
" ref: https://vimawesome.com/plugin/markdown-syntax
" disable folding ? see refs 
Plug 'plasticboy/vim-markdown'

" vim-bookmarks
Plug 'https://github.com/MattesGroeger/vim-bookmarks'


" vim-pandoc-markdown-preview
Plug 'https://github.com/conornewton/vim-pandoc-markdown-preview' 

call plug#end()





" General setting ----------------------------
" I have still no idea what some lines mean
" Took from https://gist.github.com/edrpls/540981968026da7567e93ebb40e82983<Paste>

" Whitespace stuff
"set nowrap
set tabstop=8
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab
set list listchars=tab:▸\ ,trail:·
" Wordwrap
set wrap
set linebreak
set nolist " list disables linebreak
set textwidth=0
set wrapmargin=0

set number
set ruler
set relativenumber
set synmaxcol=1000
set clipboard=unnamed



" vim-markdown 
" to disable the folding in all documents 
" set nofoldenable 
" or just in md files: 
let g:vim_markdown_folding_disabled = 1


" To configure the folding in different ways: 
" let g:vim_markdown_folding_level = 6
" let g:vim_markdown_folding_style_pythonic = 1

" For mathematics: 
let g:vim_markdown_math = 1



" Themes --------------------------------
"
" Color theme 
" In order to see if the terminal emulator support 24-bit color, do this 
" printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
" If TRUECOLOR is printed in red, it does. 
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
" Set onedark theme for default theme 
colorscheme onedark
" --------------------------- 

" Nerdtree 
" Opened by default 
" au VimEnter *  NERDTree


" YouCompleteMe setting (needed to be functional) 
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']


" Vim-bookmarks
" Enables highligh of the marked lines  
let g:bookmark_highlight_lines = 1
" Sign of bookmarks in the left column  
 let g:bookmark_sign = '♥'
" Automatically close bookmarks split when jumping to a bookmark 
let g:bookmark_auto_close = 1
"" " Next line allows grouping of bookmarks per root directory. This way
"" bookmarks from other projets are not interfering. This is done by saving a
"" file called .vim-bookmartks into the current working directory. CARE, you
"" should add the filemame .vim-bookmarks to your (global) .gitignore file so
"" it doesn't get checked into verson control.
 let g:bookmark_save_per_working_dir = 1
 let g:bookmark_auto_save = 1 


 " Vim-pandoc-markdown-preview 
 "
 " set Okular as default preview previewer 
 let g:md_pdf_viewer="Okular"

