# Contribuindo com o `gen`

Obrigado pelo interesse! O projeto é deliberadamente minimalista: **um único script Bash** (`gen`), sem dependências externas além do que já vem no macOS. Toda feature nova entra nesse arquivo.

## Princípios do projeto

- **Gera texto → clipboard.** A ferramenta não escreve arquivos nem roda comandos externos por conta própria (ex.: não chama `ssh-keygen`). O tipo `ssh` gera só a passphrase; a criação da chave fica com o usuário.
- **Zero dependências.** Use apenas o que vem no sistema: `bash`, `openssl`, `uuidgen`, `head`, `tr`, `pbcopy`/`pbpaste`.
- **Secret no stdout, mensagens no stderr.** Assim `gen tipo > arquivo` grava só o valor.
- **Sem newline no clipboard.** Sempre `printf '%s'` (nunca `echo`) ao mandar pro `pbcopy`.
- **Charset seguro pra shell.** Tipos destinados a colar em comandos (`pass`, `ssh`) evitam aspas (`'` `"`) e barra (`\`).

## Como adicionar um novo tipo de secret

Todo tipo novo toca **três lugares dentro do `gen`**:

1. **`ajuda()`** — adicione a linha na seção `TIPOS` (e, se fizer sentido, um exemplo em `EXEMPLOS`), alinhando as colunas com os demais. Este é o "menu".
2. **Bloco de tamanho padrão** (`if [[ -z "$TAMANHO" ]]; then case ...`) — só se o tipo precisar de um default diferente de 32.
3. **`case "$TIPO"` principal** — o `case` que efetivamente gera o `SECRET`.

## Testando

```bash
./gen <tipo>          # testa a versão do projeto (não a instalada)
./gen <tipo> <tam>    # varie tamanho, cheque o charset e o comprimento
```

Para validar a instalação global:

```bash
./install.sh
gen <tipo>            # agora usa ~/bin/gen
```

> ⚠️ O comando global `gen` só reflete mudanças **depois de rodar `./install.sh`** — editar o arquivo do projeto não atualiza o `~/bin/gen`.

## Abrindo um PR

- Mantenha o estilo do script (`set -euo pipefail`, cores via variáveis `B C G D R`).
- Descreva o tipo/mudança e cole um exemplo de saída no PR.
- Atualize o `README.md` se adicionou um tipo ou mudou o comportamento visível.
