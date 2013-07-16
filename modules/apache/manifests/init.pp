class apache (
) {

  package { ['httpd', 'mod_ssl', 'mod_passenger']:
    ensure => 'present'
  }

  service {'httpd':
    ensure  => 'running',
    enable  => true,
    require => Package["redis"]
  }

}
