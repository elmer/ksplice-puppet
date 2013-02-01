# ksplice::config
class ksplice::config(
  $access_key = undef,
  $auto_install = true
) {

  $auto_install_value = $auto_install ? {
    true    => 'yes',
    false   => 'no',
    default => '',
  }

  file { '/etc/uptrack/uptrack.conf':
    ensure  => present,
    content => template('ksplice/uptrack.conf.erb'),
  }

}
