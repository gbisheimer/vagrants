# odoo base system required packages
package { "build-essential": ensure => present }
package { "postgresql": ensure => present }
package { "wget": ensure => present }
package { "git": ensure => present }
package { "mc": ensure => present }
package { "openssl": ensure => present }
package { "shellinabox": ensure => present }

# Installs PostgreSQL 9.3 server from PGDG repository
class {'postgresql::globals':
  version => '9.3',
  manage_package_repo => true,
  encoding => 'UTF8',
  locale  => 'it_IT.utf8',
}->
class { 'postgresql::server':
  ensure => 'present',
  ip_mask_deny_postgres_user => '0.0.0.0/32', # Allows posgres user connection from any host
  ip_mask_allow_all_users    => '0.0.0.0/0',
  listen_addresses => '*',
  postgres_password => 'postgres',            # Sets default postgres user password
}

# Installs contrib modules
class { 'postgresql::server::contrib':
  package_ensure => 'present',
}

# Creates vagrant user for postgresql login
postgresql::server::role { 'vagrant':
  password_hash => postgresql_password('vagrant', 'vagrant'),
  createdb => true,
  login => true,
  replication => true,
}

# Creates PLCLogger user for postgresql login
postgresql::server::role { 'PLCLogger':
  password_hash => postgresql_password('plclogger', 'plclogger'),
  createdb => true,
  login => true,
  replication => true,
}

# Adds odoo user to pg_hba.conf rules
postgresql::server::pg_hba_rule { 'vagrant':
  description => "Allows md5 authentication to user vagrant",
  type => 'host',
  address => '0.0.0.0/0',
  database => 'all',
  user => 'vagrant',
  auth_method => 'md5',
}

# Adds odoo user to pg_hba.conf rules
postgresql::server::pg_hba_rule { 'PLCLogger':
  description => "Allows md5 authentication to user vagrant",
  type => 'host',
  address => '0.0.0.0/0',
  database => 'all',
  user => 'PLCLogger',
  auth_method => 'md5',
}