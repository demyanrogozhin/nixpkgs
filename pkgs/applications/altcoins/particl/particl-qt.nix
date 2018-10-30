{ stdenv
, particl-core
, autoreconfHook
, boost
, db48
, fetchurl
, libevent
, miniupnpc
, openssl
, pkgconfig
, zeromq
, zlib
, unixtools
, qtbase
, qttools
, qrencode
, protobuf
, hidapi
, python3
}:

particl-core.overrideAttrs (oldAttrs : rec {

  name = "particl-qt-${version}";
  inherit (oldAttrs) version src nativeBuildInputs doCheck;

  buildInputs = oldAttrs.buildInputs ++ [
    qtbase qttools qrencode protobuf hidapi
  ];

  configureFlags = oldAttrs.configureFlags ++ [
    "--with-gui=qt5"
    "--enable-usbdevice=yes"
    "--with-qt-bindir=${qtbase}/bin:${qttools}/bin:${qtbase.dev}/bin:${qttools.dev}/bin"
  ] ++ stdenv.lib.optionals (doCheck) [
    "--enable-gui-tests=yes"
  ];

  # QT_PLUGIN_PATH needs to be set when executing QT, which is needed when testing Bitcoin's GUI.
  # See also https://github.com/NixOS/nixpkgs/issues/24256
  checkFlags = [ "QT_PLUGIN_PATH=${qtbase}/lib/qt-5.${stdenv.lib.versions.minor qtbase.version}/plugins" ];

  meta = with stdenv.lib; {
    description = "Privacy-Focused Marketplace & Decentralized Application Platform";
    longDescription= ''
      An open source, decentralized privacy platform built for global person to person eCommerce.
      QT wallet and CLI daemon;
    '';
    homepage = https://particl.io/;
    maintainers = with maintainers; [ demyanrogozhin ];
    license = licenses.mit;
    platforms = platforms.linux;
  };
})
