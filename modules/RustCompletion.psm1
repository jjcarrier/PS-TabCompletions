#Requires -Modules HelpParser

$rustcScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)

    $helpData = rustc --help
    $paramValueAssign = $wordToComplete.Contains('=') -and $wordToComplete.IndexOf("=") -lt $cursorPosition
    if ($wordToComplete.StartsWith("--") -and -not $paramValueAssign) {
        Get-ParsedHelpOption -HelpData $helpData |
            New-ParsedHelpParamCompletionResult -WordToComplete $wordToComplete
    } elseif ($wordToComplete.StartsWith("-") -and -not $paramValueAssign) {
        Get-ParsedHelpFlag -HelpData $helpData |
            New-ParsedHelpParamCompletionResult -WordToComplete $wordToComplete
    } else {
        $resultPrefix = ''
        $values = $helpData |
            Get-ParsedHelpParamValue `
                -WordToComplete $wordToComplete `
                -CommandAst $commandAst `
                -CursorPosition $cursorPosition `
                -ParamValueAssignment:$paramValueAssign `
                -ResultPrefix ([ref]$resultPrefix)
        $values | New-ParsedHelpValueCompletionResult -ResultPrefix $resultPrefix
    }
}

$rustdocScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)

    $helpData = rustdoc --help
    $paramValueAssign = $wordToComplete.Contains('=') -and $wordToComplete.IndexOf("=") -lt $cursorPosition
    if ($wordToComplete.StartsWith("--") -and -not $paramValueAssign) {
        Get-ParsedHelpOption -HelpData $helpData |
            New-ParsedHelpParamCompletionResult -WordToComplete $wordToComplete
    } elseif ($wordToComplete.StartsWith("-") -and -not $paramValueAssign) {
        Get-ParsedHelpFlag -HelpData $helpData |
            New-ParsedHelpParamCompletionResult -WordToComplete $wordToComplete
    } else {
        $resultPrefix = ''
        $values = $helpData |
            Get-ParsedHelpParamValue `
                -WordToComplete $wordToComplete `
                -CommandAst $commandAst `
                -CursorPosition $cursorPosition `
                -ParamValueAssignment:$paramValueAssign `
                -ResultPrefix ([ref]$resultPrefix)
        $values | New-ParsedHelpValueCompletionResult -ResultPrefix $resultPrefix
    }
}

$rustfmtScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)

    $helpData = rustfmt --help
    $paramValueAssign = $wordToComplete.Contains('=') -and $wordToComplete.IndexOf("=") -lt $cursorPosition
    if ($wordToComplete.StartsWith("--") -and -not $paramValueAssign) {
        Get-ParsedHelpOption -HelpData $helpData |
            New-ParsedHelpParamCompletionResult -WordToComplete $wordToComplete
    } elseif ($wordToComplete.StartsWith("-") -and -not $paramValueAssign) {
        Get-ParsedHelpFlag -HelpData $helpData |
            New-ParsedHelpParamCompletionResult -WordToComplete $wordToComplete
    } else {
        $resultPrefix = ''
        $values = $helpData |
            Get-ParsedHelpParamValue `
                -WordToComplete $wordToComplete `
                -CommandAst $commandAst `
                -CursorPosition $cursorPosition `
                -ParamValueAssignment:$paramValueAssign `
                -ResultPrefix ([ref]$resultPrefix)
        $values | New-ParsedHelpValueCompletionResult -ResultPrefix $resultPrefix
    }
}

$rustupScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)

    $helpData = rustup --help
    $paramValueAssign = $wordToComplete.Contains('=') -and $wordToComplete.IndexOf("=") -lt $cursorPosition
    if ($wordToComplete.StartsWith("--") -and -not $paramValueAssign) {
        Get-ParsedHelpOption -HelpData $helpData |
            New-ParsedHelpParamCompletionResult -WordToComplete $wordToComplete
    } elseif ($wordToComplete.StartsWith("-") -and -not $paramValueAssign) {
        Get-ParsedHelpFlag -HelpData $helpData |
            New-ParsedHelpParamCompletionResult -WordToComplete $wordToComplete
    } else {
        $resultPrefix = ''
        $values = $helpData |
            Get-ParsedHelpParamValue `
                -WordToComplete $wordToComplete `
                -CommandAst $commandAst `
                -CursorPosition $cursorPosition `
                -ParamValueAssignment:$paramValueAssign `
                -ResultPrefix ([ref]$resultPrefix)
        $values | New-ParsedHelpValueCompletionResult -ResultPrefix $resultPrefix
    }
}

Register-ArgumentCompleter -CommandName rustc -Native -ScriptBlock $rustcScriptBlock
Register-ArgumentCompleter -CommandName rustdoc -Native -ScriptBlock $rustdocScriptBlock
Register-ArgumentCompleter -CommandName rustfmt -Native -ScriptBlock $rustfmtScriptBlock
Register-ArgumentCompleter -CommandName rustup -Native -ScriptBlock $rustupScriptBlock
