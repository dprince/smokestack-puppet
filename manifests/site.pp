node default {

  class { 'collectd': }
  class { 'collectd::plugins::librato':
    librato_email => hiera('librato_email'),
    librato_api_token => hiera('librato_api_token'),
  }
  class { 'packagekit::cron': }

}
