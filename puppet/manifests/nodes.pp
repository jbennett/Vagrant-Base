node default {
	exec { "apt-update":
    	command => "/usr/bin/apt-get update"
	}

	include nginx
	include mysql
	include php
	include pear
	include drush
	# include git

	nginx::site {'default':
		source => 'puppet:///modules/nginx/project-nginx.conf',
	}
	
	mysql::account { 'drupal':
		user => 'drupal',
		password => 'drupal',
	}
}
