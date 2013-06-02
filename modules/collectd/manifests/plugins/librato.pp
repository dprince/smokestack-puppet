#
# Configure collectd to use the librato plugin
#
class collectd::plugins::librato (
  $librato_email='joe@example.com',
  $librato_api_token='1985481910fe29ab201302011054857292'
) {

  File['/etc/collectd.d/librato.conf'] -> Service['collectd']
  File['/opt/collectd-librato/collectd-librato.py'] -> Service['collectd']

  file { "/etc/collectd.d/librato.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 640,
    content => template('collectd/librato.conf.erb'),
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
    source  => 'puppet:///modules/collectd/collectd-librato.py',
    require => File["/opt/collectd-librato/"]
  }

}
