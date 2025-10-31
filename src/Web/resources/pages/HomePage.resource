*** Settings ***
Documentation     Pagina inicial do sistema
Library           Browser
Resource          ../env.resource
Resource          ../base.resource

*** Keywords ***
Go to home pelo navbar
    Click    role=link[name="Cinema App"]
   
    Wait For Elements State    role=link[name="Cinema App"]    visible

Go To Filmes em Cartaz
    Click    role=navigation >> role=link[name="Filmes em Cartaz"]
    
    # CORRIGIDO: O seletor e o estado 'visible' estão SEPARADOS
    Wait For Elements State    role=heading[name="Filmes em Cartaz"]    visible

Go to Login page
    Click    role=navigation >> role=link[name="Login"]
    

    Wait For Elements State    role=heading[name="Login"]    visible

Go to Signup page

    Click    role=link[name="Cadastrar"]
    
    Wait For Elements State     xpath=//h1[contains(text(), "Cadastro")]    visible

Go to Minhas Reservas page
    Click    role=link[name="Minhas Reservas"]
    
    Wait For Elements State     role=heading[name="Minhas Reservas"]    visible

Go to meu perfil page
    Click    role=link[name="Perfil"]

    Wait For Elements State    role=heading[name="Meu Perfil"]    visible

Go to Admin Dashboard page
    Click    role=navigation >> role=link[name="Administração"]
    

Go out
    Click            role=button[name="Sair"]

