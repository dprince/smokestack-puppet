#
# Base ssh configuration
#
class ssh::init (
) {

  # Disable ssh password access
  augeas{"set_ssh_nopass":
    context   => "/files/etc/ssh/sshd_config",
    changes   => [
        "set PasswordAuthentication no"
      ],
    notify => Service['sshd']
  }

  service {'sshd':
    ensure  => 'running',
    enable  => true
  }

}
