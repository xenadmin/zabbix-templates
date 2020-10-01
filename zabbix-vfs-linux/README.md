# Zabbix vfs User parameter

## Introduction

A collection of Zabbix agent User Parameters. To be used on Linux to extend the vfs agent item keys.
This collection currently offers the following extensions:

- **vfs.file.age**
  - Point the item key to a path of your choice. The script will return the age in seconds of the oldest file in the directory. If no files exist, it returns 0. Example Template.xml provided.
- **vfs.file.discovery**
  - Point the User Macro `{$PATH}` on host level, to a path of your choice. The low level discovery rule will return all file names (without path) via `{#FILENAME}`. In the example template the `vfs.file.cksum` is observed. If you need the full path, you can use `{$PATH}` in the item key, for example: `vfs.file.cksum[{$PATH}{#FILENAME}]`
- **vfs.dir.discovery**
  - Point the User Macro `{$PATH}` on host level, to a path of your choice. The low level discovery rule will return all directroy names (without path) via `{#DIRNAME}`. There is currently no example template. You can use the [Template vfs File checksum monitor.xml](https://github.com/xenadmin/zabbix-templates/blob/master/zabbix-vfs-linux/Template%20vfs%20File%20checksum%20monitor.xml) file, and change the Discovery rule to `vfs.dir.discovery`.

## Installation

1. I presume Zabbix agent is already installed and configured.
1. Copy script file onto target Linux server, for example: `/usr/local/bin/vfs-file-discovery.pl`
1. Make script executeable, for example: `chmod +x /use/local/bin/vfs-file-discovery.pl`
1. Configure User Parameter in `/etc/zabbix/zabbix_agentd.conf` or `/etc/zabbix/zabbix_agentd.d/userparameter.conf`, for example:
    1. `UserParameter=vfs.file.age[*],/usr/local/bin/zabbix_vfs.file.old.sh $1`
    1. `UserParameter=vfs.file.discovery[*],/etc/zabbix/zabbix_agentd.d/vfs-file-discovery.pl $1`
    1. `UserParameter=vfs.dir.discovery[*],/etc/zabbix/zabbix_agentd.d/vfs-dir-discovery.pl $1`
    1. Restart Zabbix agent.
1. Test User Parameter, for example:
    1. `zabbix_agentd -t vfs.file.discovery[/root]` -> Should return a valid JSON string.
1. Import example Template into Zabbix Frontend.
    1. For **vfs oldest file in folder** examine the example items and trigger, and adjust the paths according to your needs.
    1. For **vfs File checksum monitor** examine the `vfs.file.discovery` discovery rule and set the user macro `{$PATH}` on the host level.
    1. Link the template to a host.

## Notes

These files and templates were tested and created on Zabbix 4.0 and Debian Linux 8&9 amd64.
There should be no reason this will not work on older Zabbix versions. Sadly I have no Zabbix 3.x installation available to provide older XML files.

Parts of this GitHub Repository are directly related to [ZBXNEXT-712 - low-level discovery of files in a directory](https://support.zabbix.com/browse/ZBXNEXT-712).
In this ZBXNEXT request is a script example provided by [Aleksandrs Saveljevs](https://support.zabbix.com/secure/ViewProfile.jspa?name=asaveljevs), but without further manual. I copied and adjusted his script, and wrote this README and example Template.xml, to make his work available to everyone. All credits for the files [vfs-file-discovery.pl](https://github.com/xenadmin/zabbix-templates/blob/master/zabbix-vfs-linux/vfs-file-discovery.pl) & [vfs-dir-discovery.pl](https://github.com/xenadmin/zabbix-templates/blob/master/zabbix-vfs-linux/vfs-dir-discovery.pl) belong to [Aleksandrs Saveljevs](https://support.zabbix.com/secure/ViewProfile.jspa?name=asaveljevs).

## Example / Screenshot

### vfs.file.age

```bash
root@ftp:/home/user1# zabbix_agentd -t vfs.file.age[/home/ftp/customer/out]
vfs.file.age[/home/ftp/customer/out]                [t|0]
```

### vfs.file.discovery

```bash
root@debian:/home/user1# zabbix_agentd -t vfs.file.discovery[/home/user1]
vfs.file.discovery[/root]                     [t|{
        "data":[
                {"{#FILENAME}":"zabbix-release_2.4-1+wheezy_all.deb"},
                {"{#FILENAME}":"script.sh"},
                {"{#FILENAME}":"testfile.txt"}
        ]
}]
```

### vfs.dir.discovery

```bash
root@debian:/home/user1# zabbix_agentd -t vfs.dir.discovery[/root]
vfs.dir.discovery[/root]                      [t|{
        "data":[
                {"{#DIRNAME}":"testfolder1"},
                {"{#DIRNAME}":"test-folder-2"}
        ]
}]
```

## Changelog

- 19 Februar 2019: initial commit.
