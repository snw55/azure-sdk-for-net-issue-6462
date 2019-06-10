Write-Host "Build & publish app"
$Command = ("dotnet publish {0}\issue\issue.csproj --configuration Release --runtime win-x64 --self-contained" -f $PSScriptRoot)
Invoke-Expression -Command $Command

Write-Host "Package artefacts"
$PublishPath = ("{0}\issue\bin\release\netcoreapp2.2\win-x64\publish\*" -f $PSScriptRoot)
Compress-Archive -Path $PublishPath -DestinationPath "drop.zip" -Force