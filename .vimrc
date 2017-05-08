let mapleader="," " leader is a comma
map <leader>cd :cd%:p:h

" relood the current vimrc file
nnoremap <leader>sv :source $MYVIMRC<CR> 
nnoremap <leader>ev :vsp $MYVIMRC<CR> 
nnoremap <leader><leader> :call ToggleNerdTree()<CR>
nnoremap <leader><space> :noh<CR>
nnoremap <leader>a :Ack<space>
nnoremap <F4> :NERDTreeClose<CR>
inoremap jj <ESC>
inoremap <ESC> <Nop>
noremap 0 $
noremap 1 ^
" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \l       : list buffers
" \b \f \g : go back/forward/last-used
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <C-l>   :bn<CR>
nnoremap <C-h> :bp<CR>
nnoremap <Leader>l :ls<CR>
"close current buffer
nnoremap <Leader>d :bdelete<CR>
"force close current buffer, even if there're unsaved changes
nnoremap <Leader>fd :bdelete!<CR>
nnoremap <Leader>v :call VsplitBuffer()<CR>
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

fun! IsWindows()
    return has('win32') || has('win64')
endfun

fun! IsMac()
    return has('gui_macvim')
endfun

fun! IsUnix()
    return has('unix')
endfun

"check if NERDTree buffer is open in the current tab
fun! IsNerdTreeOpen()
    return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfun

" Toggles NERDTree, but uses NERDTreeFind to navigate to the current file
fun! ToggleNerdTree()
    if IsNerdTreeOpen()
        execute ':NERDTreeClose'
    else
        execute ':NERDTreeFind'
    endif
endfun

":GrepBufs <input>
":cn next match
":cp previous match
function! BuffersList()
  let all = range(0, bufnr('$'))
  let res = []
  for b in all
    if buflisted(b)
      call add(res, bufname(b))
    endif
  endfor
  return res
endfunction

function! GrepBuffers (expression)
  exec 'vimgrep/'.a:expression.'/ '.join(BuffersList())
endfunction

command! -nargs=+ GrepBufs call GrepBuffers(<q-args>)

function! VsplitBuffer()
    call inputsave()
    let buf_num = input('Which buffer?')
    call inputrestore()
    exec 'vsp | b '.buf_num
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
set nocompatible                " vi compatible is LAME
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Let vundle manage Vundle
"required
Plugin 'VundleVim/Vundle.vim'
"My bundles go here
Plugin 'bkad/CamelCaseMotion'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/tComment'
Plugin 'tpope/vim-surround'
Plugin 'thinca/vim-quickrun'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'morhetz/gruvbox'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
call vundle#end()
filetype plugin indent on "required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark'

let g:ctrlp_max_depth = 80
let g:ctrlp_max_files = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""' " use ag for searching
let g:ctrlp_working_path = 0 " ctrlp respect changing vim's working directory

if executable('ag')
    let g:ackprg = 'ag --vimgrep' " use ag if it's installed
endif



"set enc=utf-8 not sure if this is needed; see fileencoding=utf-8
set noswf " no swap file

set go-=T "hide toolbar and the gui tabs
set go-=e "Use non-gui tabs
set guifont=Consolas:h14
"----------------COLORS------------------------------
let g:gruvbox_contrast_dark='hard'
color gruvbox
syn on
set background=dark

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

"---------------------------------------------


set cursorline
set smartindent
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
set mouse=a
" allow window resizing with the mouse inside tmux
if &term =~ '^screen'
    set ttymouse=xterm2
endif


