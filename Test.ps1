    Write-Host "Installing Pester" -ForegroundColor Cyan
    Install-Module Pester -Force -SkipPublisherCheck -MaximumVersion 4.9.0
    Import-Module Pester
    Write-Host "Installing PSFramework" -ForegroundColor Cyan
    Install-Module PSFramework -Force -SkipPublisherCheck
    Import-Module PSFramework
    Write-Host "Installing dbatools" -ForegroundColor Cyan
    Install-Module dbatools -Force -SkipPublisherCheck
    Import-Module dbatools

    New-Item .\dbaSecurityScan -ItemType Directory
    git clone https://github.com/dataplat/dbasecurityscan.git .\dbaSecurityScan

    Write-Host "Install dss"
    set-location .\dbaSecurityScan
    import-module .\dbaSecurityScan.psd1

    $script:appvPassword = ConvertTo-SecureString 'P@ssw0rdl!ng' -AsPlainText -Force
    $script:appvSqlCredential = New-Object System.Management.Automation.PSCredential ('sa', $script:appvPassword)
    Write-Host "Install DacPac"
    Write-Host "Where - $($ENV:GITHUB_WORKSPACE)"
    Write-host "full path $($ENV:GITHUB_WORKSPACE)\all1.dacpac"
    $tf = Test-path "$($ENV:GITHUB_WORKSPACE)\all1.dacpac"
    write-Host "path test - $tf"
    Set-Location $ENV:GITHUB_WORKSPACE
    Get-ChildItem
# call sqlpackage.exe to deploy my db schema using my dacpac
