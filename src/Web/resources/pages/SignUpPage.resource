*** Settings ***
Documentation       Elementos e açôes comuns a todas as páginas

Library             Browser
Resource            ../env.resource
Resource            ../base.resource

*** Keywords ***
Submit signup from
    [Arguments]    ${user}
    Fill Text                  id=name                ${user['name']}
    Fill Text                  id=email               ${user['email']}
    Fill Text                  id=password            ${user['password']}
    Fill Text                  id=confirmPassword     ${user['password']}

    Click                      xpath=//button[contains(text(), "Cadastrar")]