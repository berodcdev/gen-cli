#!/bin/bash
# install.sh — instala o comando `gen` globalmente.
# Copia ./gen para ~/bin, garante permissão de execução e adiciona
# ~/bin ao PATH no ~/.zshrc caso ainda não esteja lá.
# Uso: ./install.sh
set -euo pipefail

ORIGEM="$(cd "$(dirname "$0")" && pwd)/gen"
DESTINO="$HOME/bin"
ZSHRC="$HOME/.zshrc"
LINHA_PATH='export PATH="$HOME/bin:$PATH"'

if [[ ! -f "$ORIGEM" ]]; then
  echo "Erro: script 'gen' não encontrado em $(dirname "$ORIGEM")" >&2
  exit 1
fi

mkdir -p "$DESTINO"
cp "$ORIGEM" "$DESTINO/gen"
chmod +x "$DESTINO/gen"
echo "✓ gen instalado em $DESTINO/gen"

if grep -qs '\$HOME/bin' "$ZSHRC" || echo "$PATH" | tr ':' '\n' | grep -qx "$HOME/bin"; then
  echo "✓ ~/bin já está no PATH"
else
  printf '\n# gen-cli: ~/bin no PATH\n%s\n' "$LINHA_PATH" >> "$ZSHRC"
  echo "✓ ~/bin adicionado ao PATH em $ZSHRC"
  echo "  Abra um novo terminal ou rode: source ~/.zshrc"
fi

echo "Pronto! Teste com: gen --help"
