{...}: {
  programs.keychain.enable = true;

  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent yes
      UseKeychain yes
    '';
  };
}
