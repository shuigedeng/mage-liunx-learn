$webserver=nginx

package{$webserver:
	ensure	=> latest,
}

file{'/etc/nginx/nginx.conf':
	ensure	=> file,
	source	=> '/root/modules/nginx/files/nginx.conf',
	require	=> Package['nginx'],
	notify	=> Service['nginx'],
}

service{'nginx':
	ensure	=> running,
	enable	=> true,
	hasrestart => true,
	hasstatus => true,
	#restart	=> 'systemctl reload nginx.service',
	require	=> [ Package['nginx'], File['/etc/nginx/nginx.conf'] ],
}
