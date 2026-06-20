# Monitoramento de Estado (Task Watcher)

O arquivo `src/task_watcher.js` resolve um dos maiores desafios do bot: **Sincronismo de Conversas Paralelas**.

## O Problema Original
O bot iniciou com um design puramente reativo (Request-Response): o usuário enviava algo pelo Telegram, e o bot aguardava a reposta da IDE (via CDP).
O problema disso é que:
1. O agente de IA do Antigravity pode enviar notificações proativas (ex: concluir uma subtarefa longa) horas após a última solicitação.
2. O usuário pode iniciar uma interação diretamente na interface do PC.
Nesses casos, o Telegram ficava "mudo", pois o bot não estava em seu loop ativo de `waitForAgentResponse`.

## A Solução (TaskWatcher)

O `TaskWatcher` funciona desacoplado do CDP. Em vez de injetar código na interface para escutar, ele observa nativamente o sistema de arquivos.
O Antigravity guarda todas as interações no formato JSON-Lines no caminho:
`~/.gemini/antigravity-ide/brain/<ID_CONVERSA>/.system_generated/logs/transcript.jsonl`

### Arquitetura do Watcher

1. **Auto-Descoberta**: Através de polling (`setInterval` a cada 5 segundos), o `TaskWatcher` descobre qual o ID da conversa mais recentemente modificada.
2. **FS Watch (Tail-Follow)**: Uma vez fixado na conversa, ele usa o evento `fs.watch` nativo do Node.js para receber avisos do SO quando o arquivo cresce.
3. **Leitura Parcial**: Ele rastreia o tamanho anterior (`lastSize`) do arquivo e lê apenas os bytes novos (`newBytes`).
4. **Debounce**: Para evitar "metralhar" o servidor, agrupa os eventos rápidos em blocos a cada 5 segundos.
5. **Parse JSONL**: Analisa os logs e procura as mensagens marcadas como `"type": "PLANNER_RESPONSE"`.
6. **Emissão (`onNotification`)**: Envia o conteúdo do agente para os chats autorizados do Telegram.

Desta forma, o bot garante um **espelhamento total** (Mirroring) do que está acontecendo na IDE para a tela do celular do usuário.
