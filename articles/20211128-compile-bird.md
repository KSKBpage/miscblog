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

```
apt update
apt install -y build-essential autoconf git flex bison m4 libssh-dev libncurses-dev libreadline-dev 
cd ~
git clone -b babel-rtt-01 https://github.com/tohojo/bird.git BIRD_RTT
cd BIRD_RTT
autoreconf
./configure --prefix= --sysconfdir=/etc/bird --runstatedir=/var/run/bird
make
make install
```
