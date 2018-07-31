file{'/tmp/mydir':
	ensure	=> directory,
}

file{'/tmp/puppet.file':
	content	=> 'puppet testing\nsecond line.',
	ensure	=> file,
	owner	=> 'centos',
	group	=> 'distro',
	mode	=> '0400',
}

file{'/tmp/fstab.puppet':
	source	=> '/etc/fstab',
	ensure	=> file,
}

file{'/tmp/puppet.link':
	ensure	=> link,
	target	=> '/tmp/puppet.file',
}


