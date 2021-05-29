set nocompatible
filetype off                  " required
set shell=bash

" Install vim-plug if we don't already have it
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/Programs/vim-plugins')

Plug 'her/central.vim' "centrolize backup/swap/undo direcotires of VIM

Plug 'vim/killersheep'

Plug 'scrooloose/nerdtree'

Plug 'ryanoasis/vim-devicons'

Plug 'majutsushi/tagbar'

Plug 'tpope/vim-surround' "Surround plugin

Plug 'ctrlpvim/ctrlp.vim'

Plug 'ervandew/supertab'

Plug 'vim-scripts/OmniCppComplete'

Plug 'tpope/vim-ragtag'

Plug 'mileszs/ack.vim'

Plug 'fatih/vim-go'

Plug 'vim-scripts/EnhCommentify.vim'

Plug 'vim-scripts/dbext.vim'

Plug 'jeetsukumaran/vim-buffergator'

Plug 'vim-scripts/autoload_cscope.vim'

Plug 'bling/vim-airline' "VIM status line

Plug 'tpope/vim-fugitive' "Git integration


call plug#end()

filetype plugin indent on
