set fish_key_bindings fish_user_key_bindings
fish_config theme choose "Catppuccin Mocha"
set fish_greeting

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.fish ]; and . ~/.config/tabtab/__tabtab.fish; or true

fish_add_path /usr/local/sbin
fish_add_path /usr/local/opt/yq@3/bin
fish_add_path /usr/local/opt/openjdk@11/bin
fish_add_path /usr/local/opt/openjdk/bin

# pyenv
if type -q pyenv
	pyenv init - | source
	. ~/.config/fish/auto_source_venv.fish
end


# jenv
if type -q jenv
	set PATH $HOME/.jenv/bin $PATH
	status --is-interactive; and jenv init - | source
end
