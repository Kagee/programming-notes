# ZFS

# Datasets
* `zfs create tank/anewdataset`
* `zfs list`
* `zfs list -r -o name,type,available,used,referenced,written,usedbydataset,usedbychildren,usedbysnapshots POOL/DATASET`

# Snapshots
* `zfs list -t all`
* `zfs list -t snapshots`
* `zfs get all tank/data | grep auto-snapshot`
* `zfs inherit com.sun:auto-snapshot:daily tank/data` # will delete/remove if unset on parent
* `zfs destroy tank/data@zfs-auto-snap_daily-2025-04-12-1911`
* `zfs set com.sun:auto-snapshot=true tank/data` # enable zfs-auto-snapshot (all cronjobs enabled by default)
* `zfs set com.sun:auto-snapshot:frequent=false tank/data` # disable */15 min snapshots
* `zfs set com.sun:auto-snapshot:hourly=false tank/data` # disable hourly snapshots

## Pool
* `zpool status`
* `zpool list`
* `zpool replace POOL OLD NEW`
* `zpool iostat -v 1`
* `zpool iostat -v`
* `zpool iostat -vly 1 1`

## Creation RAID 6 (raidz2) (w. missing disc)
* `truncate -s 18T /tmp/fake.img`
* `zpool create -o ashift=12 <NAME> raidz2 /tmp/fake.img /dev/disk/by-id/wwn-0x5000c500e07118d7 /dev/sd<2> /dev/sd<3> /dev/sd<4> wwn-0x5000c500e070ad0c`
  * ashift=12 => 4096 sector size 
* `zpool offline <NAME> /tmp/fake.imgirc`
* Move data?
* `zpool replace tank /media/nvme1tb/fake18tb.img wwn-0x5000c500f1d76374`
