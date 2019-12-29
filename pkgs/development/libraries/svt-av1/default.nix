{ cmake
, nasm
, fetchFromGitHub
, stdenv
, ...
}:
stdenv.mkDerivation rec {
  name = "SVT-AV1";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "OpenVisualCloud";
    repo = "SVT-AV1";
    rev = "v${version}";
    hash = "sha256-yHRQEXnhTRpRqj5LYsXAzlx51OaiWDpS4rYSeWUM9w0=";
  };

  buildInputs = [ cmake nasm ];
}
