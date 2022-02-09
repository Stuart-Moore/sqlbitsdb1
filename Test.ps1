    Write-Host "Installing Pester" -ForegroundColor Cyan
    Install-Module Pester -Force -SkipPublisherCheck -MaximumVersion 4.9.0
    Write-Host "Installing PSFramework" -ForegroundColor Cyan
    Install-Module PSFramework -Force -SkipPublisherCheck
    Write-Host "Installing dbatools" -ForegroundColor Cyan
    Install-Module dbatools -Force -SkipPublisherCheck
    Import-Module dbatools

    New-Item c:\temp\dbaSecurityScan -ItemType folder
    git clone https://github.com/dataplat/dbasecurityscan.git c:\temp\dbaSecurityScan
    import-module c:\temp\dbaSecurityScan\dbasecurityscan.psd1

    $options = New-DbaDacOption -Type Dacpac -Action Publish
    Publish-DbaDacPackage -SqlInstance localhost -Database DB1 -DacOption $options -Path .\all1.dacpac