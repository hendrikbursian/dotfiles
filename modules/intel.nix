{ pkgs, ... }:
{
  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs;[
        onevpl-intel-gpu
        libvdpau-va-gl
        # intel-vaapi-driver
        intel-media-driver
      ];
    };
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  boot.kernelParams = [
    "i915.force_probe=28e1"
    "enable_guc=3"
  ];
}
