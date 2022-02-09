    Write-Host "Installing Pester" -ForegroundColor Cyan
    Install-Module Pester -Force -SkipPublisherCheck -MaximumVersion 4.9.0
    Install-Module Pester -Force -SkipPublisherCheck 
    Write-Host "Installing PSFramework" -ForegroundColor Cyan
    Install-Module PSFramework -Force -SkipPublisherCheck
    Write-Host "Installing dbatools" -ForegroundColor Cyan
    Install-Module dbatools -Force -SkipPublisherCheck
    Import-Module dbatools

    git clone https://github.com/dataplat/dbasecurityscan.git ../dbaSecurityScan
    import-module ../dbaSecurityScan/dbasecurityscan/dbasecurityscan.psd1

    $options = New-DbaDacOption -Type Dacpac -Action Publish
    Publish-DbaDacPackage -SqlInstance sql2016 -Database DB1 -DacOption $options -Path c:\temp\db.dacpac