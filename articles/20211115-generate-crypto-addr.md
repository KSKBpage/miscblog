生成btc地址
```
docker run -it --rm --gpus '"device=0,1"' nvidia/cuda:11.6.1-cudnn8-devel-ubuntu20.04

apt update
apt install -y git build-essential
git clone https://github.com/JeanLucPons/VanitySearch
cd VanitySearch
make gpu=1 CUDA=/usr/local/cuda  CXXCUDA=/usr/bin/g++ CCAP=7.5 all
./VanitySearch  -gpu 3FeedKskb
```

生成eth地址
```
docker run -it --rm --gpus '"device=0,1"' nvidia/opencl

apt update
apt install -y git xxd build-essential
git clone https://github.com/1inch/profanity2
cd profanity2
make

openssl ecparam -genkey -name secp256k1 -text -noout -outform DER | xxd -p -c 1000 | sed 's/41534e31204f49443a20736563703235366b310a30740201010420//' | sed 's/a00706052b8104000aa144034200/\'$'\n/' | tee keys.txt
head -1 keys.txt > keys.privkey
tail -1 keys.txt | cut -c 3- > keys.pubkey

./profanity2.x64  --matching feedbbbbXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -z $(<keys.pubkey)
```

生成trx地址
Attemp 1
```
docker run -it --rm --gpus '"device=0,1"' nvidia/cuda:12.0.0-devel-ubuntu20.04

DEBIAN_FRONTEND=noninteractive
apt update
apt install -y git xz-utils curl sudo clinfo

useradd superuser
groupadd nixbld
usermod -aG sudo superuser
usermod -aG nixbld superuser
echo 'superuser ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/superuser
mkdir -p /home/superuser
chown superuser -R /home/superuser
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh

git clone https://github.com/10gic/vanitygen-plusplus.git
cd vanitygen-plusplus
/nix/store/smfmnz0ylx80wkbqbjibj7zcw4q668xp-nix-2.19.2/bin/nix-build

# Error
sudo ./result/bin/oclvanitygen++ -C TRX TFeedBBBB
sudo ./result/bin/vanitygen++ -C TRX TFeedBBBB
```

Attemp 2
```
mkdir vanitygen
docker run -it --rm -v $PWD/vanitygen:/vanitygen ubuntu:22.04
docker run -it --rm -v $PWD/vanitygen:/vanitygen nvidia/cuda:12.0.0-cudnn8-runtime-ubuntu22.04

DEBIAN_FRONTEND=noninteractive
apt update
apt install -y git xz-utils curl sudo clinfo nix-bin

nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update

cd /vanitygen
git clone https://github.com/10gic/vanitygen-plusplus.git
cd vanitygen-plusplus
nix-build

cp -Lr ./result ./result2
# Error
cd vanitygen/vanitygen-plusplus
./result2/bin/oclvanitygen++ -C TRX TFeedBBBB
./result2/bin/vanitygen++ -C TRX TFeedBBBB
```

Attemp 3
```
wget https://cdimage.ubuntu.com/ubuntu-base/releases/22.04.3/release/ubuntu-base-22.04.3-base-amd64.tar.gz
mkdir ubuntu2204
tar -xvzf ubuntu-base-22.04.3-base-amd64.tar.gz -C ubuntu2204/
chroot ubuntu2204
echo nameserver 1.1.1.1 > /etc/resolv.conf
DEBIAN_FRONTEND=noninteractive
apt update
apt install -y git xz-utils curl sudo clinfo nix-bin

nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update

git clone https://github.com/10gic/vanitygen-plusplus.git
cd vanitygen-plusplus
nix-build

```
