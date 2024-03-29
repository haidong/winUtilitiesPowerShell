ADD-PSSNAPIN SqlServerProviderSnapin100
ADD-PSSNAPIN SqlServerCmdletSnapin100
Get-Content C:\Users\haidong\Documents\work\powerShell\serverList.txt | ForEach-Object {
    $serverName = $_ 
    Invoke-Expression "psinfo \\$_ -d volume" | foreach {
        if ($_ -imatch '\s+([A-Z]):\sFixed\s+(\w+)\s+(.*?)(\d+\.\d+\s\w\w)\s+(\d+\.\d+\s\w\w)\s+(\d+\.\d+%).*$') {
            $driveLetter, $diskFormat, $diskLabel, $diskTotalSize, $diskAvailableSize = $matches[1].trim(), $matches[2].trim(), $matches[3].trim(), $matches[4].replace('GB', '').trim(), $matches[5].replace('GB', '').trim()
            $sql = "EXEC serverDiskInfoInsert '$serverName', '$driveLetter', '$diskFormat', '$diskLabel', $diskTotalSize, $diskAvailableSize"
            Invoke-Sqlcmd -Query $sql -ServerInstance "myServer" -Database "alexTest"
                                                                                                                  }
                                                          }
                                                                                            }

get-wmiobject -computername serverName Win32_volume | where { $_.DriveLetter -ne 'X:'} | foreach {
	
	    $diskTotalSize = $_.Capacity / 1gb
	    $diskAvailableSize =  $_.FreeSpace / 1gb
            $driveLetter, $diskFormat, $diskLabel = $_.Name.substring(0,1), 'NTFS', $_.Label
            $sql = "EXEC serverDiskInfoInsert 'serverName', '$driveLetter', '$diskFormat', '$diskLabel', $diskTotalSize, $diskAvailableSize"
	Invoke-Sqlcmd -Query $sql -ServerInstance "myServer" -Database "alexTest"

	}
