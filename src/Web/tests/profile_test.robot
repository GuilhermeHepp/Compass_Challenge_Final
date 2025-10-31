*** Settings ***
Documentation         Teste da pagina de perfil

Library               Browser

Resource             ../resources/base.resource



Test Setup           Start Session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve poder atualizar o nome do usuário no perfil
    ${user}    Create Dictionary
    ...    name=Nome Atualizado Robot
    ...    email=admin@example.com
    ...    password=password123
    
    Go to Login page
    Submit login from   ${user}
    Notice should be    Login realizado com sucesso!

    ${user}    Create Dictionary
    ...    name=administrador

    Go to meu perfil page
    Alterar nome do usuario    ${user.name}
    Notice should be    Perfil atualizado com sucesso
    Botao OK
    Go out