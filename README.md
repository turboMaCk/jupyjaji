# Reproducible Jupyter Environment

My own jupyter distribution build on top of Nix package manager
and it's python37 package set.
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
