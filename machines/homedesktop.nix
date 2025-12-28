{ config, lib, pkgs, modulesPath, home-manager, ... }:

{
  # Modules

  imports =
    [
      ../modules/boilerplate.nix
      ../modules/home.nix
      ../modules/desktop-environment.nix
      ../modules/users.nix
      ../modules/packages.nix
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    # Module Overrides

    networking.hostName = "homedesktop";
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      open = false;
      powerManagement.enable = true;
      modesetting.enable = true;
    };
    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
    boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1" "pcie_aspm=off"];

    # Hardware Configuration

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/6b4756ca-dc0d-4e33-b0f4-1263ba8c8286";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/C883-4012";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
