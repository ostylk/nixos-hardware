{ lib, stdenv, buildPackages, fetchurl, perl, buildLinux
, modDirVersionArg ? null, ... }@args:

with lib;

buildLinux (args // rec {
  version = "5.15.5";

  # modDirVersion needs to be x.y.z, will automatically add .0 if needed
  modDirVersion = if (modDirVersionArg == null) then
    concatStringsSep "." (take 3 (splitVersion "${version}.0"))
  else
    modDirVersionArg;

  # branchVersion needs to be x.y
  extraMeta.branch = versions.majorMinor version;

  src = fetchurl {
    url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
    sha256 = "07w5k2y5hk6ys19zgg3x21g6im9x0pwk5f6f8b0q3b152lq5lmp9";
  };
} // (args.argsOverride or { }))
