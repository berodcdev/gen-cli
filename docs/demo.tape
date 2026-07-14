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

# Setup invisível: garante `gensec` no PATH e prompt limpo
Hide
Type `export PATH="$HOME/bin:$PATH"; PROMPT='%F{6}❯%f '; clear`
Enter
Show

Sleep 800ms

Type "gensec"
Sleep 500ms
Enter
Sleep 2s

Type "gensec b64 48"
Sleep 500ms
Enter
Sleep 2s

Type "gensec uuid"
Sleep 500ms
Enter
Sleep 2s

Type "gensec pass 24"
Sleep 500ms
Enter
Sleep 2s

Type "gensec ssh"
Sleep 500ms
Enter
Sleep 2500ms

Type "gensec -h"
Sleep 500ms
Enter
Sleep 4s
