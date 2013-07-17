class cloudcue::api (
) {

  class { 'apache': }

  file { '/etc/httpd/conf.d/cloudcue.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source  => 'puppet:///modules/cloudcue/cloudcue_http.conf',
    require => Class['apache']
  }

}
