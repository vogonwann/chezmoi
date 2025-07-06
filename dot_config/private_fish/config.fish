if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end
starship init fish | source

set -Ux GEMINI_API_KEY "AIzaSyAlUrkGpsTvqT9GQ8OteDYg4b1DLuY8DWM"
# Add Go bin to PATH if not already present
if not contains $HOME/go/bin $PATH
    set -Ua PATH $HOME/go/bin
end
