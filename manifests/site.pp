node default {

  class { 'collectd': }
  class { 'collectd::plugins::librato':
    librato_email => hiera('librato_email'),
    librato_api_token => hiera('librato_api_token'),
  }
  class { 'packagekit::cron': }

}

node /^mirror.*/ inherits default {

  class { 'smokestack::yum::mirror': }

  smokestack::yum::repo { 'f18-x86_64-updates':
   description => "Fedora 18 - x86_64 - Updates",
   mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=updates-released-f18&arch=x86_64',
   cron_hour => 1,
   cron_minute => 15,
  }

  smokestack::yum::repo { 'f18-x86_64-release':
   description => "Fedora 18 - x86_64 - Release",
   mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=fedora-18&arch=x86_64',
   cron_hour => 2,
   cron_minute => 15,
  }

  smokestack::yum::repo { 'centos-6.4-x86_64-updates':
   description => "CentOS-6.4 - Updates",
   mirrorlist => 'http://mirrorlist.centos.org/?release=6.4&arch=x86_64&repo=updates',
   cron_hour => 3,
   cron_minute => 15,
  }

  smokestack::yum::repo { 'centos-6.4-x86_64-base':
   description => "CentOS-6.4 - Base",
   mirrorlist => 'http://mirrorlist.centos.org/?release=6.4&arch=x86_64&repo=os',
   cron_hour => 4,
   cron_minute => 15,
  }

}

node /^xen.*/ inherits default {

  class { "smokestack::worker": }

  smokestack::xen_worker {'xen_worker_1':
    worker_id => 1,
    xenserver_ip => hiera('xenserver_ip_1'),
  }

  smokestack::xen_worker {'xen_worker_2':
    worker_id => 2,
    xenserver_ip => hiera('xenserver_ip_2'),
  }

  smokestack::xen_worker {'xen_worker_3':
    worker_id => 3,
    xenserver_ip => hiera('xenserver_ip_3'),
  }

  smokestack::xen_worker {'xen_worker_4':
    worker_id => 4,
    xenserver_ip => hiera('xenserver_ip_4'),
  }

}

node /^libvirt.*/ inherits default {

  class { 'smokestack::worker': }

  smokestack::libvirt_worker {'libvirt_worker_1':
    worker_id => 1,
  }

  smokestack::libvirt_worker {'libvirt_worker_2':
    worker_id => 2,
  }

}
