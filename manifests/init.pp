# == Class: ksplice
#
# Puppet module for ksplice http://www.ksplice.com/
#
# === Parameters
#
# [*access_key*]
#   This is your access_key from http://www.ksplice.com/
#
# [*uptrack_upgrade*]
#   This allows you to upgrade uptrack upon install (see uptrack.conf)
#
# [*auto_install*]
#   This allows auto installation of new kernel. (see uptrack.conf)
#
# === Examples
#
#  class { ksplice:
#    access_key      => 'youraccesskeyhere',
#    uptrack_upgrade => true,
#    auto_install    => true,
#  }
#
# === Authors
#
# Elmer Rivera <elmer@vizcayano.com>
#
# === Copyright
#
# Copyright 2013 Elmer Rivera
#
class ksplice(
  $access_key = undef,
  $uptrack_upgrade = false,
  $auto_install = true,
) {

  if ! $access_key {
    fail('You must have an access key for ksplice to work!')
  }

  class { 'ksplice::repo':
    stage => setup,
  }

  class { 'ksplice::package':
    access_key => $access_key,
    stage      => main,
  }

  class { 'ksplice::config':
    access_key   => $access_key,
    auto_install => $auto_install,
    stage        => deploy_infra,
    require      => Class['ksplice::package'],
  }

  if $uptrack_upgrade {
    exec { 'uptrack_upgrade':
      command => '/usr/sbin/uptrack-upgrade',
      require => Class['ksplice::config'],
    }
  }

}
