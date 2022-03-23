## 
After the ACM Install, issue the following command:
```
oc patch hiveconfig hive --type merge -p '{"spec":{"targetNamespace":"hive","logLevel":"debug","featureGates":{"custom":{"enabled":["AlphaAgentInstallStrategy"]},"featureSet":"Custom"}}}'
```

Then create an Assisted-Service `configmap`:
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: assisted-service-config
  namespace: open-cluster-management
  labels:
    app: assisted-service
data:
  LOG_LEVEL: "debug"
```

Create the Pull Secret used for the Assisted-Service Deployment:
```
apiVersion: v1
kind: Secret
metadata:
  name: assisted-deployment-pull-secret
  namespace: open-cluster-management
stringData:
  .dockerconfigjson: ''
```

```
cat <<EOF | oc apply -f -
apiVersion: agent-install.openshift.io/v1beta1
kind: AgentServiceConfig
metadata:
  name: agent
  namespace: open-cluster-management
spec:
  databaseStorage:
    accessModes:
    - ReadWriteOnce
    resources:
      requests:
        storage: 15Gi
    storageClassName: ocs-storagecluster-ceph-rbd
  filesystemStorage:
    accessModes:
    - ReadWriteOnce
    resources:
      requests:
        storage: 35Gi
    storageClassName: ocs-storagecluster-ceph-rbd
#  mustGatherImages:
#  - name: cnv
#    openshiftVersion: '4.8'
#    url: registry.redhat.io/container-native-virtualization/cnv-must-gather-rhel8:v2.6.5
#  - name: ocs
#    openshiftVersion: '4.8'
#    url: registry.redhat.io/ocs4/ocs-must-gather-rhel8
#  - name: lso
#    openshiftVersion: '4.8'
  osImages:
  - openshiftVersion: "4.7"
    cpuArchitecture: x86_64
    rootFSUrl: https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.7/4.7.33/rhcos-live-rootfs.x86_64.img
    url: https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.7/4.7.33/rhcos-4.7.33-x86_64-live.x86_64.iso
    version: 47.84.202110041927-0
  - openshiftVersion: "4.8"
    cpuArchitecture: x86_64
    rootFSUrl: https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.8/4.8.14/rhcos-4.8.14-x86_64-live-rootfs.x86_64.img
    url: https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.8/4.8.14/rhcos-4.8.14-x86_64-live.x86_64.iso
    version: 48.84.202110042259-0
  - openshiftVersion: "4.9"
    cpuArchitecture: x86_64
    rootFSUrl: https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.9/4.9.0/rhcos-4.9.0-x86_64-live-rootfs.x86_64.img
    url: https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.9/4.9.0/rhcos-4.9.0-x86_64-live.x86_64.iso
    version: 49.84.202110081407-0
EOF
```

## References:
https://cloudcult.dev/creating-openshift-clusters-with-the-assisted-service-api/
https://github.com/pandeybk/ztp-tigers/tree/main/hub-install