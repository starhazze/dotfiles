{ config, ... }:

{

  # --- helper script ---
  home.file."${config.home.homeDirectory}/.local/bin/matugen-mode-sync" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      case "$1" in
        dark)  dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'" ;;
        light) dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'" ;;
      esac
    '';
  };

  xdg.configFile = {

    # --- matugen config ---

    "matugen/config.toml".text = ''
      [config.wallpaper]
      command = "awww"
      arguments = ["img", "--transition-type", "random"]
      set = true

      [config]
      scheme = "scheme-expressive"

      [templates.system_theme]
      input_path  = "${config.xdg.configHome}/matugen/templates/system-theme.txt"
      output_path = "/tmp/matugen-mode"
      post_hook   = "${config.home.homeDirectory}/.local/bin/matugen-mode-sync {{ mode }}"

      [templates.waybar]
      input_path = "${config.xdg.configHome}/matugen/templates/colors.css"
      output_path = "${config.xdg.configHome}/waybar/colors.css"
      post_hook = "pkill -SIGUSR2 waybar"

      [templates.pywalfox]
      input_path = '${config.xdg.configHome}/matugen/templates/pywalfox-colors.json'
      output_path = '${config.home.homeDirectory}/.cache/wal/colors.json'
      post_hook = 'pywalfox update'

      [templates.vesktop]
      input_path = '${config.xdg.configHome}/matugen/templates/midnight-discord.css'
      output_path = '${config.xdg.configHome}/vesktop/themes/midnight-discord.css'

      [templates.swaync]
      input_path = "${config.xdg.configHome}/matugen/templates/colors.css"
      output_path = "${config.xdg.configHome}/swaync/colors.css"
      post_hook = "swaync-client -rs"

      [templates.neovim]
      input_path = '${config.xdg.configHome}/matugen/templates/nvim.lua'
      output_path = '${config.xdg.configHome}/nvim/lua/colors.lua'
      post_hook = 'pkill -SIGUSR1 nvim'

#      unsused for now
#      [templates.matuwall]
#      input_path = '${config.xdg.configHome}/matugen/templates/matuwall-colors.json'
#      output_path = '${config.xdg.configHome}/matuwall/colors.json'

      [templates.kitty]
      input_path = "${config.xdg.configHome}/matugen/templates/kitty-colors.conf"
      output_path = "${config.xdg.configHome}/kitty/current-theme.conf"
      post_hook = "pkill -USR1 kitty"

      [templates.qt5ct]
      input_path = "${config.xdg.configHome}/matugen/templates/qtct-colors.conf"
      output_path = "${config.xdg.configHome}/qt5ct/colors/matugen.conf"

      [templates.qt6ct]
      input_path = "${config.xdg.configHome}/matugen/templates/qtct-colors.conf"
      output_path = "${config.xdg.configHome}/qt6ct/colors/matugen.conf"

      [templates.gtk3]
      input_path = '${config.xdg.configHome}/matugen/templates/gtk-colors.css'
      output_path = '${config.xdg.configHome}/gtk-3.0/colors.css'
      post_hook = 'thunar -q; gsettings set org.gnome.desktop.interface gtk-theme ""; gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-{{mode}}'
      
      [templates.gtk4]
      input_path = '${config.xdg.configHome}/matugen/templates/gtk-colors.css'
      output_path = '${config.xdg.configHome}/gtk-4.0/colors.css'

      [templates.niri]
      input_path = "${config.xdg.configHome}/matugen/templates/niri-colors.kdl"
      output_path = "${config.xdg.configHome}/niri/colors.kdl"
      post_hook = "niri msg action load-config-file &"

      [templates.cava]
      input_path = "${config.xdg.configHome}/matugen/templates/cava-colors.ini"
      output_path = "${config.xdg.configHome}/cava/colors.ini"
      post_hook = "pkill -USR1 cava"

      [templates.wlogout]
      input_path = '${config.xdg.configHome}/matugen/templates/colors.css'
      output_path = '${config.xdg.configHome}/wlogout/colors.css'
    '';

    # --- templates ---   

    "matugen/templates/system-theme.txt".text = ''
      {{ mode }}
    '';

    "matugen/templates/pywalfox-colors.json".text = ''
      {
        "wallpaper": "{{image}}",
        "alpha": "100",
        "colors": {
          "color0": "{{colors.surface.dark.hex}}",
          "color1": "",
          "color2": "",
          "color3": "{{colors.primary.default.hex}}",
          "color4": "",
          "color5": "{{colors.secondary.default.hex}}",
          "color6": "",
          "color7": "{{colors.surface_container_highest.default.hex}}",
          "color8": "",
          "color9": "",
          "color10": "{{colors.primary.default.hex}}",
          "color11": "",
          "color12": "",
          "color13": "{{colors.secondary.default.hex}}",
          "color14": "",
          "color15": "{{colors.on_background.default.hex}}"
        }
      }
    '';

    "matugen/templates/gtk-colors.css".text = ''
      /*
      * GTK Colors
      * Generated with Matugen
      */
      
      @define-color accent_color {{colors.primary_fixed_dim.default.hex}};
      @define-color accent_fg_color {{colors.on_primary_fixed.default.hex}};
      @define-color accent_bg_color {{colors.primary_fixed_dim.default.hex}};
      @define-color window_bg_color {{colors.surface_dim.default.hex}};
      @define-color window_fg_color {{colors.on_surface.default.hex}};
      @define-color headerbar_bg_color {{colors.surface_dim.default.hex}};
      @define-color headerbar_fg_color {{colors.on_surface.default.hex}};
      @define-color popover_bg_color {{colors.surface_dim.default.hex}};
      @define-color popover_fg_color {{colors.on_surface.default.hex}};
      @define-color view_bg_color {{colors.surface.default.hex}};
      @define-color view_fg_color {{colors.on_surface.default.hex}};
      @define-color card_bg_color {{colors.surface.default.hex}};
      @define-color card_fg_color {{colors.on_surface.default.hex}};
      @define-color sidebar_bg_color @window_bg_color;
      @define-color sidebar_fg_color @window_fg_color;
      @define-color sidebar_border_color @window_bg_color;
      @define-color sidebar_backdrop_color @window_bg_color;
    '';

    "matugen/templates/colors.css".text = ''
      /*
      * Css Colors
      * Generated with Matugen
      */
      <* for name, value in colors *>
          @define-color {{name}} {{value.default.hex}};
      <* endfor *>
    '';

    "matugen/templates/kitty-colors.conf".text = ''
      <* if {{ is_dark_mode }} *>
      cursor {{colors.on_surface.default.hex}}
      cursor_text_color {{colors.on_surface_variant.default.hex}}
      
      foreground            {{colors.on_surface.default.hex}}
      background            {{colors.surface.default.hex}}
      selection_foreground  {{colors.on_secondary.default.hex}}
      selection_background  {{colors.secondary_fixed_dim.default.hex}}
      url_color             {{colors.primary.default.hex}}

      # black
      color8   #262626
      color0   #4c4c4c
      
      # red
      color1   #ac8a8c
      color9   #c49ea0
      
      # green
      color2   #8aac8b
      color10  #9ec49f
      
      # yellow
      color3   #aca98a
      color11  #c4c19e
      
      # blue
      color4  {{colors.primary.default.hex}}
      color12 #a39ec4
      
      # magenta
      color5   #ac8aac
      color13  #c49ec4
      
      # cyan
      color6   #8aacab
      color14  #9ec3c4
      
      # white
      color15   #e7e7e7
      color7  #f0f0f0   
      <* else *>
      cursor {{colors.on_surface.light.hex}}
      cursor_text_color {{colors.on_surface_variant.light.hex}}
      
      foreground            {{colors.on_surface.light.hex}}
      background            {{colors.surface.light.hex}}
      selection_foreground  {{colors.on_secondary.light.hex}}
      selection_background  {{colors.secondary_fixed_dim.light.hex}}
      url_color             {{colors.primary.light.hex}}

      # black
      color8   #262626
      color0   #4c4c4c
      
      # red
      color1   #ac8a8c
      color9   #c49ea0
      
      # green
      color2   #8aac8b
      color10  #9ec49f
      
      # yellow
      color3   #aca98a
      color11  #c4c19e
      
      # blue
      color4  {{colors.primary.default.hex}}
      color12 #a39ec4
      
      # magenta
      color5   #ac8aac
      color13  #c49ec4
      
      # cyan
      color6   #8aacab
      color14  #9ec3c4
      
      # white
      color15   #e7e7e7
      color7  #f0f0f0   
      <* endif *>
    '';

    "matugen/templates/niri-colors.kdl".text = ''
      layout {
          focus-ring {
              active-color "{{colors.primary.default.hex}}"
              inactive-color "{{colors.outline.default.hex}}"
              urgent-color   "{{colors.error.default.hex}}"
          }

          border {
              active-color   "{{colors.primary.default.hex}}"
              inactive-color "{{colors.outline.default.hex}}"
              urgent-color   "{{colors.error.default.hex}}"
          }

          shadow {
              color "{{colors.shadow.default.hex}}70"
          }

          tab-indicator {
              active-color   "{{colors.primary.default.hex}}"
              inactive-color "{{colors.outline.default.hex}}"
              urgent-color   "{{colors.error.default.hex}}"
          }

          insert-hint {
              color "{{colors.primary.default.hex}}80"
          }
      }

      overview {
          backdrop-color "{{colors.background.default.hex}}"
      }
    '';

    "matugen/templates/nvim.lua".text = ''
      -- yanked from here: https://github.com/kkuroma/dotfiles/blob/main/src/.config/matugen/templates/neovim-theme.lua
      -- Auto-generated by Matugen
      -- Colors derived from matugen palette with forced hues (matching ANSI/kitty)
 
      local colors = {
        red      = '#c49ea0',
        green    = '#9ec49f',
        yellow   = '#c4c19e',
        blue     = '{{colors.primary.default.hex}}',
        magenta  = '#c49ec4',
        cyan     = '#9ec3c4',
        orange   = '#c4c19e',
        pink     = '#c49ec4',
      
        fg       = '{{colors.on_surface.default.hex}}',
        fg_dim   = '{{colors.on_surface_variant.default.hex}}',
        comment  = '{{colors.outline.default.hex}}',
        primary  = '{{colors.primary.default.hex}}',
        secondary = '{{colors.secondary.default.hex}}',
        tertiary  = '{{colors.tertiary.default.hex}}',  -- was missing
      }

      -- Helper
      local function set_hl_multiple(groups, value)
        for _, v in pairs(groups) do
          vim.api.nvim_set_hl(0, v, value)
        end
      end
      
      -- Core: transparent backgrounds
      vim.api.nvim_set_hl(0, 'Normal', { fg = colors.fg, bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NormalNC', { fg = colors.fg, bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { fg = colors.fg, bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = colors.comment, bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'MsgArea', { fg = colors.fg, bg = 'NONE' })
      
      -- Selection / cursor (these need bg to be readable)
      vim.api.nvim_set_hl(0, 'Visual', {
        bg = '{{colors.primary_container.default.hex}}',
      })
      vim.api.nvim_set_hl(0, 'CursorLine', {
        bg = '{{colors.surface_container_high.default.hex}}',
      })
      vim.api.nvim_set_hl(0, 'Search', {
        bg = '{{colors.secondary_container.default.hex}}',
        fg = '{{colors.on_secondary_container.default.hex}}',
      })
      vim.api.nvim_set_hl(0, 'IncSearch', {
        bg = '{{colors.primary.default.hex}}',
        fg = '{{colors.on_primary.default.hex}}',
      })
      vim.api.nvim_set_hl(0, 'PmenuSel', {
        bg = '{{colors.primary.default.hex}}',
        fg = '{{colors.on_primary.default.hex}}',
      })
      
      -- Pmenu (needs bg to float above content)
      vim.api.nvim_set_hl(0, 'Pmenu', {
        bg = '{{colors.surface_container_high.default.hex}}',
        fg = colors.fg,
      })
      
      -- StatusLine (needs bg to separate from content)
      vim.api.nvim_set_hl(0, 'StatusLine', {
        bg = '{{colors.surface_container.default.hex}}',
        fg = colors.fg,
      })
      
      -- Line numbers
      vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.comment })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = colors.primary, bold = true })
      
      -- Comments
      set_hl_multiple({ 'Comment', '@comment' }, {
        fg = colors.comment,
        italic = true,
      })
      
      -- Keywords (primary accent)
      set_hl_multiple({ 'Keyword', '@keyword', '@keyword.control', '@keyword.function', 'Conditional', 'Repeat' }, {
        fg = colors.primary,
      })
      
      -- Functions (secondary accent)
      set_hl_multiple({ 'Function', '@function', '@function.call', '@method', '@method.call' }, {
        fg = colors.secondary,
      })
      
      -- Strings (green)
      set_hl_multiple({ 'String', '@string', '@string.escape' }, {
        fg = colors.green,
      })
      
      -- Types & Classes
      set_hl_multiple({ 'Type', '@type', '@type.builtin', 'Structure', 'StorageClass' }, {
        fg = colors.tertiary,
      })
      
      -- Numbers & Constants
      set_hl_multiple({ 'Number', '@number', 'Boolean', '@boolean', 'Constant', '@constant' }, {
        fg = colors.orange,
      })

      -- Variables (default fg)
      set_hl_multiple({ 'Identifier', '@variable', '@parameter' }, {
        fg = colors.fg,
      })
      
      -- Special/Magic variables (red)
      set_hl_multiple({ '@variable.builtin', 'Special' }, {
        fg = colors.red,
        italic = true,
      })
      
      -- Operators (fg)
      set_hl_multiple({ 'Operator', '@operator' }, {
        fg = colors.cyan,
      })
      
      -- Punctuation
      set_hl_multiple({ 'Delimiter', '@punctuation.delimiter', '@punctuation.bracket' }, {
        fg = colors.fg_dim,
      })
      
      -- Tags (HTML/XML)
      set_hl_multiple({ 'Tag', '@tag', '@tag.delimiter' }, {
        fg = colors.primary,
      })
      
      -- Attributes
      set_hl_multiple({ '@tag.attribute' }, {
        fg = colors.secondary,
        italic = true,
      })
      
      -- Diagnostics
      vim.api.nvim_set_hl(0, 'Error', { fg = colors.red, bold = true })
      vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = colors.red })
      vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = colors.yellow })
      vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = colors.blue })
      vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = colors.fg_dim })
    '';

    "matugen/templates/midnight-discord.css".text = ''
      /**
       * @name midnight
       * @description A dark, rounded discord theme.
       * @author refact0r
       * @version 1.6.2
       * @invite nz87hXyvcy
       * @website https://github.com/refact0r/midnight-discord
       * @source https://github.com/refact0r/midnight-discord/blob/master/midnight.theme.css
       * @authorId 508863359777505290
       * @authorLink https://www.refact0r.dev
      */
      
      /* IMPORTANT: make sure to enable dark mode in discord settings for the theme to apply properly!!! */
      
      @import url('https://refact0r.github.io/midnight-discord/build/midnight.css');
      
      /* customize things here */
      :root {
      	/* font, change to 'gg sans' for default discord font*/
      	--font: 'figtree';
      
      	/* top left corner text */
      	--corner-text: 'Midnight';
      
      	/* color of status indicators and window controls */
          --online-indicator: {{colors.inverse_primary.default.hex}};     /* change to #23a55a for default green */
      	--dnd-indicator: {{colors.error.default.hex}};                  /* change to #f13f43 for default red */
      	--idle-indicator: {{colors.tertiary_container.default.hex}};    /* change to #f0b232 for default yellow */
      	--streaming-indicator: {{colors.on_primary.default.hex}};       /* change to #593695 for default purple */
      
      	/* accent colors */
          --accent-1: {{colors.tertiary.default.hex}};            /* links */
      	--accent-2: {{colors.primary.default.hex}};             /* general unread/mention elements, some icons when active */
      	--accent-3: {{colors.primary.default.hex}};             /* accent buttons */
      	--accent-4: {{colors.surface_bright.default.hex}};      /* accent buttons when hovered */
      	--accent-5: {{colors.primary_fixed_dim.default.hex}};   /* accent buttons when clicked */
          --accent-new: {{colors.inverse_primary.default.hex}};   /* user panel mute & deafen buttons */
      	--mention:  {{colors.surface.default.hex}};             /* mentions & mention messages */
      	--mention-hover: {{colors.surface_bright.default.hex}}; /* mentions & mention messages when hovered */
      
      	/* text colors */
      	--text-0: {{colors.surface.default.hex}};               /* text on colored elements */
      	--text-1: {{colors.on_surface.default.hex}};            /* other normally white text */
      	--text-2: {{colors.on_surface.default.hex}};            /* headings and important text */
      	--text-3: {{colors.on_surface_variant.default.hex}};    /* normal text */
      	--text-4: {{colors.on_surface_variant.default.hex}};    /* icon buttons and channels */
      	--text-5: {{colors.outline.default.hex}};               /* muted channels/chats and timestamps */
      
      	/* background and dark colors */
          --bg-1: {{colors.surface_variant.default.hex}};                             /* dark buttons when clicked */
      	--bg-2: {{colors.surface_container_high.default.hex}};              /* dark buttons */
      	--bg-3: {{colors.surface_container_low.default.hex}};               /* spacing, secondary elements */
      	--bg-4: {{colors.surface.default.hex}};                             /* main background color */
      	--hover: {{colors.surface_bright.default.hex}};                     /* channels and buttons when hovered */
      	--active: {{colors.surface_bright.default.hex}};                    /* channels and buttons when clicked or selected */
      	--message-hover: {{colors.surface_bright.default.hex}};             /* messages when hovered */
      
      	/* amount of spacing and padding */
      	--spacing: 12px;
      
      	/* animations */
      	/* ALL ANIMATIONS CAN BE DISABLED WITH REDUCED MOTION IN DISCORD SETTINGS */
      	--list-item-transition: 0.2s ease;  /* channels/members/settings hover transition */
      	--unread-bar-transition: 0.2s ease; /* unread bar moving into view transition */
      	--moon-spin-transition: 0.4s ease;  /* moon icon spin */
      	--icon-spin-transition: 1s ease;    /* round icon button spin (settings, emoji, etc.) */
      
      	/* corner roundness (border-radius) */
      	--roundness-xl: 22px; /* roundness of big panel outer corners */
      	--roundness-l: 20px; /* popout panels */
      	--roundness-m: 16px; /* smaller panels, images, embeds */
      	--roundness-s: 12px; /* members, settings inputs */
      	--roundness-xs: 10px; /* channels, buttons */
      	--roundness-xxs: 8px; /* searchbar, small elements */
      
      	/* direct messages moon icon */
      	/* change to block to show, none to hide */
      	--discord-icon: none; /* discord icon */
      	--moon-icon: block; /* moon icon */
      	--moon-icon-url: url('https://upload.wikimedia.org/wikipedia/commons/c/c4/Font_Awesome_5_solid_moon.svg'); /* custom icon url */
      	--moon-icon-size: auto;
      
      	/* filter uncolorable elements to fit theme */
      	/* (just set to none, they're too much work to configure) */
      	--login-bg-filter: saturate(0.3) hue-rotate(-15deg) brightness(0.4); /* login background artwork */
      	--green-to-accent-3-filter: hue-rotate(56deg) saturate(1.43); /* add friend page explore icon */
      	--blurple-to-accent-3-filter: hue-rotate(304deg) saturate(0.84) brightness(1.2); /* add friend page school icon */
      }
      
      /* Selected chat/friend text */
      .selected_f5eb4b,
      .selected_f6f816 .link_d8bfb3 {
        color: var(--text-0) !important;
        background: var(--accent-3) !important;
      }
      
      .selected_f6f816 .link_d8bfb3 * {
        color: var(--text-0) !important;
        fill: var(--text-0) !important;
      }
    '';

    "matugen/templates/cava-colors.ini".text = ''
      [color]
      background = 'default'
      foreground = '{{colors.primary.default.hex}}'
      
      ; gradient = 0
      gradient = 1
      gradient_color_1 = '{{colors.primary_container.default.hex}}'
      gradient_color_2 = '{{colors.primary.default.hex}}'
      gradient_color_3 = '{{colors.on_primary_container.default.hex}}'
      
      horizontal_gradient = 0
      ; horizontal_gradient = 1
      horizontal_gradient_color_1 = '{{colors.primary_container.default.hex}}'
      horizontal_gradient_color_2 = '{{colors.primary.default.hex}}'
      horizontal_gradient_color_3 = '{{colors.on_primary_container.default.hex}}'
      horizontal_gradient_color_4 = '{{colors.primary.default.hex}}'
      horizontal_gradient_color_5 = '{{colors.primary_container.default.hex}}'
    '';

    "matugen/templates/qtct-colors.conf".text = ''
      [ColorScheme]
      active_colors={{colors.on_background.default.hex}}, {{colors.surface.default.hex}}, #ffffff, #cacaca, #9f9f9f, #b8b8b8, {{colors.on_background.default.hex}}, #ffffff, {{colors.on_surface.default.hex}}, {{colors.background.default.hex}}, {{colors.background.default.hex}}, {{colors.shadow.default.hex}}, {{colors.primary_container.default.hex}}, {{colors.on_primary_container.default.hex}}, {{colors.secondary.default.hex}}, {{colors.primary.default.hex}}, {{colors.surface.default.hex}}, {{colors.scrim.default.hex}}, {{colors.surface.default.hex}}, {{colors.on_surface.default.hex}}, {{colors.secondary.default.hex}}
      disabled_colors={{colors.on_background.default.hex}}, {{colors.surface.default.hex}}, #ffffff, #cacaca, #9f9f9f, #b8b8b8, {{colors.on_background.default.hex}}, #ffffff, {{colors.on_surface.default.hex}}, {{colors.background.default.hex}}, {{colors.background.default.hex}}, {{colors.shadow.default.hex}}, {{colors.primary_container.default.hex}}, {{colors.on_primary_container.default.hex}}, {{colors.secondary.default.hex}}, {{colors.primary.default.hex}}, {{colors.surface.default.hex}}, {{colors.scrim.default.hex}}, {{colors.surface.default.hex}}, {{colors.on_surface.default.hex}}, {{colors.secondary.default.hex}}
      inactive_colors={{colors.on_background.default.hex}}, {{colors.surface.default.hex}}, #ffffff, #cacaca, #9f9f9f, #b8b8b8, {{colors.on_background.default.hex}}, #ffffff, {{colors.on_surface.default.hex}}, {{colors.background.default.hex}}, {{colors.background.default.hex}}, {{colors.shadow.default.hex}}, {{colors.primary_container.default.hex}}, {{colors.on_primary_container.default.hex}}, {{colors.secondary.default.hex}}, {{colors.primary.default.hex}}, {{colors.surface.default.hex}}, {{colors.scrim.default.hex}}, {{colors.surface.default.hex}}, {{colors.on_surface.default.hex}}, {{colors.secondary.default.hex}}
    '';

    "qt5ct/qt5ct.conf".text = ''
      [Appearance]
      color_scheme_path=${config.xdg.configHome}/qt5ct/colors/matugen.conf
      custom_palette=true
      icon_theme=breeze
      style=Fusion
    '';
  };
}
