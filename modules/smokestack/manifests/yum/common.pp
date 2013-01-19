class smokestack::yum::common (
  $repos_dir='/var/www/html/repos/'
) {

  package { ['yum-utils', 'createrepo']:
    ensure => 'present'
  }

  file { $repos_dir:
    ensure  => directory,
    mode    => '755',
    owner   => 'root',
    group   => 'root'
  }

}
