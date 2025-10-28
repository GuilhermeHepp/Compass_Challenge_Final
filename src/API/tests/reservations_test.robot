*** Settings ***
Library             RequestsLibrary
Library             JSONLibrary
Library             Collections
Library             BuiltIn
Library             OperatingSystem
Resource            ../resources/reservations_keyword.resource
Resource            ../resources/auth_keyword.resource
Resource            ../resources/sessions_keyword.resource


Suite Setup       Setup Test Session
Suite Teardown    Teardown Test Session

*** Test Cases ***
Listar Minhas Reservas
    [Documentation]    Teste para listar as reservas do usuário autenticado
    [Tags]             reservations    positive    smoke
    
    &{valid_user} =    Create Dictionary
    ...    email=${USER_EMAIL}
    ...    password=${USER_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data
    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token
    
    ${reservations_response}=    Get My Reservations    ${auth_token}
    
    Log    Minhas reservas: ${reservations_response}

Listar Todas as Reservas como Admin
    [Documentation]    Teste para listar todas as reservas como administrador
    [Tags]             reservations    positive    admin
    
    &{valid_user} =    Create Dictionary
    ...    email=${ADMIN_EMAIL}
    ...    password=${ADMIN_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data
    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token
    
    ${reservations_response}=    Get All Reservations    ${auth_token}
    
    Log    Todas as reservas: ${reservations_response}

Criar Reserva
    [Documentation]    Teste para criar uma nova reserva
    [Tags]             reservations    positive
    
    &{valid_user} =    Create Dictionary
    ...    email=${USER_EMAIL}
    ...    password=${USER_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data
    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token

    # Get first session for reservation
    ${sessions_response}=    Get All Sessions
    ${first_session}=    Get From Dictionary    ${sessions_response}    data
    ${session}=          Get From List    ${first_session}    0
    ${session_id}=       Get From Dictionary    ${session}    _id

    &{seat1} =    Create Dictionary
    ...    row=A
    ...    number=${1}
    ...    type=full

    &{seat2} =    Create Dictionary
    ...    row=A
    ...    number=${2}
    ...    type=half

    @{seats} =    Create List    ${seat1}    ${seat2}

    &{reservation_data} =    Create Dictionary
    ...    session=${session_id}
    ...    seats=${seats}
    ...    paymentMethod=credit_card

    ${reservation_response}=    Post Create Reservation    ${auth_token}    ${reservation_data}
    
    Log    Reserva criada com sucesso: ${reservation_response}