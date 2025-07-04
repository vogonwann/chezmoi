if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end
starship init fish | source

set -Ux GEMINI_API_KEY "my_gemini_api_key"
# Add Go bin to PATH if not already present
if not contains $HOME/go/bin $PATH
    set -Ua PATH $HOME/go/bin
end
