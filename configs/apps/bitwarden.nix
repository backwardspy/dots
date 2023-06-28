{email, ...}: {
  programs.rbw = {
    enable = true;
    settings.email = email;
  };
}
