*** Settings ***
Documentation     Cenários de autenticação - Signup

Library         Collections

Resource          ../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot   

*** Test Cases ***
Voltar a HomePage 
    Go to home pelo navbar

Ir para Filmes em Cartaz
    
    Go to Filmes em Cartaz

Ir para Login page
    Go to Login page

Ir para Signup page
    Go to Signup page

Ir para Minhas Reservas page
    Go to Minhas Reservas page

Ir para meu perfil page
    Go to meu perfil page

Ir para Admin Dashboard page
    Go to Admin Dashboard page

Ir para Sair da conta
    Go out
    

