    Write-Host "Installing Pester" -ForegroundColor Cyan
    Install-Module Pester -Force -SkipPublisherCheck -MaximumVersion 4.9.0
    Import-Module Pester
    Write-Host "Installing PSFramework" -ForegroundColor Cyan
    Install-Module PSFramework -Force -SkipPublisherCheck
    Import-Module PSFramework
    Write-Host "Installing dbatools" -ForegroundColor Cyan
    Install-Module dbatools -Force -SkipPublisherCheck
    Import-Module dbatools

    New-Item c:\temp\dbaSecurityScan -ItemType Directory
    git clone https://github.com/dataplat/dbasecurityscan.git c:\temp\dbaSecurityScan

    Write-Host "Install dss"
    import-module c:\temp\dbaSecurityScan\dbasecurityscan.psd1

    Write-Host "Install DacPac"
    Set-Location $ENV:GITHUB_WORKSPACE
    $options = New-DbaDacOption -Type Dacpac -Action Publish
    Publish-DbaDacPackage -SqlInstance localhost -Database DB1 -DacOption $options -Path .\all1.dacpac