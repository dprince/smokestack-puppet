#
# Base SmokeStack base configuration
#
class smokestack::base (
  $home_dir='/home/smokestack',
  $username='smokestack',
  $kytoon_libvirt_use_sudo='False',
  $kytoon_cloudcue_url='',
  $kytoon_cloudcue_username='',
  $kytoon_cloudcue_password='',
  $redis_server,
  $package_cache_server,
  $smokestack_db_host,
  $smokestack_db_name,
  $smokestack_db_username,
  $smokestack_db_password,
) {

  # base packages required by all SmokeStack workers
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
          '/u/apps/SmokeStack/',
          '/u/apps/SmokeStack/releases',
          '/u/apps/SmokeStack/shared',
          '/u/apps/SmokeStack/shared/config',
          '/u/apps/SmokeStack/shared/config/environments',
          '/u/apps/SmokeStack/shared/log',
          '/u/apps/SmokeStack/shared/pids']:
    ensure  => directory,
    mode    => '775',
    #recurse => true,
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

  file { "/u/apps/SmokeStack/shared/config/database.yml":
    ensure  => present,
    owner   => $username,
    group   => $username,
    mode    => 640,
    content => template('smokestack/database.yml.erb'),
    require => File['/u/apps/SmokeStack/shared/config']
  }

  file { "/u/apps/SmokeStack/shared/config/environments/production.rb":
    ensure  => present,
    owner   => $username,
    group   => $username,
    mode    => 640,
    content => template('smokestack/production.rb.erb'),
    require => File['/u/apps/SmokeStack/shared/config/environments']
  }

  file { "$home_dir/.kytoon.conf":
    ensure  => present,
    owner   => $username,
    group   => $username,
    mode    => 640,
    content => template('smokestack/kytoon.conf.erb'),
    require => File[$home_dir]
  }

}
