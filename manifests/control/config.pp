# == Class: contrail::control::config
#
# Configure the control service
#
# === Parameters:
#
# [*secret*]
#   RNDC secret
#
# [*forwarder*]
#   (optional) Default forward DNS server
#   Defaults '8.8.8.8'
#
# [*dns_config*]
#   (optional) Hash of parameters for /etc/contrail/dns/contrail-dns.conf
#
# [*manage_named_conf*]
#   (optional) Boolean to manage or not /etc/contrail/contrail-named.conf file
#
# [*control_config*]
#   (optional) Hash of parameters for /etc/contrail/contrail-control.conf
#
# [*control_nodemgr_config*]
#   (optional) Hash of parameters for /etc/contrail/contrail-control-nodemgr.conf
#
class contrail::control::config (
  $secret,
  $dns_config             = {},
  $control_config         = {},
  $contrail_version       = '',
  $control_nodemgr_config = {},
  $manage_named           = 'true',
  $forwarder              = '8.8.8.8',
) {

#  include ::contrail::vnc_api
#  include ::contrail::ctrl_details
#  include ::contrail::service_token
#  include ::contrail::keystone

  validate_hash($dns_config)
  validate_hash($control_config)
  validate_hash($control_nodemgr_config)

  $contrail_control_config         = { 'path' => '/etc/contrail/contrail-control.conf' }
  $contrail_control_nodemgr_config = { 'path' => '/etc/contrail/contrail-control-nodemgr.conf' }
  $contrail_dns_config             = { 'path' => '/etc/contrail/contrail-dns.conf' }

  create_ini_settings($control_config, $contrail_control_config)
  create_ini_settings($control_nodemgr_config, $contrail_control_nodemgr_config)
  create_ini_settings($dns_config, $contrail_dns_config)
  if $forwarder {
    if is_array($forwarder) {
      $forwarders_option = join([join($forwarder, ';'),';'], '')
    } else {
      $forwarders_option = "${forwarder};"
    }
  } else {
    $forwarders_option = ''
  }
  if $manage_named == 'true' {
    file { '/etc/contrail/dns/contrail-named.conf' :
      ensure  => file,
      content => template('contrail/contrail-named.conf.erb'),
    }
  }
}
