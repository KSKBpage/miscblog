for forwarded traffic
```
nft add table raw
nft 'add chain raw prerouting {type filter hook prerouting priority -300;}'
nft add rule raw prerouting ip daddr 1.1.1.1 notrack ip daddr set 2.2.2.2
```

for local traffic
```
nft add table raw
nft 'add chain raw output {type filter hook output priority -300;}'
nft add rule raw output ip daddr 1.1.1.1 notrack ip daddr set 2.2.2.2
```
