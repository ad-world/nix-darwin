{ pkgs, lib, python3Packages }:

python3Packages.buildPythonApplication rec {
  pname = "yfin-cli";
  version = "0.2.0";
  pyproject = true;

  src = pkgs.fetchPypi {
    pname = "yfin_cli";
    inherit version;
    hash = "sha256-hzDUOkRDtbRhm+qryF0voqtEBkhXzt49NVDDptDNeQc=";
  };

  build-system = with python3Packages; [
    hatchling
  ];

  dependencies = with python3Packages; [
    lxml
    rich
    typer
    yfinance
  ];

  pythonImportsCheck = [ "src.cli" ];

  # Upstream tests exercise live Yahoo Finance calls; don't run them in a Nix build.
  doCheck = false;

  meta = {
    description = "Command-line interface for Yahoo Finance data";
    homepage = "https://pypi.org/project/yfin-cli/";
    license = lib.licenses.mit;
    mainProgram = "yfin";
  };
}
