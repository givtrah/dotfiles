{ config, pkgs, ...}: {


  services.hyprpaper = {
    enable = true;
    settings = {
    	ipc = "on";
			splash = "off";
		};
  };

  home.packages = with pkgs; 

  [


  ];


}
