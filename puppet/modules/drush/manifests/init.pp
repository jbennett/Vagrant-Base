class drush {
	include drush::install
}

class drush::install {
	exec { "pear install drush":
		command "pear install --alldeps pear.drush.org/drush",
		creates => '/usr/bin/drush',
		requires => Class['pear::install']
	}
}
