#
# Base SmokeStack ssh configuration
#
class smokestack::ssh (
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
