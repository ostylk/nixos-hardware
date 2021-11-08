{ config, lib, pkgs, ... }:
let
  repos = (pkgs.callPackage ../../repos.nix { });
  patches = repos.linux-surface + "/patches";
  surface_kernelPatches = [
    {
      name = "microsoft-surface-patches-linux-5.14.16";
      patch = null;
      extraConfig = ''
        #
        # Surface Aggregator Module
        #
        CONFIG_SURFACE_AGGREGATOR m
        CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION n
        CONFIG_SURFACE_AGGREGATOR_BUS y
        CONFIG_SURFACE_AGGREGATOR_CDEV m
        CONFIG_SURFACE_AGGREGATOR_REGISTRY m

        CONFIG_SURFACE_ACPI_NOTIFY m
        CONFIG_SURFACE_DTX m
        CONFIG_SURFACE_KIP_TABLET_SWITCH m
        CONFIG_SURFACE_PLATFORM_PROFILE m

        CONFIG_SURFACE_HID m
        CONFIG_SURFACE_KBD m

        CONFIG_BATTERY_SURFACE m
        CONFIG_CHARGER_SURFACE m

        #
        # Surface Hotplug
        #
        CONFIG_SURFACE_HOTPLUG m

        #
        # IPTS touchscreen
        #
        # This only enables the user interface for IPTS data.
        # For the touchscreen to work, you need to install iptsd.
        #
        CONFIG_MISC_IPTS m

        #
        # Cameras: IPU3
        #
        CONFIG_VIDEO_IPU3_IMGU m
        CONFIG_VIDEO_IPU3_CIO2 m
        CONFIG_CIO2_BRIDGE y
        CONFIG_INTEL_SKL_INT3472 m
        CONFIG_REGULATOR_TPS68470 m
        CONFIG_COMMON_CLK_TPS68470 m

        #
        # Cameras: Sensor drivers
        #
        CONFIG_VIDEO_OV5693 m
        CONFIG_VIDEO_OV8865 m

        #
        # ALS Sensor for Surface Book 3, Surface Laptop 3, Surface Pro 7
        #
        CONFIG_APDS9960 m

        #
        # Other Drivers
        #
        CONFIG_INPUT_SOC_BUTTON_ARRAY m
        CONFIG_SURFACE_3_BUTTON m
        CONFIG_SURFACE_3_POWER_OPREGION m
        CONFIG_SURFACE_PRO3_BUTTON m
        CONFIG_SURFACE_GPE m
        CONFIG_SURFACE_BOOK1_DGPU_SWITCH m
      '';
    }
    {
      name = "ms-surface/0001-surface3-oemb";
      patch = patches + "/5.14/0001-surface3-oemb.patch";
    }
    {
      name = "ms-surface/0002-mwifiex";
      patch = patches + "/5.14/0002-mwifiex.patch";
    }
    {
      name = "ms-surface/0003-ath10k";
      patch = patches + "/5.14/0003-ath10k.patch";
    }
    {
      name = "ms-surface/0004-ipts";
      patch = patches + "/5.14/0004-ipts.patch";
    }
    {
      name = "ms-surface/0005-surface-sam";
      patch = patches + "/5.14/0005-surface-sam.patch";
    }
    {
      name = "ms-surface/0006-surface-sam-over-hid";
      patch = patches + "/5.14/0006-surface-sam-over-hid.patch";
    }
    {
      name = "ms-surface/0007-surface-gpe";
      patch = patches + "/5.14/0007-surface-gpe.patch";
    }
    {
      name = "ms-surface/0008-surface-button";
      patch = patches + "/5.14/0008-surface-button.patch";
    }
    {
      name = "ms-surface/0009-surface-typecover";
      patch = patches + "/5.14/0009-surface-typecover.patch";
    }
    {
      name = "ms-surface/0010-cameras";
      patch = patches + "/5.14/0010-cameras.patch";
    }
    {
      name = "ms-surface/0011-amd-gpio";
      patch = patches + "/5.14/0011-amd-gpio.patch";
    }
  ];
in (with pkgs;
  recurseIntoAttrs (linuxPackagesFor (callPackage ./linux-5.14.16.nix {
    kernelPatches = surface_kernelPatches;
  })))
