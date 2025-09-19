*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    Collections
Library    String
Resource    keywords.robot    


*** Variables ***
${datatable}    AutomatedTestingProject/testdata.xlsx   
${url}    https://demo.s-cart.org/
${browser}    Chrome
${rows}    18
${cols}    9   


*** Test Cases ***
TC4: ContactPage
    [Documentation]    Test Contact Page
    [Tags]    ContactPage
    Open Excel Document    ${datatable}    ContactPage    
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

    FOR    ${i}    IN RANGE    2    ${rows}+1
        Open Contact Page
        Fill Contact Form    ${i}
        Submit Contact Form
        Verify Submission Result    ${i}
    END

    Save Excel Document    ${datatable}
    Close Current Excel Document



