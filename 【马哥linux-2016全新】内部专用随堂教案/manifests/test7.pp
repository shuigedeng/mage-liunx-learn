package{'nginx':
	ensure	=> latest,
}

service{'nginx':
	ensure	=> running,
	enable	=> true,
	hasrestart => true,
	hasstatus => true,
	restart	=> 'systemctl reload nginx.service',
}
