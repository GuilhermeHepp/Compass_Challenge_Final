*** Settings ***
Library             RequestsLibrary
Library             JSONLibrary
Library             Collections
Library             BuiltIn
Library             OperatingSystem
Resource            ../resources/movies_keyword.resource
Resource            ../resources/auth_keyword.resource

Suite Setup       Setup Test Session
Suite Teardown    Teardown Test Session

*** Test Cases ***
Listar Todos os Filmes
    [Documentation]    Teste para listar todos os filmes disponíveis
    [Tags]             movies    positive    smoke
    
    ${movies_response}=    Get All Movies
    
    Log    Filmes listados com sucesso: ${movies_response}

Buscar Filme por ID
    [Documentation]    Teste para buscar um filme específico por ID
    [Tags]             movies    positive
    
    ${movies_response}=    Get All Movies
    ${first_movie}=    Get From Dictionary    ${movies_response}    data
    ${movie_id}=       Get From List    ${first_movie}    0
    ${movie_id}=       Get From Dictionary    ${movie_id}    _id
    
    ${movie_response}=    Get Movie By ID    ${movie_id}
    
    Log    Filme encontrado: ${movie_response}

Criar Filme como Admin
    [Documentation]    Teste para criar um novo filme como administrador
    [Tags]             movies    positive    admin
    
    &{valid_user} =    Create Dictionary
    ...    email=${ADMIN_EMAIL}
    ...    password=${ADMIN_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data
    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token

    &{movie_data} =    Create Dictionary
    ...    title=Filme Teste Robot
    ...    synopsis=Sinopse do filme de teste
    ...    director=Diretor Teste
    ...    genres=["Ação", "Aventura"]
    ...    duration=120
    ...    classification=12
    ...    releaseDate=2024-12-01

    ${movie_response}=    Post Create Movie    ${auth_token}    ${movie_data}
    
    Log    Filme criado com sucesso: ${movie_response}

Atualizar Filme como Admin
    [Documentation]    Teste para atualizar um filme existente como administrador
    [Tags]             movies    positive    admin
    
    &{valid_user} =    Create Dictionary
    ...    email=${ADMIN_EMAIL}
    ...    password=${ADMIN_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data
    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token

    ${movies_response}=    Get All Movies
    ${first_movie}=    Get From Dictionary    ${movies_response}    data
    ${movie}=          Get From List    ${first_movie}    0
    ${movie_id}=       Get From Dictionary    ${movie}    _id

    &{update_data} =    Create Dictionary
    ...    title=Filme Atualizado Robot

    ${updated_movie}=    Put Update Movie    ${auth_token}    ${movie_id}    ${update_data}
    
    Log    Filme atualizado: ${updated_movie}