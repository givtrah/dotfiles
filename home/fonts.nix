{ config, pkgs, ...}: {

	fonts.fontconfig.enable = true;

	home.packages = with pkgs; [
  	font-awesome
		google-fonts
		noto-fonts
  	noto-fonts-cjk-sans
  	noto-fonts-color-emoji
  	liberation_ttf
  	fira-code
  	fira-code-symbols
  	mplus-outline-fonts.githubRelease
#  	dina-font # included from somewhere else?
#  	proggyfonts # included from somewhere else?
		nerd-fonts.jetbrains-mono
		nerd-fonts.fira-code
		nerd-fonts.droid-sans-mono
		nerd-fonts.hack
		nerd-fonts.iosevka

    # Microsoft fonts
		corefonts
		vista-fonts

    # Microsoft replacement fonts
    liberation_ttf # replacements for Times New Roman (Liberation Serif), Arial (Liberation Sans), Courier New (Liberation Mono)
    carlito # sans-serif font metric-compatible with Microsoft Calibri
    caladea # Serif font metric-compatible with Microsoft Cambria

  ];
}
