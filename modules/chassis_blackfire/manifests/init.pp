class chassis_blackfire (
  $config,
  $php_version  = $config[php],
  $server_id    = $config[blackfire][server_id],
  $server_token = $config[blackfire][server_token],
  $socket       = 'unix:///var/run/blackfire/agent.sock',
  $log_level    = 1
) {
  if empty($server_id) or empty($server_token) {
    warning
    'blackfire server_id and server_token are required for blackfire to work. Get them at https://blackfire.io/account/agents'
  }

  # Repo
  apt::source { 'blackfire':
    location => 'http://packages.blackfire.io/debian',
    release  => 'any',
    repos    => 'main',
    key      => {
      source => 'https://packages.blackfire.io/gpg.key',
      id     => '9B64BFB189197267DD269B29DFD7480747312329',
    },
    notify   => Exec['apt_update']
  }

  # Agent
  if ( !empty($config[disabled_extensions]) and 'chassis/blackfire' in $config[disabled_extensions] ) {
    $package = absent
    $file = absent
    $service = stopped
  } else {
    $package = latest
    $file = 'present'
    $service = running
  }

  if !defined(Package['blackfire-agent']) {
    package { 'blackfire-agent':
      ensure  => latest,
      require => Apt::Source['blackfire']
    }
  }

  file { "/etc/blackfire/agent":
    ensure  => $file,
    content => template('chassis_blackfire/agent.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service["php${php_version}-fpm"],
    require => Package['blackfire-agent']
  }

  service { 'blackfire-agent':
    ensure  => $service,
    require => Apt::Source['blackfire']
  }

  # PHP
  package { 'blackfire-php':
    ensure => latest,
  }

  file { "/etc/php/${php_version}/fpm/conf.d/blackfire.ini":
    ensure  => $file,
    content => template('chassis_blackfire/blackfire.ini.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service["php${php_version}-fpm"],
    require => Package['blackfire-php']
  }

  file { "/etc/php/${php_version}/cli/conf.d/blackfire.ini":
    ensure  => $file,
    content => template('chassis_blackfire/blackfire.ini.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['blackfire-php']
  }
}
