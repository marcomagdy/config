"leader is '\' by default
map <leader>cd :cd%:p:h

nnoremap <leader><leader> :NERDTreeFind<CR>
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
nnoremap <C-Tab>   :bn<CR>
nnoremap <C-S-Tab> :bp<CR>
nnoremap <Leader>l :ls<CR>
"close current buffer
nnoremap <Leader>d :bdelete<CR>
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
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()
filetype plugin indent on "required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1


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
" highlight the cursor line on the active buffer only
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END


"set enc=utf-8 not sure if this is needed; see fileencoding=utf-8
set noswf " no swap file

set go-=T "hide toolbar and the gui tabs
set go-=e "Use non-gui tabs
set guifont=Consolas:h14
"----------------COLORS------------------------------
color desert
syn on
set background=dark

highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
highlight LineNr       ctermbg=236 ctermfg=240
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=15  ctermfg=0
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=240 ctermfg=12
highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1
highlight SpellBad     ctermbg=0   ctermfg=1

"---------------------------------------------


" Below are the settings from Git installation
" Setting some decent VIM settings for programming

set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set showmode                    " show the current mode


