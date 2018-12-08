# Start the lm_sensors service
class lm_sensors::service {
  # Start lm_sensors service
  service { $lm_sensors::service_name:
    ensure  => $lm_sensors::service_ensure,
    name    => $lm_sensors::service_name,
    enable  => $lm_sensors::service_enable,
    require => Exec['sensors-detect'],
  }
}
