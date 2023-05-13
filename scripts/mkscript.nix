name: source:
with import <nixpkgs> {};
  derivation {
    system = builtins.currentSystem;
    builder = "${bash}/bin/bash";
    args = [./builder.bash];
    inherit name source coreutils;
  }
