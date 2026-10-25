net accounts /uniquepw:24 /maxpwage:60 /minpwage:1 /minpwlen:10 `
             /lockoutthreshold:10 /lockoutduration:30 /lockoutwindow:30 .\.cache

$cfg = "$env:TEMP\secpol.cfg"
secedit /export /cfg $cfg | Out-Null

(Get-Content $cfg) `
    -replace 'PasswordComplexity\s*=\s*\d', 'PasswordComplexity = 1' `
    -replace 'ClearTextPassword\s*=\s*\d',  'ClearTextPassword = 0' |
    Set-Content $cfg

secedit /configure /db "$env:windir\security\local.sdb" /cfg $cfg /areas SECURITYPOLICY
Remove-Item $cfg
