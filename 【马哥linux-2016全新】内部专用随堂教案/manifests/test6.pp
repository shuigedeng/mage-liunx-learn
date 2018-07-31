package{'zsh':
	ensure	=> latest,
}

package{'jdk':
	ensure	=> installed,
	source	=> '/usr/local/src/jdk-8u25-linux-x64.rpm',
	provider => rpm,
}
