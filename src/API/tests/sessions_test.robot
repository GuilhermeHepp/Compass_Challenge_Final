*** Settings ***
Library             RequestsLibrary
Library             JSONLibrary
Library             Collections
Library             BuiltIn
Library             OperatingSystem
Resource            ../resources/sessions_keyword.resource
Resource            ../resources/auth_keyword.resource
Resource            ../resources/movies_keyword.resource
Resource            ../resources/theaters_keyword.resource

Suite Setup       Setup Test Session
Suite Teardown    Teardown Test Session

*** Test Cases ***
Listar Todas as Sessões
    [Documentation]    Teste para listar todas as sessões disponíveis
    [Tags]             sessions    positive    smoke
    
    ${sessions_response}=    Get All Sessions
    
    Log    Sessões listadas com sucesso: ${sessions_response}

Buscar Sessão por ID
    [Documentation]    Teste para buscar uma sessão específica por ID
    [Tags]             sessions    positive
    
    ${sessions_response}=    Get All Sessions
    ${first_session}=    Get From Dictionary    ${sessions_response}    data
    ${session_id}=       Get From List    ${first_session}    0
    ${session_id}=       Get From Dictionary    ${session_id}    _id
    
    ${session_response}=    Get Session By ID    ${session_id}
    
    Log    Sessão encontrada: ${session_response}

Criar Sessão como Admin
    [Documentation]    Teste para criar uma nova sessão como administrador
    [Tags]             sessions    positive    admin
    
    &{valid_user} =    Create Dictionary
    ...    email=${ADMIN_EMAIL}
    ...    password=${ADMIN_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data
    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token

    # Get first movie and theater for session creation
    ${movies_response}=    Get All Movies
    ${first_movie}=    Get From Dictionary    ${movies_response}    data
    ${movie}=          Get From List    ${first_movie}    0
    ${movie_id}=       Get From Dictionary    ${movie}    _id

    ${theaters_response}=    Get All Theaters
    ${first_theater}=    Get From Dictionary    ${theaters_response}    data
    ${theater}=          Get From List    ${first_theater}    0
    ${theater_id}=       Get From Dictionary    ${theater}    _id

    &{session_data} =    Create Dictionary
    ...    movie=${movie_id}
    ...    theater=${theater_id}
    ...    datetime=2024-12-01T19:00:00.000Z
    ...    fullPrice=25.00
    ...    halfPrice=12.50

    ${session_response}=    Post Create Session    ${auth_token}    ${session_data}
    
    Log    Sessão criada com sucesso: ${session_response}

Reiniciar Assentos da Sessão como Admin
    [Documentation]    Teste para reiniciar todos os assentos de uma sessão
    [Tags]             sessions    positive    admin
    
    &{valid_user} =    Create Dictionary
    ...    email=${ADMIN_EMAIL}
    ...    password=${ADMIN_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data
    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token

    ${sessions_response}=    Get All Sessions
    ${first_session}=    Get From Dictionary    ${sessions_response}    data
    ${session}=          Get From List    ${first_session}    0
    ${session_id}=       Get From Dictionary    ${session}    _id

    ${reset_response}=    Put Reset Session Seats    ${auth_token}    ${session_id}
    
    Log    Assentos reiniciados: ${reset_response}