*** Settings ***
Documentation    Resource file for sessions keyword APIs
Resource         common_keywords.resource
Library          RequestsLibrary
Library          JSONLibrary

*** Keywords ***
Get All Sessions
    ${response}=    GET On Session    api_session    /sessions
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Get Session By ID
    [Arguments]    ${session_id}
    ${response}=    GET On Session    api_session    /sessions/${session_id}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Post Create Session
    [Arguments]    ${auth_token}    ${session_data}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    POST On Session    api_session    /sessions    headers=${headers}    json=${session_data}
    Should Be Equal As Integers    ${response.status_code}    201
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Put Update Session
    [Arguments]    ${auth_token}    ${session_id}    ${session_data}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    PUT On Session    api_session    /sessions/${session_id}    headers=${headers}    json=${session_data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Delete Session
    [Arguments]    ${auth_token}    ${session_id}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    DELETE On Session    api_session    /sessions/${session_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Put Reset Session Seats
    [Arguments]    ${auth_token}    ${session_id}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    PUT On Session    api_session    /sessions/${session_id}/reset-seats    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}