#
# Install cron job used to post worker metrics to Librato
#
# Intended to be used on SmokeStack worker nodes only.
#
class smokestack::metrics (
  $librato_email,
  $librato_api_key,
  $username='smokestack',
  $home_dir='/home/smokestack'
) {

  if !defined(Package['curl']) {
    package { 'curl': }
  }

  file { "$home_dir/upload_metrics.bash":
    ensure  => present,
    owner   => $username,
    group   => $username,
    mode    => 750,
    content => template('smokestack/upload_metrics.bash'),
    require => File[$home_dir]
  }

  cron { "smokestack metrics":
    command => "$home_dir/upload_metrics.bash",
    user    => $username,
    minute  => "*/1"
  }

}
