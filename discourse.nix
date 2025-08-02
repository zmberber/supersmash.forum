{
  services = {
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
        serverAddress = "mail.your-server.de";
        enableStartTLSAuto = true;
        port = 587;
        username = "discourse@supersmash.forum";
        passwordFile = "/var/secrets/discourse-smtp";
        incoming.enable = true;
      };
      siteSettings = {
        max_category_nesting = 3;
      };
      secretKeyBaseFile = "/var/secrets/discourse-secretKeyBaseFile";
      enableACME = true;
    };
  };
  postgresql = {
    package = pkgs.postgresql_15;
  };
}
