from fabric.api import env, sudo, run, local, settings
from fabric.context_managers import cd, lcd
from fabric.operations import prompt, put
import os
from fabric.decorators import roles
from datetime import datetime
from time import strftime
import ntpath

# Dev chores
####################
def clone_keys():
	put('~/.ssh/id_rsa.pub', '~/.ssh/id_rsa.pub', mode=0400)
	put('~/.ssh/id_rsa', '~/.ssh/id_rsa', mode=0400)

def boot_env():
	with lcd('public/sites/default'):
		local('chmod +w .')
		local('if [ ! -f settings.php ] ; then cp default.settings.php settings.php ; fi')
		local('chmod -w .')
	with cd('/vagrant/public'):
		run('drush site-install standard --db-url=mysql://drupal:drupal@localhost/drupal install_configure_form.update_status_module=\'array(FALSE,FALSE)\'')
	pull_dev_db


# setup environments
####################
def vm():
	env.hosts = ['vagrant@127.0.0.1']
	env.port = 2222
	env.key_filename = ['~/.vagrant.d/insecure_private_key']

def dev():
	env.hosts = ['asdf@asdf.com']

def prod():
	env.hosts = ['asdf@asdf.com']

# Tasks
####################
'''
This syncs your local database to the dev server database
'''
def pull_dev_db():
	with cd('/vagrant/public'):
		run('drush sql-sync @dev @self -y')
		run('drush @self cc all')

def pull_dev_files():
	with cd('/vagrant/public'):
		run('drush -y rsync @dev:%files/ @self:%files')
