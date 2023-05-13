default:
    @just --list

switch:
    home-manager switch

update:
    nix-channel --update
    @just switch