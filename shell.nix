{ pkgs ? import <nixpkgs> {} }: pkgs.mkShellNoCC {
  packages = with pkgs; [python312 uv basedpyright ruff cmake ninja graphviz pprof stdenv.cc.cc.lib libz];
  LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.libz}/lib";
}
