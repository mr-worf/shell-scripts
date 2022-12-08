# admin-scripts
Admin helper scripts

- mztop.sh

Linux shell script to get informations about NUMA and CPU affinity.

# Usage 
### mztop.sh
This script does't require `root` access

- NUMA and CPU affinity for process
```
$ mztop.sh -p envoy
numa: 0              cpu id: 1-15,97-111        pid: 7248                 cmd: envoy
```

- Get NUMA and CPU affinity for CPU ID/core 
```
$ mztop.sh -c 11
numa: 0-1            cpu id: 0-191              pid: 4062115              cmd: containerd-shim
numa: 0              cpu id: 11                 pid: 68                   cmd: cpuhp/11
numa: 0-1            cpu id: 0-191              pid: 4766                 cmd: crond
numa: 0-1            cpu id: 0-191              pid: 1119                 cmd: cryptd
numa: 0-1            cpu id: 0-191              pid: 4514                 cmd: dbus-daemon
numa: 0-1            cpu id: 0-191              pid: 5029                 cmd: dockerd
numa: 0              cpu id: 1-15,97-111        pid: 7234                 cmd: dumb-init
numa: 0              cpu id: 1-15,97-111        pid: 7248                 cmd: envoy
numa: 0-1            cpu id: 0-191              pid: 4476                 cmd: ext4-rsv-conver
numa: 0-1            cpu id: 0-191              pid: 4891                 cmd: filebeat
numa: 0-1            cpu id: 0-191              pid: 1210                 cmd: ipv6_addrconf
numa: 0              cpu id: 11                 pid: 1198                 cmd: irq/35-pciehp
numa: 0-1            cpu id: 0-191              pid: 1168                 cmd: kblockd
numa: 0              cpu id: 0-47,96-143        pid: 1103                 cmd: kcompactd0
numa: 0-1            cpu id: 0-191              pid: 1096                 cmd: kdevtmpfs
numa: 0              cpu id: 11                 pid: 70                   cmd: ksoftirqd/11
numa: 0-1            cpu id: 0-191              pid: 1211                 cmd: kstrp
numa: 0              cpu id: 0-47,96-143        pid: 1194                 cmd: kswapd0
numa: 0              cpu id: 11                 pid: 72                   cmd: kworker/11:0H-events_highpri
numa: 0              cpu id: 11                 pid: 4180353              cmd: kworker/11:1-rcu_gp
numa: 0              cpu id: 11                 pid: 4411                 cmd: kworker/11:1H-kblockd
numa: 0              cpu id: 11                 pid: 184082               cmd: kworker/11:2
.............................
```

- NUMA and CPU affinity for all PIDs
```
$ mztop.sh -a
numa: 0-1            cpu id: 0-191              pid: 209151               cmd: (sd-pam)
numa: 0-1            cpu id: 0-191              pid: 4521                 cmd: NetworkManager
numa: 0-1            cpu id: 0-191              pid: 5180                 cmd: agetty
numa: 0-1            cpu id: 0-191              pid: 1903                 cmd: ata_sff
numa: 0-1            cpu id: 0-191              pid: 209167               cmd: bash
numa: 0-1            cpu id: 0,84-96,180-191    pid: 9221                 cmd: bird
numa: 0-1            cpu id: 0,84-96,180-191    pid: 9220                 cmd: bird6
numa: 0-1            cpu id: 0-191              pid: 1169                 cmd: blkcg_punt_bio
numa: 0-1            cpu id: 0,84-96,180-191    pid: 8828                 cmd: calico-node
numa: 0-1            cpu id: 0,84-96,180-191    pid: 8829                 cmd: calico-node
numa: 0-1            cpu id: 0,84-96,180-191    pid: 8830                 cmd: calico-node
numa: 0-1            cpu id: 0,84-96,180-191    pid: 8831                 cmd: calico-node
numa: 0-1            cpu id: 0,84-96,180-191    pid: 8834                 cmd: calico-node
numa: 0-1            cpu id: 0,84-96,180-191    pid: 8835                 cmd: calico-node
numa: 0-1            cpu id: 0-191              pid: 4604                 cmd: chronyd
numa: 0-1            cpu id: 0-191              pid: 4558                 cmd: conntrack-stats
numa: 0-1            cpu id: 0-191              pid: 4970                 cmd: containerd
numa: 0-1            cpu id: 0-191              pid: 5512                 cmd: containerd-shim
numa: 0-1            cpu id: 0-191              pid: 5514                 cmd: containerd-shim
numa: 0-1            cpu id: 0-191              pid: 5516                 cmd: containerd-shim
numa: 0-1            cpu id: 0-191              pid: 6917                 cmd: containerd-shim
numa: 0-1            cpu id: 0-191              pid: 6963                 cmd: containerd-shim
.............................
```