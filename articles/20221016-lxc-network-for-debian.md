# Debian 底下的 lxc 和網路相關設定

## lxc 容器使用教學
https://github.com/KSKBpage/miscblog/blob/main/articles/20230204-lxc-setup.md

## 容器預設網路

### 主系統網路設定

設定檔位置: `/etc/default/lxc-net`
```
USE_LXC_BRIDGE="true"
LXC_BRIDGE="lxcbr0"
LXC_ADDR="192.168.21.1"
LXC_NETMASK="255.255.255.0"
LXC_NETWORK="192.168.21.0/24"
LXC_DHCP_RANGE="192.168.21.100,192.168.21.254"
LXC_DHCP_MAX="253"
LXC_DHCP_CONFILE=""
LXC_DHCP_PING="true"
LXC_DOMAIN=""
# Honor system's dnsmasq configuration
#LXC_DHCP_CONFILE=/etc/dnsmasq.conf
```

### 容器內網路設定
```
auto eth0
iface eth0 inet static
    pre-up ip link set $IFACE down || true
    pre-up ip addr flush $IFACE || true
    address 192.168.21.3/24
    gateway 192.168.21.1
```


## 預設設定(for 新增的lxc)

設定檔位置: `/etc/lxc/default.conf`
```
lxc.net.0.type = veth
lxc.net.0.link = lxcbr0
lxc.net.0.flags = up

lxc.apparmor.profile = generated
lxc.apparmor.allow_nesting = 1
```


## 允許 /dev/net/tun

設定檔位置: 
* 全部新增的容器: `/etc/lxc/default.conf`
* 單一容器: `/var/lib/lxc/[lxc名稱]/config`
* Proxmox ve: `/etc/pve/lxc/$VM_ID.conf`

```
lxc.cgroup.devices.allow = c 10:200 rwm
lxc.cgroup2.devices.allow = c 10:200 rwm
lxc.mount.entry = /dev/net/tun /dev/net/tun none bind,create=file
```

## 接入外部網路(不透過 NAT)

### 方法1: bridge

設定 bridge ，把原本 eth1 的東西搬到 bridge 上面

#### 設定主系統網橋

設定檔位置: `/etc/network/interfaces`
```
auto eth1
iface eth1 inet manual

auto br-eth1
iface br-eth1 inet static
    address 192.168.14.10/24
    hwaddress b6:70:8f:54:80:d3
    bridge_stp off
    bridge_waitport 1
    bridge_fd 0
    bridge_vlan_aware yes
    bridge_ports eth1 # 要橋接的網卡
```

#### 容器接入網橋

設定檔位置: 
* 全部新增的容器: `/etc/lxc/default.conf`
* 單一容器: `/var/lib/lxc/[lxc名稱]/config`

```
# IX NET
lxc.net.1.type = veth
lxc.net.1.hwaddr = 34:d7:a0:4c:81:de
lxc.net.1.link = br-llix
```

### 方法2: macvtap

#### 設定主系統 macvtap

因為 linux 的神奇設定，macvtap 之間可以互相溝通，但不允許主網卡和 macvtap 溝通，直接設定 macvtap 會導致無法連線容器  
所以要設定一個 macvtap 給主系統用 ，主系統不使用主網卡，把主系統也變成 macvtap 成員的一部份  

設定檔位置: `/etc/network/interfaces`
```
auto eth1
iface eth1 inet manual

auto mvt-eth1
iface mvt-eth1 inet static
    address 192.168.14.10/24
    pre-up ip link add link eth1 name $IFACE type macvtap mode bridge || true
    post-down ip link del $IFACE || true
```

#### 設定給容器用的 macvtap (在主系統設定)

設定檔位置: `/etc/network/interfaces`
```
auto mvt-eth1-lxc1
iface mvt-eth1-lxc1 inet manual
    pre-up ip link add link eth1 name $IFACE type macvtap mode bridge|| true
    post-down ip link del $IFACE || true
```
### 把容器用 macvtap 交給 lxc 接管

設定檔位置: 
* 單一容器: `/var/lib/lxc/[lxc名稱]/config`

```
lxc.net.11.type = phys
lxc.net.11.link = mvt-eth1-lxc1
```

### 方法3: 把網卡搬去容器裡面
把 `eth1` 丟進容器裡面，主系統從此看不見這張網卡(關閉容器會回來)

設定檔位置: 
* 單一容器: `/var/lib/lxc/[lxc名稱]/config`

```
lxc.net.11.type = phys
lxc.net.11.link = eth1
```

## 好用設定

### DNAT
port forward 給容器
```
iptables -t nat -A PREROUTING -d 103.172.124.8 -p udp --dport 8220:8239 -j DNAT --to 192.168.21.2
iptables -t nat -A PREROUTING -d 103.172.124.8 -p tcp --dport 8220:8239 -j DNAT --to 192.168.21.2
```

### VETH
lxc 和 host 的點對點 L2連線。

路徑: `/etc/network/interfaces`  
設定: 新增兩張網卡 `veth-kskbix` 和 `veth-kskbix-lxc`
```
auto veth-kskbix
iface veth-kskbix inet6 static inherits ix-lan
    mtu 9000
    accept_dad 0
    pre-up ip link add ${IFACE} type veth peer name $IFACE-lxc
    pre-up sysctl -w net.ipv6.conf.$IFACE.accept_dad=0
    post-down ip link del $IFACE
    post-down ip link del $IFACE-lxc
```

路徑: `/var/lib/lxc/poema-ix-evpn/config`  
設定: `veth`兩張網卡類似於 L2 隧道的兩端。用 `type = phys` 把其中一張 `veth-kskbix-lxc` 這張網卡直接移到 lxc 裡面
```
lxc.net.1.type = phys
lxc.net.1.link = veth-kskbix-lxc
lxc.net.1.flags = up
