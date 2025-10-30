*** Settings ***
Documentation     Pagina de checkout e acoes relacionadas
Library           Browser
Resource          ../env.resource
Resource          ../base.resource

*** Keywords ***
Selecionar metodo de pagamento
    [Arguments]    ${payment_method}

    Click    css=.payment-method >> text=${payment_method}

Finalizar compra
    Click    role=button[name="Finalizar Compra"]

Visualizar minhas reservas
    Click    role=link[name="Visualizar Minhas Reservas"]