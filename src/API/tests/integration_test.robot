*** Settings ***
Library             RequestsLibrary
Library             JSONLibrary
Library             Collections
Library             BuiltIn
Library             OperatingSystem
Resource            ../resources/auth_keyword.resource
Resource            ../resources/movies_keyword.resource
Resource            ../resources/theaters_keyword.resource
Resource            ../resources/sessions_keyword.resource
Resource            ../resources/reservations_keyword.resource
Resource            ../resources/users_keyword.resource

Suite Setup       Setup Test Session
Suite Teardown    Teardown Test Session

*** Test Cases ***
Fluxo Completo Cinema - Criar Filme, Cinema, Sessão e Reserva
    [Documentation]    Teste de integração completo do sistema de cinema
    [Tags]             integration    e2e    complete_flow
    
    # Login como Admin
    &{admin_user} =    Create Dictionary
    ...    email=${ADMIN_EMAIL}
    ...    password=${ADMIN_PASS}

    ${admin_login}=    Post Login User    ${admin_user}
    ${admin_data} =    Collections.Get From Dictionary    ${admin_login}    data
    ${admin_token}=    Collections.Get From Dictionary    ${admin_data}    token

    # Criar Filme
    &{movie_data} =    Create Dictionary
    ...    title=Filme Integração Robottooo
    ...    synopsis=Filme criado para teste de integração
    ...    director=Diretor Robot
    ...    genres=["Ação", "Ficção"]
    ...    duration=130
    ...    classification=14
    ...    releaseDate=2024-12-15

    ${movie_response}=    Post Create Movie    ${admin_token}    ${movie_data}
    ${movie_created}=     Get From Dictionary    ${movie_response}    data
    ${movie_id}=          Get From Dictionary    ${movie_created}    _id
    
    Log    Filme criado: ${movie_id}

    # Criar Cinema
    &{theater_data} =    Create Dictionary
    ...    name=Cinema Integração Robotoo
    ...    capacity=80
    ...    type=standard

    ${theater_response}=    Post Create Theater    ${admin_token}    ${theater_data}
    ${theater_created}=     Get From Dictionary    ${theater_response}    data
    ${theater_id}=          Get From Dictionary    ${theater_created}    _id
    
    Log    Cinema criado: ${theater_id}

    # Criar Sessão
    &{session_data} =    Create Dictionary
    ...    movie=${movie_id}
    ...    theater=${theater_id}
    ...    datetime=2024-12-15T20:00:00.000Z
    ...    fullPrice=30.00
    ...    halfPrice=15.00

    ${session_response}=    Post Create Session    ${admin_token}    ${session_data}
    ${session_created}=     Get From Dictionary    ${session_response}    data
    ${session_id}=          Get From Dictionary    ${session_created}    _id
    
    Log    Sessão criada: ${session_id}

    # Login como Usuário
    &{user_data} =    Create Dictionary
    ...    email=${USER_EMAIL}
    ...    password=${USER_PASS}

    ${user_login}=    Post Login User    ${user_data}
    ${user_data_obj} =    Collections.Get From Dictionary    ${user_login}    data
    ${user_token}=        Collections.Get From Dictionary    ${user_data_obj}    token

    # Criar Reserva
    &{seat1} =    Create Dictionary
    ...    row=A
    ...    number=${5}    
    ...    type=full

    &{seat2} =    Create Dictionary
    ...    row=A
    ...    number=${6}    
    ...    type=full

    @{seats} =    Create List    ${seat1}    ${seat2}

    &{reservation_data} =    Create Dictionary
    ...    session=${session_id}
    ...    seats=${seats}
    ...    paymentMethod=credit_card

    ${reservation_response}=    Post Create Reservation    ${user_token}    ${reservation_data}
    ${reservation_created}=     Get From Dictionary    ${reservation_response}    data
    ${reservation_id}=          Get From Dictionary    ${reservation_created}    _id
    
    Log    Reserva criada: ${reservation_id}

    # Verificar Reserva
    ${my_reservations}=    Get My Reservations    ${user_token}
    
    Log    Fluxo completo executado com sucesso!
    Log    Filme: ${movie_id}
    Log    Cinema: ${theater_id}
    Log    Sessão: ${session_id}
    Log    Reserva: ${reservation_id}

    # Reset session seats as admin
    ${reset_response}=    Put Reset Session Seats    ${admin_token}    ${session_id}
    Log    Assentos da sessão reiniciados: ${reset_response}

    # List all users as admin
    ${all_users}=    Get All Users    ${admin_token}
    Log    Todos os usuários: ${all_users}