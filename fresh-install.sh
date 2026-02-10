cd ~

# Install Oh-My-Zsh
if [ ! -d "~/.oh-my-zsh" ]; then
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
fi

# Symlink for zsh
rm .zshrc
ln -s dotfiles/.zshrc .zshrc

# Symlink for .config
mkdir -p .config
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/tmux ~/.config/tmux

# Install cargo
curl https://sh.rustup.rs -sSf | sh
# Install treesitter
cargo install --locked tree-sitter-cli

