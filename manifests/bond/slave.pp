# == Definition: network::bond::slave
#
# Creates a bonded slave interface.
#
# === Parameters:
#
#   $macaddress   - required
#   $master       - required
#   $ethtool_opts - optional
#
# === Actions:
#
# Deploys the file /etc/sysconfig/network-scripts/ifcfg-$name.
#
# === Requires:
#
#   Service['network']
#
# === Sample Usage:
#
#   network::bond::slave { 'eth1':
#     macaddress => $::macaddress_eth1,
#     master     => 'bond0',
#   }
#
# === Authors:
#
# Mike Arnold <mike@razorsedge.org>
#
# === Copyright:
#
# Copyright (C) 2011 Mike Arnold, unless otherwise noted.
#
define network::bond::slave (
  $master,
  $interface    = $name,
  $macaddress   = '',
  $ethtool_opts = ''
) {
  include network

  file { "ifcfg-${interface}":
    ensure  => 'present',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    path    => "/etc/sysconfig/network-scripts/ifcfg-${interface}",
    content => template('network/ifcfg-bond.erb'),
    before  => File["ifcfg-${master}"],
    # notify  => Service['network'],
  }
} # define network::bond::slave
