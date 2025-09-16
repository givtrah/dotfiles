{ config, pkgs, ...}: {


  home.packages = with pkgs; 

  [
#  libreoffice-fresh
  hunspell
  hunspellDicts.da_DK
  hunspellDicts.en_US
  jdk # - wrong one
#	temurin-jre-bin-17 # should be the correct one for libreoffice according to wiki.nixos.org 2025-09-15

#  onlyoffice-bin_latest



  ]



  ++
   
    (if (pkgs.system == "aarch64-linux")
    then [ ] # libreoffice ] # libreoffice from flatpaks - due to compile error on 2025-02-18
  else
    (if (pkgs.system == "x86_64-linux")
      then [ 
#  Wrap libreoffice-fresh to use the Adwaita theme
				(pkgs.writeShellScriptBin "libreoffice-adwaita" ''
        export GTK_THEME="Adwaita"
        exec ${pkgs.libreoffice-fresh}/bin/libreoffice "$@"
      '')

#			libreoffice-fresh 

			onlyoffice-bin_latest
			pdfsam-basic 
			]
      else []));



xdg.desktopEntries.libreoffice-adwaita = {
    name = "LibreOffice (Adwaita)";
    exec = "libreoffice-adwaita %U";
    
    # Use the generic LibreOffice icon.
    # The exact path may vary slightly, but this is a common one.
    icon = "${pkgs.libreoffice-fresh}/share/icons/hicolor/scalable/apps/libreoffice-main.svg";
    
    categories = [ "Office" "WordProcessor" "Spreadsheet" "Presentation" "Graphics" ];
    comment = "Office Suite with Adwaita Theme";
    genericName = "Office Suite";
  };











}
