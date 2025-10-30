*** Settings ***
Documentation     Pagina de filmes e acoes relacionadas
Library           Browser
Resource          ../env.resource
Resource          ../base.resource

*** Keywords ***

Buscar filme
    [Arguments]    ${movie_title}
    Fill Text      css=input[placeholder*=Buscar]     ${movie_title}

Verificar filme na lista
    [Arguments]    ${movie_title}

    ${element}     Set Variable    xpath=//h3[text()="${movie_title}"]

    Wait For Elements State     ${element}     visible        5
    Get Text                    ${element}     equal          ${movie_title}

Filtrar por gênero
    [Arguments]    ${genre}
    Select Options By    xpath=//select[option[text()="Todos os gêneros"]]    label    ${genre}

Selecionar Filme para fazer reserva
    [Arguments]    ${movie_title}

    Click    xpath=//div[contains(@class, 'movie-card') and .//*[contains(text(), '${movie_title}')]]//a[contains(text(), 'Ver Detalhes')]
    Wait For Elements State    role=heading[name="${movie_title}"]    visible

Voltar aos filmes
    Click            role=link[name="Voltar para Filmes"]