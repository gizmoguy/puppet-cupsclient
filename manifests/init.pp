# Class: cupsclient
# ===========================
#
# Simple puppet module for managing /etc/cups/client.conf
#
# Parameters
# ----------
#
# * `allowanyroot`
# Specifies whether to allow TLS with certificates that have not
# been signed by a trusted Certificate Authority.
#
# * `allowexpiredcerts`
# Specifies whether to allow TLS with expired certificates.
#
# * `encryption`
# Specifies the level of encryption that should be used.
#
# * `gssservicename`
# Specifies the Kerberos service name that is used for
# authentication, typically "host", "http", or "ipp". CUPS adds the
# remote hostname ("name@server.example.com") for you.
#
# * `servername`
# Specifies the address and optionally the port to use when
# connecting to the server.
#
# * `ssloptions`
# Sets encryption options (only in /etc/cups/client.conf). By
# default, CUPS only supports encryption using TLS v1.0 or higher
# using known secure cipher suites. The AllowDH option enables
# cipher suites using plain Diffie-Hellman key negotiation. The
# AllowRC4 option enables the 128-bit RC4 cipher suites, which are
# required for some older clients that do not implement newer ones.
# The AllowSSL3 option enables SSL v3.0, which is required for some
# older clients that do not support TLS v1.0. The DenyTLS1.0 option
# disables TLS v1.0 support - this sets the minimum protocol version
# to TLS v1.1.
#
# * `user`
# Specifies the default user name to use for requests.
#
# * `validatecerts`
# Specifies whether to only allow TLS with certificates whose common
# name matches the hostname.
#
# Examples
# --------
#
# @example
#    class { 'cupsclient':
#      servername => 'cups.mycorp.com',
#    }
#
# Authors
# -------
#
# Brad Cowie <brad@wand.net.nz>
#
# Copyright
# ---------
#
# Copyright 2016 Brad Cowie, Waikato University, unless otherwise noted.
#
class cupsclient (
  $config           = $cupsclient::params::config,
  $config_path      = $cupsclient::params::config_path,
  $config_file      = $cupsclient::params::config_file,
  $config_group     = $cupsclient::params::config_group,
  $config_owner     = $cupsclient::params::config_owner,
  $package          = $cupsclient::params::package,
  $package_ensure   = $cupsclient::params::package_ensure,
  $package_provider = $cupsclient::params::package_provider,

  $allowanyroot      = '',
  $allowexpiredcerts = '',
  $encryption        = '',
  $gssservicename    = '',
  $servername        = '',
  $ssloptions        = '',
  $user              = '',
  $validatecerts     = '',
) inherits cupsclient::params {

  validate_string($config)
  validate_absolute_path($config_path)
  validate_string($config_file)
  validate_string($config_group)
  validate_string($config_owner)
  validate_string($package)
  validate_string($package_ensure)
  validate_string($package_provider)

  validate_string($allowanyroot)
  validate_string($allowexpiredcerts)
  validate_string($encryption)
  validate_string($gssservicename)
  validate_string($servername)
  validate_string($ssloptions)
  validate_string($user)
  validate_string($validatecerts)

  file { $config_path:
    ensure  => directory,
    path    => $config_path,
    owner   => $config_owner,
    group   => $config_group,
    mode    => '0755'
  }

  file { 'client.conf':
    ensure  => file,
    path    => $config_file,
    content => template($config),
    owner   => $config_owner,
    group   => $config_group,
    mode    => '0644',
    require => File[$config_path]
  }

  package { $package:
    ensure   => $package_ensure,
    name     => $package,
    provider => $package_provider,
  }

}
