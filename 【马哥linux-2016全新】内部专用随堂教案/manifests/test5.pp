cron{"sync time":
	command	=> '/usr/sbin/ntpdate 172.16.0.1 &> /dev/null',
	minute	=> '*/10',
	ensure	=> absent,
}
