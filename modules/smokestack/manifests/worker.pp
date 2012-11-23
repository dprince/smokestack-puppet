#
# Base SmokeStack worker configuration
#
class smokestack::worker (
  $username='smokestack',
  $home_dir='/home/smokestack'
) {

  # base packages required by all SmokeStack workers
  package { ['rubygems',
              'ruby-devel',
              'rubygem-bundler',
              'gcc',
              'gcc-c++',
              'git',
              'monit',
              'mysql-devel',
              'ntp']:
    ensure => 'present'
  }

  service {'ntpd':
    ensure  => 'running',
    enable  => true,
    require => Package["ntp"]
  }

  user { $username:
    ensure => present
  }

  file { $home_dir:
    ensure  => directory,
    mode    => '700',
    owner   => $username,
    group   => $username,
    require => User['smokestack']
  }

  # Capistrano directory tree
  file { ['/u/',
          '/u/apps/',
          '/u/apps/SmokeStack/',
          '/u/apps/SmokeStack/releases',
          '/u/apps/SmokeStack/shared',
          '/u/apps/SmokeStack/shared/log',
          '/u/apps/SmokeStack/shared/pids']:
    ensure  => directory,
    mode    => '775',
    recurse => true,
    owner   => $username,
    group   => $username,
    require => User['smokestack']
  }

  # Disable tty requirement for sudo
  augeas{"set_requiretty":
    context   => "/files/etc/sudoers/",
    changes   => [
        "clear Defaults/requiretty/negate"
      ]
  }

}
