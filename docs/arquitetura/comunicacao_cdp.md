# Comunicação via CDP (Chrome DevTools Protocol)

A principal interface de comunicação entre este bot e a IDE Antigravity é construída sobre o **Chrome DevTools Protocol (CDP)**, gerenciada pelo arquivo `src/cdp_controller.js`.

## Por que usar CDP?

A IDE Antigravity original foi projetada como uma interface gráfica independente baseada em web/Electron, que não possui uma API REST nativa para interação externa. Em vez de modificar o código fonte da IDE (o que dificultaria atualizações), o bot "se acopla" à porta de depuração (debug port) que o Electron/Chrome expõe nativamente.

## Como funciona?

1. **Descoberta**: O `cdp_controller.js` consulta o endpoint `http://127.0.0.1:<PORT>/json/list` para descobrir quais instâncias (Targets) estão rodando no momento.
2. **Conexão WebSocket**: Ele estabelece uma conexão WebSocket (`ws://`) diretamente na aba do agente ativo.
3. **Injeção de Scripts (`Runtime.evaluate`)**: A função central usada é a avaliação de código JavaScript no contexto da página da IDE.
   
### Exemplo de Fluxo (Enviar Mensagem)
Quando o usuário manda uma mensagem via Telegram, o bot executa um script na página da IDE que:
1. Localiza a caixa de texto (`<textarea>`).
2. Altera o valor (`.value`) e dispara eventos de `input`.
3. Localiza o botão de envio (`<button>`) e dispara um `.click()`.

### Extração do Chat
Para capturar as respostas do modelo, o bot faz polling contínuo via CDP. Ele procura elementos no DOM com a classe `markdown-body` ou similar, e extrai o `innerText` para montar a conversa que será repassada ao Telegram.

## Múltiplas Abas/Workspaces
A IDE suporta múltiplas conversas ou "workspaces". O CDP permite que o bot interaja apenas com a aba "Ativa" (Active Thread). Isso é resolvido rastreando a URL e o título de cada alvo CDP retornado pelo navegador.
