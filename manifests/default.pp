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

postgresql::server::role { 'vagrant':
  password_hash => postgresql_password('vagrant', 'vagrant'),
  createdb => true,
  login => true,
  replication => true,
}