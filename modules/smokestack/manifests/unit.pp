#
# Base SmokeStack worker configuration
#
#
class smokestack::unit (
  $username='smokestack',
  $home_dir='/home/smokestack'
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

}
