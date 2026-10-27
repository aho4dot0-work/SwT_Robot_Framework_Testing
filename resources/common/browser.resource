*** Settings ***
Library    Browser

*** Variables ***
${BROWSER}    chromium
${HEADLESS}    True

*** Keywords ***
Start Test Browser
    New Browser    browser=${BROWSER}    headless=${HEADLESS}

Close Test Browser Session
    Close Browser
