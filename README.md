# cupsclient

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with cupsclient](#setup)
    * [What cupsclient affects](#what-cupsclient-affects)
    * [Beginning with cupsclient](#beginning-with-cupsclient)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This is a very simple Puppet module for managing the cups-client configuration.

## Setup

### What cupsclient affects

* Installs cups-client package
* Manages /etc/cups/client.conf

### Beginning with cupsclient

```puppet
include '::cupsclient'
```

## Usage

Typical usage will involve setting cups-client's ServerName parameter which
will turn on remote CUPS lookups for printers.

```puppet
class { '::cupsclient':
  servername => 'cups.mycorp.com',
}
```

## Reference

### Classes

* cupsclient: Main class for installation and configuration.

### Parameters

####`allowanyroot`

Possible values:
 * Yes
 * No

Specifies whether to allow TLS with certificates that have not
been signed by a trusted Certificate Authority.

####`allowexpiredcerts`

Possible values:
 * Yes
 * No

Specifies whether to allow TLS with expired certificates.

####`encryption`

Possible values:
 * IfRequested
 * Never
 * Required

Specifies the level of encryption that should be used.

####`gssservicename`

Possible values:
 * name

Specifies the Kerberos service name that is used for
authentication, typically "host", "http", or "ipp". CUPS adds the
remote hostname ("name@server.example.com") for you.

####`servername`

Possible values:
 * hostname-or-ip-address[:port]
 * /domain/socket
 * hostname-or-ip-address[:port]/version=1.1

Specifies the address and optionally the port to use when
connecting to the server.

####`ssloptions`

Possible values:
 * [AllowDH] [AllowRC4] [AllowSSL3] [DenyTLS1.0]
 * None

Sets encryption options (only in /etc/cups/client.conf). By
default, CUPS only supports encryption using TLS v1.0 or higher
using known secure cipher suites. The AllowDH option enables
cipher suites using plain Diffie-Hellman key negotiation. The
AllowRC4 option enables the 128-bit RC4 cipher suites, which are
required for some older clients that do not implement newer ones.
The AllowSSL3 option enables SSL v3.0, which is required for some
older clients that do not support TLS v1.0. The DenyTLS1.0 option
disables TLS v1.0 support - this sets the minimum protocol version
to TLS v1.1.

####`user`

Possible values:
 * name

Specifies the default user name to use for requests.

####`validatecerts`

Possible values:
 * Yes
 * No

Specifies whether to only allow TLS with certificates whose common
name matches the hostname.

## Limitations

This module has been built on and tested against Puppet 3.x.

This module has been tested on:

* Ubuntu 15.10
* Ubuntu 16.04
