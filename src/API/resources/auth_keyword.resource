*** Settings ***
Documentation    Resource file for authentication keyword APIs
Resource         common_keywords.resource
Library          RequestsLibrary
Library          JSONLibrary

*** Keywords ***
Post Register User
    [Arguments]    ${user_data}
    ${response}=    POST On Session    api_session    /auth/register    json=${user_data}
    Should Be Equal As Integers    ${response.status_code}    201
    [Return]    ${response}

Post Login User
    [Arguments]    ${login_data}
    ${response}=    POST On Session    api_session    /auth/login    json=${login_data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}    Set Variable    ${response.json()}    
    [Return]    ${response_json}

Get user Profile
    [Arguments]    ${auth_token}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    GET On Session    api_session    /auth/me    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Put Update User Profile
    [Arguments]    ${auth_token}    ${update_data}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    PUT On Session    api_session    /auth/profile    headers=${headers}    json=${update_data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}