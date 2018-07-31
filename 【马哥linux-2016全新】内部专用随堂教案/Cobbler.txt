



Cobbler:

一、安装

前提：cobbler由epel源提供，故此需要事先配置指向epel的yum源方可进行类似下面的安装过程。

# yum install cobbler cobbler-web pykickstart debmirror

# service httpd start
# service cobblerd start

执行“cobbler check命令检查存的问题，而后逐一按提示解决之。常见的问题如下所示：
1 : The 'server' field in /etc/cobbler/settings must be set to something other than localhost, or kickstarting features will not work.  This should be a resolvable hostname or IP for the boot server as reachable by all machines that will use it.
2 : For PXE to be functional, the 'next_server' field in /etc/cobbler/settings must be set to something other than 127.0.0.1, and should match the IP of the boot server on the PXE network.
3 : some network boot-loaders are missing from /var/lib/cobbler/loaders, you may run 'cobbler get-loaders' to download them, or, if you only want to handle x86/x86_64 netbooting, you may ensure that you have installed a *recent* version of the syslinux package installed and can ignore this message entirely.  Files in this directory, should you want to support all architectures, should include pxelinux.0, menu.c32, elilo.efi, and yaboot. The 'cobbler get-loaders' command is the easiest way to resolve these requirements.
4 : change 'disable' to 'no' in /etc/xinetd.d/rsync
5 : comment 'dists' on /etc/debmirror.conf for proper debian support
6 : comment 'arches' on /etc/debmirror.conf for proper debian support
7 : The default password used by the sample templates for newly installed machines (default_password_crypted in /etc/cobbler/settings) is still set to 'cobbler' and should be changed, try: "openssl passwd -1 -salt 'random-phrase-here' 'your-password-here'" to generate new one
8 : fencing tools were not found, and are required to use the (optional) power management features. install cman or fence-agents to use them

Restart cobblerd and then run 'cobbler sync' to apply changes.

如上各问题的解决方法如下所示：
1、修改/etc/cobbler/settings文件中的server参数的值为提供cobbler服务的主机相应的IP地址或主机名，如172.16.100.15；
2、修改/etc/cobbler/settings文件中的next_server参数的值为提供PXE服务的主机相应的IP地址，如172.16.100.16；
3、如果当前节点可以访问互联网，执行“cobbler get-loaders”命令即可；否则，需要安装syslinux程序包，而后复制/usr/share/syslinux/{pxelinux.0,memu.c32}等文件至/var/lib/cobbler/loaders/目录中；
4、执行“chkconfig rsync on”命令即可；
5、注释/etc/debmirror.conf文件中的“@dists="sid";”一行；
6、注释/etc/debmirror.conf文件中的“@arches="i386";”一行；
7、执行“openssl passwd -1 -salt $(openssl rand -hex 4)”生成密码，并用其替换/etc/cobbler/settings文件中default_password_crypted参数的值；
8、执行“yum install cman fence-agents”命令安装相应的程序包即可；

接着重启cobblerd，而后执行“cobbler sync”同步新的配置至cobbler。

二、配置及启动cobbler所依赖的各服务

cobbler的运行依赖于dhcp、tftp、rsync及dns服务。其中dhcp可由dhcpd(isc)提供，也可由dnsmasq提供；tftp可由tftp-server程序包提供，也可由cobbler自带的tftp功能提供；rsync由rsync程序包提供；dns可由bind提供，也可由dnsmasq提供。

cobbler可自行管理这些服务中的部分甚至是全部，但需要配置/etc/cobbler/settings文件中的“manage_dhcp”、“manage_tftpd”、“manage_rsync”和“manage_dns”分别进行定义。另外，由于每种服务都有着不同的实现方式，如若需要进行自定义，需要通过修改/etc/cobbler/modules.conf配置文件中各服务的模块参数的值来实现。

本文采用了独立管理的方式，即不通过cobbler来管理这些服务。

2.1 配置dhcp服务

定义好所需的“subnet”及其它参数或选项，而后启动dhcpd守护进程即可。本示例中所用的dhcpd的配置如下所示：

option domain-name "magedu.com";
option domain-name-servers 192.168.10.254,172.16.0.1;

default-lease-time 43200;
max-lease-time 86400;

log-facility local7;

subnet 172.16.0.0 netmask 255.255.0.0 {
    range 172.16.100.121 172.16.100200;
    option routers 172.16.100.7;
}

next-server 172.16.100.7;
filename="pxelinux.0";

接着使用“service dhcpd start”启动服务即可。


2.2 配置tftp服务

# chkconfig tftp on
# service xinetd restart




三、配置cobbler

cobbler的各主要组件间的关系如下图所示。



3.1 管理distro

使cobbler变得可用的第一步为定义distro，其可以通过为其指定外部的安装引导内核及ramdisk文件的方式实现。而如果已经有完整的系统安装树（如CentOS6的安装镜像）则推荐使用import直接导入的方式进行。

例如，对于已经挂载至/media/cdrom目录的CentOS 6.5 x86_64的安装镜像，则可以使用类似如下命令进行导入。
# cobbler import --name=centos-6.5-x86_64 --path=/media/cdrom

可使用“cobbler distro list”列出所有的distro。

如果有kickstart文件，也可以使用“--kickstart=/path/to/kickstart_file”进行导入，因此import会自动为导入的distro生成一个profile。

3.2 管理profile

cobbler使用profile来为特定的需求类别提供所需要安装配置，即在distro的基础上通过提供kickstart文件来生成一个特定的系统安装配置。distro的profile可以出现在PXE的引导菜单中作为安装的选择之一。

因此，如果需要为前面创建的centos-6.5-x86_64这个distro提供一个可引导安装条目，其用到的kickstart文件为/tmp/centos-6.5-x86_64.cfg(只提供了最基本的程序包)，则可通过如下命令实现。
# cobbler profile add --name=centos-6.5-x86_64-basic --distro=centos-6.5-x86_64 --kickstart=/tmp/centos-6.5-x86_64.cfg

可使用“cobbler profile list”查看已经创建的profile。


四、使用cobbler_web

4.1 配置cobbler_web的认证功能

cobbler_web支持多种认证方式，如authn_configfile、authn_ldap或authn_pam等，默认为authn_denyall，即拒绝所有用户登录。下面说明两种能认证用户登录cobbler_web的方式。

4.1.1 使用authn_pam模块认证cobbler_web用户

首先修改modules中[authentication]段的module参数的值为authn_pam。

接着添加系统用户，用户名和密码按需设定即可，例如下面的命令所示。
# useradd cblradmin
# echo 'cblrpass' | passwd --stdin cblradmin

而后将cblradmin用户添加至cobbler_web的admin组中。修改/etc/cobbler/users.conf文件，将cblradmin用户名添加为admin参数的值即可，如下所示。
[admins]
admin = "cblradmin"

最后重启cobblerd服务，通过http://YOUR_COBBLERD_IP/cobbler_web访问即可。

4.1.2 使用authn_configfile模块认证cobbler_web用户

首先修改modules中[authentication]段的module参数的值为authn_configfile。

接着创建其认证文件/etc/cobbler/users.digest，并添加所需的用户即可。需要注意的是，添加第一个用户时，需要为htdigest命令使用“-c”选项，后续添加其他用户时不能再使用；另外，cobbler_web的realm只能为Cobbler。如下所示。

# htdigest -c /etc/cobbler/users.digest Cobbler cblradmin  

最后重启cobblerd服务，通过http://YOUR_COBBLERD_IP/cobbler_web访问即可。



