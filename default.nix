{ pkgs ? import <nixpkgs> {} }:
with pkgs.python37Packages;
pkgs.stdenv.mkDerivation rec {
  name = "jupyjaji-${version}";
  version = "0.1.0";
  src = ./.;
  propagatedBuildInputs = [
    ipykernel
    jupyter
    notebook
    numpy
    pydotplus
    matplotlib
    pandas
    sklearn-deap
    statsmodels
  ];
  installPhase = let
    script = pkgs.writeScriptBin "jupyjaji" ''
      #! /${pkgs.stdenv.shell}
      ${notebook}/bin/jupyter-notebook --notebook-dir=$(pwd) "$@"
    '';
  in ''
    mkdir -p $out/bin
    ln -s ${script}/bin/jupyjaji $out/bin/jupyjaji
  '';
}
