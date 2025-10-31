*** Settings ***
Library           RequestsLibrary
Library           JSONLibrary
Library           Collections
Resource          ../variables/global_variables.resource

*** Keywords ***
Setup Test Session
    [Arguments]    ${base_url}=${API_BASE_URL}
    Create Session    api_session    ${base_url}    timeout=${GLOBAL_TIMEOUT}

Teardown Test Session
    Delete All Sessions

Load JSON Data
    [Arguments]    ${file_path}
    ${json_data}=    Load JSON From File    ${file_path}
    [Return]    ${json_data}


