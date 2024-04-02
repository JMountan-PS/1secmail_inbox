*** Settings ***
Library    Collections
Library    String
Library    RequestsLibrary

*** Variables ***
${one_mail}
${username}
${domain}

*** Test Cases ***
Create Inbox

    ${session}=    Create Session    one_sec_mail    https://www.1secmail.com/api/v1/
    ${response}=                     Get On Session    one_sec_mail    ?action\=genRandomMailbox&count\=1
    ${res_json}=                     Set Variable                  ${response.json()}
    ${one_mail}=                     Set Variable                  ${res_json}[0]
    ${one_mail_split]}=                     Split String                  ${one_mail}    @
    ${username}=                     Set Variable                  ${one_mail_split}[0]
    ${domain}=                       Set Variable                  ${one_mail_split}[1]


# SEND AN MAIL TO THIS ADDRESS

Get Messages
    ${session}=    Create Session    one_sec_mail        https://www.1secmail.com/api/v1/
    ${response}=                     Get On Session        one_sec_mail    ?action\=getMessages&login\=${username}&domain\=txcct.com
    Log To Console                   ${response.status_code}
    Log To Console                   ${response.text}
    ${res_json}=                     Set Variable                  ${response.json()}
