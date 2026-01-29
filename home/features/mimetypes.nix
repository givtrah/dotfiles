{ config, pkgs, ...}: {

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "okularApplication_pdf.desktop";


			# Default browser
			"text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";


    };
  };

}
