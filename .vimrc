set nocompatible
filetype off                  " required
set shell=bash

" Install vim-plug if we don't already have it
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim-plug/plugins')

Plug 'junegunn/goyo.vim'

Plug 'her/central.vim' "centrolize backup/swap/undo direcotires of VIM

Plug 'vim/killersheep'

Plug 'scrooloose/nerdtree', { 'tag': '*' }

Plug 'ryanoasis/vim-devicons', { 'tag': '*' }

"Plug 'lambdalisue/nerdfont.vim'

"Plug 'mcchrish/nnn.vim'

"Plug 'voldikss/vim-floaterm'

" tabular plugin is used to format tables
Plug 'godlygeek/tabular'
" JSON front matter highlight plugin
"Plug 'elzr/vim-json'
"Plug 'plasticboy/vim-markdown'
"Plug 'pedrohdz/vim-yaml-folds'

Plug 'majutsushi/tagbar'

Plug 'tpope/vim-surround' "Surround plugin

Plug 'ctrlpvim/ctrlp.vim'

"Plug 'ervandew/supertab'

"Plug 'vim-scripts/OmniCppComplete'

Plug 'tpope/vim-ragtag'

Plug 'mileszs/ack.vim'

Plug 'hashivim/vim-terraform'

"Plug 'fatih/vim-go', { 'tag': '*' }

Plug 'vim-scripts/EnhCommentify.vim'

Plug 'vim-scripts/dbext.vim'

Plug 'jeetsukumaran/vim-buffergator'

Plug 'vim-scripts/autoload_cscope.vim'

Plug 'bling/vim-airline' "VIM status line

Plug 'tpope/vim-fugitive' "Git integration

Plug 'neoclide/jsonc.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

Plug 'mattn/emmet-vim'

"Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}

Plug 'rottencandy/vimkubectl'

call plug#end()

filetype plugin indent on
