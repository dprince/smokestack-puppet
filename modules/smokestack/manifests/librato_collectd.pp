#
# Configure collectd for on a SmokeStack workers
# NOTE: Currently uses Librato Metrics
#
class smokestack::librato_collectd (
  $librato_email='joe@example.com',
  $librato_api_token='1985481910fe29ab201302011054857292'
) {

  package { 'collectd':
    ensure => 'present'
  }

  service { "collectd":
    ensure => 'running',
    enable => true,
    require => [Package['collectd'], File['/etc/collectd.d/librato.conf'], File['/opt/collectd-librato/collectd-librato.py']]
  }

  file { "/etc/collectd.d/librato.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 640,
    content => template('smokestack/librato.conf.erb'),
    notify => Service['collectd'],
    require => Package['collectd'],
  }

  file { '/opt/collectd-librato/':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => 770,
  }

  file { '/opt/collectd-librato/collectd-librato.py':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source  => 'puppet:///modules/smokestack/collectd-librato.py',
    require => File["/opt/collectd-librato/"]
  }

}
