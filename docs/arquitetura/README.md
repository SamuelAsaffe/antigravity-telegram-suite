# Arquitetura do Antigravity Telegram Suite

Bem-vindo à documentação da arquitetura do bot Antigravity Telegram Suite. 

Este projeto atua como uma **ponte inteligente** entre o aplicativo Telegram e o agente autônomo Antigravity (IDE ou Standalone). Ele não é o agente de IA em si, mas sim um orquestrador que intercepta, monitora e controla as ações da interface do agente.

## Visão Geral do Sistema

O sistema é construído sobre Node.js e utiliza a biblioteca `telegraf` para se comunicar com a API do Telegram. A grande sacada deste bot é que ele controla a IDE do Antigravity através do **Chrome DevTools Protocol (CDP)**, injetando scripts e extraindo informações diretamente da árvore DOM da janela, agindo como um usuário invisível.

### Componentes Principais

1. **`src/index.js` (Core / Bot Engine)**: 
   - Ponto de entrada do sistema.
   - Gerencia a autenticação dos usuários do Telegram (lista de IDs permitidos).
   - Registra os comandos (ex: `/goal`, `/plan`, `/stop`).
   - Gerencia o fluxo de requisição e resposta (aguardar resposta do agente).

2. **`src/cdp_controller.js` (Controlador CDP)**:
   - Gerencia a conexão WebSocket com a porta de depuração do Chrome/Electron (geralmente porta 9222).
   - Fornece funções para encontrar as janelas do agente, extrair o histórico de chat e injetar mensagens na caixa de texto.
   - Para mais detalhes, veja [Comunicação CDP](comunicacao_cdp.md).

3. **`src/task_watcher.js` (Monitor de Tarefas)**:
   - Serviço executado em segundo plano que vigia os logs do agente no sistema de arquivos (`transcript.jsonl`).
   - Essencial para interceptar mensagens proativas e enviá-las ao Telegram (mesmo as que não foram solicitadas pelo Telegram).
   - Para mais detalhes, veja [Monitoramento de Estado](monitoramento_estado.md).

4. **`src/autoaccept.js` (Auto-Accept Script)**:
   - Um script utilitário injetado na página do agente para clicar automaticamente no botão "Proceed" em determinados fluxos (como o comando `/goal`).

5. **`src/updater.js` & `src/watchdog.js` (Gerenciadores de Ciclo de Vida)**:
   - Lidam com atualizações remotas via GitHub e reinício automático do processo principal (`index.js`) em caso de falhas ou atualizações.

6. **`src/turbo_orchestrator.js` (Orquestrador Turbo)**:
   - Uma camada abstrata para lidar com as filas e repetições de mensagens de forma acelerada, se necessário.

## Fluxo Básico de Uma Mensagem

1. O usuário envia uma mensagem no Telegram.
2. `index.js` intercepta a mensagem e chama o `cdp_controller.js` para enviá-la para a IDE.
3. `cdp_controller.js` envia o texto usando CDP (`Runtime.evaluate`).
4. O bot fica em um loop de repetição (`waitForAgentResponse`), lendo o DOM via CDP para ver se o agente terminou de gerar a resposta.
5. Quando o agente termina, a resposta é extraída e devolvida ao Telegram via `bot.telegram.sendMessage`.
