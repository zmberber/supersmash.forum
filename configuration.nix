{ options, config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
  services = {
    openssh.enable = true;
    discourse = {
      enable = true;
      admin = {
        email = "admin@zmberber.com";
        fullName = "Zeremonienmeister Berber";
        username = "admin";
        passwordFile = "/var/secrets/discourse-admin";
      };
      plugins = with config.services.discourse.package.plugins; [
        discourse-docs
        discourse-oauth2-basic
      ];
      hostname = "supersmash.forum";
      mail.outgoing = {
        serverAddress = " mail.your-server.de";
        port = 587;
        username = "discourse@supersmash.forum";
        passwordFile = "/var/secrets/discourse-smtp";
      };
      mail.incoming.enable = true;
      secretKeyBaseFile = "/var/secrets/discourse-secretKeyBaseFile";
    };
    postgresql = {
      package = pkgs.postgresql_13;
    };
  };
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    growPartition = true;
    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
  };
  time = {
    timeZone = "Europe/Berlin";
  };
  
  networking = {
    hostName = "supersmash";
    firewall = {
      allowedTCPPorts = [80 443];
      allowedUDPPorts = [51820];
    };
  };
  
  environment.systemPackages = with pkgs; [
    vim
    emacs-nox
    git
  ];

  security = {
    acme = {
      acceptTerms = true;
      defaults.email = "certs@zmberber.com";
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGL4SqRZxHe+zziJ/8Q8nFfav5VfYj1zQUxnrHtrI2N4"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJSGssxhQnkSyuqskIhiI7h4jIBkj2kMzNH6/LctK/2V"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIb3uuMqE/xSJ7WL/XpJ6QOj4aSmh0Ga+GtmJl3CDvljGuIeGCKh7YAoqZAi051k5j6ZWowDrcWYHIOU+h0eZCesgCf+CvunlXeUz6XShVMjyZo87f2JPs2Hpb+u/ieLx4wGQvo/Zw89pOly/vqpaX9ZwyIR+U81IAVrHIhqmrTitp+2FwggtaY4FtD6WIyf1hPtrrDecX8iDhnHHuGhATr8etMLwdwQ2kIBx5BBgCoiuW7wXnLUBBVYeO3II957XP/yU82c+DjSVJtejODmRAM/3rk+B7pdF5ShRVVFyB6JJR+Qd1g8iSH+2QXLUy3NM2LN5u5p2oTjUOzoEPWZo7lykZzmIWd/5hjTW9YiHC+A8xsCxQqs87D9HK9hLA6udZ6CGkq4hG/6wFwNjSMnv30IcHZzx6IBihNGbrisrJhLxEiKWpMKYgeemhIirefXA6UxVfiwHg3gJ8BlEBsj0tl/HVARifR2y336YINEn8AsHGhwrPTBFOnBTmfA/VnP1NlWHzXCfVimP6YVvdoGCCnAwvFuJ+ZuxmZ3UzBb2TenZZOzwzV0sUzZk0D1CaSBFJUU3oZNOkDIM6z5lIZgzsyKwb38S8Vs3HYE+Dqpkfsl4yeU5ldc6DwrlVwuSIa4vVus4eWD3gDGFrx98yaqOx17pc4CC9KXk/2TjtJY5xmQ=="
  ];
  

  system.stateVersion = "23.11";
}
