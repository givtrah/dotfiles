{ pkgs, lib, options, ... }:

{


  networking.timeServers = [ "ntp.ku.dk" ]; 

	fileSystems."/mnt/slow/media" = {
		device = "100.86.219.83:/slow/media";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
	};


	fileSystems."/mnt/slow/backedup" = {
		device = "100.86.219.83:/slow/backedup";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
	};


	fileSystems."/mnt/fast" = {
		device = "100.86.219.83:/fast";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
	};








}

