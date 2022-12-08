# admin-scripts
Admin helper scripts

- mztop.sh

Linux shell script to get informations about NUMA and CPU affinity.

### mztop.sh
This script does't require `root` access

- NUMA and CPU affinity for process
```
$ mztop.sh -p envoy $process_name
```

- Get NUMA and CPU affinity for CPU ID/core 
```
$ mztop.sh -c $cpu_id
```

- NUMA and CPU affinity for all PIDs
```
$ mztop.sh -a
```