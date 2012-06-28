equizmo-ws
==========

Este é um projeto de exemplo de como disponibilizar serviços SOAP e REST para as aplicações de exemplo iOS e Android;

Características
----------

Projeto JEE 6 / [Demoiselle](http://github.com/demoiselle). 
Hospedado na nuvem da RedHat [OpenShift](https://openshift.redhat.com). 
Exposição de serviços SOAP e REST.

Acessando o projeto
----------

O projeto está disponível em http://quiz-exmo.rhcloud.com/

Web Services
----------

### User

Serviços relacionados aos usuários do quiz.
http://quiz-exmo.rhcloud.com/user?wsdl

* `login`: cadastra nome e e-mail na lista de usuários do sistema
* `list`: lista todos os usuários cadastrados na base
* `ranking`: retorna a posição do usuário no raking geral

### Category

Serviços relacionados as categorias do quiz.
http://quiz-exmo.rhcloud.com/category?wsdl

* `add`: adiciona uma nova categorias de jogo. Retorna `true` se incluida com sucesso; `false` se a categoria já exitia previamente.
* `list`: retorna uma lista das categorias de jogo

### Quiz

Serviços relacionados aos quiz.
http://quiz-exmo.rhcloud.com/quiz?wsdl

* `add`: adiciona um novo quiz
* `quiz`: obtém um quiz para a categoria informada
