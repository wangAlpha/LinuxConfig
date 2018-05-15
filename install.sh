sudo apt-get update;
sudo apt-get install git -y;
sudo apt-get install vim -y;
sudo apt-get install emacs -y;
sudo apt-get install curl -y;
sudo apt-get install htop -y;

sudo apt-get install mysql-client mysql-server -y;
sudo apt-get install redis -y;
sudo apt-get install build-essential -y;
sudo apt-get install llvm -y;
sudo apt-get install clang-5.0 -y;
sudo apt-get install clang-format-5.0 -y;
sudo apt-get install screen -y;

sudo apt-get install golang -y;
sudo apt-get install gocode -y;

sudo apt-get install python3 -y;
sudo apt-get install pylint3 -y
sudo apt-get install mpg123 -y;
sudo apt-get install python3-pip -y;
sudo pip3 install --upgrade pip; 
sudo pip3 install ptpython;
sudo pip3 install Netease-Musicbox - y;
sudo pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U;

sudo apt-get install shadowsocks -y;
sudo apt-get install jq -y;
sudo snap install pycharm-community --classic;
sudo snap install snapd -y;
sudo snap install electronic-wechat;

sudo apt-get install zsh -y;
sudo sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo chsh -s `which zsh`;

sudo apt-get install tlp tlp-rdw -y;
sudo tlp start;
sudo apt-get install gnome-tweak-tool -y;

sudo curl https://sh.rustup.rs -sSf | sh;
sudo apt-get install cargo -y;
cargo install racer;
rustup component add rust-src;
rustup install nightly;
rustup update nightly
cargo +nightly install --force clippy;
rustup component add rustfmt-preview;

sudo add-apt-repository ppa:noobslab/macbuntu;
sudo apt-get install macbuntu-os-icons-lts-v7 -y;
sudo apt-get install macbuntu-os-ithemes-lts-v7 -y;
sudo apt-get install albert -y;

sudo apt-get install --no-install-recommends gdm3 -y;
sudo apt-get install chromium-browser -y;
sudo apt-get remove ligthdm -y;                                           

sudo apt-get update;
sudo apt-get upgrade -y;
sudo apt-get dist-upgrade -y;
