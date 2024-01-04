function lookup {
    param (
        [string]$pattern,
        [string]$filePath,
        [string]$fileExtension = "*.*"
    )

    try {
        Write-Host "Starting..." -ForegroundColor Cyan

        $matchesFound = $false;
        $files = Get-ChildItem -Path $filePath -Recurse -Filter $fileExtension | Where-Object { $_.PSIsContainer -eq $false }

        foreach ($file in $files) {
            $fileContent = Get-Content $file.FullName | Select-String -Pattern $pattern

            foreach ($match in $fileContent) {
                if ($matchesFound -eq $false) {
                    $matchesFound = $true
                }

                Write-Host "$($file.FullName)"
                Write-Host "$($match.Line)" -ForegroundColor Green
            }
        }

        if ($matchesFound -eq $false) {
            Write-Host "No matches found in the specified path." -ForegroundColor Yellow
            return
        }
    } catch {
        Write-Host "An error occurred: $_.Exception.Message"
        return
    }
    
    Write-Host "Done!" -ForegroundColor Cyan
}
