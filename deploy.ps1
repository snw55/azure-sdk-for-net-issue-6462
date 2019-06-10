$ErrorActionPreference = 'Stop'

Invoke-Expression -Command .\app\build.ps1
Invoke-Expression -Command .\resources\provision.ps1

Publish-AzureWebsiteProject -Package .\app\drop.zip -Name "issue-6462-2083f381-app"