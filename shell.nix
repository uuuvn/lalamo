{ pkgs ? import <nixpkgs> {} }: pkgs.mkShellNoCC {
  packages = with pkgs; [python312 uv basedpyright ruff cmake ninja stdenv.cc.cc.lib];
  LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
}
