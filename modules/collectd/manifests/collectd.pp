#
# Configure collectd
#
class collectd (
  $hostname=false,
  $fqdnlookup=true,
  $interval=60
) {

  package { 'collectd':
    ensure => 'present',
  }

  service { "collectd":
    ensure => 'running',
    enable => true,
    require => [Package['collectd']],
  }

  file { "/etc/collectd.conf":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => template('collectd/collectd.conf.erb'),
    notify => Service['collectd'],
    require => Package['collectd'],
  }

}
