生成pgp
```
docker run -it --rm --gpus '"device=2"' -v (pwd):/ext nvidia/cuda:11.2.0-cudnn8-devel-ubuntu20.04
apt update
export DEBIAN_FRONTEND=noninteractive
apt install -y git build-essential pkg-config libgcrypt-dev
git clone https://github.com/cuihaoleo/gpg-fingerprint-filter-gpu
cd gpg-fingerprint-filter-gpu
make
./gpg-fingerprint-filter-gpu -a ed25519 bbbbbbbb /ext/b.pgp

# move b.pgp to my PC
gpg --allow-non-selfsigned-uid --import b.pgp
gpg --edit-key BBBBBBBB
gpg> adduid
gpg> uid 1
gpg> deluid
gpg> save
gpg --send-keys BBBBBBBB  --keyserver   hkp://keyserver.ubuntu.com
```

Reference: https://awsl.blog/2020/gpg-fingerprint-filter
