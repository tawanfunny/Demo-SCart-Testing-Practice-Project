*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    Collections
Library    String
Resource    keywords.robot
Resource    variables.robot

*** Variables ***
${datatable}    AutomatedTestingProject/testdata.xlsx   
${url}    https://demo.s-cart.org/
${browser}    Chrome
${rows}    11
${cols}    6   


*** Test Cases ***
TC2: Login
    [Documentation]    Test Login Page
    [Tags]    Login
    Open Excel Document    ${datatable}    Login
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

    FOR    ${i}    IN RANGE    2    ${rows}+1
        Open Login Page

        ${email}    Read Excel Cell    ${i}    2
        ${email}    Set Variable If    '${email}' in ['None', '${EMPTY}']    ${EMPTY}    ${email}
        
        ${password}    Read Excel Cell    ${i}    3
        ${password}    Set Variable If    '${password}' in ['None', '${EMPTY}']    ${EMPTY}    ${password}

        Enter Credentials    ${email}    ${password}
        Click Login

        ${is_success}    Check Login Result
        ${ExpectedResult}    Read Excel Cell    ${i}    4
        Log To Console    ExpectedResult: ${ExpectedResult}

        ${SuccessMessage}    Set Variable    ${EMPTY}
        IF    ${is_success}
            ${ActualMessage}    Get Success Message
            ${result}    Set Variable    Pass
        ELSE
            ${ActualMessage}    Get Error Message
            ${is_actual_pass}    Set Variable If    '${ActualMessage}' == '${SuccessMessage}'    Pass    Fail
            ${result}    Set Variable If    '${is_actual_pass}' == '${ExpectedResult}'    Pass    Fail
            IF    '${is_actual_pass}' == 'Fail'
                Capture Screenshot On Failure    ${i}
            END
        END

        Write Test Result To Excel    ${i}    ${ActualMessage}    ${result}

        IF    ${is_success} == True
            Logout
        END
    END

    Save Excel Document    ${datatable}
    Close Current Excel Document
    