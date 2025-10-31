*** Settings ***
Documentation         Teste da pagina de filmes

Library               Browser

Resource             ../resources/base.resource


Test Setup           Start Session
Test Teardown        Take Screenshot

*** Test Cases ***
Fazer Reservas
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
    Entrar na sessão disponivel    12:00     Inception
    
    Verificar se a pagina de assentos está aberta
    Resetar Assentos Selecionados
    Sleep    3s
    Seleciona assentos na sessão    A    1
    Seleciona assentos na sessão    A    2
    Sleep    3s
    Confirmar reserva de assentos

    Selecionar metodo de pagamento    Cartão de Crédito
    Finalizar compra
    Notice should be    Reserva Confirmada!
    Visualizar minhas reservas