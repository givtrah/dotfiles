{
  disko.devices = {
    disk = {
      disk1 = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-WDS100T1X0E-00AFY0_21413J448305";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1024M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
	      mountpoint = "/boot";
              mountOptions = [ "defaults" ];
            };
          };
          swap = {
            size = "64G";
            content = {
              type = "swap";
              };
            };
          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ]; # Override existing partition, probably means format it
              subvolumes = {
                "rootfs" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=lzo" "noatime" ];
                  };
                "nix" = {
                   mountpoint = "/nix";
                   mountOptions = [ "compress=lzo" "noatime" ];
                  };
                "log" = {
                   mountpoint = "/var/log";
                   mountOptions = [ "compress=lzo" "noatime" ];
                  };
                };
              };
            };
           };
         };
       };
    disk2 = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-Samsung_SSD_990_PRO_4TB_S7DPNF0Y104536N";
      content = {
        type = "gpt";
        partitions = {
          luks = {
            size = "100%";
              content = {
                type = "luks";
                name = "crypted";
		settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];

                  subvolumes = {
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=lzo" "noatime" ];
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  }

