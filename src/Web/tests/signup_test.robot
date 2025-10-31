*** Settings ***
Documentation         Cenarios de Teste para a tela de cadastro

Library               Browser

Resource             ../resources/base.resource



Test Setup           Start Session
Test Teardown        Take Screenshot


*** Test Cases ***
Deve poder cadastrar um novo usuario
    
    ${user}          Create Dictionary
    ...              name=Guilherme    
    ...              email=gggggg@qa.com
    ...              password=teste1234
    
    Go to signup page
    Submit signup from    ${user}
    Notice should be      Conta criada com sucesso!



    Sleep                 5s

Usuario ja existente nao deve ser cadastrado
    
    ${user}          Create Dictionary
    ...              name=Guilherme    
    ...              email=gggggg@qa.com
    ...              password=teste1234
    
    Go to signup page
    Submit signup from    ${user}
    Alert should be    User already exists
