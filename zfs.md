# ZFS

# Datasets
* `zfs list`
* `zfs list -r -o name,type,available,used,referenced,written,usedbydataset,usedbychildren,usedbysnapshots POOL/DATASET`
  
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
