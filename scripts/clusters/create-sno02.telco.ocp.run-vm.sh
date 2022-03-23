export HUB_CLUSTER_NAME="ztp-hub"
export CLUSTER_NAME="sno02"
export NAME_BRIDGE="br0"
export UUID="deed1e55-fe11-f0e5-0dd5-babb1ed1a011"
export MAC="00:00:00:00:00:11"

sudo qemu-img create -f qcow2 /opt/ssd/${HUB_CLUSTER_NAME}/${CLUSTER_NAME}.qcow2 200G

sudo virt-install \
  --name=${HUB_CLUSTER_NAME}-${CLUSTER_NAME} \
  --uuid=${UUID} \
  --ram=33384 \
  --vcpus=8 \
  --cpu host-passthrough \
  --os-type linux \
  --os-variant rhel8.0 \
  --noreboot \
  --events on_reboot=restart \
  --noautoconsole \
  --boot hd,cdrom \
  --import \
  --disk path=/opt/ssd/${HUB_CLUSTER_NAME}/${CLUSTER_NAME}.qcow2,size=20 \
  --network type=direct,source=${NAME_BRIDGE},mac=${MAC},source_mode=bridge,model=virtio
