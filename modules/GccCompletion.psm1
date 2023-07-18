#Requires -Modules HelpParser

$gdbScriptBlock = {
	param($wordToComplete, $commandAst, $cursorPosition)

	$helpData = gdb --help
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

$gccScriptBlock = {
	param($wordToComplete, $commandAst, $cursorPosition)

	$helpData = gcc --help
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

$gppScriptBlock = {
	param($wordToComplete, $commandAst, $cursorPosition)

	$helpData = g++ --help
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

$gcovScriptBlock = {
	param($wordToComplete, $commandAst, $cursorPosition)

	$helpData = gcov --help
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

Register-ArgumentCompleter -CommandName gdb -Native -ScriptBlock $gdbScriptBlock
Register-ArgumentCompleter -CommandName gcc -Native -ScriptBlock $gccScriptBlock
Register-ArgumentCompleter -CommandName g++ -Native -ScriptBlock $gppScriptBlock
Register-ArgumentCompleter -CommandName gcov -Native -ScriptBlock $gcovScriptBlock
