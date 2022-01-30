{ pkgs ? import <nixos-unstable> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    age
    awscli2
    sops
    terraform
    nodejs-14_x
    vscode
  ];
}
