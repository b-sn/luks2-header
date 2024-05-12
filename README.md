#### To backup LUKS header to a file

- Using `dd`

```sh
$ sudo dd if=/dev/sdX of=/path/to/backupfile bs=512 count=4096
```

- Using [cryptsetup](https://gitlab.com/cryptsetup/cryptsetup)

```sh
$ sudo cryptsetup luksHeaderBackup /dev/sdX --header-backup-file /path/to/backupfile
```



#### To encrypt LUKS partition with a header stored separately in a file

```sh
$ sudo cryptsetup --header /path/to/backupfile luksOpen /dev/sdX my_encrypted_volume
```



#### To restore LUKS header from a backup

```sh
$ sudo cryptsetup luksHeaderRestore /dev/sdX --header-backup-file /path/to/backupfile
```



#### To calculate sha256 binary hash of file

```sh
$ openssl dgst -sha256 -binary ./file_name > output_file
```



#### To replace part of a binary file content with content from another file

```sh
$ dd if=smallerFile of=largerFile bs=1 count=32768 conv=notrunc
```



#### TMPFS

```sh
$ sudo mkdir /tmp/ramdisk
$ sudo chmod 777 /tmp/ramdisk
$ sudo mount -t tmpfs -o size=2G myramdisk /tmp/ramdisk
```



#### cryptsetup tests

```sh
$ sudo dd if=/dev/zero of=/tmp/ramdisk/disk1 bs=512 count=200000
$ echo "111" > /tmp/ramdisk/disk1_pass
$ sudo cryptsetup luksFormat --batch-mode --header /tmp/ramdisk/disk1_header /tmp/ramdisk/disk1 /tmp/ramdisk/disk1_pass
$ sudo cryptsetup open --header /tmp/ramdisk/disk1_header /tmp/ramdisk/disk1 disk1_enc --key-file /tmp/ramdisk/disk1_pass
$ sudo mkfs.ext4 /dev/mapper/disk1_enc
$ sudo mount /dev/mapper/disk1_enc /mnt/disk1_enc
$ echo "test data" | sudo tee /mnt/disk1_enc/test
# OR
$ sudo chmod 777 /mnt/disk1_enc/test && echo "test data" > /mnt/disk1_enc/test
$ sudo umount /mnt/disk1_enc
$ sudo cryptsetup close /dev/mapper/disk1_enc
```

