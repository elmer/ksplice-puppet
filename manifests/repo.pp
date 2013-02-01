# ksplice::repo
class ksplice::repo {

  apt::source { 'ksplice':
    ensure            => present,
    location          => 'http://www.ksplice.com/apt',
    release           => $::lsbdistcodename,
    repos             => 'ksplice',
    include_src       => true,
    required_packages => ['ca-certificates'],
    key               => 'B6D4038E',
    key_source        => 'http://www.ksplice.com/apt/ksplice-archive.asc',
  }

}
