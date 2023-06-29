{homeDirectory, ...}: {
  programs.keychain = {
    enable = true;
    keys = [
      "${homeDirectory}/.ssh/id_rsa"
      "${homeDirectory}/.ssh/id_ed25519"
    ];
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent yes
      IdentityFile ${homeDirectory}/.ssh/id_ed25519

      IgnoreUnknown UseKeychain
      UseKeychain yes
    '';
  };
}
