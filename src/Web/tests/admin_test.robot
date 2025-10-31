*** Settings ***
Documentation         Teste da pagina de filmes

Library               Browser

Resource             ../resources/base.resource


Test Setup           Start Session
Test Teardown        Take Screenshot

*** Test Cases ***
Entrar no Admin Dashboard
    ${user}    Create Dictionary
    ...    name=Nome Atualizado Robot
    ...    email=admin@example.com
    ...    password=password123

    Go to Login page
    Submit login from   ${user}
    Notice should be    Login realizado com sucesso!

    Go to Admin Dashboard page
    Voltar para pagina inicial da tela ADM
    Sleep    4s