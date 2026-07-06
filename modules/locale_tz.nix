{ pkgs, ... }:
{
  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

   # Default internationalisation properties
  i18n.defaultLocale = "en_DK.UTF-8";

 # Supported internationalisation properties.
   i18n.extraLocales = [ 
    "en_US.UTF-8/UTF-8"
    "da_DK.UTF-8/UTF-8"
    "en_DK.UTF-8/UTF-8" 
  ];

  i18n.extraLocaleSettings = {                                                                                                
  LC_ADDRESS = "en_DK.UTF-8";                                                                     
  LC_IDENTIFICATION = "en_DK.UTF-8";                                                              
  LC_MEASUREMENT = "en_DK.UTF-8";                                                                 
  LC_MONETARY = "en_DK.UTF-8";                                                                    
  LC_NAME = "en_DK.UTF-8";                                                                        
  LC_NUMERIC = "en_DK.UTF-8";                                                                     
  LC_PAPER = "en_DK.UTF-8";                                                                       
  LC_TELEPHONE = "en_DK.UTF-8";                                                                   
  LC_TIME = "en_DK.UTF-8";                                                                        
  };     

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Configure keymap in X11 
  services.xserver.xkb = {
    layout = "dk";
    variant = "";
  };


}


#      "OLD" locale settings
#  i18n.extraLocaleSettings = {
#    LC_ADDRESS = "da_DK.UTF-8";
#    LC_IDENTIFICATION = "da_DK.UTF-8";
#    LC_MEASUREMENT = "da_DK.UTF-8";
#    LC_MONETARY = "da_DK.UTF-8";
#    LC_NAME = "da_DK.UTF-8";
#    LC_NUMERIC = "en_US.UTF-8";
#    LC_PAPER = "da_DK.UTF-8";
#    LC_TELEPHONE = "da_DK.UTF-8";
#    LC_TIME = "en_US.UTF-8";
#  };


