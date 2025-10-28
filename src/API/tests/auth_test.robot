*** Settings ***
# GARANTA QUE ESSAS BIBLIOTECAS ESTÃO AQUI NO TOPO
Library             RequestsLibrary
Library             JSONLibrary
Library             Collections
Library             BuiltIn
Library             OperatingSystem
Resource            ../resources/auth_keyword.resource


Suite Setup       Setup Test Session
Suite Teardown    Teardown Test Session

*** Test Cases ***
Cadastro Usuario com Sucesso
    [Documentation]    Teste para verificar o cadastro de um novo usuário com sucesso.
    [Tags]             auth    smoke    positive
    &{new_user} =       Create Dictionary
    ...    name=Teste User      
    ...    email=test2@teste.com
    ...    password=senhaforte123


    Post Register User   ${new_user}

    Log    Usuário cadastrado com sucesso!

Login Usuario com Sucesso
    [Documentation]    Teste para verificar o login de um usuário existente com sucesso.
    [Tags]             auth    positive    smoke

    &{valid_user} =    Create Dictionary
    ...    email=${ADMIN_EMAIL}   # <-- Mude se for outro email
    ...    password=${ADMIN_PASS}       # <-- Mude se for outra senha

    Post Login User    ${valid_user}

    Log    Login realizado com sucesso!

Listar Perfil do Usuario Autenticado
    [Documentation]    Teste para listar o perfil do usuário autenticado.
    [Tags]             auth    positive
    
    &{valid_user} =    Create Dictionary
    ...    email=${USER_EMAIL}
    ...    password=${USER_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data

    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token

    ${user_profile}=    Get user Profile    ${auth_token}
    
    Log    Perfil do usuário: ${user_profile}
    
Atualizar Perfil do Usuario Autenticado
    [Documentation]    Teste para atualizar o perfil do usuário autenticado.
    [Tags]             auth    positive

    &{valid_user} =    Create Dictionary
    ...    email=${USER_EMAIL}
    ...    password=${USER_PASS}

    ${login_response}=    Post Login User    ${valid_user}
    ${data_object} =    Collections.Get From Dictionary    ${login_response}    data

    ${auth_token}=      Collections.Get From Dictionary    ${data_object}    token

    &{update_data} =    Create Dictionary
    ...    name=Nome Atualizado
    ...    current_password=${USER_PASS}
    ...    new_password=novasenha456
    
    ${updated_profile}=    Put Update User Profile    ${auth_token}    ${update_data}
    Log    Perfil atualizado: ${updated_profile}