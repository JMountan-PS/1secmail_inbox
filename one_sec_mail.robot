*** Settings ***
Library    Collections
Library    String
Library    RequestsLibrary

*** Variables ***


*** Test Cases ***
Create Inbox

    ${session}=    Create Session    one_sec_mail    https://www.1secmail.com/api/v1/
    ${response}=                     Get On Session    one_sec_mail    ?action\=genRandomMailbox&count=1