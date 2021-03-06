abbr -a e nvim

if command -v exa > /dev/null
  abbr -a l 'exa'
  abbr -a ls 'exa'
  abbr -a ll 'exa -l'
  abbr -a lla 'exa -la'
else
  abbr -a l 'ls'
  abbr -a ll 'ls -l'
  abbr -a lla 'ls -la'
end

if command -v swaymsg > /dev/null
  abbr -a ken 'swaymsg input type:keyboard xkb_switch_layout 0'
  abbr -a kcz 'swaymsg input type:keyboard xkb_switch_layout 1'
end

set fish_greeting

#set PATH ~/.config/bin ~/.local/bin $PATH

setenv EXA_COLORS da=37

# Base16 Shell
if status --is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
end

set fish_color_command white --bold
set fish_color_comment cyan
set fish_color_param white
set fish_color_quote magenta
set fish_color_autosuggestion brblack

set fish_color_error red
set fish_color_search_match --background=brblack
set fish_color_selection --background=yellow

set fish_pager_color_completion white
set fish_pager_color_prefix white --bold
set fish_pager_color_selected_completion brblack
set fish_pager_color_selected_prefix brblack
set fish_pager_color_selected_description brblack

if command -v starship > /dev/null
  starship init fish | source
else
  set_color red
  echo -n "ERROR"
  set_color normal
  echo ": Missing the fish prompt binary 'Starship'."
end
