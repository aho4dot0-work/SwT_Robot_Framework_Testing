*** Settings ***
Documentation    Minimal smoke test for Browser setup and lifecycle; it does not test a product application.
Resource    ../../../resources/common/browser.resource
Suite Setup    Start Test Browser
Test Setup    New Context
Test Teardown    Close Context
Suite Teardown    Close Test Browser Session

*** Test Cases ***
Open Blank Page
    New Page    about:blank
    Get Url    ==    about:blank
