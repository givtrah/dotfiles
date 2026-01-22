{ config, pkgs, ...}: {

home-manager.users.${config.home.username} = {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "okularApplication_pdf.desktop";
    };
  };
};

}
