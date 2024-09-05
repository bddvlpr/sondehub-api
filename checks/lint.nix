{
  stdenvNoCC,
  redocly-cli,
}:
stdenvNoCC.mkDerivation {
  name = "redocly-lint";

  src = ./..;

  buildInputs = [redocly-cli];
  buildPhase = ''
    mkdir $out
    redocly-cli lint
  '';
}
