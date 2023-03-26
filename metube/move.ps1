$sourceDirectory = "."
$destinationDirectory = "G:\YouTube"

# Create the destination directory if it doesn't already exist
if(!(Test-Path -Path $destinationDirectory)){
    New-Item -ItemType Directory -Path $destinationDirectory
}

# Get all .mp4 files in the source directory
$mp4Files = Get-ChildItem -Path $sourceDirectory -Filter *.mp4

# Move each .mp4 file to the destination directory
foreach($file in $mp4Files){
    Move-Item -Path $file.FullName -Destination $destinationDirectory -Force
}
