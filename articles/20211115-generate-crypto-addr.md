生成btc地址
```
docker run -it --rm --gpus=all nvidia/cuda:11.2.0-cudnn8-devel-ubuntu20.04

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
```
docker run -it --rm --gpus '"device=0,1"' nvidia/opencl

docker run -it --rm ubuntu:20.04

apt update
apt install -y git xz-utils curl sudo

useradd superuser
groupadd nixbld
usermod -aG sudo superuser
usermod -aG nixbld superuser
echo 'superuser ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/superuser
mkdir -p /home/superuser
chown superuser -R /home/superuser
su superuser

cd ~
bash

sh <(curl -L https://nixos.org/nix/install) --no-daemon

git clone https://github.com/10gic/vanitygen-plusplus.git
cd vanitygen-plusplus
nix-build

#Not finished
```
