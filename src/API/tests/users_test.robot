*** Settings ***
Library             RequestsLibrary
Library             JSONLibrary
Library             Collections
Library             BuiltIn
Library             OperatingSystem
Resource            ../resources/users_keyword.resource
Resource            ../resources/auth_keyword.resource

Suite Setup       Setup Test Session
Suite Teardown    Teardown Test Session

*** Test Cases ***
Listar Todos os Usuários como Admin
    [Documentation]    Teste para listar todos os usuários como administrador
    [Tags]             users    positive    admin
    
    &{valid_user} =    Create Dictionary
    ...    email=${ADMIN_EMAIL}
    ...    password=${ADMIN_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data
    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token
    
    ${users_response}=    Get All Users    ${auth_token}
    
    Log    Usuários listados com sucesso: ${users_response}

Buscar Usuário por ID como Admin
    [Documentation]    Teste para buscar um usuário específico por ID
    [Tags]             users    positive    admin
    
    &{valid_user} =    Create Dictionary
    ...    email=${ADMIN_EMAIL}
    ...    password=${ADMIN_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data
    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token
    
    ${users_response}=    Get All Users    ${auth_token}
    ${first_user}=    Get From Dictionary    ${users_response}    data
    ${user_id}=       Get From List    ${first_user}    0
    ${user_id}=       Get From Dictionary    ${user_id}    _id
    
    ${user_response}=    Get User By ID    ${auth_token}    ${user_id}
    
    Log    Usuário encontrado: ${user_response}

Atualizar Usuário como Admin
    [Documentation]    Teste para atualizar um usuário como administrador
    [Tags]             users    positive    admin
    
    &{valid_user} =    Create Dictionary
    ...    email=${ADMIN_EMAIL}
    ...    password=${ADMIN_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data
    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token

    ${users_response}=    Get All Users    ${auth_token}
    ${first_user}=    Get From Dictionary    ${users_response}    data
    ${user}=          Get From List    ${first_user}    0
    ${user_id}=       Get From Dictionary    ${user}    _id

    &{update_data} =    Create Dictionary
    ...    name=Nome Atualizado Robot
    ...    role=user

    ${updated_user}=    Put Update User    ${auth_token}    ${user_id}    ${update_data}
    
    Log    Usuário atualizado: ${updated_user}