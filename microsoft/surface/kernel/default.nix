{ config, lib, pkgs, ... }:

{
  #boot.kernelPackages = pkgs.callPackage ./linux-5.14.15 { };
  boot.kernelPackages = pkgs.callPackage ./linux-surface { };
}
