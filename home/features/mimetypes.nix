{ config, pkgs, ...}: {

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "okularApplication_pdf.desktop";
    };
  };

}
