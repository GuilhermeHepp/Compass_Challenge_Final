*** Settings ***
Documentation    Resource file for movies keyword APIs
Resource         common_keywords.resource
Library          RequestsLibrary
Library          JSONLibrary

*** Keywords ***
Get All Movies
    ${response}=    GET On Session    api_session    /movies
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Get Movie By ID
    [Arguments]    ${movie_id}
    ${response}=    GET On Session    api_session    /movies/${movie_id}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Post Create Movie
    [Arguments]    ${auth_token}    ${movie_data}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    POST On Session    api_session    /movies    headers=${headers}    json=${movie_data}
    Should Be Equal As Integers    ${response.status_code}    201
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Put Update Movie
    [Arguments]    ${auth_token}    ${movie_id}    ${movie_data}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    PUT On Session    api_session    /movies/${movie_id}    headers=${headers}    json=${movie_data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}

Delete Movie
    [Arguments]    ${auth_token}    ${movie_id}
    &{headers}=    Create Dictionary    Authorization=Bearer ${auth_token}
    ${response}=    DELETE On Session    api_session    /movies/${movie_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${response_json}=    Set Variable    ${response.json()}
    [Return]    ${response_json}