## **Concepts**

### **Browser, Context and Page**

	In Browser(RF), the workspace is split into 3 levels:

* Browser: representing a type of browser that the tests will be conducted using. This browser contains multiple contexts and can persist and be reused across different tests  
* Context: representing an independent session inside a running browser. A context holds its own cookies, storage and permissions. A context can contain/be used for multiple pages  
* Page: A tab by which the test interacts with the application being tested. The test can find elements, input parameters and interact with elements on a page.

	At any given time, only 1 page of 1 context of 1 browser can be active and all commands invoked will target the currently active page(of a context of a browser).

	When a test ends, contexts and pages of that test will disappear. But the browser will not, it will be reused during future tests and will only disappear when all tests conclude or if we specifically close the browser.

	It is possible to extract context’s storage data and rebuild the context for future tests to save time and have persistence in testing state.

### **Finding element**

	In order to interact with an element on the page, you’d need to find it first. You can do so via the expression {locator}=value which will return a matching element.

| Locator | Example | What it finds |
| ----- | ----- | ----- |
| ID | `id=username` | Element with `id="username"` |
| CSS selector | `css=input[name="username"]` | Input whose `name` is `username` |
| Text | `text=Login` | Element containing the text `Login` |
| XPath | `xpath=//input[@name="username"]` | Input with the specified name |
| Role | `role=button[name="Login"]` | Button whose accessible name is `Login` |
| Test | `data-testid=theme-toggle` | Element with the test ID of theme-toggle.(This css identifier is reserved specifically for testing purposes like this and is the most preferred option if available) |

	Example:

| \*\*\* Settings \*\*\**Library*    Browser\*\*\* Test Cases \*\*\*Find And Use Login Form Elements    New Browser    chromium    headless=True    New Context    New Page    http\://localhost:8080/login        Fill Text    id=username    testUser        Fill Text    id=password    pass123        Click    id=login-button        Get Url    \==    http\://localhost:8080/home    Close Browser |
| :---- |
|  |

	Browser comes with regex to helps with finding the elements:

| Operator | Meaning |
| :---: | :---: |
| \= | exact match |
| \*= | contains substring |
| ^= | starts with string |
| \$= | ends with string |
| \~= | contains one whole word |
| \|= | contains hyphenated word |

### **Assertion**

	Assertions let you assess and work with elements you have retrieved from the page in order to confirm if the application is behaving correctly or if an error has occurred. The list of assertion operations are as followed:

| Operator | Also written |
| :---: | :---: |
| \== | equal, equals, should be |
| \!= | inequal, should not be |
| \> | greater than |
| \>= | greater than or equal |
| \< | less than |
| \<= | less than or equal |
| `*=` | Contains |
| `^=` | Starts with |
| `$=` | End with |
| `matches` | Matches a regex (python) |
| `validate` | Validate using python code |

	Example 

|              Get Text    h1    \==    Welcome               Get Text    id=status     \!=    Failed               Get Text     id=message     \*=     Welcome               Get Url     ^=     http\://localhost:8080               Get Url     \$=     /home               Get Url     matches     .\*/home\$               Get Text     h1     validate     value.startswith("Home")  |
| :---- |

An assertion when used with getters, does not fail in the traditional sense. When an assertion like this is unsuccessful, it will be retried again until it either returns a success or time out. This is due to the delayed nature of webpage and element loading. The exact time out and retry delay can be set by passing arguments to the Browser library during import in Settings as demonstrated thusly.

| \*\*\* Settings \*\*\*Library    Browser    timeout=15s    retry\_assertions\_for=5s |
| :---- |

### **Logging**

	Logging can be read in order to trace the operations of the test and extract more information about the testing process and results. Browser logs its processes and results in multiple places:

| Where | What it holds | When to open it |
| :---: | :---: | :---: |
| log.html | The Python side: keywords, arguments, status | First. Always. |
| playwright-log.txt | The Node side of the library | A keyword failed and log.html does not say why |
| browser/traces/trace\_\*.zip | Every Playwright call, with DOM snapshots | Something failed and you need to see the page as it was |
| Coverage report | Which code the run actually exercised | Asking what the suite does not touch |

