class nginx {
	package{'nginx':
		ensure	=> latest,
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
	file{'/etc/nginx/nginx.conf':
		source => '/root/modules/nginx/files/nginx_web.conf',
		ensure	=> file,
		notify 	=> Service['nginx'],
	}
}

class nginx::proxy inherits nginx {
	file{'/etc/nginx/nginx.conf':
		source => '/root/modules/nginx/files/nginx_proxy.conf',
		ensure	=> file,
		notify 	=> Service['nginx'],
	}
}

include nginx::proxy
