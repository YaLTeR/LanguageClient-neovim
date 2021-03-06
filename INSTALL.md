# 1. Install neovim or vim

Obviously you need [neovim](https://github.com/neovim/neovim#install-from-package) or [vim](http://www.vim.org/)!

# 2. Install dependencies

None.

# 3. Install this plugin

> Choose binary architecture to match your machine. Right now, binaries
> are built for 5 platforms through Travis CI,
> - i686-unknown-linux-musl
> - x86\_64-unknown-linux-musl
> - i686-pc-windows-gnu
> - x86\_64-pc-windows-gnu
> - x86\_64-apple-darwin
> And use it to replace the example architecture inside tags.

> If you don't want to use pre-built binaries, specify branch `next` and `make release` as post
> action after plugin installation and update. e.g., `Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'make release'}`.

Choose steps matching your plugin manager.

## [vim-plug](https://github.com/junegunn/vim-plug) user
Add following to vimrc
```vim
Plug 'autozimu/LanguageClient-neovim', {'tag': 'binary-*-x86_64-apple-darwin' }
```

Restart neovim and run `:PlugInstall` to install.

## [dein.vim](https://github.com/Shougo/dein.vim) user
Add following to vimrc
```vim
call dein#add('autozimu/LanguageClient-neovim', {
    \ 'rev': 'binary-*-x86_64-apple-darwin',
    \ })
```

Restart neovim and run `:call dein#install()` to install.

## Manual
Clone this repo into some place, e.g., `~/.vim-plugins`
```sh
mkdir -p ~/.vim-plugins
cd ~/.vim-plugins
git clone https://github.com/autozimu/LanguageClient-neovim.git
cd LanguageClient-neovim
# Suppose latest release is 0.1.2
git checkout binary-0.1.2-x86_64-apple-darwin
# Or build it locally
# make release
```

Add this plugin to vim/neovim `runtimepath`,
```vim
set runtimepath+=~/.vim-plugins/LanguageClient-neovim
```

# 4. Install language servers
Install language servers if corresponding language servers are not available
yet on your system. Please see <http://langserver.org> and/or
<https://github.com/Microsoft/language-server-protocol/wiki/Protocol-Implementations>
for list of language servers.

# 5. Configure this plugin
Example configuration
```vim
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
```

# 6. Troubleshooting

1. Begin with something small.
    - Backup your vimrc and use [min-init.vim](min-init.vim) as vimrc.
    - Try with [sample projects](tests/data).
1. Run `:echo &runtimepath` and make sure the plugin path is in the list.
1. Make sure language server could be started when invoked manually from shell.
