class drush {
	include drush::install
}

class drush::install {
	exec { "pear install console_table":
		command => "/usr/bin/pear install --alldeps Console_Table",
		require => Class['pear::config']
	}

	exec { "pear install drush":
		command => "/usr/bin/pear install --alldeps pear.drush.org/drush",
		creates => '/usr/bin/drush',
		require => Class['pear::config']
	}
}
