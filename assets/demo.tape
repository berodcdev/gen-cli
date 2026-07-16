# VHS tape — gera o GIF de demonstração.
# Requer: vhs (https://github.com/charmbracelet/vhs). Rode:  vhs assets/demo.tape
# Prefira um modo/dados fictícios (--demo, --help, etc.) para não expor dados reais.

Output assets/demo.gif

Set Shell "bash"
Set FontSize 15
Set Width 1240
Set Height 650
Set Padding 24
Set TypingSpeed 55ms
Set Theme { "name": "alive-matrix", "background": "#0a0d0a", "foreground": "#c8e6c9", "black": "#0a0d0a", "red": "#ff5f5f", "green": "#39ff14", "yellow": "#f4f465", "blue": "#5fafff", "magenta": "#d787ff", "cyan": "#5fffd7", "white": "#e8f5e9", "brightBlack": "#5c6d5c", "brightRed": "#ff8787", "brightGreen": "#8bff6b", "brightYellow": "#ffff87", "brightBlue": "#87d7ff", "brightMagenta": "#ffafff", "brightCyan": "#afffff", "brightWhite": "#ffffff", "cursor": "#39ff14", "selection": "#1f3d1f" }

# Prepara o ambiente sem aparecer no GIF: garante `gensec` no PATH e um prompt verde limpo.
Hide
Type `export PATH="$HOME/bin:$PATH"; PS1=$'\e[92m❯\e[0m '; clear`
Enter
Show

Sleep 800ms
Type "gensec"                # hex, 32 bytes (padrão)
Sleep 500ms
Enter
Sleep 1800ms

Type "gensec b64 48"         # base64, ótimo p/ JWT secret
Sleep 500ms
Enter
Sleep 1800ms

Type "gensec uuid"           # UUID v4
Sleep 500ms
Enter
Sleep 1800ms

Type "gensec pass 24"        # senha forte com símbolos
Sleep 500ms
Enter
Sleep 1800ms

Type "gensec ssh"            # passphrase pra chave SSH
Sleep 500ms
Enter
Sleep 2500ms

Type "# gerado com entropia segura, já no clipboard ;)"
Sleep 2500ms
