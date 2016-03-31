#{ stdenv, fetchurl, pkgconfig, openssl, fuse, libxml2, ntfs3g, attr }:
pkgs: with pkgs;

stdenv.mkDerivation rec {
  name = "wimlib-${version}";
  version = "1.9.1";

  src = fetchurl {
    url = "https://wimlib.net/downloads/wimlib-${version}.tar.gz";
    sha256 = "056h1jyycvd978fcwbwpfg4zywwb7idcyrvn6n8x068r4agj0rjl";
  };

  buildInputs = [ pkgconfig openssl fuse libxml2 ntfs3g attr ];

  meta = {
    description = "A library and program to extract, create, and modify WIM files";
    license = stdenv.lib.licenses.gpl3;
    homepage = http://wvware.sourceforge.net;
  };
}
