#
# Base CloudCue worker configuration
#
class cloudcue::worker (
  $username='cloudcue',
) {

  # base packages required by all CloudCue workers
  package { ['rubygems',
              'libxslt-devel',
              'libxml2-devel',
              'libxml-devel',
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

  # Capistrano directory tree
  file { ['/u/',
          '/u/apps/',
          '/u/apps/CloudCue/',
          '/u/apps/CloudCue/releases',
          '/u/apps/CloudCue/shared',
          '/u/apps/CloudCue/shared/log',
          '/u/apps/CloudCue/shared/pids']:
    ensure  => directory,
    mode    => '775',
    #recurse => true,
    owner   => $username,
    group   => $username,
    require => User['cloudcue']
  }

  # Disable tty requirement for sudo
  augeas{"set_requiretty":
    context   => "/files/etc/sudoers/",
    changes   => [
        "clear Defaults/requiretty/negate"
      ]
  }

}
