# ksplice package
class ksplice::package(
  $access_key = '',
) {

  exec {'debconf-set-selections':
    command => "/bin/echo 'uptrack uptrack/accesskey string ${access_key}' \
      |/usr/bin/debconf-set-selections",
  }

  package { 'uptrack':
    ensure  => installed,
    require => Exec['debconf-set-selections'],
  }

}
