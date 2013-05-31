#
# SmokeStack unit test worker
#
define smokestack::xen_worker (
 $worker_id,
 $xenserver_ip,
 $username='smokestack',
 $home_dir='/home/smokestack'
) {

  file { "/etc/monit.d/xen_worker_$worker_id":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 640,
    content => template('smokestack/xen_worker.monit.erb'),
    require => Package['monit'],
  }

}
