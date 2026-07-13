# 🔐 gen

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![Platform: macOS](https://img.shields.io/badge/platform-macOS-black.svg)](#requisitos)
[![Shell: Bash](https://img.shields.io/badge/shell-bash-4EAA25.svg)](#requisitos)

CLI de arquivo único para gerar **secrets criptograficamente seguros** no macOS e copiar direto pro clipboard. Sem dependências além do que já vem no sistema.

![Demonstração do gen gerando secrets e copiando pro clipboard](docs/demo.gif)

## Por que existe

Toda vez que você precisa de um JWT secret, uma senha forte, um token de API ou uma passphrase de chave SSH, acaba caçando um site aleatório ou montando um `openssl rand` de cabeça. O `gen` resolve isso num comando curto: gera com fonte de entropia segura (`/dev/urandom` / `openssl`), imprime o valor e **já deixa no clipboard**, pronto pra colar.

## Requisitos

- **macOS** — usa `pbcopy`/`pbpaste` para o clipboard.
- **Bash**, `openssl`, `uuidgen`, `head`, `tr` — todos já vêm no sistema. **Zero dependências externas.**

> Em Linux funcionaria a lógica de geração, mas o clipboard depende de `pbcopy`. Um port exigiria fallback para `xclip`/`wl-copy`.

## Instalação

```bash
git clone https://github.com/berodcdev/gen-cli.git
cd gen-cli
./install.sh
```

O `install.sh` copia o `gen` para `~/bin/gen`, dá permissão de execução e garante `~/bin` no `PATH` via `~/.zshrc`. Abra um novo terminal (ou `source ~/.zshrc`) e o comando `gen` fica disponível globalmente.

Prefere não instalar? Rode direto do diretório: `./gen`.

## Uso

```
gen [tipo] [tamanho]
```

| tipo    | o que gera                          | charset / formato            | tamanho padrão |
|---------|-------------------------------------|------------------------------|----------------|
| `hex`   | bytes aleatórios em hexadecimal     | hexadecimal                  | 32 bytes       |
| `b64`   | bytes aleatórios em base64          | base64 (bom pra JWT secret)  | 32 bytes       |
| `uuid`  | UUID v4 em minúsculas               | UUID v4                      | ignora tamanho |
| `alnum` | letras e números                    | `A-Za-z0-9`                  | 32 caracteres  |
| `pass`  | senha forte                         | letras, números e símbolos   | 32 caracteres  |
| `ssh`   | passphrase para chave SSH           | seguro pra shell             | 40 caracteres  |

> **Unidades:** `hex` e `b64` recebem o tamanho em **bytes** (a saída final tem mais caracteres); `alnum`, `pass` e `ssh` contam **caracteres** do resultado final.

O secret vai para o **stdout** e as mensagens de confirmação para o **stderr** — então `gen hex > arquivo` grava só o valor, sem poluição.

## Exemplos

```bash
gen                 # 32 bytes em hex (padrão)
gen b64 48          # JWT secret com 48 bytes em base64
gen uuid            # UUID v4
gen alnum 40        # 40 caracteres [A-Za-z0-9], seguro pra URL/env/header
gen pass 24         # senha forte de 24 caracteres
gen ssh             # passphrase de 40 caracteres pra chave SSH
gen hex 16 > .secret   # grava só o secret no arquivo
```

O tipo `ssh` ainda imprime uma dica pronta para criar a chave usando a passphrase que acabou de ir pro clipboard:

```bash
ssh-keygen -t ed25519 -N "$(pbpaste)" -f ~/.ssh/minha-chave
```

Veja o menu completo a qualquer momento com `gen -h`.

## Aviso de segurança

- O `gen` **não escreve arquivos nem armazena secrets** por conta própria — ele gera texto, imprime e copia pro clipboard. Nada é persistido pela ferramenta.
- O valor gerado fica no **clipboard** até você copiar outra coisa. Em máquinas compartilhadas, limpe o clipboard depois de usar.
- Redirecionar para arquivo (`gen hex > .secret`) grava o secret em disco em texto puro — trate esse arquivo com cuidado e nunca o versione (o `.gitignore` já bloqueia `.env`, `*.pem`, `*_rsa`, etc.).
- Os charsets de `pass` e `ssh` **evitam aspas e barra** de propósito, para que o valor possa ser colado dentro de comandos (ex.: `ssh-keygen -N '...'`) sem quebrar o quoting.

## Contribuindo

Contribuições são bem-vindas! Veja o [CONTRIBUTING.md](./CONTRIBUTING.md) para detalhes de como adicionar um novo tipo de secret e testar as mudanças.

## Licença

[MIT](./LICENSE) © 2026 Bernardo Rodrigues · [@berodcdev](https://github.com/berodcdev)
