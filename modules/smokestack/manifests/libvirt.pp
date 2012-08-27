#
# Configure libvirt for use on a SmokeStack worker
#
#
class smokestack::libvirt (
  $username='smokestack',
  $images_dir='/var/lib/libvirt/images/'
) {

  package { ['libvirt', 'qemu-kvm', 'virt-manager', 'libguestfs-tools-c']:
    ensure => 'present'
  }

  service {'libvirtd':
    ensure  => 'running',
    enable  => true,
    require => Package["libvirt"]
  }

  group { 'libvirt':
    ensure => present
  }

  file { $images_dir:
    ensure  => directory,
    mode    => '771',
    owner   => 'root',
    group   => 'libvirt',
    require => [Group['libvirt'], Package["libvirt"]]
  }

  exec { "/sbin/usermod -G libvirt -a smokestack":
    onlyif => "groups smokestack | grep -v libvirt",
    require => Group['libvirt'],
    path    => "/usr/bin"

  }

  augeas{"libvirtd_conf":
    context   => "/files/etc/libvirt/libvirtd.conf/",
    changes   => [
        "set unix_sock_group libvirt",
        "set unix_sock_rw_perms 0770",
        "set auth_unix_ro none",
        "set auth_unix_rw none",
      ],
    notify => Service['libvirtd']
  }

  file { '/usr/share/augeas/lenses/libvirtnetwork.aug':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source  => 'puppet:///modules/smokestack/libvirtnetwork.aug'
  }

  exec { "recreate network":
    command     => "virsh net-destroy default && virsh net-create /etc/libvirt/qemu/networks/default.xml",
    path => "/bin",
    refreshonly => true,
    user     => 'root'
  }

  augeas{"libvirt_network_default_xml":
    context   => "/files/etc/libvirt/qemu/networks/default.xml/",
    changes   => [
        "set network/ip/#attribute/address 192.168.129.1",
        "set network/ip/dhcp/range/#attribute/start 192.168.129.2",
        "set network/ip/dhcp/range/#attribute/end 192.168.129.254",
      ],
    require => File["/usr/share/augeas/lenses/libvirtnetwork.aug"],
    notify => Exec["recreate network"]
  }

}
