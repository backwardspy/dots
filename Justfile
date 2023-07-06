default:
    @just --list

pull:
    git rm --cached machine.nix
    git pull
    git add -Nf machine.nix

switch:
    home-manager switch

update:
    nix flake update
    @just switch

format:
    alejandra .
