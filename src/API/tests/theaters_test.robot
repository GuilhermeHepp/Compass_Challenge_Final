*** Settings ***
Library             RequestsLibrary
Library             JSONLibrary
Library             Collections
Library             BuiltIn
Library             OperatingSystem
Resource            ../resources/theaters_keyword.resource
Resource            ../resources/auth_keyword.resource
Resource            ../resources/movies_keyword.resource

Suite Setup       Setup Test Session
Suite Teardown    Teardown Test Session

*** Test Cases ***
Listar Todos os Cinemas
    [Documentation]    Teste para listar todos os cinemas disponíveis
    [Tags]             theaters    positive    smoke
    
    ${theaters_response}=    Get All Theaters
    
    Log    Cinemas listados com sucesso: ${theaters_response}

Buscar Cinema por ID
    [Documentation]    Teste para buscar um cinema específico por ID
    [Tags]             theaters    positive
    
    ${theaters_response}=    Get All Theaters
    ${first_theater}=    Get From Dictionary    ${theaters_response}    data
    ${theater_id}=       Get From List    ${first_theater}    0
    ${theater_id}=       Get From Dictionary    ${theater_id}    _id
    
    ${theater_response}=    Get Theater By ID    ${theater_id}
    
    Log    Cinema encontrado: ${theater_response}

Criar Cinema como Admin
    [Documentation]    Teste para criar um novo cinema como administrador
    [Tags]             theaters    positive    admin
    
    &{valid_user} =    Create Dictionary
    ...    email=${ADMIN_EMAIL}
    ...    password=${ADMIN_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data
    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token

    &{theater_data} =    Create Dictionary
    ...    name=Cinema Robot Test
    ...    capacity=100
    ...    type=standard

    ${theater_response}=    Post Create Theater    ${auth_token}    ${theater_data}
    
    Log    Cinema criado com sucesso: ${theater_response}

Atualizar Cinema como Admin
    [Documentation]    Teste para atualizar um cinema existente como administrador
    [Tags]             theaters    positive    admin
    
    &{valid_user} =    Create Dictionary
    ...    email=${ADMIN_EMAIL}
    ...    password=${ADMIN_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data
    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token

    ${theaters_response}=    Get All Theaters
    ${first_theater}=    Get From Dictionary    ${theaters_response}    data
    ${theater}=          Get From List    ${first_theater}    0
    ${theater_id}=       Get From Dictionary    ${theater}    _id

    &{update_data} =    Create Dictionary
    ...    name=Cinema Atualizado Robot
    ...    capacity=150

    ${updated_theater}=    Put Update Theater    ${auth_token}    ${theater_id}    ${update_data}
    
    Log    Cinema atualizado: ${updated_theater}