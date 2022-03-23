export NAME_BRIDGE="br0"
export CLUSTER_NAME="ztp-hub"
nmcli con delete ${NAME_BRIDGE}
nmcli con delete ${NAME_BRIDGE}-slave

virsh destroy ${CLUSTER_NAME}-master-1
virsh destroy ${CLUSTER_NAME}-master-2
virsh destroy ${CLUSTER_NAME}-master-3

virsh undefine  ${CLUSTER_NAME}-master-1
virsh undefine  ${CLUSTER_NAME}-master-2
virsh undefine  ${CLUSTER_NAME}-master-3

rm -rf /opt/ssd/${CLUSTER_NAME}/hub01.qcow2
rm -rf /opt/ssd/${CLUSTER_NAME}/hub02.qcow2
rm -rf /opt/ssd/${CLUSTER_NAME}/hub03.qcow2