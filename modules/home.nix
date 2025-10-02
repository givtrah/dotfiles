{ pkgs, lib, options, ... }:

{


	fileSystems."/mnt/slow" = {
		device = "192.168.42.42:/slow";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
	};


	fileSystems."/mnt/fast" = {
		device = "192.168.42.42:/fast";
		fsType = "nfs";
		options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" ];
	};








}

