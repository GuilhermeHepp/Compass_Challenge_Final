*** Settings ***
Documentation    Pagina de perfil e acoes relacionadas

Library          Browser
Resource            ../env.resource
Resource            ../base.resource

*** Keywords ***
Alterar nome do usuario
    [Arguments]    ${new_name}

    Fill Text    id=name    ${new_name}

    Click    role=button[name="Salvar Alterações"]

Botao OK
    Click    role=button[name="OK"]

