exec{'/usr/sbin/modprobe ext4':
	user	=> root,
	group	=> root,
	refresh	=> '/usr/sbin/modprobe -r ext4 && /usr/sbin/modprobe ext4',
	timeout	=> 5,
	tries	=> 2,
}

exec{'/bin/echo mageedu > /tmp/hello.txt':
	user	=> root,
	group	=> root,
	creates	=> '/tmp/hello.txt',
}

exec{'/bin/echo mageedu > /tmp/hello2.txt':
	user	=> root,
	group	=> root,
	unless	=> '/usr/bin/test -e /tmp/hello2.txt',
}
