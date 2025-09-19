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
${rows}    11
${cols}    10   


*** Test Cases ***
TC1: Review 
    [Documentation]    Test Review 
    [Tags]    Review 
    Open Excel Document    ${datatable}    Review    
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

    FOR    ${i}    IN RANGE    2    ${rows}+1
        Review Login    ${i}
        Navigate to Product Page    ${i}
        Write Review    ${i}
        Submit Review    
        Validate Review And Result    ${i}
        Logout And Return  
    END
    Save Excel Document    ${datatable}
    Close Current Excel Document



