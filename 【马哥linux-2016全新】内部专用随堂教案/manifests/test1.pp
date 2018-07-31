group{'distro':
	gid	=> 2000,
	ensure	=> present,
}

user{'centos':
	uid	=> 2000,
	gid	=> 2000,
	shell	=> '/bin/bash',
	home	=> '/home/centos',
	ensure	=> present,
}
