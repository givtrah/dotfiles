{ pkgs, config, ... }:
{

	services.onlyoffice = {
		enable = true;
		hostname = "localhost";
#		jwtSecretFile = config.age.secrets.onlyoffice-jwt.path;
	};

}
