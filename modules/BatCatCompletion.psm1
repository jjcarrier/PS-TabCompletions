#Requires -Modules HelpParser

$batScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)

    $helpData = bat --help
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

Register-ArgumentCompleter -CommandName bat -Native -ScriptBlock $batScriptBlock
