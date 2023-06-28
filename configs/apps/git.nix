{email, username, ...}: {
  programs.git = {
    enable = true;
    difftastic = {
      enable = true;
      background = "dark";
    };
    lfs.enable = true;
    userEmail = email;
    userName = username;
    extraConfig = {
      user.signingKey = "~/.ssh/id_ed25519";
      commit.gpgSign = true;
      tag.gpgSign = true;
      pull.rebase = true;
      push = {
        autoSetupRemote = true;
        gpgSign = "if-asked";
      };
      gpg.format = "ssh";
      init.defaultBranch = "main";
    };
  };
}
