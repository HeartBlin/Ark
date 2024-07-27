{ config, ... }:

let
  cfg = config.Ark.home;
  user = config.Ark.userName;
  gitUser = cfg.git.user;
  gitEmail = cfg.git.email;
  gitSignKey = cfg.git.signKey;
in {
  config.home-manager.users."${user}" = {
    programs.git = {
      enable = true;

      userName = gitUser;
      userEmail = gitEmail;

      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "${gitSignKey}";
      };
    };

    programs.ssh = {
      enable = true;
      extraConfig = ''
        Host github.com
          HostName github.com
          PreferredAuthentications publickey
          IdentityFile /home/heartblin/.ssh/GithubAuth
      '';
    };
  };
}
