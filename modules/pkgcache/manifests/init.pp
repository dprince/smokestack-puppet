class pkgcache (
) {

  package { 'sqlite': ensure => present }

  class { 'apache': }

  file { '/etc/httpd/conf.d/pkgcache.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source  => 'puppet:///modules/pkgcache/pkgcache_http.conf',
    require => Class['apache']
  }

  file {'/var/www/pkgcache':
    ensure  => directory,
    mode    => '775',
    #recurse => true,
    owner   => 'apache',
    group   => 'apache',
    require => Class['apache']
  }


  file {'/var/www/pkgcache/pkgcache':
    ensure  => present,
    owner   => 'apache',
    group   => 'apache',
    mode    => 755,
    source  => 'puppet:///modules/pkgcache/pkgcache'
  }

}
