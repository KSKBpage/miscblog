```
apt update
apt install -y build-essential autoconf git flex bison m4 libssh-dev libncurses-dev libreadline-dev 
cd ~
git clone https://gitlab.nic.cz/labs/bird.git BIRD
cd BIRD
autoreconf
./configure --prefix= --sysconfdir=/etc/bird --runstatedir=/var/run/bird
make
make install
```
