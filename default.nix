let
  pkgs = import ./pkgs.nix { };

in
rec {
  mypkgs = import ./pkgs.nix pkgs;
  vm = (import <nixpkgs/nixos/lib/eval-config.nix> {
    system = "x86_64-linux";
    modules = [
      <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
      
      { nixpkgs.config.allowUnfree = true; }

      { users.extraUsers.root.initialHashedPassword = "";
        services.mingetty.autologinUser = "root";
      }

      { virtualisation.graphics = false;
        virtualisation.qemu.networkingOptions = [
          "-netdev user,id=network0 -device e1000,netdev=network0"
        ];
        virtualisation.emptyDiskImages = [ 5000 ];
      }

      { environment.systemPackages = [
          mypkgs.kiwi
          mypkgs.wimlib
          pkgs.dialog
          pkgs.httpfs2
          pkgs.phantomjs2
          pkgs.ntfs3g
          pkgs.ms-sys
          pkgs.parted
        ];
        environment.etc."getdownloadurl.js" = {
          enable = true;
          source = ./getdownloadurl.js;
        };
        networking.networkmanager.enable = true;
      }
    ];
  }).config.system.build.vm;
}

