# Get all PowerShell scripts in subfolders
$scripts = Get-ChildItem -Path "." -Recurse -Include "backup.ps1"

# Loop through each script and execute it
foreach ($script in $scripts) {
    Invoke-Expression "& `"$($script.FullName)`""
}
