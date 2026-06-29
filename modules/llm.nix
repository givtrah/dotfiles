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
		loadModels = [ "gemma4:31b" "gemma4:26b" "gemma4:12b" "qwen3.6:27b" "qwen3.6:35b" "qwen3-coder:30b" "qwen2.5-coder:7b" "devstral-small-2:24b"  ];
		
		};

  services.open-webui  = {
		enable = true;
		environment = {
 #   OLLAMA_HOST = "0.0.0.0"; # used to be necessary, but doesn't seem to anymore
  };
		host = "0.0.0.0";
	};





}
