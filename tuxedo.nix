{ pkgs, config, ... }:

{
  boot.extraModulePackages = with config.boot.kernelPackages; [
    tuxedo-keyboard
  ];

  # Keyboard backlight
  boot.kernelParams = [
    "tuxedo_keyboard.mode=0"
    "tuxedo_keyboard.brightness=0"
    "tuxedo_keyboard.color_left=0xffffff"
  ];

  hardware.tuxedo-keyboard.enable = true;
  hardware.tuxedo-rs = {
    enable = true;
    tailor-gui.enable = true;
  };
}
