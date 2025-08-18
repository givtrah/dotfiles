{ config, pkgs, ...}: {


  services.hyprpaper = {
    enable = true;
    settings = {
    	ipc = "on";
		};
  };

  home.packages = with pkgs; 

  [


  ];


}
