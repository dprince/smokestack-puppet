class cloudcue::cron (
) {

  file { '/etc/cron.d/cloudcue_pools':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source  => 'puppet:///modules/cloudcue/cron_pools'
  }

  file { '/etc/cron.d/cloudcue_cleanup':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source  => 'puppet:///modules/cloudcue/cron_cleanup'
  }

}
