#!/bin/bash
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/configuring-a-network-bridge_configuring-and-managing-networking

nmcli connection add type bridge con-name br0 ifname br0

```
[root@localhost bpandey]# nmcli device status
DEVICE      TYPE      STATE                   CONNECTION 
eno1np0     ethernet  connected               eno1np0    
virbr0      bridge    connected (externally)  virbr0     
eno2np1     ethernet  disconnected            --         
lo          loopback  unmanaged               --         
macvtap2    macvlan   unmanaged               --         
macvtap3    macvlan   unmanaged               --         
virbr0-nic  tun       unmanaged               --  
```

nmcli connection modify eno1np0 master br0
nmcli connection modify virbr0 master br0

nmcli connection modify br0 ipv4.addresses '192.168.7.214/32'
nmcli connection modify br0 ipv4.gateway '192.168.4.1'
nmcli connection modify br0 ipv4.dns '75.75.75.75'
nmcli connection modify br0 ipv4.method manual

nmcli connection up br0
nmcli connection delete <UUID>