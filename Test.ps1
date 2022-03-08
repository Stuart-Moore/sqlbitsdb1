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
    # Set-Location ..


    # $sqlUser = 'sqltest'
    # $sqlPasswd = ConvertTo-SecureString $env:SQL_PASSWD -AsPlainText -Force
    # $sqlCred = New-Object System.Management.Automation.PSCredential ($env:SQL_USER, $sqlPasswd)


    $sqlUser = 'sqltest'
    $sqlPasswd = ConvertTo-SecureString 'P@ssw0rdl!ng' -AsPlainText -Force
    $sqlCred = New-Object System.Management.Automation.PSCredential ($sqluser, $sqlPasswd)

    $server = Connect-DbaInstance -SqlInstance $env:SQLHOST -SqlCredential $sqlcred -verbose
    $query = Get-Content "..\roles1.sql" -raw 
    $server.Databases['master'].ExecuteNonQuery($query)

    # $sqlCred = New-Object System.Management.Automation.PSCredential ($env:SQL_USER, $env:SQL_PASSWD)
    $config = Get-Content ../roles1.json -raw | ConvertFrom-Json
    $results = Invoke-DssTest -sqlinstance $env:SQLHOST -sqlcredential $sqlCred -config $config -database roles1

    $results.failedTestCount | Should -Be 0 -Because 'There should be no failing test'