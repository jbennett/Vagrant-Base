class pear {
	include pear::install, pear::config
}

class pear::install {
	package { 'php-pear': ensure => present }
}

class pear::config {
	exec { "pear auto_discover":
		command => "/usr/bin/pear config-set auto_discover 1",
		require => Class['pear::install']
	}
}
