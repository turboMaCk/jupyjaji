# Reproducible Jupyter Environment

My own jupyter distribution build on top of [Nix package manager](https://nixos.org/nix/)
and [nixpkgs](https://nixos.org/nixpkgs/).
This project is somewhat similar to python distributions like
[anaconda](https://www.anaconda.com) but using source based
approach with reproducible build (and binary cache).

Compatible with MacOS and Linux.

## Installation

Install [nix package manager](https://nixos.org/nix/).

```
$ curl https://nixos.org/nix/install | sh
```

Install jupyter with packages

```
$ git clone git@github.com:turboMaCk/jupyjaji.git
$ cd jupyjaji
$ nix-env -i -f default.nix
```

## Usage

Just run `jupyjaji` from what ever directory you want.

```
$ jupyjaji
[I 17:03:38.228 NotebookApp] Serving notebooks from local directory: /home/marek/Documents
[I 17:03:38.228 NotebookApp] The Jupyter Notebook is running at:
[I 17:03:38.228 NotebookApp] http://localhost:8888/?token=a6efc193fda74628ad4569eb55a3493b4ab0e4cfdc466c0d
[I 17:03:38.228 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 17:03:38.328 NotebookApp] 
    
    To access the notebook, open this file in a browser:
        file:///run/user/1000/jupyter/nbserver-18132-open.html
    Or copy and paste one of these URLs:
        http://localhost:8888/?token=a6efc193fda74628ad4569eb55a3493b4ab0e4cfdc466c0d

```

## Advanced Usage

Jupyjaji is build in extensible way and more advanced nix user can customize it
quite a bit.

### Custom Python Version

Say you want to use python `3.6.x` instead of default one for your installation.
This can be done using `python` argument to build:

```
$ nix-build -E "import ./default.nix { python = \"python36\"; }"
```

In fact the python string has to correspond to nixpkgs' attribute.
One of the possible ways to explore options is using REPL:

```
$ nix repl

nix-repl> pkgs = import <nixpkgs> {}

nix-repl> pkgs.python<TAB>
pkgs.python              pkgs.python3             pkgs.python3Full
pkgs.python-qt           pkgs.python35            pkgs.python3Packages
pkgs.python-setup-hook   pkgs.python35Full        pkgs.pythonDocs
pkgs.python2             pkgs.python35Packages    pkgs.pythonFull
pkgs.python27            pkgs.python36            pkgs.pythonIRClib
pkgs.python27Full        pkgs.python36Full        pkgs.pythonInterpreters
pkgs.python27Packages    pkgs.python36Packages    pkgs.pythonPackages
pkgs.python2Full         pkgs.python37            pkgs.pythonSexy
pkgs.python2Packages     pkgs.python37Full        pkgs.pythonmagick
pkgs.python2nix          pkgs.python37Packages
nix-repl> pkgs.python
```

### Custom Packages

You can override default packages. Say numpy and pandas is all you really need in addition
to jupyter notebook and python kernel, then you can build jupyjaji using

```
$ nix-build -E "import ./default.nix { packages = [\"numpy\" \"pandas\"]; }"
```

Once again those string are attribute names from nixpkgs.

### Pinning Nixpkgs

By default nixpkgs use import from your global channel using `import <nixpkgs>`.
but it's possible to use pinned version. For instance say you have own pinned version
of nixpkgs in `~/nixpkgs`. You can build this project using packages from this definition using:

```
$ nix-build -E "import ./default.nix { nixpkgs = import ~/nixpkgs; }"
```

