#{ stdenv, fetchFromGitHub, python3Packages, wimlib, dialog }:
pkgs:
with pkgs;
with pkgs.python3Packages;

buildPythonApplication rec {
  name = "kiwi-${version}";
  version = "1";

  src = fetchFromGitHub {
    owner = "bobvanderlinden";
    repo = "KiWi";
    rev = "f0ce0e6";
    sha256 = "09vv7jm3kw711db0pq2hg56xcnn0w1nm0fs36rdygjy123ryj9rr";
  };

  pythonPath = [
    pythondialog
  ];

  propagatedBuildInputs = [
    pythondialog
    dialog
    wimlib
  ];

  meta = with stdenv.lib; {
    homepage = https://github.com/jakogut/KiWI;
    description = "Killer Windows Installer - An alternative to WDS";
    maintainers = [ maintainers.bobvanderlinden ];
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
