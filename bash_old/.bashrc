export BAT_THEME=ansi

# ----------- FZF -----------

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
export FZF_COMPLETION_TRIGGER='~~'

# Use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --no-ignore --hidden --strip-cwd-prefix"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --no-ignore --hidden --strip-cwd-prefix"

# Setup the fzf-git
# Navigate to your home directory: "cd"
# Clone the repository: "git clone https://github.com/junegunn/fzf-git.sh.git"
source ~/.config/fzf-git.sh/fzf-git.sh

# Setup the fzf theme
fg="#CBE0F0"
bg="-1"
bg_highlight="-1"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# Setup fzf previews with eza and bat

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :100000 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# ----------- END -----------
