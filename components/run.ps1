param(
    $taskList=@('Default'),
    $version="1.0.0",
    [switch]$enablePackager
)

$nugetDirectory = ".\#_srcPath_#\.nuget"
$nugetPath = Join-Path $nugetDirectory "nuget.exe"
if((Test-Path -Path $nugetPath) -eq $false){
    Write-Host "Downloading nuget to $nugetDirectory"
    New-Item -ItemType Directory -Path $nugetDirectory -Force | Out-Null
    Invoke-WebRequest -Uri "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -OutFile $nugetPath | Out-Null
} else {
    if(((Get-ChildItem $nugetPath).LastWriteTime - [DateTime]::Today).Days -lt 0){
        Write-Host "Nuget daily check" -foreground Yellow
        & $nugetPath update -self
    }
}

$psakePath = ".\#_toolsPath_#\psake\4.6.0\psake.psm1"
if((Test-Path -Path $psakePath) -eq $false){
    Write-Host "Psake module missing"
    Write-Host "Updating package provider"
    Install-PackageProvider NuGet -Force
    Write-Host "Seaching for psake package and saving local copy"
    $module = Find-Module -Name psake
    Write-Host "Psake module found. Saving local copy"
    $module | Save-Module -Path .\tools\ -Force
}

# '[p]sake' is the same as 'psake' but  is not polluted
Remove-Module [p]sake
Import-Module $psakePath

# call #_buildScript_# with properties
Invoke-Psake -buildFile ".\#_buildScript_#" -taskList $taskList -properties @{ "version" = $version; "enablePackager" = $enablePackager; }

if($psake.build_success) { exit 0 } else { exit 1 }
