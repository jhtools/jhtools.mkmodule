
param(
    [Parameter(Mandatory = $false)]
    [string]$Module = $null,
    [Parameter(Mandatory = $false)]
    [string]$CompanyName = "Company Name",
    [Parameter(Mandatory = $false)]
    [string]$Author = $null,
    [Parameter(Mandatory = $false)]
    [string]$Destination = (Get-Location)
)

$dir = New-Item -Path $Destination -ItemType Directory -Force


if ([string]::IsNullOrEmpty($Module)) {
    Write-Host "Destination is $($dir.Name)"
    $Module = $dir.Name
}

Write-Host "Module is $Module"

if ([String]::IsNullOrEmpty($Author)) {
    $Author = $CompanyName
}

$guid = [guid]::NewGuid()
$today = Get-Date -Format "%d.%M.%y"
$scriptDirectory = $PSScriptRoot
Get-Content -Path "$scriptDirectory/template.psd1"
| ForEach-Object {
    $_ -replace '\[Module\]', $Module `
        -replace '\[CompanyName\]', $CompanyName `
        -replace '\[Author\]', $Author `
        -replace '\[Guid\]', $guid `
        -replace '\[Today\]', $today
}
| Out-File -FilePath "$Destination/$Module.psd1"

Copy-Item -Path "$scriptDirectory/template.psm1" -Destination "$Destination/$Module.psm1"

New-Item -ItemType Directory -Path "$Destination/Public" -Force | Out-Null
New-Item -ItemType Directory -Path "$Destination/Private" -Force | Out-Null
