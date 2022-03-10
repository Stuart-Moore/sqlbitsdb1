
$downloadPath = 'c:\temp'

$installerPath = Start-DownloadWithRetry -Url $installerUrl -DownloadPath $downloadPath -Name "SQL2019-SSEI-Expr.exe"

Start-Process msiexec.exe -Wait -ArgumentList "'/I $installerPath /quiet'"