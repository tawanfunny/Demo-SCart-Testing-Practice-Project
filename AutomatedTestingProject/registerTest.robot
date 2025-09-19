*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    Collections
Library    String
Resource    keywords.robot

*** Variables ***
${datatable}    AutomatedTestingProject/testdata.xlsx   
${url}    http://localhost:8081/Academic_Services/homepage
${browser}    Chrome
${rows}    26
${cols}    13   


*** Test Cases ***
TC1: Register
    [Documentation]    Test Register Page
    [Tags]    Register
    Open Excel Document    ${datatable}    Register
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Set Selenium Speed    0.01

    FOR    ${i}    IN RANGE    2    ${rows}+1
        Open Register Page
        Input Register Form    ${i}
        Submit Register Form
        Validate Register Result    ${i}
    END

    Save Excel Document    ${datatable}
    Close Current Excel Document



