class nginx {
  $package = 'nginx'
  $docroot = '/var/www'
  $nginx_conf = 'nginx.conf'
  $default_conf = 'default.conf'

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  package { $package :
    ensure => present,
  }

  file { $docroot :
    ensure  => directory,
    require => Package[$package],
  }

  file { "${docroot}/index.html":
    ensure => file,
    source => "puppet:///modules/${package}/index.html",
  }

  file { $nginx_conf :
    ensure => file,
    path   => "/etc/nginx/${nginx_conf}",
    source => "puppet:///modules/${package}/${nginx_conf}",
  }

  file { $default_conf :
    ensure => file,
    path   => "/etc/nginx/conf.d/${default_conf}",
    source => "puppet:///modules/${package}/${default_conf}",
  }

  service { $package :
    ensure    => running,
    enable    => true,
    subscribe => [ File[$nginx_conf], File[$default_conf] ],
  }
}
