Generate DNSSEC keys
```
apt install bind9utils
mkdir -p neodns
cd neodns

mkdir ksk
dnssec-keygen -a RSASHA256 -f KSK -K ksk -P now -A now -b 2048 -n ZONE kskb.neo

mkdir dnskey
dnssec-keygen -a RSASHA256 -K dnskey -P now -A now -b 2048 kskb.neo
```

All my configs:
https://github.com/KSKBpage/miscblog/tree/main/articles/20211214-Neonetwork-DNS-RDNS/bind
