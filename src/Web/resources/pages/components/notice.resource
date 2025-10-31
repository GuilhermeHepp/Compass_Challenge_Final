*** Settings ***
Documentation                 Mensagens de Notificacao

Library                     Browser

*** Keywords ***
Notice should be
    [Arguments]    ${expected_message}
    
    Wait For Elements State    text=${expected_message}    visible