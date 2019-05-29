克隆到本地
> wget -P ./Downloads https://raw.githubusercontent.com/the0demiurge/CharlesScripts/master/charles/bin/ssr

或者
> svn co https://github.com/lan542662/settings/trunk/xxr

赋予可执行权限

chmod u+x ./ssr

然后将脚本放入可执行脚本的目录

sudo mv ./ssr /usr/local/sbin/

安装 启动
ssr install config unstall start stop
配置文件在.local/share/shadowsocksr中
启用后需配置在终端中启用
alias setproxy="export ALL_PROXY=socks5://127.0.0.1:1080; export all_proxy=socks5://127.0.0.1:1080"
alias unsetproxy="unset ALL_PROXY; unset all_proxy"
alias ipp="curl -i http://ip.sb"
[脚本原地址](https://github.com/the0demiurge/CharlesScripts/blob/master/charles/bin/ssr)
[参考](https://git.mrwang.pw/Reed/Linux_ssr_script)
