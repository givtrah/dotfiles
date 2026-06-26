{ config, pkgs, ...}: {

	fonts.fontconfig.enable = true;

	home.packages = with pkgs; [
  	font-awesome
		google-fonts
		corefonts
		vista-fonts
		noto-fonts
  	noto-fonts-cjk-sans
  	noto-fonts-color-emoji
  	liberation_ttf
  	fira-code
  	fira-code-symbols
  	mplus-outline-fonts.githubRelease
#  	dina-font
#  	proggyfonts
		nerd-fonts.jetbrains-mono
		nerd-fonts.fira-code
		nerd-fonts.droid-sans-mono
		nerd-fonts.hack
		nerd-fonts.iosevka

	];


}
