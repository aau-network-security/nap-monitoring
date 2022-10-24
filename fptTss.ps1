

Write-Host "Sleeping for 30s..."
Start-Sleep 30

$remote = "/upload/*";
$sync = "C:\Users\John Doe\Downloads\sync\*";
$wildcard = "*.zip"

set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"

try
{
# Load WinSCP .NET assembly
Add-Type -Path "${env:ProgramFiles(x86)}\WinSCP\WinSCPnet.dll"

# Set up session options
$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Sftp
    HostName = xxxxxx
    PortNumber = xxx
    UserName = xxx
    Password = xxx
    SshHostKeyFingerprint = xxxxx
}

$session = New-Object WinSCP.Session
        try
        {
            # Connect
            $session.Open($sessionOptions)

            #List Dir
            $listFiles = $session.EnumerateRemoteFiles($remote, $wildcard, [EnumerationOptions]::None)

            foreach ($file in $listFiles) {

                echo "$file"
                $transferResult = $session.GetFilesToDirectory($remote, $sync, "true")
                break

            }

            # Print results
            $sync = get-childitem -Filter * "C:\Users\John Doe\Downloads\sync\*"
            foreach ($transfer in $sync)
                {
                    Write-Host  -foregroundcolor green ("Upload of {0} succeeded" -f $transfer.FileName)
                    if ([System.IO.Path]::GetExtension($transfer.Fullname) -ieq ".zip")
                    {
                        sz x $transfer.Fullname -o"C:\Users\John Doe\Downloads\runbaby\" -p "infected"
                        Remove-Item $transfer.Fullname
                    }
                    else{
                      echo "Problem with the archive"

                    }

                }
        }
            finally
            {
                # Disconnect, clean up
                $session.Dispose()
            }

            #exit 0
    }
        catch [Exception]
        {
            Write-Host $_.Exception.Message
            exit 1
        }
      $danger = get-childitem -Filter *  "C:\Users\John Doe\Downloads\runbaby\*";
      if ([System.IO.Path]::GetExtension("$danger") -ieq ".exe")
        {
           Start-Process $danger.Fullname -ArgumentList "/s"
           Write-Host "Bad will happen now"
           Start-Sleep -Seconds 600
           Stop-Computer -ComputerName localhost
        }
      else{
          Rename-Item $danger.Fullname -newName "$danger.exe"
          Start-Process $danger.Fullname -ArgumentList "/s"
          Start-Sleep -Seconds 600
          Stop-Computer -ComputerName localhost
      }


}