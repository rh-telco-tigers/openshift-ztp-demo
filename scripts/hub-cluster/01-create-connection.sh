#!/bin/bash
export NAME_BRIDGE=br0
mkdir -p ~/virsh-configs/networks/
cat << EOF > ~/virsh-configs/networks/${NAME_BRIDGE}.xml
<network>
  <name>$NAME_BRIDGE</name>
  <forward mode="bridge" />
  <bridge name="$NAME_BRIDGE" />
</network>
EOF

nmcli con add type bridge ifname ${NAME_BRIDGE} con-name ${NAME_BRIDGE}
nmcli con add type bridge-slave ifname eno1np0 master ${NAME_BRIDGE} con-name ${NAME_BRIDGE}-slave
nmcli con up ${NAME_BRIDGE}
ifup br0