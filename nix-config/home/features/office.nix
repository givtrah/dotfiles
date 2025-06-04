{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [
#  libreoffice-fresh
  hunspell
  hunspellDicts.da_DK
  hunspellDicts.en_US


#  onlyoffice-bin_latest



  ]



  ++
   
    (if (pkgs.system == "aarch64-linux")
    then [ ] # libreoffice ] # libreoffice from flatpaks - due to compile error on 2025-02-18
  else
    (if (pkgs.system == "x86_64-linux")
      then [ libreoffice-fresh onlyoffice-bin_latest pdfsam-basic ]
      else []));


















}
