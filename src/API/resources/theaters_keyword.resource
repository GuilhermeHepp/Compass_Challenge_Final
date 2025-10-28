*** Settings ***
Documentation    Resource file for theaters keyword APIs
Resource         common_keywords.resource
Library          RequestsLibrary
Library          JSONLibrary

*** Keywords ***
Get All Theaters
    ${response}=    GET On Session    api_session    /theaters
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Get Theater By ID
    [Arguments]    ${theater_id}
    ${response}=    GET On Session    api_session    /theaters/${theater_id}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Post Create Theater
    [Arguments]    ${auth_token}    ${theater_data}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    POST On Session    api_session    /theaters    headers=${headers}    json=${theater_data}
    Should Be Equal As Integers    ${response.status_code}    201
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Put Update Theater
    [Arguments]    ${auth_token}    ${theater_id}    ${theater_data}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    PUT On Session    api_session    /theaters/${theater_id}    headers=${headers}    json=${theater_data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Delete Theater
    [Arguments]    ${auth_token}    ${theater_id}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    DELETE On Session    api_session    /theaters/${theater_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}