{ lib, pkgs, fetchFromGitHub, fetchurl }: {
  linux-surface = fetchFromGitHub {
    owner = "linux-surface";
    repo = "linux-surface";
    rev = "d6a55947a75ae6387dc67da561f1e1f6534a88ae";
    sha256 = "j+IGxnWESuwS6v7R8vug4nf/GxfTTqIL88OrnoCbeQo=";
  };

  ath10k-firmware = fetchFromGitHub {
    owner = "kvalo";
    repo = "ath10k-firmware";
    rev = "c987e38cbdb90dcb4e477d5dd21de66c77996435";
    sha256 = "16a67baxlga8vb43zbby2s7kpp4488vczg3manmr9g3wxnhhb9n3";
  };

  surface-go-ath10k-firmware_upstream = fetchurl {
    url = "https://support.killernetworking.com/K1535_Debian/board.bin";
    # url="https://www.killernetworking.com/support/K1535_Debian/board.bin";
    sha256 = "0l8wfj8z4jbb31nzqkaxisby0n6061ix01c5di9bq66iby59j8py";
  };

  surface-go-ath10k-firmware_backup = fetchFromGitHub {
    owner = "mexisme";
    repo = "linux-surface_ath10k-firmware";
    rev = "74e5409e699383d6ca2bc4da4a8433d16f3850b1";
    sha256 = "169vgvxpgad9anmchs22fj5qm6ahzjfdnwhd8pc280q705vx6pjk";
  };
}
