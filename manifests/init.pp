# Module only for physical machines that sets up lm_sensors
class lm_sensors (
  Boolean $service_enable,
  Enum['present','absent'] $package_ensure,
  Enum['running','stopped'] $service_ensure,
  Stdlib::Absolutepath $config_file,
  Stdlib::Absolutepath $sensorsd_dir,
  String $exec_command,
  String $package,
){

  if $::virtual == 'physical' {
    contain lm_sensors::install
    contain lm_sensors::service

    Class['::lm_sensors::install']
    -> Class['::lm_sensors::service']
  }
}
