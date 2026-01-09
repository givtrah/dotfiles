{ pkgs, ... }:
{

 # Useful other development tools
  environment.systemPackages = with pkgs; [

  lmstudio
	llama-cpp-vulkan
	ollama-vulkan

  ];

	services.ollama = {
	  package = pkgs.ollama-rocm;
		enable = true;
#		acceleration = "rocm";
#		loadModels = [ "gpt-oss:20b" "gpt-oss:120b" "devstral-small-2:24b" "qwen3-coder:30b" "gemma3:27b" "olmo-3.1:32b" "mistral-3:14b" ];
		
		};

  services.open-webui.enable = true;


}
