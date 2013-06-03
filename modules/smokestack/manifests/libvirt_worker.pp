#
# SmokeStack libvirt worker
#
define smokestack::libvirt_worker (
 $worker_id,
 $username='smokestack',
 $home_dir='/home/smokestack'
) {

  file { "/etc/monit.d/libvirt_worker_$worker_id":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 640,
    content => template('smokestack/libvirt_worker.monit.erb'),
    require => Package['monit'],
  }

}
