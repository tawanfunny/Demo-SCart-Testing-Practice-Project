*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    Collections
Library    String
Resource    C:\test2\it\AutomatedTestingProject\variables.robot    


*** Keywords ***
Open Login Page
    [Documentation]    
    Wait Until Element Is Visible    ${login_menu}
    Click Element    ${login_menu}
    Wait Until Element Is Visible    ${login_page}
    Click Element    ${login_page}

Enter Credentials
    [Arguments]    ${email}    ${password}
    [Documentation]    
    Input Text    ${email_field}    ${email}
    Input Text    ${password_field}    ${password}
    Execute JavaScript    window.scrollTo(0, 500)

Click Login
    [Documentation]    
    Wait Until Element Is Visible    ${submit_button}
    Click Button    ${submit_button}

Check Login Result
    [Documentation]    
    ${is_success}    Run Keyword And Return Status    Page Should Contain Element   ${success_message}
    RETURN    ${is_success}

Get Success Message
    [Documentation]    
    Wait Until Element Is Visible    ${success_message}    5s
    ${SuccessMessage}    Get Text    ${success_message}
    RETURN    ${SuccessMessage}

Get Error Message
    [Documentation]    
    ${has_error}    Run Keyword And Return Status    Page Should Contain Element    ${error_message}
    IF    ${has_error}
        Wait Until Element Is Visible    ${error_message}    3s
        ${ErrorMessage}    Get Text    ${error_message}
        RETURN    ${ErrorMessage}
    ELSE
        RETURN    Unknown Error
    END

Capture Screenshot On Failure
    [Arguments]    ${i}
    [Documentation]    
    ${screenshot_file}    Set Variable    ${screenshot_path}Login_Fail_${i}.png
    Capture Page Screenshot    ${screenshot_file}

Write Test Result To Excel
    [Arguments]    ${i}    ${actual_message}    ${result}
    [Documentation]   
    Write Excel Cell    ${i}    5    ${actual_message} 
    Write Excel Cell    ${i}    6    ${result}

Logout
    [Documentation]   
    Wait Until Element Is Visible    ${login_menu}
    Scroll Element Into View    ${login_menu}
    Click Element    ${logout_button}



Open Register Page
    wait until element is visible    //header/div[1]/nav[1]/div[1]/div[1]/div[2]/ul[1]/li[8]
    Click element    //header/div[1]/nav[1]/div[1]/div[1]/div[2]/ul[1]/li[8]
    wait until element is visible    //a[@href='https://demo.s-cart.org/customer/login.html']
    Click element    //a[@href='https://demo.s-cart.org/customer/login.html']
    Execute JavaScript    window.scrollTo(0, 500)
    Sleep    2s
    Scroll Element Into View    locator=//a[@href='https://demo.s-cart.org/customer/register.html']
    Click element    //a[@href='https://demo.s-cart.org/customer/register.html']

Input Register Form
    [Arguments]    ${i}
    Scroll Element Into View   //input[@name='first_name']
    wait until element is visible    //input[@name='first_name']
    ${Firstname}    Read Excel Cell    ${i}    2
    ${Firstname}    Set Variable If    '${Firstname}' in ['None', '${EMPTY}']    ${EMPTY}    ${Firstname}
    Input Text    //input[@name='first_name']    ${Firstname}
    
    wait until element is visible    //input[@name='last_name']
    ${Surname}    Read Excel Cell    ${i}    3
    ${Surname}    Set Variable If    '${Surname}' in ['None', '${EMPTY}']    ${EMPTY}    ${Surname}
    Input Text    //input[@name='last_name']    ${Surname}
    
    wait until element is visible    //input[@name='email']
    ${Email}    Read Excel Cell    ${i}    4
    ${Email}    Set Variable If    '${Email}' in ['None', '${EMPTY}']    ${EMPTY}    ${Email}
    Input Text    //input[@name='email']    ${Email}
    
    Scroll Element Into View    //input[@name='phone'] 
    wait until element is visible    //input[@name='phone']
    ${Phone}    Read Excel Cell    ${i}    5
    ${Phone}    Set Variable If    '${Phone}' in ['None', '${EMPTY}']    ${EMPTY}    ${Phone}
    Input Text    //input[@name='phone']    ${Phone}

    Scroll Element Into View    //input[@name='address1'] 
    wait until element is visible    //input[@name='address1']
    ${Address1}   Read Excel Cell    ${i}    6
    ${Address1}   Set Variable If    '${Address1}' in ['None', '${EMPTY}']    ${EMPTY}    ${Address1}
    Input Text    //input[@name='address1']    ${Address1}
    
    Scroll Element Into View    //input[@name='address2']
    wait until element is visible    //input[@name='address2']
    ${Address2}   Read Excel Cell    ${i}    7
    ${Address2}   Set Variable If    '${Address2}' in ['None', '${EMPTY}']    ${EMPTY}    ${Address2}
    Input Text    //input[@name='address2']    ${Address2}
    
    Scroll Element Into View    //select[@class='form-control country']
    wait until element is visible    //select[@class='form-control country']
    ${Country}    Read Excel Cell    ${i}    8
    ${Country}    Set Variable If    '${Country}' in ['None', '${EMPTY}']    ${EMPTY}    ${Country}
    IF    '${Country}' != '${EMPTY}'
        Select From List By Label   //select[@class='form-control country']    ${Country}
    END

    Scroll Element Into View    //input[@name='password']
    wait until element is visible    //input[@name='password']
    ${Password}    Read Excel Cell    ${i}    9
    ${Password}    Set Variable If    '${Password}' in ['None', '${EMPTY}']    ${EMPTY}    ${Password}
    Input Text    //input[@name='password']    ${Password}

    wait until element is visible    //input[@name='password_confirmation']
    ${ConfirmPassword}    Read Excel Cell    ${i}    10
    ${ConfirmPassword}    Set Variable If    '${ConfirmPassword}' in ['None', '${EMPTY}']    ${EMPTY}    ${ConfirmPassword}
    Input Text    //input[@name='password_confirmation']    ${ConfirmPassword}

Submit Register Form
    Scroll Element Into View    //button[@class='g-recaptcha button']
    Wait Until Element Is Visible    //button[@class='g-recaptcha button']    10s
    Execute JavaScript    document.querySelector(".g-recaptcha.button").click()
    Sleep    3s

Validate Register Result
    [Arguments]    ${i}
    ${is_success}    Run Keyword And Return Status    Page Should Contain Element    //div[@class='col-12 col-sm-12 col-md-9 min-height-37vh']//p
    Log To Console    is_success: ${is_success}

    ${ExpectedResult}    Read Excel Cell    ${i}    11
    Log To Console    ExpectedResult: ${ExpectedResult}

    ${SuccessMessage}    Set Variable    ${EMPTY}
    IF  ${is_success}
        Wait Until Element Is Visible    //div[@class='col-12 col-sm-12 col-md-9 min-height-37vh']//p    5s
        ${SuccessMessage}    Get Text    //div[@class='col-12 col-sm-12 col-md-9 min-height-37vh']//p
        Log To Console    Success Message: ${SuccessMessage}
        ${ActualMessage}    Set Variable    ${SuccessMessage}
        ${result}    Set Variable    Pass
    ELSE
        ${has_error}    Run Keyword And Return Status    Page Should Contain Element    //span[@class='help-block']
        Mouse Over    //span[@class='help-block']   
        Execute JavaScript    window.scrollBy(0, 200) 
        
        IF    ${has_error}
            Wait Until Element Is Visible    //span[@class='help-block']    3s
            ${ErrorMessage}    Get Text    //span[@class='help-block']
            Log To Console    Error Message: ${ErrorMessage}
            ${ActualMessage}    Set Variable    ${ErrorMessage}
            ${result}    Set Variable    Fail
        ELSE
            ${ActualMessage}    Set Variable    Unknown Error
            ${result}    Set Variable    Fail
        END
    END
    

    ${ActualMessage}    Strip String    ${ActualMessage}
    ${ExpectedResult}    Strip String    ${ExpectedResult}

    ${is_actual_pass}    Set Variable If    '${ActualMessage}' == '${SuccessMessage}'    Pass    Fail
    ${result}    Set Variable If    '${is_actual_pass}' == '${ExpectedResult}'    Pass    Fail

    IF    '${is_actual_pass}' == 'Fail'
        ${screenshot_path}    Set Variable    AutomatedTestingProject/screenshots/register_Fail_${i}.png
        Capture Page Screenshot    ${screenshot_path}
    END
    Execute JavaScript    window.scrollBy(0, -1000) 

    Write Excel Cell    ${i}    12    ${ActualMessage} 
    Write Excel Cell    ${i}    13    ${result}

    IF    ${is_success} == True
       
        Wait Until Element Is Visible    //header/div[1]/nav[1]/div[1]/div[1]/div[2]/ul[1]/li[8]
        Scroll Element Into View    //header/div[1]/nav[1]/div[1]/div[1]/div[2]/ul[1]/li[8]
        Wait Until Element Is Visible    //header/div[1]/nav[1]/div[1]/div[1]/div[2]/ul[1]/li[8]/ul[1]/li[2]/a[1]
        Click Element     //header/div[1]/nav[1]/div[1]/div[1]/div[2]/ul[1]/li[8]/ul[1]/li[2]/a[1]

        # Go To    //a[@href='https://demo.s-cart.org/customer/register.html']
    END



Open Contact Page
    wait until element is visible    //a[@href='https://demo.s-cart.org/contact.html']
    Click element    //a[@href='https://demo.s-cart.org/contact.html']

Fill Contact Form
    [Arguments]    ${i}
    Scroll Element Into View    //input[@name='name'] 
    ${Name}    Read Excel Cell    ${i}    2
    ${Name}    Set Variable If    '${Name}' in ['None', '${EMPTY}']    ${EMPTY}    ${Name}
    Input Text    //input[@name='name']    ${Name}
    
    Scroll Element Into View    //input[@name='email']
    ${Email}   Read Excel Cell    ${i}    3
    ${Email}    Set Variable If    '${Email}' in ['None', '${EMPTY}']    ${EMPTY}    ${Email}
    Input Text    //input[@name='email']    ${Email}

    Scroll Element Into View    //input[@name='phone']
    ${Phone}   Read Excel Cell    ${i}    4
    ${Phone}    Set Variable If    '${Phone}' in ['None', '${EMPTY}']    ${EMPTY}    ${Phone}
    Input Text    //input[@name='phone']    ${Phone}

    Scroll Element Into View    //input[@type='text']
    Execute JavaScript    window.scrollTo(0, 700)
    ${Subject}   Read Excel Cell    ${i}    5
    ${Subject}    Set Variable If    '${Subject}' in ['None', '${EMPTY}']    ${EMPTY}    ${Subject}
    Wait Until Element Is Visible    //input[@name='title']    5s
    Input Text    //input[@name='title']    ${Subject}
    
    Scroll Element Into View    //textarea[@name='content']
    ${content}    Read Excel Cell    ${i}    6
    ${content}    Set Variable If    '${content}' in ['None', '${EMPTY}']    ${EMPTY}    ${content}
    Input Text    //textarea[@name='content']   ${content}

Submit Contact Form
    Scroll Element Into View    //button[@data-action='submit']
    Execute JavaScript    window.scrollTo(0, 1000)
    Click Button    //button[@data-action='submit']
    Sleep    2s

Verify Submission Result
    [Arguments]    ${i}
    ${is_success}    Run Keyword And Return Status    Page Should Contain Element     //h2[@id='swal2-title']  
    Log    is_success: ${is_success}
    
    ${ExpectedResult}    Read Excel Cell    ${i}    7
    Log To Console    ExpectedResult: ${ExpectedResult}
    
    ${SuccessMessage}    Set Variable    ${EMPTY}
    IF    ${is_success}
        Wait Until Element Is Visible     //h2[@id='swal2-title']   5s
        ${SuccessMessage}    Get Text     //h2[@id='swal2-title']
        Log To Console    Success Message: ${SuccessMessage}
        ${ActualMessage}    Set Variable    ${SuccessMessage}
        ${result}    Set Variable    Pass
    ELSE
        ${has_error}    Run Keyword And Return Status    Page Should Contain Element    //span[@class='help-block']
        Scroll Element Into View    //span[@class='help-block']
        Execute JavaScript    window.scrollBy(0, 100) 
        IF    ${has_error}
            Wait Until Element Is Visible    //span[@class='help-block']    3s
            ${ErrorMessage}    Get Text    //span[@class='help-block']
            Log To Console    Error Message: ${ErrorMessage}
            ${ActualMessage}    Set Variable    ${ErrorMessage}
            ${result}    Set Variable    Fail
        ELSE
            ${ActualMessage}    Set Variable    Unknown Error
        END
    END

    ${ActualMessage}    Strip String    ${ActualMessage}
    ${ExpectedResult}    Strip String    ${ExpectedResult}
    ${is_actual_pass}    Set Variable If    '${ActualMessage}' == '${SuccessMessage}'    Pass    Fail
    ${result}    Set Variable If    '${is_actual_pass}' == '${ExpectedResult}'    Pass    Fail

    IF  '${is_actual_pass}' == 'Fail'
        ${screenshot_path}    Set Variable    AutomatedTestingProject/screenshots/contact_Fail_${i}.png
        Capture Page Screenshot    ${screenshot_path}
    END
    

    Write Excel Cell    ${i}    8    ${ActualMessage} 
    Write Excel Cell    ${i}    9    ${result}


Review Login
    [Arguments]    ${i}
    Wait Until Element Is Visible    //header/div[1]/nav[1]/div[1]/div[1]/div[2]/ul[1]/li[8]
    Click Element    //header/div[1]/nav[1]/div[1]/div[1]/div[2]/ul[1]/li[8]
    Wait Until Element Is Visible    //a[@href='https://demo.s-cart.org/customer/login.html']
    Click Element    //a[@href='https://demo.s-cart.org/customer/login.html']
    ${email}    Read Excel Cell    ${i}    2
    ${email}    Set Variable If    '${email}' in ['None', '${EMPTY}']    ${EMPTY}    ${email}
    Input Text    //input[@name='email']    ${email}
    ${password}    Read Excel Cell    ${i}    3
    ${password}    Set Variable If    '${password}' in ['None', '${EMPTY}']    ${EMPTY}    ${password}
    Input Text    //input[@name='password']    ${password}
    Wait Until Element Is Visible    //button[@name='SubmitLogin']
    Execute JavaScript    window.scrollTo(0, 500)
    Click Button    xpath=//button[@name='SubmitLogin']

Navigate to Product Page
    [Arguments]    ${i}
    Wait Until Element Is Visible    //a[@href='https://demo.s-cart.org']
    Scroll Element Into View    //a[@href='https://demo.s-cart.org']
    Click Element     //a[@href='https://demo.s-cart.org']
    Execute JavaScript    window.scrollBy(0, 1200) 
    ${scroll_amount}    Evaluate    550 * ((${i} >= 4) and (${i} <= 7)) + 800 * ((${i} >= 8) and (${i} <= 11))
    Execute JavaScript    window.scrollBy(0, ${scroll_amount})
    Sleep    1s
    ${productNo}    Read Excel Cell    ${i}    4
    Scroll Element Into View    (//h5[@class='product-title'])[${productNo}]
    Click Element    (//h5[@class='product-title'])[${productNo}]
    Log To Console    productNo:${productNo}
    ${productTitle}    Read Excel Cell    ${i}    5
    ${productTitle}   Set Variable If    '${productTitle}' in ['None', '${EMPTY}']    ${EMPTY}    ${productTitle}
    Log To Console    productTitle:${productTitle}

Write Review
    [Arguments]    ${i}
    Wait Until Element Is Visible    //textarea[@id='input-review']
    Scroll Element Into View    //textarea[@id='input-review']
    ${yourReview}    Read Excel Cell    ${i}    6
    ${yourReview}   Set Variable If    '${yourReview}' in ['None', '${EMPTY}']    ${EMPTY}    ${yourReview}
    Input Text    //textarea[@id='input-review']    ${yourReview}

    Execute JavaScript    window.scrollBy(0, 100) 
    ${Rating}    Read Excel Cell    ${i}    7 
    ${Rating}    Set Variable If    '${Rating}' in ['None', '${EMPTY}']    ${EMPTY}    ${Rating} 
    Run Keyword If    '${Rating}' != '${EMPTY}' and '${Rating}'.isdigit()    Convert To Integer    ${Rating}
    Run Keyword If    '${Rating}' != '${EMPTY}' and '${Rating}'.isdigit()    Click Element    (//input[@name='point'])[${Rating}]

Submit Review
    Execute JavaScript    window.scrollBy(0, 300) 
    Click Element    //button[@class='g-recaptcha button']

Validate Review And Result
    [Arguments]    ${i}
    ${ExpectedResult}    Read Excel Cell    ${i}    8
    Log To Console    ExpectedResult: ${ExpectedResult}

    ${SuccessMessage}    Set Variable    ${EMPTY}
    ${ActualMessage}    Set Variable    Your review added success!
    ${is_success}    Run Keyword And Return Status    Wait Until Element Is Visible    
    ...    //div[@class='swal2-popup swal2-toast swal2-show']//h2[@id='swal2-title']
    IF  ${is_success}
        Wait Until Element Is Visible     //div[@class='swal2-popup swal2-toast swal2-show']//h2[@id='swal2-title']    5s
        ${SuccessMessage}    Get Text     //div[@class='swal2-popup swal2-toast swal2-show']//h2[@id='swal2-title']
        Log To Console    Success Message: ${SuccessMessage}
        ${ActualMessage}    Set Variable    ${SuccessMessage}
        ${result}    Set Variable    Pass
    ELSE
        ${has_error}    Run Keyword And Return Status    Page Should Contain Element    //span[@class='help-block']
        Scroll Element Into View    //input[@name='point']
        Execute JavaScript    window.scrollBy(0, 100) 
        IF    ${has_error}
            Wait Until Element Is Visible    //span[@class='help-block']    3s
            ${ErrorMessage}    Get Text    //span[@class='help-block']
            Log To Console    Error Message: ${ErrorMessage}
            ${ActualMessage}    Set Variable    ${ErrorMessage}
            ${result}    Set Variable    Fail
        ELSE
            ${ActualMessage}    Set Variable    Unknown Error
        END
    END
    ${ActualMessage}    Strip String    ${ActualMessage}
    ${ExpectedResult}    Strip String    ${ExpectedResult}
    ${is_actual_pass}    Set Variable If    '${ActualMessage}' == '${SuccessMessage}'    Pass    Fail
    ${result}    Set Variable If    '${is_actual_pass}' == '${ExpectedResult}'    Pass    Fail
    
    IF  '${is_actual_pass}' == 'Fail'
        ${screenshot_path}    Set Variable    AutomatedTestingProject/screenshots/review_Fail_${i}.png
        Capture Page Screenshot    ${screenshot_path}
    END
    
    Write Excel Cell    ${i}    9    ${ActualMessage} 
    Write Excel Cell    ${i}    10    ${result}

Logout And Return
         Wait Until Element Is Visible    //header/div[1]/nav[1]/div[1]/div[1]/div[2]/ul[1]/li[8]
        Scroll Element Into View    //header/div[1]/nav[1]/div[1]/div[1]/div[2]/ul[1]/li[8]

        Wait Until Element Is Visible    //header/div[1]/nav[1]/div[1]/div[1]/div[2]/ul[1]/li[8]/ul[1]/li[2]/a[1]
        Click Element     //header/div[1]/nav[1]/div[1]/div[1]/div[2]/ul[1]/li[8]/ul[1]/li[2]/a[1]
    