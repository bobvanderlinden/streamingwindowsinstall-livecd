pkgs: with pkgs;

stdenv.mkDerivation rec {
  name = "wininstall-${version}";
  version = "1.9.1";

  builder = writeScript "builder.sh" ''
    source $stdenv/setup
    mkdir -p $out/bin
    install -m755 ${./wininstall} $out/bin/wininstall
    install -m755 ${./retrievewindowsisourl} $out/bin/retrievewindowsisourl
  '';

  buildInputs = [
    ntfs3g
    wimlib
    httpfs2
    phantomjs2
    ntfs3g
    ms-sys
    parted
  ];

  meta = {
    description = "A streaming Windows installer";
  };
}
