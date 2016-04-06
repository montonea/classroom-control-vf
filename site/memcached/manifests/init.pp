class memcached {
  package { 'memcached' :
    ensure => present,
  }

  file {'memcached_config' :
    ensure  => file,
    path    => '/etc/sysconfig/memcached',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/memcached/memcached_config',
    require => Package['memcached'],
  }

  service { 'memcached' :
    ensure    => running,
    enable    => true,
    subscribe => File['memcached_config'],
  }
}

