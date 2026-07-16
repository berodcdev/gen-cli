# 🔐 gensec

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![Platform: macOS | Linux](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-black.svg)](#requisitos)
[![Shell: Bash](https://img.shields.io/badge/shell-bash-4EAA25.svg)](#requisitos)

CLI de arquivo único para gerar **secrets criptograficamente seguros** no macOS e no Linux, copiando direto pro clipboard. Sem dependências além do que já vem no sistema.

![Demonstração do gensec gerando secrets e copiando pro clipboard](assets/demo.gif)

## Por que existe

Toda vez que você precisa de um JWT secret, uma senha forte, um token de API ou uma passphrase de chave SSH, acaba caçando um site aleatório ou montando um `openssl rand` de cabeça. O `gensec` resolve isso num comando curto: gera com fonte de entropia segura (`/dev/urandom` / `openssl`), imprime o valor e **já deixa no clipboard**, pronto pra colar.

## Requisitos

- **macOS ou Linux.**
- **Bash**, `openssl`, `uuidgen`, `head`, `tr` — todos já vêm no sistema. **Zero dependências externas** na geração.
- **Clipboard:** detectado automaticamente conforme o sistema.
  - macOS: `pbcopy`/`pbpaste` (já vêm instalados).
  - Linux (Wayland): `wl-clipboard` — `sudo apt install wl-clipboard`.
  - Linux (X11): `xclip` — `sudo apt install xclip` — ou `xsel`.

> Sem nenhum utilitário de clipboard, o `gensec` ainda **gera e imprime** o secret normalmente (útil em pipe/redirect); só não copia automático e avisa qual pacote instalar.

## Instalação

```bash
git clone https://github.com/berodcdev/gen-cli.git
cd gen-cli
./install.sh
```

O `install.sh` copia o `gensec` para `~/bin/gensec`, dá permissão de execução e garante `~/bin` no `PATH` via o rc do seu shell (`~/.zshrc` ou `~/.bashrc`). Abra um novo terminal (ou dê `source` no arquivo) e o comando `gensec` fica disponível globalmente.

Prefere não instalar? Rode direto do diretório: `./gensec`.

## Uso

```
gensec [tipo] [tamanho]
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

O secret vai para o **stdout** e as mensagens de confirmação para o **stderr** — então `gensec hex > arquivo` grava só o valor, sem poluição.

## Exemplos

```bash
gensec                 # 32 bytes em hex (padrão)
gensec b64 48          # JWT secret com 48 bytes em base64
gensec uuid            # UUID v4
gensec alnum 40        # 40 caracteres [A-Za-z0-9], seguro pra URL/env/header
gensec pass 24         # senha forte de 24 caracteres
gensec ssh             # passphrase de 40 caracteres pra chave SSH
gensec hex 16 > .secret   # grava só o secret no arquivo
```

O tipo `ssh` ainda imprime uma dica pronta para criar a chave usando a passphrase que acabou de ir pro clipboard:

```bash
ssh-keygen -t ed25519 -N "$(pbpaste)" -f ~/.ssh/minha-chave
```

Veja o menu completo a qualquer momento com `gensec -h`.

## Aviso de segurança

- O `gensec` **não escreve arquivos nem armazena secrets** por conta própria — ele gera texto, imprime e copia pro clipboard. Nada é persistido pela ferramenta.
- O valor gerado fica no **clipboard** até você copiar outra coisa. Em máquinas compartilhadas, limpe o clipboard depois de usar.
- Redirecionar para arquivo (`gensec hex > .secret`) grava o secret em disco em texto puro — trate esse arquivo com cuidado e nunca o versione (o `.gitignore` já bloqueia `.env`, `*.pem`, `*_rsa`, etc.).
- Os charsets de `pass` e `ssh` **evitam aspas e barra** de propósito, para que o valor possa ser colado dentro de comandos (ex.: `ssh-keygen -N '...'`) sem quebrar o quoting.

## Contribuindo

Contribuições são bem-vindas! Veja o [CONTRIBUTING.md](./CONTRIBUTING.md) para detalhes de como adicionar um novo tipo de secret e testar as mudanças.

## Licença

[MIT](./LICENSE) © 2026 Bernardo Rodrigues · [@berodcdev](https://github.com/berodcdev)
