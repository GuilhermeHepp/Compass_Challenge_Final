*** Settings ***
Documentation    Resource file for reservations keyword APIs
Resource         common_keywords.resource
Library          RequestsLibrary
Library          JSONLibrary

*** Keywords ***
Get My Reservations
    [Arguments]    ${auth_token}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    GET On Session    api_session    /reservations/me    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Get All Reservations
    [Arguments]    ${auth_token}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    GET On Session    api_session    /reservations    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Get Reservation By ID
    [Arguments]    ${auth_token}    ${reservation_id}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    GET On Session    api_session    /reservations/${reservation_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Post Create Reservation
    [Arguments]    ${auth_token}    ${reservation_data}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    POST On Session    api_session    /reservations    headers=${headers}    json=${reservation_data}
    Should Be Equal As Integers    ${response.status_code}    201
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Put Update Reservation Status
    [Arguments]    ${auth_token}    ${reservation_id}    ${status_data}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    PUT On Session    api_session    /reservations/${reservation_id}    headers=${headers}    json=${status_data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Delete Reservation
    [Arguments]    ${auth_token}    ${reservation_id}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    DELETE On Session    api_session    /reservations/${reservation_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}