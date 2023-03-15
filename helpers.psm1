function Create-DatedDirectory {
    param(
        [Parameter(Mandatory=$true)]
        [string]$folderPath
    )

    # Get the current date and format it as YYYY-MM-DD
    $dateString = Get-Date -Format "yyyy-MM-dd"

    # Combine the folder path and date string to create the directory path
    $directoryPath = Join-Path -Path $folderPath -ChildPath $dateString

    # Check if the directory already exists, if not, create it
    if (-not (Test-Path -Path $directoryPath -PathType Container)) {
        New-Item -ItemType Directory -Path $directoryPath
    }
}