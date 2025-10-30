*** Settings ***
Documentation     Pagina inicial do sistema
Library           Browser
Resource          ../env.resource
Resource          ../base.resource

*** Keywords ***
Go to home pelo navbar
    Go To    ${BASE_URL}
   
    Wait For Elements State    role=link[name="Cinema App"]    visible

Go To Filmes em Cartaz
    Go To    ${BASE_URL}/movies
    
    Wait For Elements State    role=heading[name="Filmes em Cartaz"]    visible

Go to Login page
    Go to     ${BASE_URL}/login
    
    Wait For Elements State     role=heading[name="Login"]    visible

Go to Signup page

    Go to     ${BASE_URL}/register
    
    Wait For Elements State     xpath=//h1[contains(text(), "Cadastro")]    visible

Go to Minhas Reservas page
    Go to     ${BASE_URL}/reservations
    
    Wait For Elements State     role=heading[name="Minhas Reservas"]    visible

Go to meu perfil page
    Go to     ${BASE_URL}/profile
    
    Wait For Elements State     role=heading[name="Perfil"]    visible

Go to Admin Dashboard page
    Go to     ${BASE_URL}/admin
    
    Wait For Elements State     role=heading[name="Administração"]    visible

Go out
    Click            xpath=//button[contains(text(), "Sair")]

