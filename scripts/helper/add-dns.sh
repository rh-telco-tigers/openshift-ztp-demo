pdnsutil  add-record  ztp-hub.ztp.home.lab  ns1        A   192.168.7.213
pdnsutil  add-record  ztp-hub.ztp.home.lab  @          NS  ns1.
pdnsutil  add-record  ztp-hub.ztp.home.lab  api        A   192.168.7.201
pdnsutil  add-record  ztp-hub.ztp.home.lab  *.apps     A   192.168.7.20

pdnsutil  add-record  telco.ocp.run  api.sno01        A   192.168.7.10
pdnsutil  add-record  telco.ocp.run  *.apps.sno01     A   192.168.7.10

pdnsutil  add-record  telco.ocp.run  api.sno02        A   192.168.7.11
pdnsutil  add-record  telco.ocp.run  *.apps.sno02     A   192.168.7.11


vim /etc/pdns-recursor/recursor.conf
# Domains: *.ztphubdemo.home.lab
forward-zones+=ztphubdemo.home.lab=127.0.0.1:5300
# Domains: *.telco.ocp.run
forward-zones+=telco.ocp.run=127.0.0.1:5300

# Domains: *.ztp-hub.ztp.home.lab
forward-zones+=ztp-hub.ztp.home.lab=127.0.0.1:5300


systemctl restart pdns.service
systemctl restart pdns-recursor.service 


pdnsutil check-all-zones
dig A console-openshift-console.apps.ztpdemo.home.lab @192.168.7.213

