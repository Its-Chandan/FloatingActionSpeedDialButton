$files = Get-ChildItem -Path . -Recurse -File | Where-Object { 
    $_.Extension -match '\.(java|kt|xml|gradle|md|properties)' -and 
    $_.FullName -notmatch '\\\.git\\' -and 
    $_.FullName -notmatch '\\\.idea\\' -and 
    $_.FullName -notmatch '\\build\\' 
}
$count = 0
foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        if ($null -eq $content) { continue }
        $new_content = $content -replace 'Copyright \d{4} Roberto Leinardi', 'Copyright 2024 Its-Chandan'
        $new_content = $new_content -replace 'leinardi/FloatingActionButtonSpeedDial', 'Its-Chandan/FloatingActionButtonSpeedDial'
        $new_content = $new_content -replace 'Roberto Leinardi', 'Its-Chandan'
        $new_content = $new_content -replace 'roberto\.leinardi@gmail\.com', ''
        
        if ($new_content -cne $content) {
            # Use UTF-8 without BOM
            $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
            [System.IO.File]::WriteAllText($file.FullName, $new_content, $utf8NoBom)
            $count++
        }
    } catch {
        Write-Output "Failed: $($file.FullName)"
    }
}
Write-Output "Replaced copyright in $count files"
