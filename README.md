#### To backup LUKS header to a file

- Using `dd`

```sh
$ sudo dd if=/dev/sdX of=/path/to/backupfile bs=512 count=4096
```

- Using `cryptsetup`

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

