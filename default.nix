{
  stdenvNoCC,
  redocly-cli,
}:
stdenvNoCC.mkDerivation {
  name = "sondehub-api";

  src = ./.;

  buildInputs = [redocly-cli];
  buildPhase = ''
    mkdir $out
    redocly-cli bundle \
      --output $out/openapi.yaml
    redocly-cli bundle \
      --output $out/openapi.json
  '';
}
