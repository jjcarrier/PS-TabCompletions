#Requires -Modules HelpParser

$batScriptBlock = {
	param($wordToComplete, $commandAst, $cursorPosition)

	$helpData = bat --help
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

Register-ArgumentCompleter -CommandName bat -Native -ScriptBlock $batScriptBlock
