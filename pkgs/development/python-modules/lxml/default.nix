{ stdenv, lib, buildPythonPackage, fetchFromGitHub
, cython
, libxml2
, libxslt
, zlib
, xcodebuild
}:

buildPythonPackage rec {
  pname = "lxml";
  version = "4.6.4-5";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "lxml-${version}";
    sha256 = "159cc48nl40qsx8pc8sasgny5xc0s3y0xrq3w3aw53s3ijncsgfl";
  };

  # setuptoolsBuildPhase needs dependencies to be passed through nativeBuildInputs
  nativeBuildInputs = [ libxml2.dev libxslt.dev cython ] ++ lib.optionals stdenv.isDarwin [ xcodebuild ];
  buildInputs = [ libxml2 libxslt zlib ];

  # tests are meant to be ran "in-place" in the same directory as src
  doCheck = false;

  pythonImportsCheck = [ "lxml" "lxml.etree" ];

  meta = with lib; {
    description = "Pythonic binding for the libxml2 and libxslt libraries";
    homepage = "https://lxml.de";
    license = licenses.bsd3;
    maintainers = with maintainers; [ jonringer sjourdois ];
  };
}
