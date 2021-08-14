*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${url}

*** Test Cases ***
Verify Search product functionality
    [Documentation]     this test case search product and verifies details in cart
    [Tags]  centralTest
    Open Chrome Browser
    Search TV and Verify
    Select Category TV
    Filter By '44 - 55'
    Add first product to Cart
    Search TV and Verify
    Select Category TV
    Filter By '32 - 43'
    Add second product to Cart
    Click on Cart
    Compare Products
*** Keywords ***
Open Chrome Browser
    ${options}=    Evaluate  sys.modules['selenium.webdriver.chrome.options'].Options()    sys
    Call Method     ${options}    add_argument    --disable-notifications
    ${driver}=    Create Webdriver    Chrome    options=${options}
    Go To   https://www.powerbuy.co.th/th/
    Maximize Browser Window
Search TV and Verify
    input text   css:input[id="txt-searchBox-input"]    TV
    Click Element   xpath://*[@id="btn-searchBox-input"]/img
    sleep   10s
    Click Element   xpath://*[@id="btn-searchBox-input"]/img
    SeleniumLibrary.Page Should Contain    ผลการค้นหาสำหรับ  "TV"
Select Category TV
    Click Element   xpath://*[@id="layout"]/div[2]/div[3]/div[2]/div/div[2]/div[1]/div/div/div/div/div[2]/div[2]/div/div/div[1]/div[1]/div
    Wait Until Page Contains Element    xpath://*[@id="layout"]/div[2]/div[3]/div[2]/div/div[2]/div[1]/div/div/div/div/div[2]/div[2]/div/div/div[1]/div[1]/div

Filter By '44 - 55'
     SeleniumLibrary.Click Element  css:#layout > div:nth-child(2) > div:nth-child(3) > div.Padding-sc-10o2jvk-0.cdMYSS > div > div.Row__Wrapper-v6uxgu-0.kSLyDU > div.Col__Column-sc-1619uro-0.gCHSMi > div > div > div > div > div:nth-child(13) > div.CardCollaspe__CardAnimation-sc-1jxh92o-2.bAxvMY > div > div > div:nth-child(1) > div.Col__Column-sc-1619uro-0.bPTHbK > div
Filter By '32 - 43'
     sleep   10s
     SeleniumLibrary.Click Element  css:#layout > div:nth-child(2) > div:nth-child(3) > div.Padding-sc-10o2jvk-0.cdMYSS > div > div.Row__Wrapper-v6uxgu-0.kSLyDU > div.Col__Column-sc-1619uro-0.gCHSMi > div > div > div > div > div:nth-child(13) > div.CardCollaspe__CardAnimation-sc-1jxh92o-2.bAxvMY > div > div > div:nth-child(2) > div.Col__Column-sc-1619uro-0.bPTHbK > div
Add first product to Cart
     sleep   10s
     Wait For Condition     return document.readyState=="complete"
     ${product_name}  Get Text  css:#txt-productName-263085
     Click Link     css:#lnk-viewProduct-263085-name
     sleep   10s
     ${ProdNm_AddtocarPage}     Get Text   xpath://*[@id="lbl-productName-productDetail"]
     Set Test Variable ${ProdNm_AddtocarPage}
     SeleniumLibrary.Page Should Contain    ${product_name}
     Set Test Variable ${product_name}
     Should Be Equal As Strings    ${product_name}    ${ProdNm_AddtocarPage}
     SeleniumLibrary.Click Element  xpath://*[@id="btn-addCart-263085"]
Click on Cart
    SeleniumLibrary.Click Element  css:div[class='MainHeader__MiniCartContainer-cOzool KbPez'] img[class='Icon-sc-134752z-0 ksKMag']
Add second product to Cart
     sleep   10s
     Wait For Condition     return document.readyState=="complete"
     ${productSecond_name}  Get Text  css:#lnk-viewProduct-262249-name
     Set Test Variable  ${productSecond_name}
     Click Link     css:#lnk-viewProduct-262249-name
     sleep   10s
     ${ProdsecondNm_AddtocarPage}     Get Text   xpath://*[@id="lbl-productName-productDetail"]
     SeleniumLibrary.Page Should Contain    ${productSecond_name}
     Set Test Variable  ${productSecond_name}
     Should Be Equal As Strings   ${productSecond_name}    ${ProdsecondNm_AddtocarPage}
     SeleniumLibrary.Click Element  css:.Button__StyledButton-r30g8h-0.eQtjoC.AddToCartButton__AddToCartButtonElem-dtemKR.bwuoky
Compare Products
     ${cart_product1}    Get Text    css:div[class='Container-i0qbvs-0 kfNkAm'] div:nth-child(2) div:nth-child(1) div:nth-child(1) div:nth-child(3) div:nth-child(1) a:nth-child(1) div:nth-child(1)
     Should Be Equal As Strings   ${product_name}    ${cart_product1}
     ${cart_product2}    Get Text    css:body div[id='app'] div[class='Layout__Background-hjsXR tpfOq'] div div div:nth-child(3) div:nth-child(1) div:nth-child(1) div:nth-child(3) div:nth-child(1) a:nth-child(1) div:nth-child(1)
     Should Be Equal As Strings   ${productSecond_name}    ${cart_product2}