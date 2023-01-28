set -x

cargo install fd-find
cargo install ripgrep
cargo install bat
cargo install sd
cargo install exa
cargo install coreutils
cargo install dust
cargo install watchexec

sudo apt-get install -y zsh htop httpie rsync

curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

pip install mycli
pip install tldr
pip install ptpython
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
