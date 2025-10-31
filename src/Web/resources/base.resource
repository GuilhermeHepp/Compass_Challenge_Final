*** Settings ***

Library             Browser
Library             JSONLibrary
Resource            env.resource
Resource            pages/LoginPage.resource
Resource            pages/components/notice.resource
Resource            pages/SignUpPage.resource
Resource            pages/HomePage.resource
Resource            pages/components/alert.resource
Resource            pages/Movies.resource
Resource            pages/SessionPage.resource
Resource            pages/CheckoutPage.resource
Resource            pages/Reservations.resource
Resource            pages/ProfilePage.resource
Resource            pages/AdminPage.resource

*** Keywords ***
Start Session

    New Browser     browser=chromium     headless=False
    New Page        ${BASE_URL}