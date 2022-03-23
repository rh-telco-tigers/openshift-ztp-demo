#!/bin/bash
export CLUSTER_NAME="ztp-hub"

sudo qemu-img create -f qcow2 /opt/ssd/${CLUSTER_NAME}/disk-hub01.qcow2 50G
sudo qemu-img create -f qcow2 /opt/ssd/${CLUSTER_NAME}/disk-hub02.qcow2 50G
sudo qemu-img create -f qcow2 /opt/ssd/${CLUSTER_NAME}/disk-hub03.qcow2 50G

cat <<EOF > /opt/ssd/${CLUSTER_NAME}/disk-hub01.xml
<disk type='file' device='disk'>
    <driver name='qemu' type='qcow2'/>
    <source file='/opt/ssd/${CLUSTER_NAME}/disk-hub01.qcow2'/>
    <target dev='vdb' bus='virtio'/>
</disk>
EOF

cat <<EOF > /opt/ssd/${CLUSTER_NAME}/disk-hub02.xml
<disk type='file' device='disk'>
    <driver name='qemu' type='qcow2'/>
    <source file='/opt/ssd/${CLUSTER_NAME}/disk-hub02.qcow2'/>
    <target dev='vdb' bus='virtio'/>
</disk>
EOF

cat <<EOF > /opt/ssd/${CLUSTER_NAME}/disk-hub03.xml
<disk type='file' device='disk'>
    <driver name='qemu' type='qcow2'/>
    <source file='/opt/ssd/${CLUSTER_NAME}/disk-hub03.qcow2'/>
    <target dev='vdb' bus='virtio'/>
</disk>
EOF

virsh attach-device ${CLUSTER_NAME}-master-1 /opt/ssd/${CLUSTER_NAME}/disk-hub01.xml --persistent
virsh attach-device ${CLUSTER_NAME}-master-2 /opt/ssd/${CLUSTER_NAME}/disk-hub02.xml --persistent
virsh attach-device ${CLUSTER_NAME}-master-3 /opt/ssd/${CLUSTER_NAME}/disk-hub03.xml --persistent

## ssh to each vm and run following
sudo wipefs -a /dev/vdb
