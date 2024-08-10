{ pkgs, config, lib, ... }:

{
  hardware.cpu.intel.updateMicrocode = true;

  powerManagement.enable = true;
  services.thermald.enable = true;

  # test auto-cpufreq
  services.tlp = {
    enable = false;
    settings = {
      DISK_DEVICES = "nvme0n1 nvme1n1";

      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "power";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_BOOST_ON_AC = 0;
      CPU_BOOST_ON_BAT = 0;

      CPU_HWP_DYN_BOOST_ON_AC = 0;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      WIFI_PWR_ON_AC = "on";
      WIFI_PWR_ON_BAT = "on";
      WOL_DISABLE = "Y";

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";

      MEM_SLEEP_ON_AC = "deep";
      MEM_SLEEP_ON_BAT = "deep";

      PLATFORM_PROFILE_ON_AC = "low-power";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      INTEL_GPU_MIN_FREQ_ON_AC = 0;
      INTEL_GPU_MIN_FREQ_ON_BAT = 0;
      INTEL_GPU_MAX_FREQ_ON_AC = 0;
      INTEL_GPU_MAX_FREQ_ON_BAT = 0;
      INTEL_GPU_BOOST_FREQ_ON_AC = 0;
      INTEL_GPU_BOOST_FREQ_ON_BAT = 0;

      SOUND_POWER_SAVE_ON_AC = 1;
      SOUND_POWER_SAVE_ON_BAT = 1;

      PCIE_ASPM_ON_AC = "powersupersave";
      PCIE_ASPM_ON_BAT = "powersupersave";

      RUNTIME_PM_DRIVER_DENYLIST = "mei_me";

      TLP_DEBUG = "arg bat disk lock nm path pm ps rf run sysfs udev usb";
    };
  };

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
        energy_performance_preference = "power";
      };
      charger = {
        governor = "powersave";
        turbo = "never";
        energy_performance_preference = "power";
        enable_thresholds = true;
        start_threshold = 40;
        stop_threshold = 80;
      };
    };
  };

  # environment = {
  #   systemPackages = [
  #     pkgs.powertop
  #   ];
  # };

}
