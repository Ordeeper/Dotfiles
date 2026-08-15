{ lib, appimageTools, fetchurl }:

let
  pname = "openscreen";
  version = "1.9.5";

  src = fetchurl {
    url = "https://github.com/getopenscreen/openscreen/releases/download/v${version}/Openscreen-Linux-${version}.AppImage";
    hash = "sha256-Oq2tjg0iWt421ltGWObfQ/r3Va6hehBtyre5z8mzof8=";
  };

  contents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm444 ${contents}/${pname}.desktop -t $out/share/applications
    cp -r ${contents}/usr/share/icons $out/share

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
  '';

  meta = {
    description = "Screen recorder with click-triggered auto-zoom and annotations";
    homepage = "https://github.com/getopenscreen/openscreen";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
