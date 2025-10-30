*** Settings ***
Documentation     Cenários de autenticação - Signup

Library         Collections

Resource          ../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot   

*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado
    
    ${user}    Create Dictionary
    ...    name=Nome Atualizado Robot
    ...    email=admin@example.com
    ...    password=password123
    
    Go to Login page
    Submit login from   ${user}
    Notice should be    Login realizado com sucesso!

Usurio nao deve logar com credenciais invalidas
    
    ${user}    Create Dictionary
    ...    name=Nome Atualizado Robot
    ...    email=admin@example.com
    ...    password=wrongpassword
    
    Go to Login page
    Submit login from   ${user}
    Alert should be    Invalid email or password

