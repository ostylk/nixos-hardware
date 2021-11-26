{ config, lib, pkgs, ... }:
let
  repos = (pkgs.callPackage ../../repos.nix { });
  patches = repos.linux-surface + "/patches";
  surface_kernelPatches = [
    {
      name = "microsoft-surface-patches-linux-5.15.5";
      patch = null;
      extraConfig = ''
        #
        # Surface Aggregator Module
        #
        SURFACE_AGGREGATOR m
        SURFACE_AGGREGATOR_ERROR_INJECTION n
        SURFACE_AGGREGATOR_BUS y
        SURFACE_AGGREGATOR_CDEV m
        SURFACE_AGGREGATOR_REGISTRY m

        SURFACE_ACPI_NOTIFY m
        SURFACE_DTX m
        SURFACE_KIP_TABLET_SWITCH m
        SURFACE_PLATFORM_PROFILE m

        SURFACE_HID m
        SURFACE_KBD m

        BATTERY_SURFACE m
        CHARGER_SURFACE m

        #
        # Surface Hotplug
        #
        SURFACE_HOTPLUG m

        #
        # IPTS touchscreen
        #
        # This only enables the user interface for IPTS data.
        # For the touchscreen to work, you need to install iptsd.
        #
        MISC_IPTS m

        #
        # Cameras: IPU3
        #
        CIO2_BRIDGE y
        INTEL_SKL_INT3472 m
        REGULATOR_TPS68470 m
        COMMON_CLK_TPS68470 m

        #
        # Cameras: Sensor drivers
        #
        VIDEO_OV5693 m
        VIDEO_OV8865 m

        #
        # ALS Sensor for Surface Book 3, Surface Laptop 3, Surface Pro 7
        #
        APDS9960 m

        #
        # Other Drivers
        #
        INPUT_SOC_BUTTON_ARRAY m
        SURFACE_3_BUTTON m
        SURFACE_3_POWER_OPREGION m
        SURFACE_PRO3_BUTTON m
        SURFACE_GPE m
        SURFACE_BOOK1_DGPU_SWITCH m

        #
        # Needed for reading battery data
        #
        SERIAL_DEV_BUS y
        SERIAL_DEV_CTRL_TTYPORT y
        MFD_INTEL_LPSS_PCI y
        INTEL_IDMA64 y
      '';
    }
    {
      name = "ms-surface/0001-surface3-oemb";
      patch = patches + "/5.15/0001-surface3-oemb.patch";
    }
    {
      name = "ms-surface/0002-mwifiex";
      patch = patches + "/5.15/0002-mwifiex.patch";
    }
    {
      name = "ms-surface/0003-ath10k";
      patch = patches + "/5.15/0003-ath10k.patch";
    }
    {
      name = "ms-surface/0004-ipts";
      patch = patches + "/5.15/0004-ipts.patch";
    }
    {
      name = "ms-surface/0005-surface-sam";
      patch = patches + "/5.15/0005-surface-sam.patch";
    }
    {
      name = "ms-surface/0006-surface-sam-over-hid";
      patch = patches + "/5.15/0006-surface-sam-over-hid.patch";
    }
    {
      name = "ms-surface/0007-surface-gpe";
      patch = patches + "/5.15/0007-surface-gpe.patch";
    }
    {
      name = "ms-surface/0008-surface-button";
      patch = patches + "/5.15/0008-surface-button.patch";
    }
    {
      name = "ms-surface/0009-surface-typecover";
      patch = patches + "/5.15/0009-surface-typecover.patch";
    }
    {
      name = "ms-surface/0010-cameras";
      #patch = patches + "/5.15/0010-cameras.patch";
      patch = ./cameras.patch;
    }
    {
      name = "ms-surface/0011-amd-gpio";
      patch = patches + "/5.15/0011-amd-gpio.patch";
    }
    {
      name = "ms-surface/0012-misc-fixes";
      patch = patches + "/5.15/0012-misc-fixes.patch";
    }
  ];
in (with pkgs;
  recurseIntoAttrs (linuxPackagesFor (callPackage ./linux-5.15.5.nix {
    kernelPatches = surface_kernelPatches;
  })))
