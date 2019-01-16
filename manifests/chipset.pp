# Type: lm_sensors::chipset
define lm_sensors::chipset (
  Array $chip_configs,
  Enum['present', 'absent'] $ensure,
  String $chip     = $title,
  String $filename = '',
) {

  if $::virtual == 'physical' {

    if $ensure == 'present' {
      $real_ensure = 'file'
    }
    else {
      $real_ensure = 'absent'
    }

    if $filename == '' {
      $_filename = "chip_${chip}"
    } else {
      $_filename = $filename
    }

    # create sensors.d dir & chipset file
    file {
      $::lm_sensors::sensorsd_dir:
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        require => Package[$::lm_sensors::package];
      "${::lm_sensors::sensorsd_dir}/${_filename}.conf":
        ensure  => $real_ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => File[$::lm_sensors::sensorsd_dir],
        notify  => Service[$::lm_sensors::service_name],
        content => template('lm_sensors/chipset.conf');
    }
  }
}
