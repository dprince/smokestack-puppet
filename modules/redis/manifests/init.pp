class redis (
) {

  package { 'redis':
    ensure => 'present'
  }

  service {'redis':
    ensure  => 'running',
    enable  => true,
    require => Package["redis"]
  }

}
