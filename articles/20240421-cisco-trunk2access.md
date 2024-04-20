```
configure
terminal length 0
show running-config

interface Ethernet1/49
no switchport mode trunk
no spanning-tree port type edge trunk
no switchport trunk allowed vlan 1-3999

switchport access vlan 3000
spanning-tree port type edge
copy running-config startup-config
```
