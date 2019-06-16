{ nixpkgs ? import <nixpkgs>
, python ? "python37"
, packages ? [
  "numpy"
  "pydotplus"
  "matplotlib"
  "pandas"
  "sklearn-deap"
  "statsmodels"
]
}:
let
  config = {
    packageOverrides = pkgs: with pkgs; {
      jupyjajiEnv = pkgs.${python}.withPackages (ps: with ps;
        [ ipykernel
          jupyter
          notebook
        ] ++ map (pkgName: ps.${pkgName}) packages);
    };
  };

  pkgs = nixpkgs { inherit config; };
in with pkgs.stdenv;
mkDerivation rec {
  name = "jupyjaji-${version}";
  version = "0.1.0";
  src = ./.;
  propagatedBuildInputs = [ pkgs.jupyjajiEnv ];
  installPhase = let
    script = pkgs.writeScriptBin "jupyjaji" ''
      #! /${pkgs.stdenv.shell}
      ${pkgs.jupyjajiEnv}/bin/jupyter-notebook --notebook-dir=$(pwd) "$@"
    '';
  in ''
    mkdir -p $out/bin
    ln -s ${script}/bin/jupyjaji $out/bin/jupyjaji
  '';
}
