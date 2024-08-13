{ pkgs, lib, config, ... }:

{
  options = {
    nvidia.mode = lib.mkOption {
      type = lib.types.enum [ "disable" "offload" "sync" ];
      default = "offload";
    };
  };

  config =
    let
      common = {
        environment = {
          variables = {
            # Add all vulkan drivers except nouveau
            VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/dzn_icd.x86_64.json:/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json:/run/opengl-driver/share/vulkan/icd.d/virtio_icd.x86_64.json:/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver/share/vulkan/icd.d/lvp_icd.x86_64.json:/run/opengl-driver/share/vulkan/icd.d/intel_hasvk_icd.x86_64.json:/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json";
          };

          systemPackages = with pkgs; [
            glxinfo
            vulkan-tools
          ];
        };

        # Enable graphics driver in NixOS
        hardware = {
          opengl = {
            enable = true;
            driSupport = true;
          };

          nvidia = {
            prime = {
              intelBusId = "PCI:0:2:0";
              nvidiaBusId = "PCI:1:0:0";
            };

            # Modesetting is required.
            modesetting.enable = true;

            # Use the NVidia open source kernel module (not to be confused with the
            # independent third-party "nouveau" open source driver).
            # Support is limited to the Turing and later architectures. Full list of 
            # supported GPUs is at: 
            # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
            # Only available from driver 515.43.04+
            # Currently alpha-quality/buggy, so false is currently the recommended setting.
            open = true;

            # Enable the Nvidia settings menu,
            # accessible via `nvidia-settings`.
            nvidiaSettings = true;

            # Optionally, you may need to select the appropriate driver version for your specific GPU.
            package = config.boot.kernelPackages.nvidiaPackages.beta;
          };
        };

        # Load nvidia driver for Xorg and Wayland
        services.xserver.videoDrivers = [ "nvidia" ];
      };
    in
    lib.mkIf (config.nvidia.mode == "disable")
      {
        boot.extraModprobeConfig = ''
          blacklist nouveau
          options nouveau modeset=0
        '';

        services.udev.extraRules = ''
          # Remove NVIDIA USB xHCI Host Controller devices, if present
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
          # Remove NVIDIA USB Type-C UCSI devices, if present
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
          # Remove NVIDIA Audio devices, if present
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
          # Remove NVIDIA VGA/3D controller devices
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
        '';
        boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
      }
    // lib.mkIf (config.nvidia.mode == "offload")
      common // {
      hardware.nvidia = {
        prime = {
          sync.enable = false;
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
        # of just the bare essentials.
        powerManagement.enable = true;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = true;
      };
    }
    // lib.mkIf (config.nvidia.mode == "sync")
      common // {
      environment.variables = {
        WLR_RENDERER = "vulkan";
      };

      hardware.nvidia = {
        prime.sync.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
        # of just the bare essentials.
        powerManagement.enable = false;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;
      };
    }

  ;
}
