nixpkgs:
let
    nixpkgs = import <nixpkgs> { };
    customPkgs = rec {
      pythondialog = (import ./pkgs/pythondialog pkgs);
      kiwi = (import ./pkgs/kiwi pkgs);
      wimlib = (import ./pkgs/wimlib pkgs);
      ntfs3g = (import ./pkgs/ntfs-3g pkgs);
      wininstall = (import ./pkgs/wininstall pkgs);
    };
    pkgs = nixpkgs // customPkgs;
in
    pkgs