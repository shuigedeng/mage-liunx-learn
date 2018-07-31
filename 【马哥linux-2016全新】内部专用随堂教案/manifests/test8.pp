group{'linux':
	gid	=> 3000,
	ensure	=> present,
}

user{'suse':
	uid	=> 3000,
	gid	=> 3000,
	shell	=> '/bin/bash',
	home	=> '/home/suse',
	ensure	=> present,
	require	=> Group['linux'],
}
