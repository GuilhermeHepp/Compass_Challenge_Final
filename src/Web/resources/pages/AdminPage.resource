*** Settings ***
Documentation     Pagina de checkout e acoes relacionadas
Library           Browser
Resource          ../env.resource
Resource          ../base.resource

*** Keywords ***
Voltar para pagina inicial da tela ADM
    Click    role=link[name="Voltar para a Página Inicial"]