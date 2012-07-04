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

Serviços 
--------

### User

Web Services relacionados aos usuários do quiz.
http://quiz-exmo.rhcloud.com/user?wsdl

* `login`: cadastra nome e e-mail na lista de usuários do sistema, se ainda não existir. Retorna a pontuação atual do usuário.
* `addPoints`: adiciona pontos ao usuário indicado pelo e-mail, retornando a nova pontuação. 

   > Alternativa REST: http://quiz-exmo.rhcloud.com/rest/quiz/addPoints/{email}/{points}
   
* `ranking`: retorna a posição do usuário no raking geral

### Quiz

Web Services relacionados aos quiz.
http://quiz-exmo.rhcloud.com/quiz?wsdl

* `listCategories`: retorna uma lista das categorias de jogo. 

  > Alternativa REST: http://quiz-exmo.rhcloud.com/rest/quiz/listCategories

* `giveMeAQuiz`: obtém um quiz para a categoria informada. 
   
  > Alternativa REST: http://quiz-exmo.rhcloud.com/rest/quiz/get/{category}
