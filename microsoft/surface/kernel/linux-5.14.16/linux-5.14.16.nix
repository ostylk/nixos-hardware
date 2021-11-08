{ lib, stdenv, buildPackages, fetchurl, perl, buildLinux
, modDirVersionArg ? null, ... }@args:

with lib;

buildLinux (args // rec {
  version = "5.14.16";

  # modDirVersion needs to be x.y.z, will automatically add .0 if needed
  modDirVersion = if (modDirVersionArg == null) then
    concatStringsSep "." (take 3 (splitVersion "${version}.0"))
  else
    modDirVersionArg;

  # branchVersion needs to be x.y
  extraMeta.branch = versions.majorMinor version;

  src = fetchurl {
    url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
    sha256 = "sha256-dPOaDGnp18lNKQUVZFOWcl4842Z7hbr0s8P28wPHpAY=";
  };
} // (args.argsOverride or { }))
