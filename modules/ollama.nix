{ pkgs, lib, ... }:
{

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    # Optional: preload models, see https://ollama.com/library
    loadModels = [ "gemma4:12b" "gemma4:31b" "gemma4:26b" "gemma4:e2b" "gemma4:e4b" "qwen3.6:27b" "qwen3.6:35b"];
  };

  services.open-webui.enable = true;


}

