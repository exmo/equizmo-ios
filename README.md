equizmo-ios
===========

Aplicação de exemplo iOS, cliente do eQuizmo-ws

## Funcionalidades
Segue a lista de funcionalidades exemplificadas neste projeto:

### Geolocalização: 
Durante o login é solicitado a localização atual. Neste momento apenas utilizamos os recursos físicos para obter a localização e o desligamos.
Ao utilizar geolocalização é preciso pensar na bateria e na precisão nescessária.

### Webservices/SOAP
Foi criada a classe SOAPConnection para simplificar a criação do envelope para o envio e recebimento de webservices;
Nos models User e Ranking utilizamos este tipo de serviço. 
O tratamento de xml deve ser analisado caso-a-caso, mostramos como tratar com os recursos nativos. Existem algumas bibliotecas que auxiliam porém é preciso analizar a necessidade para não adicionar pontos de falha ao projeto.

### REST / JSON
Para simplificar o uso de rest/json criamos uma categoria de Dicionário que está no pacote Util. 
Models: Category e Game;

### Internacionalização:
Todas as telas foram internalizadas. 
Não existe um recurso direto no xcode para internacionalizar objetos da interface de forma visual. Por isso criamos o pacote view/component/
Criamos as classes LocalizedLabel, LocalizedButton e LocalizedTextField, para que ao carregar estes componentes eles procurem o texto localizado.
O conteúdo de mensagens está nos arquivos Localized.strings

### Formatação de números:
No controllador de Ranking e Game a pontução do usuário utiliza o recurso nativo de formatação de maneira que o iOS é o responsável pela formatação.
Esta é a melhor maneira pois se usar-mos padrões manuais como "dd/mm/yyyy" nós estragariamos a internacionalização.

### Troca de mensagens entre as camadas:
Em objectiveC existem algumas maneiras de integrar as camadas para operações assincronas. 
Uma delas é passando um delegate para a camada superior, assim a camada superior irá chamar o delegate ao termino de suas atividades.
Outra maneira é utilizar o NSNotificationCenter, que consiste em você registrar um listener para um evento e no momento adequado disparar o evento. Exemplo: LoginViewController/User;





