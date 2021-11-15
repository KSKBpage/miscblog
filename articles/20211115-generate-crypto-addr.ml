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
docker run -it --rm --gpus=all nvidia/opencl
apt update
apt install -y git build-essential
git clone https://github.com/johguse/profanity
cd profanity/
make
./profanity.x64  --matching feed1c51cbXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```
