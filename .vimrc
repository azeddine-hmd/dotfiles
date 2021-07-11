" [ plug Manager ] "
call plug#begin()
Plug 'mhinz/vim-startify'
Plug 'psliwka/vim-smoothie'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-eunuch'
call plug#end()

" theme
syntax on
set termguicolors
set background=dark
colorscheme gruvbox

" change line color to yellow
highlight LineNr guifg=yellow
highlight CursorLineNr guifg=yellow

" settings
set number relativenumber
set shiftwidth=4
set tabstop=4
set incsearch
set ignorecase
set nobackup
set noswapfile
set nowrap
set nohlsearch
set	mouse=a
set hidden
set splitbelow
set splitright
set textwidth=81
set binary
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=no
set wildmode=longest,list,full

" set system clipboard as default yank and delete register
"set clipboard+=unnamedplus

" [ keymaping ] "
let mapleader = " "

" general
nnoremap <CR> o<ESC>
nnoremap <BS> O<ESC>
nnoremap S    :%s///g<Left><Left><Left>
nnoremap s    :s///g<Left><Left><Left>
nnoremap , F
nnoremap <Leader>br :browse oldfiles<CR>
nnoremap <Leader>. :ls<CR>:b
inoremap <c-u> <esc>mmviwU`ma
"nnoremap <Leader>g :silent :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<CR>:copen 3<CR>
nnoremap <Leader>n :cnext<CR>
nnoremap <Leader>p :cprevious<CR>
nnoremap <Leader>, mmA;<esc>`m
inoremap <c-l> <right>
inoremap <expr> <cr> getline(".")[col(".")-2:col(".")-1]=="{}" ? "<cr><esc>O" : "<cr>"
nnoremap <c-w>s :split<cr>

" notes
nnoremap <F5> :5split ~/notes/work<CR>
nnoremap <F6> :5split ~/notes/vim<CR>

" atag
nnoremap <silent> <Leader>tag       :call atags#generate()<CR>

" coc functions
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" coc binding
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> <Leader>rn <Plug>(coc-rename)
nnoremap <silent> <Leader>r  :GoRun<CR>
nnoremap <silent> <Leader>K  :call <SID>show_documentation()<CR>

" split mapping
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap - <C-W>-
nnoremap = <C-W>+
nnoremap <Leader>l 15zl
nnoremap <Leader>h 15zh

" matches
let s:includelist = []
function Matcher()
		inoremap { {}<esc>i
		inoremap ( ()<esc>i
		inoremap " ""<esc>i
		inoremap ' ''<esc>i
		inoremap [ []<esc>i
endfunction
autocmd BufWinEnter * if index(s:includelist, expand('%:e')) >= 0 | call Matcher()

" [ norminette ] "
nnoremap <F2> :! norminette %<CR>
highlight ColorColumn ctermbg=Red
set cc=81
let ignorelist = ['cub']
augroup norminette
	autocmd!
	"autocmd StdinReadPre * let s:std_in=1
	autocmd BufWritePre * if index(ignorelist, expand('%:e')) < 0 | %s/\s\+$//ge
	autocmd BufWritepre * if index(ignorelist, expand('%:e')) < 0 | %s/\n\+\%$//e
augroup END

" disable autocomment
augroup disable_comments
	autocmd!
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" Run xrdb whenever Xdefaults or Xresources are updated.
augroup xrdb
	autocmd!
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
augroup END

" Operators ------------------ {{{
" operator mapping for augroup
onoremap inau :<c-u>execute "normal! ?augroup\rjV/augroup END\rk"<CR>

" operator mapping for '('
onoremap in( :<c-u>normal! f)vi)<cr>
onoremap il( :<c-u>normal! F)vi)<cr>
onoremap ar( :<c-u>normal! f)va)<cr>
onoremap al( :<c-u>normal! F)va)<cr>

" operator mapping for '{'
onoremap in{ :<c-u>normal! f}vi}<cr>
onoremap il{ :<c-u>normal! F}vi}<cr>
onoremap ar{ :<c-u>normal! f}va}<cr>
onoremap al{ :<c-u>normal! F}va}<cr>

" operator mapping for ','
onoremap in, :<c-u>normal! f,lvt,<cr>
onoremap il, :<c-u>normal! F,hvF,l<cr>

" operator mapping for '<'
onoremap in< :<c-u>normal! f<lvt><cr>
onoremap il< :<c-u>normal! F>hvF<l<cr>

" operator mapping for '['
onoremap in[ :<c-u>normal! f]vi]<cr>
onoremap il[ :<c-u>normal! F]vi]<cr>
onoremap ar[ :<c-u>normal! f]va]<cr>
onoremap al[ :<c-u>normal! F]va]<cr>
" }}}

" Vimscript file settings ----------------  {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" netrw
nnoremap <Leader>e :15Vexplore<cr>
let g:netrw_banner = 0
let g:netrw_liststyle = 0
let g:netrw_browse_split = 0
let g:netrw_winsize = 0
let g:netrw_altv = 0
let g:netrw_localrmdir='rm -r'

" ctags
nnoremap <silent> <F9> :! ctags -R .<cr>

" fzf
nnoremap <leader>f	:Files<cr>
nnoremap <leader>g	:Rg<cr>
nnoremap <Leader>t	:Tags<cr>

" c comment follows norminette rules
nnoremap <leader>cc :read! cat ~/.vim/snippets/c_norm_comment<cr>kla<space>

" plugins runtimepath
set rtp+=~/development/neovim/my-first-plugin/