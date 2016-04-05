let
  pkgs = import ./pkgs.nix { };

in
rec {
  mypkgs = import ./pkgs.nix pkgs;

  baseModules = [
    { nixpkgs.config.allowUnfree = true; }

    { users.extraUsers.root.initialHashedPassword = "";
      services.mingetty.autologinUser = "root";
    }

    { environment.systemPackages = [
        mypkgs.kiwi
        mypkgs.wimlib
        mypkgs.wininstall
        pkgs.dialog
        pkgs.httpfs2
        pkgs.phantomjs2
        mypkgs.ntfs3g
        pkgs.ms-sys
        pkgs.parted
      ];
      networking.networkmanager.enable = true;
    }
  ];

  vm = (import <nixpkgs/nixos/lib/eval-config.nix> {
    system = "x86_64-linux";
    modules = [
      <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>

      { virtualisation.graphics = false;
        virtualisation.qemu.networkingOptions = [
          "-netdev user,id=network0 -device e1000,netdev=network0"
        ];
        virtualisation.emptyDiskImages = [ 10000 ];
      }
    ] ++ baseModules;
  }).config.system.build.vm;

  iso = (import <nixpkgs/nixos/lib/eval-config.nix> {
    modules = [
      { imports =
        [ <nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>
          <nixpkgs/nixos/modules/profiles/all-hardware.nix>
          <nixpkgs/nixos/modules/profiles/base.nix>
        ];

        # ISO naming.
        isoImage.isoName = "wininstall.iso";

        isoImage.volumeID = pkgs.lib.substring 0 11 "WININSTALL";

        # EFI booting
        isoImage.makeEfiBootable = true;

        # USB booting
        isoImage.makeUsbBootable = true;
      }
    ] ++ baseModules;
  }).config.system.build.isoImage;
}

