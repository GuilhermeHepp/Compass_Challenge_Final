*** Settings ***
Documentation         Teste da pagina de filmes

Library               Browser

Resource             ../resources/base.resource




Test Setup           Start Session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve poder buscar um filme
    ${user}    Create Dictionary
    ...    name=Nome Atualizado Robot
    ...    email=admin@example.com
    ...    password=password123
    
    Go to Login page
    Submit login from   ${user}
    Notice should be    Login realizado com sucesso!

    Go To Filmes em Cartaz

    Buscar filme    Inception
    Verificar filme na lista    Inception

Utilizar filtro de busca de filmes
    ${user}    Create Dictionary
    ...    name=Nome Atualizado Robot
    ...    email=admin@example.com
    ...    password=password123
    Go to Login page
    Submit login from   ${user}
    Notice should be    Login realizado com sucesso!

    Go To Filmes em Cartaz
    Filtrar por gênero    Drama

    Sleep    2s

Deve poder navegar para a página de detalhes do filme
    ${user}    Create Dictionary
    ...    name=Nome Atualizado Robot
    ...    email=admin@example.com
    ...    password=password123
    
    Go to Login page
    Submit login from   ${user}
    Notice should be    Login realizado com sucesso!

    Go To Filmes em Cartaz
    Verificar filme na lista    Inception
    Selecionar Filme para fazer reserva    Inception

    Sleep    5s
    Voltar aos filmes
    


    
