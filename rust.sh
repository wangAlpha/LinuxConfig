#!/bin/zsh

RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

mkdir -p ~/.cargo

echo '[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"

replace-with = "ustc"

[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"

[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"

[source.rustcc]
registry = "git://crates.rustcc.cn/crates.io-index"

[target.x86_64-unknown-linux-gnu]
rustflags = [
    "-C", "link-arg=-fuse-ld=lld",
]' > ~/.cargo/config

curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env

rustup install nightly
rustup default nightly

rustup component add rls-preview --toolchain nightly
rustup component add rls --toolchain nightly
rustup component add rust-analysis --toolchain nightly
rustup component add rust-src --toolchain nightly
rustup component add rustfmt --toolchain nightly
rustup component add clippy-preview --toolchain nightly

cargo install clippy

cargo install racer
cargo install clippy
cargo install sccache
export RUSTC_WRAPPER=`which sccache`
cargo install cargo-update
cargo installl-update -a
cargo install cargo-expand
cargo install cargo-tree
cargo install cargo-watch
cargo install fd
cargo install exa
cargo install lsd
cargo install bat
cargo install cargo-cache
rustup update;

rustup component add clippy rustfmt rls-preview rust-analysis rust-src
