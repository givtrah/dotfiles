{ pkgs, ... }:
{

 # Useful other development tools
  environment.systemPackages = with pkgs; [

  lmstudio
	llama-cpp-vulkan
#	ollama-vulkan

#  rocmPackages.rocm-smi


  ];

	services.ollama = {
	  package = pkgs.ollama-vulkan;
		enable = true;
#		acceleration = "rocm";
		loadModels = [ "gpt-oss:20b" "gpt-oss:120b" "devstral-small-2:24b" "qwen3-coder:30b" "gemma3:27b" "olmo-3.1:32b" "mistral-3:14b" ];
		
		};

  services.open-webui  = {
		enable = true;
		environment = {
 #   OLLAMA_HOST = "0.0.0.0"; # used to be necessary, but doesn't seem to anymore
  };
		host = "0.0.0.0";
	};





}
