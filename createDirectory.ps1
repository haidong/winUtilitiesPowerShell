#Given a file that contains a list of servers, with each server occupying a line, create a directory on all of them
Get-Content c:\path2FileContainsServerlist\servers.txt | ForEach-Object { Invoke-Command -ComputerName $_ -ScriptBlock { New-Item -Path "d:\newPath\blah" -type directory -Force}}
