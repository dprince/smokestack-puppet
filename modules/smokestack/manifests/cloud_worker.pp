#
# SmokeStack cloud worker
#
define smokestack::cloud_worker (
 $worker_id,
 $username='smokestack',
 $home_dir='/home/smokestack'
) {

  file { "/etc/monit.d/cloud_worker_$worker_id":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 640,
    content => template('smokestack/cloud_worker.monit.erb'),
    require => Package['monit'],
  }

}
