class smokestack::api (
) {

  class { 'apache': }

  file { '/etc/httpd/conf.d/smokestack.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source  => 'puppet:///modules/smokestack/smokestack_http.conf',
    require => Class['apache']
  }

}
