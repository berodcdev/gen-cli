# Contribuindo com o `gensec`

Obrigado pelo interesse! O projeto é deliberadamente minimalista: **um único script Bash** (`gensec`), sem dependências externas além do que já vem no sistema (macOS e Linux). Toda feature nova entra nesse arquivo.

## Princípios do projeto

- **Gera texto → clipboard.** A ferramenta não escreve arquivos nem roda comandos externos por conta própria (ex.: não chama `ssh-keygen`). O tipo `ssh` gera só a passphrase; a criação da chave fica com o usuário.
- **Zero dependências na geração.** Use apenas o que vem no sistema: `bash`, `openssl`, `uuidgen`, `head`, `tr`. O clipboard é detectado em runtime (`pbcopy` no macOS; `wl-copy`/`xclip`/`xsel` no Linux) e degrada com elegância se nenhum existir.
- **Secret no stdout, mensagens no stderr.** Assim `gensec tipo > arquivo` grava só o valor.
- **Sem newline no clipboard.** Sempre `printf '%s'` (nunca `echo`) ao mandar pro clipboard.
- **Charset seguro pra shell.** Tipos destinados a colar em comandos (`pass`, `ssh`) evitam aspas (`'` `"`) e barra (`\`).

## Como adicionar um novo tipo de secret

Todo tipo novo toca **três lugares dentro do `gensec`**:

1. **`ajuda()`** — adicione a linha na seção `TIPOS` (e, se fizer sentido, um exemplo em `EXEMPLOS`), alinhando as colunas com os demais. Este é o "menu".
2. **Bloco de tamanho padrão** (`if [[ -z "$TAMANHO" ]]; then case ...`) — só se o tipo precisar de um default diferente de 32.
3. **`case "$TIPO"` principal** — o `case` que efetivamente gera o `SECRET`.

## Testando

```bash
./gensec <tipo>          # testa a versão do projeto (não a instalada)
./gensec <tipo> <tam>    # varie tamanho, cheque o charset e o comprimento
```

Para validar a instalação global:

```bash
./install.sh
gensec <tipo>            # agora usa ~/bin/gensec
```

> ⚠️ O comando global `gensec` só reflete mudanças **depois de rodar `./install.sh`** — editar o arquivo do projeto não atualiza o `~/bin/gensec`.

## Abrindo um PR

- Mantenha o estilo do script (`set -euo pipefail`, cores via variáveis `B C G D R`).
- Descreva o tipo/mudança e cole um exemplo de saída no PR.
- Atualize o `README.md` se adicionou um tipo ou mudou o comportamento visível.
