# Based on: https://github.com/artiga033/PwshComplete/blob/main/Completions/ssh.ps1

function Get-PrevAst {
    param (
        $commandAst, $cursorPosition
    )
    $c = $commandAst.ToString()
    $prev = $commandAst.CommandElements[-1].ToString()
    if ($cursorPosition -le $c.Length) {
        $r = $c.LastIndexOf(" ", $cursorPosition)
        $l = $c.LastIndexOf(" ", $r - 1)
        while ($c[$r - 1] -eq ' ') {
            $r = $r - 1
        }
        $prev = $c.Substring($l + 1, $r - $l - 1)
    }
    return $prev
}

function Get-SshConfigHosts {
    $configFile = "$env:USERPROFILE/.ssh/config"
    if (Test-Path $configFile) {
        $config = Get-Content $configFile
        $m = $config | Select-String "Host\s+(?<name>.*$)"
        $m.Matches | ForEach-Object { $_.Groups["name"].Value }
    }
}
function Get-SshKnownHosts {
    $knownHostsFile = "$env:USERPROFILE/.ssh/known_hosts"
    if (Test-Path $knownHostsFile) {
        $knownHosts = Import-Csv $knownHostsFile -Delimiter " " -Header "H"
        $knownHosts.H | ForEach-Object {
            $_ -split ','
        } | Sort-Object -Unique
    }
}

$sshScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)

    if ($wordToComplete -eq "-") {
        @("-4", "-6", "-A", "-a", "-C", "-f", "-G", "-g", "-K", "-k",
        "-M", "-N", "-n", "-q", "-s", "-T", "-t", "-V", "-v", "-X", "-x", "-Y",
        "-y", "-B", "-b", "-c", "-D", "-E", "-e", "-F", "-I", "-i", "-J", "-L",
        "-l", "-m", "-O", "-o", "-p", "-Q", "-R", "-S", "-W", "-w")
    }
    else {
        $prev = Get-PrevAst $commandAst $cursorPosition

        switch -CaseSensitive ($prev) {
            "-b" {
                Get-NetIPAddress | ForEach-Object { $_.IPAddress } | Where-Object { $_.IPAddress -like "$wordToComplete*" }
            }
            "-c" {
                ssh -Q cipher | Where-Object { $_ -like "$wordToComplete*" }
            }
            "-l" {
                Get-LocalUser | ForEach-Object { $_.Name } | Where-Object { $_ -like "$wordToComplete*" }
            }
            "-m" {
                ssh -Q mac | Where-Object { $_ -like "$wordToComplete*" }
            }
            "-O" {
                "check" , "forward" , "cancel", "exit" , "stop" | Where-Object { $_ -like "$wordToComplete*" }
            }
            "-w" {
                $unquotedWtc = $wordToComplete.Trim("`"'")
                Get-NetIPInterface | ForEach-Object { $_.InterfaceAlias } |
                    Where-Object { $_ -match "^$unquotedWtc" } | ForEach-Object { "'$_'" }
            }
            Default {
                $c = Get-SshConfigHosts
                $k = Get-SshKnownHosts

                $all = $c + $k

                $atIndex = $wordToComplete.IndexOf('@')
                if ($atIndex -ne -1) {
                    $prefix = $wordToComplete.SubString(0, $atIndex + 1)
                    $all = $all | ForEach-Object { "$prefix$_" }
                }
                $all | Where-Object { $_ -like "$wordToComplete*" }
            }
        }
    }
}

$scpScriptBlock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    if ($wordToComplete -eq "-") {

    }
    else {
        $c = Get-SshConfigHosts
        $k = Get-SshKnownHosts
        $c + $k | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object { "${_}:" }
    }
}

Register-ArgumentCompleter -CommandName ssh -Native -ScriptBlock $sshScriptBlock
Register-ArgumentCompleter -CommandName scp -Native -ScriptBlock $scpScriptBlock
