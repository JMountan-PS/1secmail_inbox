*** Settings ***
Library                   Collections
Library                   String
Library                   RequestsLibrary

*** Comments ***
https://www.1secmail.com/api/
Use this for a throw-away inbox that does not require UI interactions

*** Variables ***
${one_mail}
${username}
${domain_name}
${mail_id}


*** Test Cases ***
Create Inbox

    ${session}=           Create Session              one_sec_mail            https://www.1secmail.com/api/v1/
    ${response}=          Get On Session              one_sec_mail            ?action\=genRandomMailbox&count\=1
    ${res_json}=          Set Variable                ${response.json()}
    ${one_mail}=          Set Variable                ${res_json}[0]
    ${one_mail_split}=    Split String                ${one_mail}             @
    ${username}=          Set Variable                ${one_mail_split}[0]
    ${domain_name}=       Set Variable                ${one_mail_split}[1]


    # SEND AN MAIL TO THIS ADDRESS

Get All Messages
    ${session}=           Create Session              one_sec_mail            https://www.1secmail.com/api/v1/
    ${response}=          Get On Session              one_sec_mail            ?action\=getMessages&login\=${username}&domain\=${domain_name}
    Log To Console        ${response.status_code}
    Log To Console        ${response.text}
    ${res_json}=          Set Variable                ${response.json()}
    FOR                   ${entry}                    IN                      @{res_json}
        IF                "${entry}[subject]" == "Mail 2"
            ${mail_id}=                               Set Variable            ${entry}[id]
        END
        IF                "${entry}[subject]" == "Mail 2"                     BREAK
    END
    Log To Console        ${mail_id}

Get Message Contents

    ${session}=           Create Session              one_sec_mail            https://www.1secmail.com/api/v1/
    ${response}=          Get On Session              one_sec_mail            ?action\=readMessage&login\=${username}&domain\=${domain_name}&id\=${mail_id}
    Log To Console        ${response.status_code}
    Log To Console        ${response.text}
    ${res_json}=          Set Variable                ${response.json()}
    ${body}=              Set Variable                ${res_json}[body]
    ${verify_strings}=    Get Regexp Matches          ${body}                 Verification code: \\d\\d\\d\\d\\d\\d
    ${verify_code}=       Get Substring               ${verify_strings}[0]    -6