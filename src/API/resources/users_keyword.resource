*** Settings ***
Documentation    Resource file for users keyword APIs
Resource         common_keywords.resource
Library          RequestsLibrary
Library          JSONLibrary

*** Keywords ***
Get All Users
    [Arguments]    ${auth_token}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    GET On Session    api_session    /users    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Get User By ID
    [Arguments]    ${auth_token}    ${user_id}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    GET On Session    api_session    /users/${user_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Put Update User
    [Arguments]    ${auth_token}    ${user_id}    ${user_data}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    PUT On Session    api_session    /users/${user_id}    headers=${headers}    json=${user_data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Delete User
    [Arguments]    ${auth_token}    ${user_id}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    DELETE On Session    api_session    /users/${user_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}