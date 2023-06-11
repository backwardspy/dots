default:
    @just --list

switch:
    home-manager switch

update:
    nix-channel --update
    @just switch
    fish -c download_nixpkgs_cache_index

format:
    alejandra .