class php {
	include php::install, php::config, php::service
}

class php::install {
	package { 'php5-fpm': ensure => present }
	package { 'php5-gd': ensure => present }
	package { 'php5-mysql': ensure => present }
	package { 'php5-mcrypt': ensure => present }
}

class php::config {
	file { '/etc/php5/fpm/php.ini':
		ensure => present,
		source => 'puppet:///modules/php/php.ini',
		owner => root,
		group => root,
		require => Class['php'],
		notify => Class['php::service'],
	}

	file { '/etc/php5/fpm/pool.d/www.conf':
		ensure => present,
		source => 'puppet:///modules/php/www.conf',
		owner => root,
		group => root,
		require => Class['php'],
		notify => Class['php::service'],
	}
}

class php::service {
	service { 'php5-fpm':
		ensure => running
	}
}
