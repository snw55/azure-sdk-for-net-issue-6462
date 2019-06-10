Param(
    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName = 'tmp-azure-issue-6462',

    [Parameter(Mandatory = $false)]
    [string]$Location = 'WestEurope'
)

$ErrorActionPreference = 'Stop'


### Resource group
$ResourceGroup = Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue
if ([String]::IsNullOrEmpty($ResourceGroup) -eq $true) {
    Write-Host ("Creating ResourceGroup: {0}" -f $ResourceGroupName)
    $ResourceGroup = New-AzResourceGroup -Name $ResourceGroupName -Location $Location
    $ResourceGroup = Get-AzResourceGroup -Name $ResourceGroupName
}
else {
    Write-Host ("Resource group {0} already exists" -f $ResourceGroupName)
}
Write-Host ("Using resource group {0}" -f $ResourceGroup.ResourceId)


### ARM template
$DeploymentParams = @{
    ResourceGroupName = $ResourceGroupName
    TemplateFile = ("{0}\template.json" -f $PSScriptRoot)
    TemplateParameterFile = ("{0}\template.params.json" -f $PSScriptRoot)
}
Write-Host "Checking template and params"
$TemplateErrors = Test-AzResourceGroupDeployment @DeploymentParams
if ([String]::IsNullOrEmpty($TemplateErrors) -eq $true) {
    Write-Host "Template and params are valid"
} else {
    Write-Host $TemplateErrors.Message
}

Write-Host "Starting new resource deployment"
$Deployment = New-AzResourceGroupDeployment @DeploymentParams
Write-Host ("Deployment concluded with state: {0}" -f $Deployment.ProvisioningState)
