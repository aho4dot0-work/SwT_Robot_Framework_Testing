# Repository Structure and Organization

## Design basis

This structure is derived from the supplied files in `docs/reference/`:

- `SwT_Overview.md` describes Robot Framework, its main script sections, the command-line runner, and several library options. This repository selects only the Browser library for its current test scope.
- `SwT_Robot_Framework.md` describes test files, suites, resource files, suite initialization files, variables/scopes, arguments, and BuiltIn keywords.
- `SwT_Browser.md` describes Browser, Context, Page, locators, assertions/retries, and browser logs.

The notes recommend `.robot` for test scripts and `.resource` for shared resources. The directories below are an organizational proposal for this repository, not a claim that Robot Framework requires this exact tree.

## Directories

| Path | Responsibility |
|---|---|
| `tests/ui/` | Browser-based UI test cases |
| `tests/ui/smoke/` | Minimal test to check browser setup and lifecycle |
| `resources/common/` | Reusable browser keywords shared across test cases; shared resource files use `.resource` |
| `resources/ui/` | Reusable UI-specific keywords and resources |
| `variables/` | Shared variable definitions once the team agrees on environment/configuration values |
| `docs/reference/` | Copies of the three source notes provided for this task |
| `results/` | Runtime output location; generated files are not committed |

## Browser lifecycle used by the smoke test

The resource file centralizes browser keywords. The suite setup opens the browser; each test creates a context and closes it after the test; the suite teardown closes the browser. This follows the lifecycle pattern shown in the supplied Browser examples. The smoke test opens `about:blank`, so it does not assume an application under test.

## Rules for future additions

- Put test flows in `.robot` files and reusable resources in `.resource` files.
- Keep shared keywords in resource files instead of duplicating the same setup sequence across tests.
- Use the available BuiltIn library for common operations, assertions, logging, and execution control where it fits.
- Use the Browser locators and assertion operators documented in `SwT_Browser.md`; prefer `data-testid` when the application already provides it.
- Keep this repository scoped to Robot Framework Browser unless the team explicitly changes the testing scope.
- Do not add application-specific values or claim a product flow is tested until the team supplies the URL, selectors, data, and expected behavior.

## Open decisions

The supplied notes do not define a target application, URL/configuration strategy, credentials management, naming standard for suite initialization files, CI/CD target, or a full test tagging strategy. These remain team decisions; this scaffold does not guess them.
