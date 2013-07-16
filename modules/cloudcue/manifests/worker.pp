#
# resque worker
#
define cloudcue::worker (
 $worker_id,
 $username='cloudcue',
 $home_dir='/home/cloudcue'
) {

  file { "/etc/monit.d/resque_worker_$worker_id":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 640,
    content => template('cloudcue/worker.monit.erb'),
    require => Package['monit'],
  }

}
