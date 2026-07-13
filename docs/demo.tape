# demo.tape — script de gravação do GIF do README (ferramenta: charmbracelet/vhs)
# Regenerar:  vhs docs/demo.tape   (requer: vhs, ttyd, ffmpeg via Homebrew)

Output docs/demo.gif

Set Shell zsh
Set FontSize 20
Set Width 1100
Set Height 780
Set Padding 24
Set Theme "Catppuccin Mocha"
Set TypingSpeed 60ms

# Setup invisível: garante `gen` no PATH e prompt limpo
Hide
Type `export PATH="$HOME/bin:$PATH"; PROMPT='%F{6}❯%f '; clear`
Enter
Show

Sleep 800ms

Type "gen"
Sleep 500ms
Enter
Sleep 2s

Type "gen b64 48"
Sleep 500ms
Enter
Sleep 2s

Type "gen uuid"
Sleep 500ms
Enter
Sleep 2s

Type "gen pass 24"
Sleep 500ms
Enter
Sleep 2s

Type "gen ssh"
Sleep 500ms
Enter
Sleep 2500ms

Type "gen -h"
Sleep 500ms
Enter
Sleep 4s
