#	Chat API Client

Este é um script Bash que funciona como um cliente para consumir uma API de chat hospedada em um servidor. O script permite enviar mensagens para a API, exibir as respostas formatadas e manter um histórico das mensagens enviadas e recebidas. Ele tenta conectar-se a uma das portas disponíveis (5013, 5014 ou 5015) para garantir redundância caso uma porta esteja indisponível.
A interface é simples e interativa, semelhante à do Ollama, onde o usuário digita mensagens no formato Prompt >>> e recebe respostas da API com quebras de linha para melhor legibilidade. O script também exibe um logotipo ASCII ao ser iniciado.
Funcionalidades

Envio de mensagens: Envia mensagens para a API via requisições POST.
Histórico: Armazena mensagens enviadas e respostas recebidas, enviando o histórico em cada nova requisição.
Redundância: Tenta conectar-se às portas 5013, 5014 e 5015, usando a primeira que responder com sucesso.
Interface amigável: Exibe um prompt interativo e respostas formatadas com quebras de linha.


## Pré-requisitos

Bash: O script deve ser executado em um ambiente com Bash (Linux, macOS ou WSL no Windows).
curl: Necessário para fazer requisições HTTP.
jq: Utilizado para processar e formatar JSON.

Instale os pré-requisitos em sistemas baseados em Debian/Ubuntu com:
`sudo apt update`
`sudo apt install curl jq`

arch:
`sudo pacman -Sy`
`sudo pacman -S curl jq`

## Como usar

Clone o repositório ou baixe o script gemini.sh.
Dê permissão de execução:chmod +x gemini.sh


Execute o script:`./gemini.sh`


Digite sua mensagem no prompt Prompt >>> e pressione Enter.
Para sair, digite exit.

Exemplo de uso
```
$ ./gemini.sh
:'######:::'########:'##::::'##:'####:'##::: ##:'####:
'##... ##:: ##.....:: ###::'###:. ##:: ###:: ##:. ##::
 ##:::..::: ##::::::: ####'####:: ##:: ####: ##:: ##::
 ##::'####: ######::: ## ### ##:: ##:: ## ## ##:: ##::
 ##::: ##:: ##...:::: ##. #: ##:: ##:: ##. ####:: ##::
 ##::: ##:: ##::::::: ##:.:: ##:: ##:: ##:. ###:: ##::
. ######::: ########: ##:::: ##:'####: ##::. ##:'####:
:......::::........::..:::::..::....::..::::..::....::

Welcome to the chat interface! Type 'exit' to quit.
Prompt >>> oie, tudo bem?

Oi! Tudo ótimo por aqui! 😊
E com você, tudo bem? Como posso te ajudar hoje?

Prompt >>> exit
Goodbye!
```

## Limitações:

O script depende da disponibilidade do servidor da API (http://177.104.86.234).
Não há tratamento avançado de erros para falhas de rede ou respostas malformadas da API.
O histórico é armazenado em memória e perdido ao encerrar o script.

### Contribuições:
Sinta-se à vontade para abrir issues ou enviar pull requests com melhorias, como:

Salvar o histórico em um arquivo.
Adicionar suporte a cores na interface.
Implementar tratamento de erros mais robusto.

Licença
Este projeto está licenciado sob a MIT License.

