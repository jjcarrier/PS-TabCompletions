# PowerShell Tab-Completions

## Description

This repository provides tab-completion functionality to a suite of CLI programs
in PowerShell. Many of these leverage the [HelpParser](https://github.com/jjcarrier/HelpParser)
module to parse a command's help documentation for options and flags, while
others may simply hook into the command's built-in tab-completion interfaces.

## Installation

```pwsh
git checkout git@github.com:jjcarrier/PSTabCompletions.git
```

## Additional Notes

The `HelpParser` module is still in an experimental state and thus there are
some known issues, but in most cases, these are minor. Please see this
repository's documentation for more information on its limitations and known
issues.
