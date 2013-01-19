#
# Configure a yum repository mirror server
# 
# Example:
#   class { 'smokestack::yum::mirror': }
#
class smokestack::yum::mirror (
) {

  package { 'httpd':
    ensure => 'present'
  }

  service { "httpd":
    ensure  => 'running',
    enable  => true,
    require => Package["httpd"]
  }

}
