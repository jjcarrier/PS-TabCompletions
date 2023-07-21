#Requires -Modules HelpParser,posh-git

################################################################################
# Setup misc argument completers
################################################################################

# Source-Control Tools
Import-Module -Name posh-git

# Programming-Tools
Import-Module "$PSScriptRoot/modules/MakeCompletion.psm1"
Import-Module "$PSScriptRoot/modules/CmakeCompletion.psm1"
Import-Module "$PSScriptRoot/modules/XtcCompletion.psm1"
Import-Module "$PSScriptRoot/modules/GccCompletion.psm1"
Import-Module "$PSScriptRoot/modules/ArmGccCompletion.psm1"
Import-Module "$PSScriptRoot/modules/DotnetCompletion.psm1"
Import-Module "$PSScriptRoot/modules/RustCompletion.psm1"

# System-Tools
Import-Module "$PSScriptRoot/modules/SshCompletion.psm1"
Import-Module "$PSScriptRoot/modules/FzfCompletion.psm1"
Import-Module "$PSScriptRoot/modules/FdCompletion.psm1"
Import-Module "$PSScriptRoot/modules/RipGrepCompletion.psm1"
Import-Module "$PSScriptRoot/modules/BatCatCompletion.psm1"

# USB-Tools
Import-Module "$PSScriptRoot/modules/DfuUtilCompletion.psm1"

# Windows-Centric Tools
if ($IsWindows) {
    Import-Module -Name WSLTabCompletion
    Import-Module "$PSScriptRoot/modules/WinGetCompletion.psm1"
    Import-Module "$PSScriptRoot/modules/UsbIpdCompletion.psm1"
    Import-Module "$PSScriptRoot/modules/Win32Completion.psm1"
}
