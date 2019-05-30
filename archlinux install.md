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

### KDE and SDDM

`kf5 kf5-aids gwenview plasma ntfs-3g`	

### 驱动安装

鼠标驱动`xf86-input-mouse xf86-input-keyboard xf86-input-evdev`

### optomize

```
sudo pacman -Rns $(pacman -Qtdq)
systemctl enable upower
```

## ssr

> wget -P ./Downloads https://raw.githubusercontent.com/the0demiurge/CharlesScripts/master/charles/bin/ssr

进入刚刚克隆的仓库目录并赋予ssr脚本执行权限

cd Linux_ssr_script && chmod +x ./ssr
然后将脚本放入可执行脚本的目录

sudo mv ./ssr /usr/local/sbin/
这样就完成了脚本的安装

使用
输入ssr，便会有如下的提示：
ssr install
ssr start
ssr stop

### zsh tilix yakuake

[tilix配置](<https://gnunn1.github.io/tilix-web/manual/vteconfig/>)

zshrc文件

```
export ALL_PROXY=socks5://127.0.0.1:1080
alias setproxy="export ALL_PROXY=socks5://127.0.0.1:1080"
alias unsetproxy="unset ALL_PROXY"
alias ip="curl -i http://ip.sb"
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
```

### 双系统同步时间

administrator运行

`reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /d 1 /t REG_QWORD /f`

### [环境变量](<https://www.cnblogs.com/liduanjun/p/3536993.html>)

.zshrc

> alias setproxy="export ALL_PROXY=socks5://127.0.0.1:1080; export all_proxy=socks5://127.0.0.1:1080"
> alias unsetproxy="unset ALL_PROXY; unset all_proxy"
> alias ipp="curl -i http://ip.sb"
> if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
>         source /etc/profile.d/vte.sh
> fi
> export PATH=$PATH:/home/kktt/platform-tools
> export PATH=$PATH:/home/kktt/Downloads/software/comma-community-2019.4/bin
> export GTAGSLABEL=ctags
> export PATH=/home/kktt/rakudo/install/share/perl6/site/bin:/home/kktt/rakudo/install/bin:$PATH

.xprofile

> export GTK_IM_MODULE=fcitx
> export QT_IM_MODULE=fcitx
> export XMODIFIERS="@im=fcitx"



`echo $PATH`查看环境变量

一下读取顺序不一样，

首选:	`export PATH=$PAHT:<PATH 1>:<PATH 2>:<PATH 3>:--------:< PATH n >`

次选:	`export PATH=<1>:<2>:$PATH`

使得刚修改的环境变量生效：source <带环境变量的文件>

查看环境变量： env 或 set 

持久化的环境变量主要存在于这几个文件中：

```
/etc/profile
/etc/environment
~/.bash_profile
~/.bashrc
```

加载优先级是：1->2->3>4 但是，读取后以用户为准

其中1和2是系统的全局环境变量，3和4是用户个人的环境变量

### python

创建软链接(源文件>目标文件---安装在mkdir -p /usr/local/python3)

**因为 linux 默认去 /usr/bin / 下找 pip3***

ln -s /usr/local/python3/bin/python3 /usr/bin/python3

配置环境变量`export PATH=$PATH:/usr/local/Python3.6/bin`

```
$ wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz
$ mkdir -p /usr/local/python3
$ tar -zxvf Python-3.6.1.tgz
$ cd Python-3.6.1
$ ./configure --prefix=/usr/local/python3
$ make
$ sudo make isntall
$ ln -s /usr/local/python3/bin/python3 /usr/bin/python3
```

```
python --version
whereis python3.5
rm /user/bin/python   删除软链接
重新设置软链接并设置路径
```

### perl6

[perlintro说明](<https://perl6intro.com/zh/>)

- **Perl 6**: 带有测试套件的语言规范。 Perl 6 是通过该规范测试套件的实现。
- **Rakudo**: Perl 6 的编译器。
- **Rakudobrew**: Rakudo 的安装管理器。
- **Zef**: Perl 6 的模块安装程序。
- **Rakudo Star**: 是一个包含 Rakudo, Zef, 和经遴选的 Perl 6 模块与文档的分发包。

`export PATH=/home/kktt/rakudo/share/perl6/site/bin:/home/kktt/rakudo/bin:$PATH`

**编辑器**

[vim-perl6](<https://github.com/vim-perl/vim-perl6>)

[atom](https://atom.io/packages/language-perl6)

[comma IDE](<https://commaide.com/>)



### software

[awesome-linux-software](<https://www.fossmint.com/awesome-linux-software/>)

[archlinux list_applications](<https://wiki.archlinux.org/index.php/list_of_applications>)

## yay
下载的软件在
/home/kktt/.cache/yay/rakudo-star

## privoxy 配合ssr代理
参考网址
https://github.com/cckpg/autoproxy2privoxy
https://juejin.im/post/5c91ff5ee51d4534446edb9a
https://www.cnblogs.com/hongdada/p/10787924.html
https://www.zhangweijie.net/post/2016/05/17/2501.html
https://www.privoxy.org/user-manual/actions-file.html
https://blog.zfanw.com/privoxy-tutorial/

安装好后sudo systemctl start privoxy
sudo systemctl status privoxy
sudo systemctl restart privoxy
等来配置测试

因为privoxy模式启用了listen-address  127.0.0.1:8118
系统设置以http 127.0.0.1 8118或者全部以127.0.0.1 8118为代理
/etc/profile写入

```
export ALL_PROXY='http://127.0.0.1:8118'
export all_proxy='http://127.0.0.1:8118'
export no_proxy=localhost,172.16.0.0/16,192.168.0.0/16,127.0.0.1,10.10.0.0/16
```

/etc/privoxy/config 

```
#forward-socks5 / 127.0.0.1:1080 .
#forward 10.*.*.*/ .
#forward 192.168.*.*/ .
#forward .baidu.com/ .
#forward .ip111.cn/ .
actionsfile pac.action
```

因为使用了pac.action所以以上forward全部都注释掉即可

/etc/privoxy/pac.action

```
{{alias}}
direct      = +forward-override{forward .}
default     = +forward-override{forward-socks5 127.0.0.1:1080 .}
#==========默认代理==========
{default}
/
#==========直接连接==========
{direct} 
.126.com
.126.net
.127.net
.139.com
.160.com
.163.com
.163.net
.163disk.com
.1688.com
.17173.com
.188.com
.189store.com
.1905.com
.1ting.com
.33lc.com
.360buy.com
.360buyimg.com
.360doc.com
.360kan.com
.360safe.com
.36kr.com
.3dmgame.com
.91wan.com
.99bill.com
.abchina.com
.acfun.com
.acfun.tv
.acg.tv
.acgvideo.com
.aipai.com
.air-matters.com
.aixifan.com
.ali213.net
.aliapp.com
.alibaba.com
.alicdn.com
.alimama.com
.alipay.com
.aliyun.com
.aliyuncs.com
.amap.com
.androidonline.net
.anruan.com
.anzhi.com
.anzow.com
.apabi.com
.appchina.com
.appinn.com
.apple.com
.autonavi.com
.baidu.com
.baidulian.net
.baidustatic.com
.baiduyy.com
.baike.com
.bdchina.com
.bdglj.com
.bdgycx.com
.bdimg.com
.bdstatic.com
.bilibili.com
.bilibili.tv
.biligame.com
.blog.163.com
.blog.csdn.net
.blogbus.com
.blogchina.com
.blogcn.com
.bookschina.com
.btv.org
.cache.netease.com
.caiyunapp.com
.cctv.com
.chinaso.com
.chinaz.com
.clouddn.com
.cn localproxy
.cnbeta.com
.cnbetacdn.com
.cnblogs.com
.cntv.net
.cootekservice.com
.csdn.net
.ctrip.com
.dgtle.com
.dianping.com
.dict.cn
.discuz.com
.discuz.net
.douban.com
.douban.fm
.doubanio.com
.douyu.com
.duokan.com
.duote.com
.duowan.com
.dy2018.com
.easou.com
.ele.me
.feng.com
.fir.im
.bbs.fobshanghai.com
.focuschina.com
.frdic.com
.g-cores.com
.gamersky.com
.godic.net
.google.cn
.gtimg.cn
.gtimg.com
.hao123.com
.hao123img.com
.hongxiu.com
.hxcdn.net
.iciba.com
.ifeng.com
.ifengimg.com
.intel.com
.ip.cn
.ip.sb
.ip111.cn
.ip138.com
.ipip.net
.iqiyi.com
.it168.com
.ithome.com
.itmop.com
.jd.com
.jianguoyun.com
.jianshu.com
.juzimi.com
.kktt.ys168.com
.knewone.com
.lanzou.com
.le.com
.lecloud.com
.lemicp.com
.licdn.com
.lofter.com
.luoo.net
.m1905.com
.maoyan.com
.meituan.com
.meituan.net
.mi.com
.miaopai.com
.miui.com
.miwifi.com
.mob.com
.mydrivers.com
.netease.com
.newasp.net
.newhua.com
.nocmd.com
.orsoon.com
.oschina.net
.pan.baidu.com
.pcbeta.com
.pplive.com
.pps.tv
.ppsimg.com
.ppstream.com
.pptv.com
.pstatp.com
.qcloud.com
.qdaily.com
.qdmm.com
.qhimg.com
.qhimgs4.com
.qhres.com
.qidian.com
.qihucdn.com
.qiniu.com
.qiniucdn.com
.qiyipic.com
.qq.com
.qqurl.com
.rarbg.to
.ruan8.com
.ruanmei.com
.ruguoapp.com
.runoob.com
.segmentfault.com
.shangxueba.com
.shimo.im
.sina.com
.sinaapp.com
.sinaimg.cn
.skycn.com
.smzdm.com
.so.com
.sogou.com
.sogoucdn.com
.sohu.com
.sohu.net
.soku.com
.soso.com
.sosoo.net
.speedtest.net
.sspai.com
.suning.com
.t.cn
.taobao.com
.tencent.com
.tenpay.com
.tmall.com
.toutiao.com
.tudou.com
.tuicool.com
.tvb.me
.umetrip.com
.upaiyun.com
.ups.com
.upyun.com
.url.cn
.v.qq.com
.v2ex.com
.veryzhun.com
.wandoujia.com
.weather.com
.wechat.com
.weibo.com
.weiyun.com
.xiami.com
.xiami.net
.xiaomicp.com
.ximalaya.com
.xmcdn.com
.xp510.com
.xunlei.com
.yhd.com
.yihaodianimg.com
.yinxiang.com
.ykimg.com
.youdao.com
.youku.com
.ys168.com
.zaobao.com
.zdic.net
.zealer.com
.zhihu.com
.zhimg.com
.zimuzu.tv
.zol.com
