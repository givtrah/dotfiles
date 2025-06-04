{
  disko.devices = {
    disk.nvme = {
      type = "disk";
      device = "/dev/nvme0n1";
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
            size = "32G";
            content = {
              type = "swap";
              };
            };
          root = {
            size = "200G";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ]; # Override existing partition, probably means format it
              subvolumes = {
                "/rootfs" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=lzo" "noatime" ];
                  };
                "/nix" = {
                   mountpoint = "/nix";
                   mountOptions = [ "compress=lzo" "noatime" ];
                  };
                "/var/log" = {
                   mountpoint = "/var/log";
                   mountOptions = [ "compress=lzo" "noatime" ];
                  };
                };
              };
            };
           luks = {
             size = "100%";
             content = {
               type = "luks";
               name = "crypted";
               extraOpenArgs = [ "--allow-discards" ];
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
  }

