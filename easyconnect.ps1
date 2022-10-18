
param (
    $remotePath = "/upload/*";
    $localPath = "C:\Users\John Doe\Downloads\sync\*";

)

set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"


try
{
    # Load WinSCP .NET assembly
    Add-Type -Path "WinSCPnet.dll"

    # Setup session options
    $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
        Protocol = [WinSCP.Protocol]::Sftp
        HostName = XXXXX
        PortNumber = XXX
        UserName = XXX
        Password = XXX
        SshHostKeyFingerprint = "ssh-edXXXXX........XXXWpYXXXXXX0"
    }



    $session = New-Object WinSCP.Session

    try
    {
        # Connect
        $session.Open($sessionOptions)

        # Synchronize files to local directory, collect results
        $synchronizationResult = $session.SynchronizeDirectories(
            [WinSCP.SynchronizationMode]::Local, $localPath, $remotePath, $False)

        # Deliberately not calling $synchronizationResult.Check
        # as that would abort our script on any error.
        # We will find any error in the loop below
        # (note that $synchronizationResult.Downloads is the only operation
        # collection of SynchronizationResult that can contain any items,
        # as we are not removing nor uploading anything)

        # Iterate over every download


        $i=1
        $newName= "virus"
        foreach ($download in $synchronizationResult.Downloads)
        {
            # Success or error?
            if ($download.Error -eq $Null)
            {
                Write-Host "Download of $($download.FileName) succeeded"
                # Download succeeded, remove file from source
                $filename = [WinSCP.RemotePath]::EscapeFileMask($download.FileName)

                Get-Date; Start-Sleep -Seconds 600; Get-Date

                Write-Host "Removing from source"

                $removalResult = $session.RemoveFiles($filename)

                if ($removalResult.IsSuccess)
                {
                    Write-Host "Removing of file $($download.FileName) succeeded"
                }
                else
                {
                    Write-Host "Removing of file $($download.FileName) failed"
                }




                $sync = get-childitem -Filter * "C:\Users\John Doe\Downloads\sync\*"
                if ([System.IO.Path]::GetExtension("$sync") -ieq ".zip")
                {
                        Write-Host "extracting the malware"
                        sz x "$sync" -o "C:\Users\John Doe\Downloads\runbaby\" -p "infected"
                        Remove-Item $sync.Fullname
                }


                $danger = get-childitem -Filter * "C:\Users\John Doe\Downloads\runbaby\*";

              #  Start-Process $danger.Fullname -ArgumentList "/s"
                Write-Host "$danger.Fullname"
                Write-Host " now i sleep for 5..."
                Start-Sleep -s 5 Seconds
                Rename-Item $danger.Fullname -newName $newName+$i
                $i++
                Write-Host $i
                }
                    exit 0
            }
            else
            {
                Write-Host (
                    "Download of $($download.FileName) failed: $($download.Error.Message)")
            }
        }
    }
    finally
    {
        # Disconnect, clean up
        $session.Dispose()
    }

    exit 0
}
catch
{
    Write-Host "Error: $($_.Exception.Message)"
    exit 1
}
