#Requires -Modules HelpParser

$scriptBlock = {
	param($wordToComplete, $commandAst, $cursorPosition)

	$helpData = cmake --help
	$paramValueAssign = $wordToComplete.Contains('=') -and $wordToComplete.IndexOf("=") -lt $cursorPosition
	if ($wordToComplete.StartsWith("--") -and -not $paramValueAssign) {
		Get-ParsedHelpOptions -HelpData $helpData |
			New-ParsedHelpParamCompletionResult -WordToComplete $wordToComplete
	} elseif ($wordToComplete.StartsWith("-") -and -not $paramValueAssign) {
		Get-ParsedHelpFlags -HelpData $helpData |
			New-ParsedHelpParamCompletionResult -WordToComplete $wordToComplete
	} else {
		$resultPrefix = ''
		$values = $helpData |
			Get-ParsedHelpParamValues `
				-WordToComplete $wordToComplete `
				-CommandAst $commandAst `
				-CursorPosition $cursorPosition `
				-ParamValueAssignment:$paramValueAssign `
				-ResultPrefix ([ref]$resultPrefix)
		$values | New-ParsedHelpValueCompletionResult -ResultPrefix $resultPrefix
	}
}

Register-ArgumentCompleter -CommandName cmake -Native -ScriptBlock $scriptBlock
