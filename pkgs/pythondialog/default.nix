#{ stdenv, fetchFromGitHub, python3Packages, wimlib, dialog }:
pkgs:
with pkgs;
with pkgs.python3Packages;

buildPythonPackage rec {
  name = "pythondialog-${version}";
  version = "3.3.0";

  src = pkgs.fetchurl {
    url = "https://pypi.python.org/packages/source/p/pythondialog/pythondialog-${version}.tar.gz";
    sha256 = "0q90cw8qcryiw5fjzkl8z5m0q2sm6q7vc48ss3qpr5qgmjrp7yq8";
  };

  patchPhase = ''
    substituteInPlace dialog.py ":/bin:/usr/bin" ":$out/bin"
  '';

  meta = with stdenv.lib; {
    homepage = "http://pythondialog.sourceforge.net/";
  };
}
