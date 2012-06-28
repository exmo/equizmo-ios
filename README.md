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

You can copy samples files to your Gaelyk app from [here](https://github.com/sergerehem/gaelyk-i18n-plugin/tree/master/usage/WEB-INF).

### User

Serviços relacionados aos usuários do quiz.
http://quiz-exmo.rhcloud.com/user?wsdl

* `login`: cadastra nome e e-mail na lista de usuários do sistema
* `list`: lista todos os usuários cadastrados na base
* `ranking`: retorna a posição do usuário no raking geral