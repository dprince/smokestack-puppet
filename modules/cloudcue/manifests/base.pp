#
# Base CloudCue configuration
#
class cloudcue::base (
  $username='cloudcue',
  $home_dir='/home/cloudcue',
  $server_name_prefix='cc_',
  $cloudcue_db_name='cloudcue_prod',
  $cloudcue_db_username='cloudcue',
  $cloudcue_db_host,
  $cloudcue_db_password,
) {

  # base packages required by all CloudCue
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

  file { $home_dir:
    ensure  => directory,
    mode    => '700',
    owner   => $username,
    group   => $username,
    require => User[$username]
  }

  # Capistrano directory tree
  file { ['/u/',
          '/u/apps/',
          '/u/apps/CloudCue/',
          '/u/apps/CloudCue/releases',
          '/u/apps/CloudCue/shared',
          '/u/apps/CloudCue/shared/config',
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

  file { "/u/apps/CloudCue/shared/config/database.yml":
    ensure  => present,
    owner   => $username,
    group   => $username,
    mode    => 640,
    content => template('cloudcue/database.yml.erb'),
    require => File['/u/apps/CloudCue/shared/config']
  }

  file { "/u/apps/CloudCue/shared/config/environments/production.rb":
    ensure  => present,
    owner   => $username,
    group   => $username,
    mode    => 640,
    content => template('cloudcue/production.rb.erb'),
    require => File['/u/apps/CloudCue/shared/config']
  }

}
