#
# SmokeStack unit test worker
#
class smokestack::unit_worker (
) {

  # packages required to run unit tests
  package { ['python-devel',
              'libxml2-devel',
              'cyrus-sasl-devel',
              'libvirt-python',
              'libcurl-devel',
              'swig',
              'python-setuptools',
              'python-pip',
              'python-virtualenv',
              'zeromq-devel',
              'patch',
              'openldap-devel',
              ]:
    ensure => 'present'
  }

  # No tox package yet so we pip install it for now...
  # NOTE: we use --upgrade so virtualenv gets upgraded too
  exec { '/usr/bin/pip-python install tox --upgrade':
    onlyif => '/bin/python -c "import tox" || exit 0',
    require => Package['python-pip']
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
