nixpkgs:
let
    nixpkgs = import <nixpkgs> { };
    customPkgs = rec {
      pythondialog = (import ./pkgs/pythondialog pkgs);
      kiwi = (import ./pkgs/kiwi pkgs);
      wimlib = (import ./pkgs/wimlib pkgs);
    };
    pkgs = nixpkgs // customPkgs;
in
    pkgs