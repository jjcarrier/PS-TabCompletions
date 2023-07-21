
$ipconfigScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)

    $helpData = Invoke-Expression 'ipconfig /?'

    # Additional help dtaa filtering to avoid the top section of the output which
    # is problemmatic with the parser logic.
    $startLine = @($helpData | Select-String "\s+Options:")[0].LineNumber
    $endLine = @(($helpData | Select-String "^$").LineNumber | Where-Object { $_ -gt $startLine })[0]
    $helpData = $helpData[($startLine-1)..($endLine-1)]
    $paramValueAssign = $wordToComplete.Contains(':') -and $wordToComplete.IndexOf(":") -lt $cursorPosition
    if ($wordToComplete.StartsWith("/") -and -not $paramValueAssign) {
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

Register-ArgumentCompleter -CommandName 'ipconfig' -Native -ScriptBlock $ipconfigScriptBlock

$formatScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)

    $helpData = Invoke-Expression 'format /?'
    $paramValueAssign = $wordToComplete.Contains(':') -and $wordToComplete.IndexOf(":") -lt $cursorPosition
    if ($wordToComplete.StartsWith("/") -and -not $paramValueAssign) {
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

Register-ArgumentCompleter -CommandName 'format' -Native -ScriptBlock $formatScriptBlock

$chkdskScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)

    $helpData = Invoke-Expression 'chkdsk /?'
    $paramValueAssign = $wordToComplete.Contains(':') -and $wordToComplete.IndexOf(':') -lt $cursorPosition
    if ($wordToComplete.StartsWith("/") -and -not $paramValueAssign) {
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

Register-ArgumentCompleter -CommandName 'chkdsk' -Native -ScriptBlock $chkdskScriptBlock

$pingScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)

    $helpData = Invoke-Expression 'ping -?'
    $paramValueAssign = $wordToComplete.Contains('=') -and $wordToComplete.IndexOf('=') -lt $cursorPosition
    if ($wordToComplete.StartsWith("--") -and -not $paramValueAssign) {
        Get-ParsedHelpFlag -HelpData $helpData |
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

Register-ArgumentCompleter -CommandName 'ping' -Native -ScriptBlock $pingScriptBlock

$netstatScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)

    # NOTE: -y has some issues here. It contains the details regarding "interval" and
    # there is a "System.Management.Automation.RemoteException" at the end.
    $helpData = Invoke-Expression 'netstat -? 2>&1'
    $paramValueAssign = $wordToComplete.Contains('=') -and $wordToComplete.IndexOf('=') -lt $cursorPosition
    if ($wordToComplete.StartsWith("--") -and -not $paramValueAssign) {
        Get-ParsedHelpFlag -HelpData $helpData |
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

Register-ArgumentCompleter -CommandName 'netstat' -Native -ScriptBlock $netstatScriptBlock

$tracertScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)

    $helpData = Invoke-Expression 'tracert -?'
    $paramValueAssign = $wordToComplete.Contains('=') -and $wordToComplete.IndexOf('=') -lt $cursorPosition
    if ($wordToComplete.StartsWith("--") -and -not $paramValueAssign) {
        Get-ParsedHelpFlag -HelpData $helpData |
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

Register-ArgumentCompleter -CommandName 'tracert' -Native -ScriptBlock $tracertScriptBlock
