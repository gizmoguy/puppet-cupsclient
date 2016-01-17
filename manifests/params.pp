# Class: cupsclient::params
# ===========================
#
#   Cupsclient default parameters.
#
class cupsclient::params {

  case $::osfamily {
    'Debian': {
      $config           = 'cupsclient/client.conf.erb'
      $config_path      = '/etc/cups/'
      $config_file      = '/etc/cups/client.conf'
      $config_group     = 'lp'
      $config_owner     = 'root'
      $package          = 'cups-client'
      $package_ensure   = 'installed'
      $package_provider = 'apt'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}
