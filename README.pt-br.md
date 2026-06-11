<div align="center">

# 🤖 Antigravity Telegram Suite

**Funciona tanto com o [Antigravity Standalone App](https://antigravity.google/)\* quanto com o [Antigravity IDE](https://antigravity.google/).**

🌍 Idiomas: [English](README.md) | [Türkçe](README.tr.md) | [Deutsch](README.de.md) | [Español](README.es.md) | [Français](README.fr.md) | [Português](README.pt-br.md)

Controle seu agente de IA Antigravity remotamente via Telegram.
Envie mensagens, troque modelos de IA, gerencie workspaces, tire capturas de tela e execute fluxos de trabalho com múltiplos agentes — tudo pelo seu celular.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Node.js](https://img.shields.io/badge/Node.js-%3E%3D18-green.svg)](https://nodejs.org)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20Windows-lightgrey.svg)]()
[![Version](https://img.shields.io/badge/Version-3.4.0-orange.svg)]()

\* *Algumas funcionalidades podem ter limitações no Standalone App. Veja [Problemas Conhecidos](#-problemas-conhecidos).*

</div>

---

## ✨ Funcionalidades

| Funcionalidade | Descrição |
|---|---|
| 💬 **Chat Headless** | Envie mensagens diretamente para o agente de IA via Telegram |
| 📎 **Upload de Arquivos & Imagens** | Envie arquivos/imagens para o agente com legendas |
| 📸 **Capturas de Tela do IDE** | Capture e receba screenshots remotamente |
| 🤖 **Troca de Modelos** | Altere os modelos de IA (Gemini, Claude, GPT) com botões inline |
| 📂 **Explorador de Arquivos** | Navegue e baixe arquivos do projeto |
| 🔄 **Gerenciamento de Workspaces** | Alterne entre projetos sem tocar no teclado |
| 🪟 **Suporte a Múltiplas Janelas** | Direcione comandos para uma janela específica do IDE quando houver várias abertas |
| 👥 **Multiusuário** | Compartilhe o controle do bot com sua equipe via Chat IDs separados por vírgula |
| 💬 **Gerenciamento de Threads** | Liste, alterne e gerencie threads de chat (conversas do agente) |
| ⚡ **Aceitação Automática (Auto-Accept)** | Clique automaticamente em botões como Run, Accept, Allow, Continue via um MutationObserver do DOM |
| 🚀 **Modo Turbo** | Orquestração com múltiplos agentes: Claude planeja → Gemini programa → Claude revisa → Gemini corrige |
| 🎯 **Modo Objetivo (Goal Mode)** | Tarefas autônomas de longa duração — o agente trabalha até o objetivo ser totalmente alcançado |
| 📋 **Modo Plano (Plan Mode)** | Gere planos de implementação antes de programar |
| 🔔 **Notificações Proativas** | TaskWatcher detecta mensagens não solicitadas do agente (timers, subagentes) e encaminha para o Telegram |
| 🤔 **Reações às Mensagens** | Mostra 🤔 durante o processamento, apaga quando concluído |
| 🔄 **Atualização Automática** | Verifique atualizações e auto-atualize com apenas um comando |
| 🌐 **Multilíngue** | Suporte a 6 idiomas: Inglês, Turco, Alemão, Espanhol, Francês, Português |
| ⌨️ **Indicador de Digitação** | Mostra "digitando..." no Telegram enquanto o agente está trabalhando |
| 🖥️ **Multiplataforma** | Funciona no Linux, macOS (Intel & Apple Silicon) e Windows |
| 🔀 **Suporte a Dual App** | Alterne de forma transparente entre o Antigravity IDE e o Standalone Agent App |

---

## 🚀 Início Rápido

### Pré-requisitos

- [Node.js](https://nodejs.org/) >= 18
- [Antigravity IDE](https://antigravity.google/) e/ou [Antigravity Standalone App](https://antigravity.google/) instalados
- Um token de bot do Telegram (obtenha um no [@BotFather](https://t.me/BotFather))

### 1. Clonar & Instalar

```bash
git clone https://github.com/emreturkmencom/antigravity-telegram-suite.git
cd antigravity-telegram-suite
npm install
```

### 2. Configuração

```bash
cp .env.example .env
```

Edite o `.env` com seus dados:

```env
# Telegram
BOT_TOKEN=seu_token_do_bot_telegram
ALLOWED_CHAT_ID=seu_chat_id,outro_chat_id_opcional

# CDP Debugging Ports (deve coincidir com o --remote-debugging-port usado ao iniciar)
AGENT_CDP_PORT=9333    # Porta para o Standalone Antigravity App
IDE_CDP_PORT=9334      # Porta para o Antigravity IDE

# Modelo de IA padrão ao iniciar novo chat
DEFAULT_MODEL=Gemini 3.1 Pro (High)

# Idioma: en | tr | de | es | fr | pt-br
LANGUAGE=pt-br

# App alvo preferido: 'agent' (Standalone) ou 'ide' (IDE)
ANTIGRAVITY_PREFERRED_APP=ide

# Habilitar auto-accept por padrão
AUTOACCEPT_DEFAULT=true
```

> 💡 Envie `/start` para o seu bot para obter o seu Chat ID.

### 3. Iniciar o App com CDP

O bot se comunica com o Antigravity via Chrome DevTools Protocol (CDP). Você deve iniciar o app com a porta de depuração habilitada.

**Se for rodar os dois aplicativos lado a lado, use portas diferentes:**

```bash
# --- Standalone Antigravity App ---
# Linux
antigravity --remote-debugging-port=9333

# macOS
open -a Antigravity --args --remote-debugging-port=9333

# Windows
Antigravity.exe --remote-debugging-port=9333
```

```bash
# --- Antigravity IDE ---
# Linux
antigravity-ide --remote-debugging-port=9334

# macOS
open -a "Antigravity IDE" --args --remote-debugging-port=9334

# Windows
"Antigravity IDE.exe" --remote-debugging-port=9334
```

> ⚠️ Os números das portas devem corresponder a `AGENT_CDP_PORT` e `IDE_CDP_PORT` no seu arquivo `.env`.

### 4. Iniciar o Bot

```bash
npm start
```

Para funcionamento 24/7 com PM2:

```bash
npm install -g pm2
pm2 start src/index.js --name antigravity-bot
pm2 save
pm2 startup
```

### Instalação Automatizada (Opcional)

```bash
# Linux & macOS
bash scripts/install.sh

# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File scripts\install.ps1
```

---

## 📱 Comandos

### Comandos Principais

| Comando | Descrição |
|---|---|
| *(qualquer texto)* | Enviar mensagem diretamente para o agente |
| `/latest` | Obter a última resposta do agente em texto |
| `/screenshot` | Tirar screenshot da janela ativa do agente |
| `/status` | Mostrar status do sistema (IDE, CDP, Bot) |
| `/stop` | Parar o agente atualmente em execução |
| `/new` | Abrir nova sessão de chat |

### Modelos de IA & Agente

| Comando | Descrição |
|---|---|
| `/model` | Trocar o modelo de IA (Gemini, Claude, etc.) |
| `/turbo` | Alternar para o **Modo Turbo** — orquestração com múltiplos agentes (veja abaixo) |
| `/goal <tarefa>` | Iniciar **Modo Objetivo** — agente trabalha sozinho até terminar |
| `/plan <tarefa>` | Gerar um **plano de implementação** antes de codar |
| `/schedule_task <tarefa>` | Agendar tarefa recorrente ou única no IDE |
| `/agents` | Listar e alternar entre as threads de chat |
| `/quota` | Verificar créditos e limites de uso de IA |

### Gerenciamento de Janelas e App

| Comando | Descrição |
|---|---|
| `/start_ide` | Iniciar o Antigravity IDE remotamente |
| `/start_ag` | Iniciar o Standalone Antigravity Agent App remotamente |
| `/close_ide` | Fechar o Antigravity IDE |
| `/close_ag` | Fechar o Standalone Agent App |
| `/close` | Fechar o aplicativo atualmente ativo |
| `/app` | Alternar entre IDE e Standalone Agent (`ANTIGRAVITY_PREFERRED_APP`) |
| `/window` | Escolher uma janela específica quando houver várias abertas |
| `/workspace` | Mudar de workspace/projeto |
| `/restart` | Reiniciar o processo do bot (PM2) |

### Arquivos & Utilidades

| Comando | Descrição |
|---|---|
| `/file` | Navegar e baixar arquivos do projeto |
| `/artifacts` | Listar e baixar artefatos da thread atual |
| `/autoaccept` | Alternar auto-accept (ligar / desligar / status) |
| `/lang` | Trocar o idioma |
| `/update` | Verificar atualizações, changelog e atualizar o bot |
| `/version` | Mostrar informações da versão |
| `/menu` | Atualizar o menu de comandos do Telegram |
| `/fix_shortcuts` | Corrigir atalhos da área de trabalho do Antigravity |

---

## 🚀 Modo Turbo (Orquestração Multi-Agente)

O Modo Turbo usa um fluxo de trabalho em estilo **Conselho de Agentes** que coordena múltiplos modelos de IA automaticamente:

```
┌─────────────────────────────────────────────────────────────────────┐
│                       PIPELINE DO MODO TURBO                        │
│                                                                     │
│  Fase 1: PLANEJAMENTO    Claude Opus → Cria plano de implementação  │
│  Fase 2: CÓDIGO          Gemini Pro  → Escreve o código             │
│  Fase 3: REVISÃO         Claude Opus → Revisão de segurança e código│
│  Fase 4: CORREÇÃO        Gemini Pro  → Corrige possíveis problemas  │
│  Fase 5: RESUMO          Gemini Pro  → Resumo final para o usuário  │
└─────────────────────────────────────────────────────────────────────┘
```

**Como usar:**
1. Ative o Modo Turbo: `/turbo` → Selecione "Enable"
2. Envie sua solicitação como texto normal
3. O bot alternará os modelos automaticamente e passará por todas as fases
4. Você receberá atualizações em tempo real das fases e um resumo final

> 💡 O Modo Turbo requer acesso aos modelos Claude e Gemini na sua assinatura Antigravity.

---

## 🎯 Modo Objetivo vs 🚀 Modo Turbo

| | Modo Objetivo (`/goal`) | Modo Turbo (`/turbo`) |
|---|---|---|
| **Como funciona** | Agente trabalha sozinho de uma vez até terminar a tarefa | O bot orquestra uma pipeline com múltiplos modelos por fora |
| **Modelos usados** | O modelo que estiver selecionado no momento | Claude (plano/revisão) + Gemini (código/correção) |
| **Vantagem Principal** | Simples, confiável, funcionalidade nativa do IDE | Colaboração entre modelos: revisão cruzada para menos erros |
| **Consumo de Tokens** | Única janela de contexto (eficiente) | Múltiplas conversas (mais tokens) |
| **Progresso** | Reação 🤔 → resultado final | Mensagem fixada no chat com updates em tempo real |
| **Melhor para** | Tarefas longas com um único modelo | Tarefas complexas que requerem revisão cruzada |
| **Arquitetura** | Nativa do IDE (comando barra `/goal`) | Orquestração externa via CDP + `turbo_orchestrator.js` |

**Quando usar qual:**
- **Tarefa longa e simples** (ex: "refatore este módulo") → `/goal` 
- **Tarefa complexa que precise de revisão** (ex: "crie essa feature de backend com foco em segurança") → `/turbo`
- **Apenas Planejamento** → `/plan` (gera o plano para depois você decidir)

---

## 🏗️ Arquitetura

```
antigravity-telegram-suite/
├── src/
│   ├── index.js              # Lógica principal do bot & Comandos do Telegram
│   ├── cdp_controller.js     # Comunicação via Chrome DevTools Protocol
│   ├── autoaccept.js         # Clicker automático via CDP MutationObserver
│   ├── turbo_orchestrator.js # Orquestração do Modo Turbo Multi-Agente
│   ├── task_watcher.js       # Notificações proativas (monitor de transcript.jsonl)
│   ├── updater.js            # Módulo de auto-update (git pull + pm2 restart)
│   ├── ui_locators.js        # Localizadores de elementos do DOM do IDE
│   ├── i18n.js               # Módulo de internacionalização
│   └── platform.js           # Abstração de SO (lançamento, fechamento, caminhos)
├── locales/
│   ├── en.json               # Inglês
│   ├── tr.json               # Turco
│   ├── de.json               # Alemão
│   ├── es.json               # Espanhol
│   ├── fr.json               # Francês
│   └── pt-br.json            # Português
├── scripts/
│   ├── install.sh            # Instalador Linux/macOS
│   └── install.ps1           # Instalador Windows
├── .env.example              # Template de variáveis de ambiente
├── CHANGELOG.md              # Histórico de versões
└── package.json
```

### Como Funciona

```
┌──────────┐     API do Telegram  ┌──────────────┐     CDP (WebSocket)     ┌─────────────────┐
│ Telegram │ ◄──────────────────► │  Bot         │ ◄────────────────────► │ Antigravity IDE  │
│   App    │  Comandos do Bot     │ Antigravity  │    Interação no DOM    │       ou         │
└──────────┘                      └──────────────┘                        │ Standalone Agent │
                                                                          └─────────────────┘
```

1. Você envia uma mensagem no Telegram
2. O bot injeta seu texto no chat do Agente IA através de CDP
3. O bot monitora a finalização da tarefa (mostrando "digitando..." no Telegram)
4. Ao concluir, a resposta é extraída e enviada de volta ao Telegram
5. **Auto-Accept**: Quando ativado, um MutationObserver monitora e clica em botões de confirmação (Run, Accept, Allow) automaticamente

### Arquitetura Dual App

O bot suporta **dois aplicativos Antigravity** ao mesmo tempo:

| Aplicativo | Porta Padrão | Variável `.env` | Descrição |
|-----|-------------|------------|-------------|
| **Standalone Agent** | `9333` | `AGENT_CDP_PORT` | App Antigravity leve focado no chat |
| **Antigravity IDE** | `9334` | `IDE_CDP_PORT` | IDE completo com editor, terminal e extensões |

Use `/app` para trocar o foco do bot entre os apps. A variável `ANTIGRAVITY_PREFERRED_APP` no `.env` determina qual app será o padrão.

---

## 🌐 Adicionando um Idioma

1. Copie `locales/en.json` para `locales/xx.json`
2. Traduza todas as chaves
3. Configure `LANGUAGE=xx` no seu `.env`

---

## ⚠️ Problemas Conhecidos

| Problema | Detalhes |
|-------|---------|
| **Limitações do Standalone App** | Algumas funcionalidades (troca de workspace, etc.) podem não funcionar bem no Standalone App. **Antigravity IDE é suportado e recomendado.** |
| **Auto-Update no IDE 2.0** | Se o IDE atualizar, elementos DOM podem quebrar até o bot ser atualizado também. |
| **Acesso ao Modo Turbo** | O modo Turbo requer Claude e Gemini disponíveis. Se um não estiver, o pipeline irá falhar. |

> 💡 Como desenvolvedor, foco no suporte para o IDE. A integração com o app Standalone funciona na base do "melhor esforço".

---

## 🤝 Contribuindo

1. Faça um Fork do repositório
2. Crie uma branch de feature (`git checkout -b feature/minha-ideia`)
3. Faça commits com as mudanças (`git commit -m 'Adiciona funcionalidade top'`)
4. Faça push para a branch (`git push origin feature/minha-ideia`)
5. Abra um Pull Request

---

## 🙏 Agradecimentos

- **[ATX-AI-Dev](https://github.com/ATX-AI-Dev)** — PR #8: Suporte ao Standalone, Watchdog, modelos dinâmicos
- **[yvg](https://github.com/yvg/antigravity-telegram-suite)** — Suporte Multi-Window
- **[achshar](https://github.com/achshar/antigravity-telegram-suite)** — Seletores de UI para threads
- **[mine260309](https://github.com/mine260309)** — Internacionalização (i18n)
- **[acmavirus/antigravity-telegram-control](https://github.com/acmavirus/antigravity-telegram-control)** — Projeto open-source que serviu como base original
- **[yazanbaker94/AntiGravity-AutoAccept](https://github.com/yazanbaker94/AntiGravity-AutoAccept)** — Padrão DOM observer que inspirou o Auto-Accept

## 🌟 Créditos & Inspirações

O modo de orquestração **Turbo Mode** foi inspirado pelo repositório [Agents-Council](https://github.com/interdesigncorp-lab/Agents-Council) da Interdesigncorp Lab.

---

## 📄 Licença

Este projeto é licenciado nos termos da Licença MIT — veja o arquivo [LICENSE](LICENSE) para detalhes.

---

<div align="center">
Feito com ❤️ por <a href="https://emreturkmen.com">Emre Türkmen</a> para programadores que codam direto do sofá.

**Ei Google, se quiser me dar um emprego, só chamar em [hello@emreturkmen.com](mailto:hello@emreturkmen.com) 😂**
</div>
