node default {

  class { 'ssh': }

  class { 'collectd': }
  class { 'collectd::plugins::librato':
    librato_email => hiera('librato_email'),
    librato_api_token => hiera('librato_api_token'),
  }

  class { 'packagekit::cron': }

}

node /^api.*/ inherits default {

  class { 'smokestack::api': }

  class { 'redis': }


  class { 'smokestack::base':
    smokestack_db_host => hiera('smokestack_db_host'),
    smokestack_db_name => hiera('smokestack_db_name'),
    smokestack_db_username => hiera('smokestack_db_username'),
    smokestack_db_password => hiera('smokestack_db_password'),
    redis_server => hiera('redis_server'),
    package_cache_server => hiera('package_cache_server')
  }

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

  class { 'smokestack::base':
    smokestack_db_host => hiera('smokestack_db_host'),
    smokestack_db_name => hiera('smokestack_db_name'),
    smokestack_db_username => hiera('smokestack_db_username'),
    smokestack_db_password => hiera('smokestack_db_password'),
    redis_server => hiera('redis_server'),
    package_cache_server => hiera('package_cache_server')
  }

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

  class { 'smokestack::metrics':
    librato_email => hiera('librato_email'),
    librato_api_token => hiera('librato_api_token'),
  }

}

node /^libvirt.*/ inherits default {

  class { 'smokestack::base':
    smokestack_db_host => hiera('smokestack_db_host'),
    smokestack_db_name => hiera('smokestack_db_name'),
    smokestack_db_username => hiera('smokestack_db_username'),
    smokestack_db_password => hiera('smokestack_db_password'),
    redis_server => hiera('redis_server'),
    package_cache_server => hiera('package_cache_server')
  }

  class { 'smokestack::libvirt': }

  smokestack::libvirt_worker {'libvirt_worker_1':
    worker_id => 1,
  }

  smokestack::libvirt_worker {'libvirt_worker_2':
    worker_id => 2,
  }

  class { 'smokestack::metrics':
    librato_email => hiera('librato_email'),
    librato_api_token => hiera('librato_api_token'),
  }

}

node /^cloud-worker.*/ inherits default {

  class { 'smokestack::base':
    kytoon_cloudcue_url => hiera('kytoon_cloudcue_url'),
    kytoon_cloudcue_username => hiera('kytoon_cloudcue_username'),
    kytoon_cloudcue_password => hiera('kytoon_cloudcue_password'),
    smokestack_db_host => hiera('smokestack_db_host'),
    smokestack_db_name => hiera('smokestack_db_name'),
    smokestack_db_username => hiera('smokestack_db_username'),
    smokestack_db_password => hiera('smokestack_db_password'),
    redis_server => hiera('redis_server'),
    package_cache_server => hiera('package_cache_server')
  }

  smokestack::cloud_worker {'cloud_worker_1':
    worker_id => 1,
  }
  smokestack::cloud_worker {'cloud_worker_2':
    worker_id => 2,
  }
  smokestack::cloud_worker {'cloud_worker_3':
    worker_id => 3,
  }
  smokestack::cloud_worker {'cloud_worker_4':
    worker_id => 4,
  }
  smokestack::cloud_worker {'cloud_worker_5':
    worker_id => 5,
  }
  smokestack::cloud_worker {'cloud_worker_6':
    worker_id => 6,
  }
  smokestack::cloud_worker {'cloud_worker_7':
    worker_id => 7,
  }
  smokestack::cloud_worker {'cloud_worker_8':
    worker_id => 8,
  }
  smokestack::cloud_worker {'cloud_worker_9':
    worker_id => 9,
  }
  smokestack::cloud_worker {'cloud_worker_10':
    worker_id => 10,
  }

  class { 'smokestack::metrics':
    librato_email => hiera('librato_email'),
    librato_api_token => hiera('librato_api_token'),
  }

}

node /^cloudcue.*/ inherits default {

  class { 'cloudcue::api': }

  class { 'redis': }

  class { 'cloudcue::base':
    cloudcue_db_host => hiera('cloudcue_db_host'),
    cloudcue_db_name => hiera('cloudcue_db_name'),
    cloudcue_db_username => hiera('cloudcue_db_username'),
    cloudcue_db_password => hiera('cloudcue_db_password')
  }

  class { 'cloudcue::cron': }

  cloudcue::worker {'worker_1':
    worker_id => 1,
  }
  cloudcue::worker {'worker_2':
    worker_id => 2,
  }
  cloudcue::worker {'worker_3':
    worker_id => 3,
  }
  cloudcue::worker {'worker_4':
    worker_id => 4,
  }
  cloudcue::worker {'worker_5':
    worker_id => 5,
  }
  cloudcue::worker {'worker_6':
    worker_id => 6,
  }
  cloudcue::worker {'worker_7':
    worker_id => 7,
  }
  cloudcue::worker {'worker_8':
    worker_id => 8,
  }
  cloudcue::worker {'worker_9':
    worker_id => 9,
  }

}

node /^pkgcache.*/ inherits default {

  class { 'pkgcache': }

}
