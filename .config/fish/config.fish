fish_add_path /usr/local/sbin
fish_add_path /usr/local/opt/yq@3/bin
fish_add_path /usr/local/opt/openjdk@11/bin
fish_add_path /usr/local/opt/openjdk/bin
fish_add_path ~/.local/bin
fish_add_path $HOME/.jenv/bin 
fish_add_path /opt/homebrew/bin

if status --is-interactive
	set -gx COLORTERM truecolor
	set -gx EDITOR nvim --clean
	set -gx HOMEBREW_AUTO_UPDATE_SECS 86400
	set -gx BAT_THEME "Catppuccin-macchiato"
	set -g fish_key_bindings fish_vi_key_bindings
	set -g fish_bind_mode insert
	set fish_greeting
	fzf_configure_bindings --directory=\cf
	
	fish_config theme choose "Catppuccin Macchiato"
	
	zoxide init fish | source
	direnv hook fish | source

	if not set -q TMUX
    set -g TMUX tmux new-session -d -s personal
    eval $TMUX
    tmux attach-session -d -t personal
	end

	source ~/.asdf/asdf.fish
end
