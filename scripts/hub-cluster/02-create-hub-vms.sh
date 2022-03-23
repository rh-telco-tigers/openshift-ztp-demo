#!/bin/bash

export CLUSTER_NAME="ztp-hub"
export NAME_BRIDGE="br0"

sudo mkdir -p /opt/ssd/${CLUSTER_NAME} /opt/ssd/boot
sudo qemu-img create -f qcow2 /opt/ssd/${CLUSTER_NAME}/hub01.qcow2 200G
sudo qemu-img create -f qcow2 /opt/ssd/${CLUSTER_NAME}/hub02.qcow2 200G
sudo qemu-img create -f qcow2 /opt/ssd/${CLUSTER_NAME}/hub03.qcow2 200G

virt-install \
  --name=${CLUSTER_NAME}-master-1 \
  --ram=33384 \
  --vcpus=12 \
  --cpu host-passthrough \
  --os-type linux \
  --os-variant rhel8.0 \
  --noreboot \
  --events on_reboot=restart \
  --noautoconsole \
  --boot hd,cdrom \
  --import \
  --disk path=/opt/ssd/${CLUSTER_NAME}/hub01.qcow2,size=20 \
  --disk /opt/ssd/boot/discovery_image_${CLUSTER_NAME}.iso,device=cdrom \
  --network type=direct,source=${NAME_BRIDGE},mac=00:00:00:00:00:a1,source_mode=bridge,model=virtio

virt-install \
  --name=${CLUSTER_NAME}-master-2 \
  --ram=33384 \
  --vcpus=12 \
  --cpu host-passthrough \
  --os-type linux \
  --os-variant rhel8.0 \
  --noreboot \
  --events on_reboot=restart \
  --noautoconsole \
  --boot hd,cdrom \
  --import \
  --disk path=//opt/ssd/${CLUSTER_NAME}/hub02.qcow2,size=20 \
  --disk /opt/ssd/boot/discovery_image_${CLUSTER_NAME}.iso,device=cdrom \
  --network type=direct,source=${NAME_BRIDGE},mac=00:00:00:00:00:a2,source_mode=bridge,model=virtio

virt-install \
  --name=${CLUSTER_NAME}-master-3 \
  --ram=33384 \
  --vcpus=12 \
  --cpu host-passthrough \
  --os-type linux \
  --os-variant rhel8.0 \
  --noreboot \
  --events on_reboot=restart \
  --noautoconsole \
  --boot hd,cdrom \
  --import \
  --disk path=/opt/ssd/${CLUSTER_NAME}/hub03.qcow2,size=20 \
  --disk /opt/ssd/boot/discovery_image_${CLUSTER_NAME}.iso,device=cdrom \
  --network type=direct,source=${NAME_BRIDGE},mac=00:00:00:00:00:a3,source_mode=bridge,model=virtio

virsh start ${CLUSTER_NAME}-master-1
virsh start ${CLUSTER_NAME}-master-2
virsh start ${CLUSTER_NAME}-master-3

