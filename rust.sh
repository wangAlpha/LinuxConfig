#!/bin/zsh

RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

mkdir -p ~/.cargo

echo '[source.crates-io]
replace-with = "ustc"

[source.ustc]
registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"

[target.x86_64-unknown-linux-gnu]
rustflags = [
    "-C", "link-arg=-fuse-ld=lld",
]' > ~/.cargo/config

source $HOME/.cargo/env

rustup install nightly
rustup default nightly

rustup component add rls-preview --toolchain nightly
rustup component add rls --toolchain nightly
rustup component add rust-analysis --toolchain nightly
rustup component add rust-src --toolchain nightly
rustup component add clippy-preview --toolchain nightly

rustup component add clippy-preview rls-preview rust-analysis rust-src

cargo install racer cargo-cache lsd bat
cargo install fd-find ripgrep;
cargo install procs tokei bat exa sd coreutils
cargo install du-dust cargo-cache watchexec ytop bottom
cargo cache -a

rustup update;

rm -rf $HOME/.cargo/registry
