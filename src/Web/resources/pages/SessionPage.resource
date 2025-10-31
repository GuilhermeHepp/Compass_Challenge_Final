*** Settings ***
Documentation     Pagina de filmes e acoes relacionadas
Library           Browser
Resource          ../env.resource
Resource          ../base.resource

*** Keywords ***
Entrar na sessão disponivel
    [Arguments]    ${session_time}    ${movie_title} 
    
    Click    xpath=(//div[contains(@class, 'session-time') and contains(normalize-space(.), '${session_time}')]/ancestor::div[contains(@class, 'session-card')]//a[contains(text(), 'Selecionar Assentos')])[1]
    
    Wait For Elements State    role=heading[name="${movie_title}"]    visible

Verificar se a pagina de assentos está aberta

    Wait For Elements State    role=heading[name="Assentos Selecionados:"]    visible

    Wait For Elements State    xpath=(//button[contains(@class, 'seat available')])[1]    visible

Seleciona assentos na sessão
    [Arguments]    ${row}    ${number}
    
    ${seat_title} =    Set Variable    Fileira ${row}, Assento ${number} - Status: available
   
    Click    button[title="${seat_title}"]

Confirmar reserva de assentos

    Click    role=button[name="Continuar para Pagamento"]

Resetar Assentos Selecionados

    Click    role=button[name="Resetar Assentos"]
