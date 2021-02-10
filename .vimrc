if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

let mapleader="," " leader is a comma

" relood the current vimrc file
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>cv :vsp $MYVIMRC<CR>

nnoremap <leader><leader> :call SmartToggleNERDTree()<CR>
nnoremap <leader><space> :noh<CR>
" <leader>f is more appropriate but adds a delay to discern <leader>f from <leader>fd
" e is mnemonic for explore
nnoremap <leader>e :Files<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>/ :BLines<CR>
nnoremap <leader>m :make<CR><CR>
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>af :Autoformat<CR>
nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap <leader>+ :call CopyBufferFullPath()<CR>
" sane Y
nnoremap Y y$
inoremap jj <ESC>
noremap 0 $
nnoremap K :call SplitLine()<CR>

" when stuck in the last preview-window, change it to a normal window
nnoremap <leader>x :new %<CR><C-o>:pc<CR>
" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \l       : list buffers
" \b \f \g : go back/forward/last-used
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>
"close current buffer (without losing the split state of the window)
nnoremap <Leader>d :call CloseBufferAndDisplayNext(0)<CR>
"force close current buffer, even if there're unsaved changes
nnoremap <Leader>fd :call CloseBufferAndDisplayNext(1)<CR>
nnoremap <Leader>v :call VsplitBuffer()<CR>
nnoremap <Leader>s :call HsplitBuffer()<CR>
nmap  -  <Plug>(choosewin)
" turn terminal window into a normal window 
tnoremap <C-n> <C-\><C-n>
" nnoremap <Leader>b :bp<CR>
" nnoremap <Leader>f :bn<CR>
" nnoremap <Leader>g :e#<CR>
" nnoremap <Leader>1 :1b<CR>
" nnoremap <Leader>2 :2b<CR>
" nnoremap <Leader>3 :3b<CR>
" nnoremap <Leader>4 :4b<CR>
" nnoremap <Leader>5 :5b<CR>

map <S-W> <Plug>CamelCaseMotion_w
map <S-B> <Plug>CamelCaseMotion_b

"check if NERDTree buffer is open in the current tab
fun! IsNerdTreeOpen()
    return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfun

" Toggles NERDTree, but uses NERDTreeFind to navigate to the current file
fun! SmartToggleNERDTree()
    if IsNerdTreeOpen()
        NERDTreeClose
    else
        NERDTreeFind
    endif
endfun

function! VsplitBuffer()
    call inputsave()
    let l:buf_num = input('Enter buffer number to vsplit:')
    call inputrestore()
    exec 'vsp | b '.buf_num
endfunction

function! HsplitBuffer()
    call inputsave()
    let l:buf_num = input('Enter buffer number to split:')
    call inputrestore()
    exec 'sp | b '.buf_num
endfunction

" Copies the full path of the file in the current buffer to the system clipboard
function! CopyBufferFullPath()
    let @+ = expand("%:p")
	echo @+
endfunction

function! CloseBufferAndDisplayNext(force)
    let l:cur_buf = bufnr("%")
    exec 'bn'
    if a:force
        exec 'bdelete! '.cur_buf
    else
        "bdelete will close the window (losing the split) if the same file is open in two buffers
        exec 'bdelete '.cur_buf
    endif
endfunction

function! SplitLine()
    exec "normal! i\<CR>\<ESC>k$"
    let l:ch = getline('.')[col('.') - 1]
    if l:ch =~ '\s'
        exec "normal! x"
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                " vi compatible is LAME
filetype off
call plug#begin('~/.vim/plugged')
Plug 'ajh17/VimCompletesMe'
" let b:vcm_tab_complete = 'tags'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

Plug 'bkad/CamelCaseMotion'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/tComment'
Plug 'tpope/vim-surround'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'marcomagdy/gruvbox'
Plug 'tpope/vim-unimpaired'
Plug 'PeterRincker/vim-argumentative'
Plug 'tommcdo/vim-lion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'justinmk/vim-sneak'
Plug 'machakann/vim-highlightedyank'
Plug 'wellle/targets.vim'
Plug 't9md/vim-choosewin'
call plug#end()
filetype plugin indent on "required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:fzf_preview_window = [] " preview window slows down things considerably, so disable it.
" ctrl-v should be ctrl-s to be consistent with nerdtree BUT tmux uses ctrl-s, so we can't.
let g:fzf_action = {
			\ 'ctrl-i': 'split',
			\ 'ctrl-v': 'vsplit',
			\ 'ctrl-t': 'tab split'}

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark'
let g:sneak#s_next = 1
let g:sneak#f_reset = 1
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:highlightedyank_highlight_duration = 750

let g:quickrun_config = {}
let g:quickrun_config.cpp = {'cmdopt' : '-fsanitize=address -std=c++17 -Wall -Wextra'}

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        let g:lsp_diagnostics_enabled = 1 " default must be 'enabled' for the toggle to work
        autocmd User lsp_setup if g:lsp_diagnostics_enabled | call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd','--clang-tidy', '--suggest-missing-includes']},
                    \ 'whitelist': ['c', 'cpp', 'cc', 'objc', 'objcpp'],
                    \ })
                    \ | endif
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType cc setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete

        autocmd FileType cpp nnoremap gd :LspDefinition<CR>
    augroup end
    command! ToggleLsp  let g:lsp_diagnostics_enabled = !g:lsp_diagnostics_enabled
endif



" use ripgrep (rg) as default grep program
if executable('rg')
    set grepprg=rg\ -S\ --vimgrep
endif

" use ninja instead of make. Switch to build dir first
if executable('ninja')
    set makeprg=ninja\ -C\ build
elseif executable('make')
    set makeprg=make\ -C\ build
endif

set enc=utf-8
set noswf " no swap file

set go-=T "hide toolbar and the gui tabs
set go-=e "Use non-gui tabs
set guifont=Consolas_NF:h14
"----------------COLORS------------------------------
let g:gruvbox_contrast_dark='medium'
let c_space_errors=1
color gruvbox
syn on
set background=dark "useful in gui version

" highlight clear SignColumn
" highlight VertSplit    ctermbg=236
" highlight ColorColumn  ctermbg=237
" highlight LineNr       ctermbg=236 ctermfg=240
" highlight CursorLineNr ctermbg=236 ctermfg=240
" highlight CursorLine   ctermbg=15  ctermfg=0
" highlight StatusLineNC ctermbg=238 ctermfg=0
" highlight StatusLine   ctermbg=240 ctermfg=12
" highlight IncSearch    ctermbg=3   ctermfg=1
" highlight Search       ctermbg=1   ctermfg=3
highlight Visual       ctermbg=15   ctermfg=163
" highlight Pmenu        ctermbg=240 ctermfg=12
" highlight PmenuSel     ctermbg=3   ctermfg=1
" highlight SpellBad     ctermbg=0   ctermfg=1
highlight SpellBad     cterm=underline

"---------------------------------------------

if !&scrolloff
    set scrolloff=1 " show at least 1 line above/below cursor
endif
set enc=utf-8
set noswf " no swap file
set listchars=tab:>\ ,trail:~,extends:>,precedes:<,nbsp:+
set list
set cursorline
set smartindent
set cinoptions=g0 " do not indent C++ scope declarations
set tabstop=4
set shiftwidth=4
set expandtab
set number
set autoread
set incsearch
set hlsearch
set smartcase
set ignorecase
set lazyredraw
set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. 
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set showmode                    " show the current mode
set colorcolumn=120             " display a line length marker
set textwidth=120
set spell
set mouse=a
set hidden                      " switching from a modified buffer hides it. Avoids the 'must save or discard' warning
set undofile
set undodir=~/.vim/undodir
set autowrite                   " save the buffers to disk when running commands like 'make'
set dip+=vertical               " diffopt - open diff in vertical windows
set nomodeline                  " disable executing some ex commands embedded in text file

" why doesn't my mouse work past the 220th column?
if has("mouse_sgr")
    set ttymouse=sgr
elseif !has('nvim')
    set ttymouse=xterm2
end


