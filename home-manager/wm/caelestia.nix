{ config, ... }: {
xdg.configFile."caelestia/cli.json".text = ''
  {
    "wallpaper": {
      "postHook": "matugen --source-color-index=0 image $WALLPAPER_PATH && hyprctl reload"
    }
  }
'';
}
