{ config, ... }: {
  xdg.configFile."otter-launcher/config.toml".text = ''
    [general]
    default_module             = "app"       # The module to run when no prefix is matched
    empty_module               = "a"         # Run with an empty prompt
    exec_cmd                   = "sh -c"     # The exec command of your shell (e.g. "bash -c", "zsh -c")
    vi_mode                    = true        # true = vi keybinds, false = emacs keybinds
    esc_to_abort               = true        # Allow quitting with Esc (useful for vi users)
    cheatsheet_entry           = "?"         # Shows a list of configured modules when entered
    cheatsheet_viewer          = "less -R; clear"
    clear_screen_after_execution = false     # Useful when chafa image flashes back after execution
    loop_mode                  = false       # Won't quit after running a module (useful for scratchpads)
    external_editor            = ""          # Ctrl+E (or v in vi normal mode) opens input in this editor
    # callback                 = ""          # Command to run after a module executes (e.g. swaymsg to resize)

    # Note: ASCII color codes are allowed below.
    # Use \u001B instead of \x1b — the Rust TOML crate cannot parse \x escapes.

    [interface]
    header = """
     \u001B[34;1m  >\u001B[0m $USER@$(echo $HOSTNAME)                \u001B[31m\u001B[0m $(cat /proc/loadavg | cut -d ' ' -f 1)  \u001B[33m󰍛\u001B[0m $(free -h | awk 'FNR == 2 {print $3}' | sed 's/i//')
        \u001B[34;1m>\u001B[0;1m """

    header_cmd                 = ""
    header_cmd_trimmed_lines   = 0        # Remove N trailing empty lines from header_cmd output
    header_concatenate         = false    # Print header and header_cmd output on the same line
    list_prefix                = "      "
    selection_prefix           = "    \u001B[31;1m> "
    place_holder               = "type and search"
    default_module_message     = "      \u001B[33msearch\u001B[0m the internet"
    empty_module_message       = ""
    suggestion_mode            = "list"   # Options: list, hint
    suggestion_lines           = 12       # Set to 0 to disable suggestions and tab completion
    indicator_with_arg_module  = "\u001B[31m^\u001B[0m "
    indicator_no_arg_module    = "\u001B[31m$\u001B[0m "
    prefix_padding             = 3        # Pad prefixes to a uniform minimum width
    prefix_color               = "\u001B[33m"
    description_color          = "\u001B[39m"
    place_holder_color         = "\u001B[30m"
    hint_color                 = "\u001B[30m"
    move_right                 = 0
    move_up                    = 0


    [[modules]]
    description  = "search with brave"
    prefix       = "br"
    cmd          = "setsid -f xdg-open 'https://search.brave.com/search?q={}'"
    with_argument = true
    url_encode   = true

    [[modules]]
    description  = "kill a running app"
    prefix       = "k"
    cmd          = 'ps -u "$USER" -o comm= | sort -u | fsel --dmenu | xargs -r pkill -9'
    with_argument = true
    url_encode   = true

    [[modules]]
    description  = "launch apps with fsel"
    prefix       = "a"
    cmd          = "fsel -vv -r -d -ss \"{}\""
    with_argument = true

    [[modules]]
    description  = "launch apps instantly"
    prefix       = "app"
    cmd          = "fsel -vv -r -d -p {}"
    with_argument = true

    [[modules]]
    description  = "manage clipboard with fsel"
    prefix       = "cl"
    cmd          = "fsel --cclip"

    [[modules]]
    description  = "find packages"
    prefix       = "pm"
    cmd          = "librewolf 'https://search.nixos.org/packages?channel=unstable&query={}'"
    with_argument = true

    [[modules]]
    description  = "open bluetui"
    prefix       = "bt"
    cmd          = "bluetui"
    with_argument = false

    [[modules]]
    description  = "open nmtui"
    prefix       = "nt"
    cmd          = "nmtui"
    with_argument = false

    [[modules]]
    description  = "power menu with fzf"
    prefix       = "p"
    cmd          = """
    function power {
      if [[ -n $1 ]]; then
        case $1 in
          "logout")    niri msg action quit ;;
          "suspend")   sudo s2ram ;;
          "hibernate") sudo s2disk ;;
          "reboot")    sudo openrc-shutdown -r now ;;
          "shutdown")  sudo openrc-shutdown -p now ;;
        esac
      fi
    }
    power $(echo -e 'reboot\nshutdown\nlogout\nsuspend\nhibernate' \
      | fzf --reverse --no-scrollbar --padding 1,3 --prompt 'Power Menu: ' \
      | tail -1)
    """

    [[modules]]
    description  = "edit system config"
    prefix       = "cn"
    cmd          = "kitty --detach 'nvim' '${config.home.homeDirectory}/dotfiles/nixos/configuration.nix'; pkill otter"
    with_argument = false

    [[modules]]
    description  = "edit HM apps.nix"
    prefix       = "an"
    cmd          = "kitty --detach 'nvim' '${config.home.homeDirectory}/dotfiles/home-manager/apps.nix'; pkill otter"
    with_argument = false

    [[modules]]
    description  = "run command in terminal"
    prefix       = "s"
    cmd          = """setsid -f "$(echo $TERM | sed 's/xterm-//g')" -e {}"""
    with_argument = true

    [[modules]]
    description  = "calculator"
    prefix       = "ca"
    cmd          = "echo '{}' | bc | wl-copy"
    with_argument = true

    [[modules]]
    description  = "search archwiki"
    prefix       = "w"
    cmd          = "setsid -f xdg-open https://wiki.archlinux.org/index.php?search='{}'"
    with_argument = true
    url_encode   = true

    [[modules]]
    description  = "cambridge dictionary"
    prefix       = "dc"
    cmd          = "setsid -f xdg-open 'https://dictionary.cambridge.org/dictionary/english/{}'"
    with_argument = true
    url_encode   = true
  '';
}
