class nginx {
	package{'nginx':
		ensure	=> latest,
		name => nginx,
	} ->
	
	service{'nginx':
		enable	=> true,
		ensure	=> running,
		hasrestart => true,
		hasstatus => true,
		restart => 'service nginx reload',
	}
}

class nginx::webserver inherits nginx {
	Package['nginx'] {
		name => tengine,
	}

	file{'/etc/nginx/nginx.conf':
		source => '/root/modules/nginx/files/nginx_web.conf',
		ensure	=> file,
		notify 	=> Service['nginx'],
	}
}

class nginx::proxy inherits nginx {
	file{'/etc/nginx/nginx.conf':
		content => template('/root/modules/nginx/files/nginx_proxy.conf'),
		ensure	=> file,
		notify 	=> Service['nginx'],
	}
}

include nginx::proxy
