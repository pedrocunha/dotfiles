autoload colors && colors

git_prompt() {
  # Get current branch name, exit if not in a git repo
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  [[ -z "$branch" ]] && return

  # Check if working tree is dirty (uncommitted changes)
  local dirty=$(git status --porcelain 2>/dev/null)

  # Green = clean, Red = dirty
  local color="green"
  [[ -n "$dirty" ]] && color="red"

  # Check for commits not yet pushed
  local unpushed=$(git cherry -v @{upstream} 2>/dev/null)

  # Build the prompt segment
  local result="%{$fg_bold[$color]%}$branch%{$reset_color%}"
  [[ -n "$unpushed" ]] && result="$result %{$fg_bold[yellow]%}unpushed%{$reset_color%}"

  echo "($result)"
}

# Prompt: "dirname(branch unpushed) "
#   - cyan directory name
#   - green/red branch (clean/dirty)
#   - yellow "unpushed" if commits not pushed
export PROMPT=$'%{$fg_bold[cyan]%}%1/%{$reset_color%}$(git_prompt) '

# Set window title before each command
precmd() {
  title "zsh" "%m" "%55<...<%~"
}
