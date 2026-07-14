#!/bin/bash
# install.sh — instala o comando `gensec` globalmente (macOS e Linux).
# Copia ./gensec para ~/bin, garante permissão de execução e adiciona
# ~/bin ao PATH no rc do shell atual (zsh/bash) caso ainda não esteja lá.
# Uso: ./install.sh
set -euo pipefail

ORIGEM="$(cd "$(dirname "$0")" && pwd)/gensec"
DESTINO="$HOME/bin"
LINHA_PATH='export PATH="$HOME/bin:$PATH"'

# Descobre o arquivo de config do shell atual pra registrar o PATH.
case "${SHELL:-}" in
  *zsh)  RC="$HOME/.zshrc" ;;
  *bash) RC="$HOME/.bashrc" ;;
  *)     RC="$HOME/.profile" ;;
esac

if [[ ! -f "$ORIGEM" ]]; then
  echo "Erro: script 'gensec' não encontrado em $(dirname "$ORIGEM")" >&2
  exit 1
fi

mkdir -p "$DESTINO"
cp "$ORIGEM" "$DESTINO/gensec"
chmod +x "$DESTINO/gensec"
echo "✓ gensec instalado em $DESTINO/gensec"

if grep -qs '\$HOME/bin' "$RC" || echo "$PATH" | tr ':' '\n' | grep -qx "$HOME/bin"; then
  echo "✓ ~/bin já está no PATH"
else
  printf '\n# gen-cli: ~/bin no PATH\n%s\n' "$LINHA_PATH" >> "$RC"
  echo "✓ ~/bin adicionado ao PATH em $RC"
  echo "  Abra um novo terminal ou rode: source $RC"
fi

# No Linux o clipboard depende de um utilitário externo; avisa se faltar.
if ! command -v pbcopy  >/dev/null 2>&1 \
   && ! command -v wl-copy >/dev/null 2>&1 \
   && ! command -v xclip   >/dev/null 2>&1 \
   && ! command -v xsel    >/dev/null 2>&1; then
  echo "⚠ Nenhum utilitário de clipboard encontrado — o gensec vai gerar o secret mas não copiar sozinho."
  echo "  Instale um: sudo apt install xclip   (ou wl-clipboard no Wayland)"
fi

echo "Pronto! Teste com: gensec --help"
