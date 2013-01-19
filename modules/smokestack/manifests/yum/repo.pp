#
# Setup a local Yum mirror and cron task
#
# Example (for Fedora 17):
#
#  smokestack::yum::repo { 'f17-x86_64-updates':
#   description => "Fedora 17 - x86_64 - Updates",
#   mirrorlist => "https://mirrors.fedoraproject.org/metalink?repo=updates-released-f17&arch=x86_64"
#  }

#
define smokestack::yum::repo (
  $description = '',
  $enabled = 0,
  $gpgcheck = 0,
  $baseurl = absent,
  $mirrorlist = absent,
  $cron_hour = 2,
  $cron_minute = 0,
) {

  include 'smokestack::yum::common'

  yumrepo { $name:
    name => $name,
    descr => $description,
    enabled => $enabled,
    gpgcheck => $gpgcheck,
    baseurl => $baseurl,
    mirrorlist => $mirrorlist
  }

  cron { "reposync $name":
    command => "/usr/bin/reposync -r $name -p $smokestack::yum::common::repos_dir; /bin/createrepo -c /tmp/$name $smokestack::yum::common::repos_dir/$name",
    hour    => $cron_hour,
    minute  => $cron_minute
  }

}
