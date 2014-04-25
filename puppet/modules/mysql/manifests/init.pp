class mysql {
	include mysql::install, mysql::config, mysql::service
}

class mysql::install {
	package { 'mysql-server':
		ensure => present
	}
}

class mysql::config {
	
}

class mysql::service {
	service { 'mysql':
		ensure => running,
		enable => true,
		require => Class['mysql::install'],
	}
}

Class['mysql::install'] -> Class['mysql::config'] -> Class['mysql::service']

define mysql::account( $user, $password ) {
    exec { "create-${name}-db":
		unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
		command => "/usr/bin/mysql -uroot -p$mysql_password -e \"create database ${name}; grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
		require => Class["mysql::service"],
    }
}
