{ pkgs, lib, options, ... }:

{


  networking.timeServers = [ "ntp.ku.dk" ]; 

	fileSystems."/mnt/slow" = {
		device = "100.86.219.83:/slow";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
	};


	fileSystems."/mnt/fast" = {
		device = "100.86.219.83:/fast";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
	};




}




