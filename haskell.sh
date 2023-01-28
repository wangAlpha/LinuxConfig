set -x
# https://mirror.xyz/0xdB4907968b599f0fb530693eF457BdE801544031/sG9PAIIVhL7urJNSze_xnjg409QYGZFgvmnqxUriuOk
mkdir -p ~/.cabal
echo 'repository mirrors.ustc.edu.cn
  url: https://mirrors.ustc.edu.cn/hackage/
  secure: True' >> ~/.cabal/config

curl --proto '=https' --tlsv1.2 -sSf https://mirrors.ustc.edu.cn/ghcup/sh/bootstrap-haskell | BOOTSTRAP_HASKELL_YAML=https://mirrors.ustc.edu.cn/ghcup/ghcup-metadata/ghcup-0.0.7.yaml sh
source ~/.ghcup/env

# '>>~/.ghcup/config.yaml
# url-source:
#     OwnSource: https://mirrors.ustc.edu.cn/ghcup/ghcup-metadata/ghcup-0.0.7.yaml

cabal install hlint
