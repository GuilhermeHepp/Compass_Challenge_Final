*** Settings ***
Documentation     Pagina de filmes e acoes relacionadas
Library           Browser
Resource          ../env.resource
Resource          ../base.resource

*** Keywords ***
Voltar para pagina inicial
    Click    role=link[name="Voltar para a Página Inicial"]
