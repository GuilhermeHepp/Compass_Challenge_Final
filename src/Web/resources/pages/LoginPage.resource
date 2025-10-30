*** Settings ***
Documentation    Ações e elementos da página de login

Library          Browser
Resource            ../env.resource
Resource            ../base.resource

*** Keywords ***
Submit login from
    [Arguments]    ${user}

    Fill Text        id=email     ${user['email']}
    Fill Text        id=password  ${user['password']}  

    Click            xpath=//button[contains(text(), "Entrar")]

    Sleep   2s