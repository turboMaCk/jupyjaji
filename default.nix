let
  config = {
    packageOverrides = pkgs: with pkgs; {
      jupyjaji = python37.withPackages (ps: with ps; [
           ipykernel
           jupyter
           notebook
           numpy
           pydotplus
           matplotlib
           pandas
           sklearn-deap
           statsmodels
      ]);
    };
  };

  pkgs = import <nixpkgs> { inherit config; };
in with pkgs.stdenv;
mkDerivation rec {
  name = "jupyjaji-${version}";
  version = "0.1.0";
  src = ./.;
  propagatedBuildInputs = [ pkgs.jupyjaji ];
  installPhase = let
    script = pkgs.writeScriptBin "jupyjaji" ''
      #! /${pkgs.stdenv.shell}
      ${pkgs.jupyjaji}/bin/jupyter-notebook --notebook-dir=$(pwd) "$@"
    '';
  in ''
    mkdir -p $out/bin
    ln -s ${script}/bin/jupyjaji $out/bin/jupyjaji
  '';
}
