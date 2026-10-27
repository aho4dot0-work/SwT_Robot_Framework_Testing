## **File and folder structure**

### 	**Test file and Suite file**	

A test file is the main artifact of the robot framework. It is a human readable file detailing testing scripts and the settings around it.

	When a test file is run, a suite file is created containing all the test cases. This relationship is similar to that of docker image and container. If a directory of test files is run instead, test suites will be recursively created from the folder tree from the test file inside and any sub-directories.

	However, not all files will be processed,

* Files starting with . or \_ will be ignored  
* Files named csv are ignored(case sensitive)  
* Unsupported file formats will be ignored

### 	 **Resource file**

	A file that details common resources for other test files to import and use. These resources typically include documentation, tag, imports, variables and keywords.

	It is good practice to use .resource for these files rather than .robot

| \*\*\* Settings \*\*\* *Documentation*     An example resource file *Library*           SeleniumLibrary *Resource*          \${RESOURCES}/common.resource \*\*\* Variables \*\*\* \${HOST}           localhost:7272 \${LOGIN URL}      http\://\${HOST}/ \${WELCOME URL}    http\://\${HOST}/welcome.html \${BROWSER}        Firefox \*\*\* Keywords \*\*\* Open Login Page     \[*Documentation*\]    Opens browser to login page     Open Browser    \${LOGIN URL}    \${BROWSER}     Title Should Be    Login Page Input Name     \[*Arguments*\]    \${name}     Input Text    username\_field    \${name} Input Password     \[*Arguments*\]    \${password}     Input Text    password\_field    \${password} |
| :---- |

### 	 **Suite initialization file**

A suite initialization file is a file that details suite configuration information like documentation, metadata or suite set up and tear down procedure.

## **Test error**

	If any keyword of a test case fails, the entire test will fail and an error message is outputted. Though some keywords will continue after failing, a behaviour similar to error-handling in programming languages. 

	In a case of failure, the error will be logged. Long error messages will be shortened for ease of reading but the full error message history is available in log files.

## **Variables**

### 	**Variable type**

1. \${variable} : Operates similarly to the concept of variable in programming language. But it should be noted that the area inside the {} is not semantically the variable name but only the final output. Or in other word, inside the {} can be an operation and the final output is resolved into a value. If the value matches any existing variable, it'll be mapped to that variable’s value. If the value doesn't have any matching variable, it’ll be used as the final value instead  
2. @{list}: Creates a list of values  
3. &{dict}: Create a dictionary of key to value pairs

	While each type has its own symbol, the more programmatic side of the robot framework operates very similarly to python. The symbol exists as a semantic hint rather than true hard type constraints, just like java.

| \*\*\* Variables \*\*\*\${myVar}    someValue@{myList}    item1    item2    item3&{myDict}    first=apple    second=banana |
| :---- |

### 	**Number variable**

	If you were to assign a number by simply typing the number as usual, the number will be treated as a string instead. Though in operations that use a number, your value would automatically be parsed into a number anyway.

The proper way to create a number variable is to put a number or operation inside \${}

	Example: 

| \*\*\* Variables \*\*\*\${myNumber}    \${5}\${myNumber2}    \${5 \+ 10}\${myNumber3}    \${\${myNumber1} \+ \${myNumber2} \+ 10} |
| :---- |

	However, if there is a variable named after a number, it will override said number. So be careful with that.

	It is good intuition to imagine it less like {variable} and more like {operation} that will eventually resolve into a value.

### 	**Creation**

	There are 2 ways to create a variable:

* Variable section: A test file level method to create variables, these variables will be accessible for all test cases in the test file  
* VAR keyword: used inside a specific test case to create local scoped variables.

| \*\*\* Variables \*\*\*\${variable}     hi\*\*\* Test Case \*\*\*Some Test Case	VAR    \${anotherVariable}    hello |
| :---- |

### 	**Assignment**

	To assign a variable, list or dictionary. You can use existing variables, or utilize a keyword’s return value to assign a variable value. Robot does not support plain ***var \= value*** assignment

| \*\*\* Test Case \*\*\*Some Test Case	\${variable} \=   Set Variable    hello 	@{list} \=   Create List    hello    good morning 	@{list2} \=   @{list} 	&{dictionary} \=   Create Dictionary    greeting=hello |
| :---- |

### **Variable Scope**

	A variable’s scope can be set using the scope option during creation

| \*\*\* Test Case \*\*\*Some Test Case	VAR    \${anotherVariable}    hello    scope=LOCAL |
| :---- |

* ### **LOCAL**: Make the variable available in the current local scope. This is the default. 

* **TEST:** Make the variable available within the current test. This includes all keywords called by the test. If used on the suite level, makes the variable available in suite setup and teardown, but not in tests or possible child suites. Prior to Robot Framework 7.2, using this scope on the suite level was an error. 

* **TASK**: Alias for TEST that can be used when [creating tasks](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#creating-tasks). 

* **SUITE:** Make the variable available within the current suite. This includes all subsequent tests in that suite, but not tests in possible child suites. 

* **SUITES**: Make the variable available within the current suite and in its child suites. 

* **GLOBAL**: Make the variable available globally. This includes all subsequent keywords and tests. 

### **Built-in variables**

| \${CURDIR} | An absolute path to the directory where the test data file is located. This variable is case-sensitive. |
| :---- | :---- |
| \${TEMPDIR} | An absolute path to the system temporary directory. |
| \${EXECDIR} | An absolute path to the directory where test execution was started from. |
| \${/} | The system directory path separator. |
| \${:} | The system path element separator. |
| \${\\n} | The system line separator.  |

### **Python similarity**

	Robot framework syntax when it comes to variables (or as operations, to put better) is based on python, and even supports direct python syntax as an alternative to Robot Framework syntax. Though robot framework syntax still carries the benefit of being made to be readable by even non-programmers and coming off as plain english. Observe examples below:

| \*\*\* Test Cases \*\*\* List item assignment     \${list} \=          Create List      one    two    three    four     \${list}\[0\] \=       Set Variable     first     \${list}\[\${1}\] \=    Set Variable     second     \${list}\[2:3\] \=     Create List      third     \${list}\[-1\] \=      Set Variable     last     Log Many           @{list}          *\# Logs 'first', 'second', 'third' and 'last'* Dictionary item assignment     \${dict} \=                Create Dictionary    first\_name=unknown     \${dict}\[first\_name\] \=    Set Variable         John     \${dict}\[last\_name\] \=     Set Variable         Doe     Log                      \${dictionary}        *\# Logs {'first\_name': 'John', 'last\_name': 'Doe'}*  |
| :---- |
| **\*\*\* Test Cases \*\*\*** **Assign multiple**     \${a}    \${b}    \${c} \=    Get Three     \${first}    @{rest} \=    Get Three     @{before}    \${last} \=    Get Three     \${begin}    @{middle}    \${end} \=    Get Three   |
| **\*\*\* Variables \*\*\*** \${VERSION: float}         7.3 \${CRITICAL: list\[int\]}    \[3278, 5368, 5417\] **\*\*\* Test Cases \*\*\*** **Variables section**     Should Be Equal    \${VERSION}       \${7.3}     Should Be Equal    \${CRITICAL}      \${{\[3278, 5368, 5417\]}} **VAR syntax**     VAR    \${number: int}      42     Should Be Equal    \${number}    \${42} **Assignment**     *\# In simple cases the VAR syntax is more convenient.*     \${number: int} \=    Set Variable    42     Should Be Equal    \${number}    \${42}     *\# In this case conversion is more useful.*     \${match}    \${version: float} \=    Should Match Regexp    RF 7.3    ^RF (\\\\d+\\\\.\\\\d+)\$     Should Be Equal    \${match}      RF 7.3     Should Be Equal    \${version}    \${7.3}  |

Example between Robot Framework syntax vs Python syntax 

| \*\*\* Variables \*\*\* @{NUMBERS}           1    2    3    4    5 &{DATES}            rc1=2025-05-08    final=2025-05-30 &{PRIORITIES}    3278=Critical    4173=High    5334=High  @{CHILDREN: int}            2    13    15 &{PAYLOAD: dict}            id=\${1}    name=Robot    children=\${CHILDREN}  |
| :---- |
| **\*\*\* Variables \*\*\*** \${NUMBERS: list\[int\]}            \[1, 2, 3, 4, 5\] \${DATES: list\[date\]}             {'rc1': '2025-05-08', 'final': '2025-05-30'} \${PRIORITIES: dict\[int, str\]}    {3278: 'Critical', 4173: 'High', 5334: 'High'} \${PAYLOAD: dict}            {'id': 1, 'name': 'Robot', 'children': \[2, 13, 15\]}  |

## **Keyword and arguments**

	Keywords work similarly to methods in python.

	Keywords take in 0 or more arguments when they are called. Arguments come in 2 types: positional and named. 

Positional arguments can only be assigned based on the position of your parameter when calling the keyword. 

Named arguments can be assigned based on their position or by calling their name. Positional arguments are mandatory to specify but named arguments will automatically use their default value if not given.

@{args} can be used to accept an undefined amount of positional argument. You can not however, define any other positional argument behind it, and all named arguments following it become name-accessible only. You can also add @{} to make all arguments after it named only.

Similarly, &{kargs} can be used to accept an undefined amount of named arguments.

Note that, it’s best to define named argument after positional argument. As if a named argument is in front of a positional argument, you can no longer set the positional argument without also setting the named argument. 

| \*\*\* Keywords \*\*\* Run Program     \[*Arguments*\]    \${positional\_arg}     \${named\_arg}=default\_value     Do Something |
| :---- |
| **\*\*\* Test Case \*\*\*** **Use Keyword**     Run Program    hello    world     Run Program    hello    named\_arg=world     Run Program    named\_arg=world hello    \#will fail |

## **Builtin Library**

	The builtin library is a robot framework native library that is available in every test suite without needing to be imported. It contains all the common use features of robot framework to get you started.

### 	**Variables and type conversion**

**`Set Variable`** `*values`

* Returns the supplied value(s) for assignment to a variable.

  **`Set Local Variable`** `name *values`

* Creates or updates a variable in the current user keyword's local scope.

  **`Set Test Variable`** `name *values`

* Creates or updates a variable accessible throughout the current test.

  **`Set Suite Variable`** `name *values [children=False]`

* Creates or updates a variable accessible throughout the current suite.

  **`Set Global Variable`** `name *values`

* Creates or updates a variable accessible across the current Robot Framework execution.

  **`Get Variable Value`** `name [default=None]`

* Returns a variable's value, or a default value if the variable is unavailable.

  **`Variable Should Exist`** `name [msg=None]`

* Fails if the specified variable does not exist.

  **`Variable Should Not Exist`** `name [msg=None]`

* Fails if the specified variable exists.

  **`Convert To Integer`** `item [base=None]`

* Converts a value to an integer.

  **`Convert To Number`** `item [precision=None]`

* Converts a value to a number, optionally rounding to the specified decimal precision.

  **`Convert To String`** `item`

* Converts a value to its string representation.

  **`Convert To Boolean`** `item`

* Converts a value to a Boolean representation according to Robot Framework's conversion rules.

  **`Convert To List`** `item`

* Converts an iterable value to a list.

  **`Convert To Dictionary`** `item`

* Converts a compatible mapping or iterable of key-value pairs to a dictionary.

  ### **Lists and dictionaries**

  **`Create List`** `*items`

* Creates and returns a list containing the supplied items.

  **`Create Dictionary`** `**items`

* Creates and returns a dictionary containing key-value pairs.

  **`Get Length`** `item`

* Returns the length of a string, list, dictionary, or other supported object.

  **`Length Should Be`** `item length [msg]`

* Fails if the object's length does not match the expected length.

  ### **Assertions and comparisons**

  **`Should Be Equal`** `first second [msg]`

* Fails if the two values are not equal.

  **`Should Not Be Equal`** `first second [msg]`

* Fails if the two values are equal.

  **`Should Be Equal As Integers`** `first second [msg]`

* Converts the values to integers and compares them.

  **`Should Be Equal As Numbers`** `first second [precision] [msg]`

* Compares numeric values, optionally using a specified decimal precision.

  **`Should Be Equal As Strings`** `first second [msg]`

* Converts values to strings and compares their textual representations.

  **`Should Be True`** `condition [msg]`

* Evaluates a condition and fails if it is false.

  **`Should Be Equal`** `first second [msg]`

* Verifies equality. This is repeated here intentionally as a reminder that it is one of the most frequently used assertions.

  **`Should Contain`** `container item [msg]`

* Fails if the container or string does not contain the specified item.

  **`Should Not Contain`** `container item [msg]`

* Fails if the container or string contains the specified item.

  **`Should Start With`** `str1 str2 [msg]`

* Fails if the first string does not start with the second string.

  **`Should End With`** `str1 str2 [msg]`

* Fails if the first string does not end with the second string.

  **`Should Be Empty`** `item [msg]`

* Fails if the specified string or collection is not empty.

  **`Should Not Be Empty`** `item [msg]`

* Fails if the specified string or collection is empty.

  **`Should Match`** `string pattern [msg]`

* Checks whether a string matches a pattern using Robot Framework's glob-style matching.

  **`Should Match Regexp`** `string pattern [msg]`

* Checks whether a string matches a regular expression.

  ### **Logging and test information**

  **`Log`** `message [level=INFO]`

* Writes a message to the Robot Framework log.

  **`Log To Console`** `message [stream=STDOUT]`

* Prints a message directly to the console.

  **`Set Test Message`** `message [append=False]`

* Sets the message associated with the current test result.

  **`Set Test Documentation`** `documentation [append=False]`

* Sets or updates the documentation for the current test.

  **`Set Tags`** `*tags`

* Adds tags to the current test.

  **`Remove Tags`** `*tags`

* Removes specified tags from the current test.

  ### **Execution control and failure handling**

  **`Run Keyword`** `name *args`

* Executes another keyword by name, passing the supplied arguments.

  **`Run Keywords`** `*keywords`

* Executes multiple keywords in sequence, separated using `AND`.

  **`Run Keyword And Return Status`** `name *args`

* Executes a keyword and returns `PASS`/`FAIL` as a Boolean value (`True`/`False`).

  **`Run Keyword And Ignore Error`** `name *args`

* Executes a keyword and returns its status (`PASS` or `FAIL`) together with its result or error message.

  **`Run Keyword And Continue On Failure`** `name *args`

* Executes a keyword and allows execution to continue after an ordinary failure, while retaining the failure in the test result.

  **`Run Keyword And Expect Error`** `expected_error name *args`

* Verifies that a keyword fails with an expected error message or pattern.

  **`Wait Until Keyword Succeeds`** `timeout retry_interval name *args`

* Repeat a keyword until it succeeds or the timeout is reached.

  **`Repeat Keyword`** `repeat name *args`

* Executes a keyword a specified number of times.

  **`Sleep`** `time [reason]`

* Pauses execution for the specified duration.

  **`Fail`** `[msg] [*tags]`

* Explicitly fails the current test or keyword.

  **`Skip If`** `condition [msg]`

* Skips the current test if the condition is true.

  This covers the 50 most basic keywords. For further reference, use [robotframework builtin library](https://robotframework.org/robotframework/latest/libraries/BuiltIn.html)

## 