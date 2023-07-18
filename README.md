# PowerShell Tab-Completions

## Description

This repository provides tab-completion functionality to a suite of CLI programs
in PowerShell. Many of these leverage the [HelpParser](https://github.com/jjcarrier/HelpParser)
module to parse a command's help documentation for options and flags, while
others may simply hook into the command's built-in tab-completion interfaces.

## Installation

Install dependencies from `PSGallery` and clone the repo:

```pwsh
Install-Module -Name posh-git -Repository PSGallery
Install-Module -Name HelpParser -Repository PSGallery
git checkout git@github.com:jjcarrier/PSTabCompletions.git
cd PSTabCompletions
```

Add the module to your `$PROFILE`:

```pwsh
Import-Module ./TabCompletions.psm1
```

## Additional Notes

The `HelpParser` module is still in an experimental state and thus there are
some known issues, but in most cases, these are minor. Please see this
repository's documentation for more information on its limitations and known
issues.
