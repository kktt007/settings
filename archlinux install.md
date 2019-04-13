## archlinux install

### DD镜像:

- windows使用rufus

- gun/linux使用:

  - 查看USB是否占用，如果占用(小数字):

    `umount /dev/sdbxx` 

  - 如果需要格式化 U 盘：

    `mkfs.vfat /dev/sdb -I`

  - 查看磁盘-f可不加:

    `lsblk -f`

  - 写入镜像

    `dd bs=4M if=/path/to/archlinux.iso of=/dev/sdx status=progress && sync`



### 分区

- 查看分区

  `lsblk -f`	或者使用	`fdisk -l`

- 分区：cgdisk (UEFI)/ cfdisk (MBR&UEFI)

  `cgdisk /dev/sdb`

- 格式化和挂载

  ```
  mkfs.ext4 /dev/sda5
  
  mkswap /dev/sda4
  
  swapon /dev/sda4
  
  mount /dev/sda5 /mnt
  
  mkdir /mnt/boot
  
  mount /dev/sda1 /mnt/boot
  ```

### mirrorlist

- 官方中文仓库:

  ```
  ## China
  Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
  Server = https://mirrors.neusoft.edu.cn/archlinux/$repo/os/$arch
  Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
  ```

- 中文社区仓库:

  ```
  [archlinuxcn]
  Server = https://cdn.repo.archlinuxcn.org/$arch
  
  [archlinuxcn]
  Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
  ```

  

​	**进入chroot再修改社区仓库并安装钥匙**

​	`sudo pacman -S archlinux-keyring archlinuxcn-keyring`

### 联网:

`wifi-menu`

### 设置时间同步

`timedatectl set-ntp true`

### 安装基本系统

`pacstrap /mnt base`

### 配置并验证系统

`genfstab -U /mnt >> /mnt/etc/fstab`

**验证是否成功mount**

`cat /mnt/etc/fstab`



timedatectl set-ntp true

```
127.0.0.1	localhost
::1		localhost
127.0.1.1	arch.localdomain	arch
```

- 配置系统（有坑）

用以下命令生成 fstab 文件 (用 -U 或 -L 选项设置UUID 或卷标)：
genfstab -U /mnt >> /mnt/etc/fstab
cat检查一下生成的 /mnt/etc/fstab 文件是否正确。对比blkid命令下硬盘分区UID和此文件是否对应，我这里就是因为没有mount好，生成的fstab也不对，导致安装完成无法启动.

### Change root 到新安装的系统：

`arch-chroot /mnt`
**设置时区**

`teselect`	或者	`ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime`
**设置时间标准 为 UTC，并调整 时间漂移**
`hwclock --systohc --utc`
Locale本地化配置
pacman -S neovim
vim /etc/locale.gen

```
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
zh_TW.UTF-8 UTF-8
```

- locale-gen

- 将系统 locale 设置为en_US.UTF-8：

- echo LANG=en_US.UTF-8 > /etc/locale.conf

- ```
  echo LANG=en_US.UTF-8 > /etc/locale.conf
  ```

  网络问题，一般用不到

  pacman -S dialog wpa_supplicant netctl wireless_tools wpa_actiond现在不安装 重启之后如果只有wifi则可能无法连接网络
  查看网卡名:
  ip link show
  设置启动dhcp:

  systemctl enable dhcpcd@enp0s2.service

Exit the chroot environment by typing `exit` or pressing `Ctrl+D`

### optomize

```
sudo pacman -Rns $(pacman -Qtdq)
systemctl enable upower
```



