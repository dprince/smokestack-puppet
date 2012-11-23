#
# SmokeStack unit test worker
#
class smokestack::unit (
) inherits smokestack::worker {

  # packages required to run unit tests
  package { ['python-devel',
              'libxslt-devel',
              'swig',
              'python-setuptools',
              'python-virtualenv',
              'zeromq-devel',
              'patch',
              'openldap-devel',
              ]:
    ensure => 'present'
  }

  file { "/etc/monit.d/unit_worker":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 640,
    content => template('smokestack/unit_worker.monit.erb'),
    require => Package['monit'],
  }

}
