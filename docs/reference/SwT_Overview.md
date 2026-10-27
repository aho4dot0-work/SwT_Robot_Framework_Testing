# **Robot framework**

## **Definition**

Robot framework is a test automation framework that allows developers to set up tests that can be run automatically to ensure the application functions as intended and catch any errors or faults that may be present. 

While the Robot framework is python-based, it can be adapted to other languages  through libraries and extensions. This also makes it preferable in heterogeneous applications with many technologies and languages as Robot framework can adapt to them on a per test case basis.

## **Set up and usage**

While Robot framework can be adapted to many languages, it is still rooted in python, so we will begin with python

Install Python [here](https://www.python.org/downloads/).

	Install Robot Framework with the following command

| pip install robotframework  |
| :---- |

Robot framework comes with a handful of easily memorable commands mainly around running testing scripts .

* **robot \<dir\>:** run all tests in the specified directory  
* **robot \<file\>**: run the specified test file  
* **robot ––include \<tag\> \<dir\>**: run all tests with a specified tag in the given directory  
* **robot ––exclude \<tag\> \<dir\>**: run all tests without a specified tag in the given directory  
* **robot –outputdir \<file\> \<dir\>**: run tests and output result to the given file  
* **robot –variable \<name\>:\<value\> \<dir\>**: run tests but also include the given variable  
* **robot –help** : help 

## **Functionality**

Robot framework allows developers to set up tests with minimal effort through a keyword-driven approach rather than coding. Keyword syntax comes from 3 sources: robot framework, libraries and custom user-defined keywords. These keywords allow dev to put together scripts for testing that can be run by Robot framework to test anything from module logic, APIs to even browsers and UI.

### **Testing Script**

	Testing scripts are runnable scripts marked by a .robot extension. They are runnable instances of test cases and are the primary facet by which a developer interacts and makes use of the robot framework.

### 	**Sections**

A testing scripts has 4 main sections:

1. **Settings:** Import libraries, dependencies and configure the test scene  
2. **Variables**: Define variables and values to be referenced throughout the testing script  
3. **Test Cases**: Contain multiple test cases labeled with names and a set of testing operations  
4. **Keywords:** The direct and simple way you can establish your own keywords. It is akin to writing functions or methods that aims at reusability in your testing scripts

	All 4 sections are optional, each section you leave out either remove functionality of the script or changes the identity of the script (a script with no test cases becomes a resource script for example)

	There is also a Tasks section that is syntactically identical to Test Cases but carries a different semantic meaning. It means operations to carry out rather than cases to test

### 	**Syntax rules**

* **Sectioning:** Each section is written as \*\*\* \<Section\> \*\*\* and takes up a full line  
* **Keyword and argument:** the format of the keyword lines is similar to CI commands. The first word is the keyword which determines the operation and proceeding words are arguments for that keyword.   
* **Spacing:** Each “cell” of a command is separated by 2 or more spaces, while 1 space will still count 2 words as being 1 keyword or argument  
* **Multiline commands**: use . . . at the start of a command to connect it to the command above it, allowing a single command to stretch multiple lines.  
* **Variables:** variables are defined by writing  \<\${variable}  value\> ,or \<\${variable}=  value\> if outside the variables section, and are referenced by writing \<\${variable}\>.   
* **Test case**: Each test case begins with a test case name.All preceding commands between 2 test case names or between a test case name and a section end belong to the proceeding test case name. The compiler uses indentation to distinguish between keywords and test case name with keywords having 1 level of indentation

### 	**Example**

| *\*\*\* Settings \*\*\**Library    BrowserLibrary    totp.pySuite Setup    New Browser    browser=\${*BROWSER*}  headless={*HEADLESS*}Test Setup    New ContextTest Teardown    Close ContextSuite Teardown    Close Browser*\*\*\* Variables \*\*\**\${*BROWSER*}    chromium\${*HEADLESS*}    False*\*\*\* Test Cases \*\*\**Login with MFA    New Page    https\://seleniumbase.io/realworld/login    Fill Text    id=username    demo\_user    Fill Text    id=password    secret\_pass    \${*totp*}    Get Totp    GAXG2MTEOR3DMMDG    Fill Text    id=totpcode     \${*totp*}    Click    "Sign in"    Get Text  h1  \==  Welcome\! |
| :---- |

## **Common Library**

Third party libraries and extensions play an important role in the robot framework experience and knowing which to use is vital. Each library is catered to specific testing situations and come with their own keywords and syntax. 

### **Browser**

		**Use case:** Interact with the browser through a textual format and conduct testing

		**Installation:**

1. Install browser with	 

   pip install robotframework-browser\[bb\] 

2. Initialize Browser with  rfbrowser install    
3. Install Playwright with pip install playwright   
4. Install Chromium with 

   python \-m playwright install chromium 

### 	**Database**

		**Use case:** To query, search, extract and test values from a database

**Installation:** Use the command 

 pip install robotframework-databaselibrary

### **Requests**

		**Use case:** To send, receive and check http request. Use for api and http endpoints

**Installation:** Use the command 

 pip install robotframework-requests 

### **Selenium**

		**Use case:** Another library for interacting and testing browser and websites

**Installation:** Use the command 

 pip install \--upgrade robotframework-seleniumlibrary 

(Information yet to cover: 

* Specific syntax of standard Robot framework  
* Specific syntax of robot framework libraries  
* Folder structure convention  
* How to create custom keywords with python scripts  
* How to set up resource files  
* How to adapt Robot framework to other languages  
* Integrating Robot framework with other CI/CD technologies(Docker, Jenkins, GitLab)

)

## 

