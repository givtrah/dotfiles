{ pkgs, lib, ... }:
{

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    # Optional: preload models, see https://ollama.com/library
    loadModels = [ "gemma3:12b" "deepseek-r1:14b" "deepcoder:14b" "qwen3:14b"];
  };

  services.open-webui.enable = true;


}

