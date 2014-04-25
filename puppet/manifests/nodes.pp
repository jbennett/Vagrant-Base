node default {
	exec { "apt-update":
    	command => "/usr/bin/apt-get update"
	}

	include git
	include mysql
	include nginx
	include php

	nginx::site {'default':
		source => 'puppet:///modules/nginx/project-nginx.conf',
	}
	
	mysql::account { 'drupal':
		user => 'drupal',
		password => 'drupal',
	}
}
