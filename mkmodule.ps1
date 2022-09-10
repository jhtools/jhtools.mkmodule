
param(
    [Parameter(Mandatory = $false)]
    [string]$Module = [System.IO.Path]::GetFileNameWithoutExtension($(Get-Location)),
    [Parameter(Mandatory = $false)]
    [string]$CompanyName = "Company Name",
    [Parameter(Mandatory = $false)]
    [string]$Author = $null,
    [Parameter(Mandatory = $false)]
    [string]$Destination = (Get-Location)
)

if ([String]::IsNullOrEmpty($Author)) {
    $Author = $CompanyName
}

if (-not (Test-Path $Destination)) {
    New-Item -ItemType Directory -Path $Destination | Out-Null
}

$guid = [guid]::NewGuid()

$scriptDirectory = $PSScriptRoot
Get-Content -Path "$scriptDirectory/template.psd1"
| ForEach-Object {
    $_ -replace '\[Module\]', $Module -replace '\[CompanyName\]', $CompanyName -replace '\[Author\]', $Author -replace '\[Guid\]', $guid
}
| Out-File -FilePath "$Destination/$Module.psd1"

Copy-Item -Path "$scriptDirectory/template.psm1" -Destination "$Destination/$Module.psm1"

New-Item -ItemType Directory -Path "$Destination/Public" | Out-Null
New-Item -ItemType Directory -Path "$Destination/Private" | Out-Null
