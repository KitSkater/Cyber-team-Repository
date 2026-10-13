
Import-Module LocalAccount


Set-LocalPolicy -Name 'PasswordPolicy' -Value @{
    'EnforcePasswordHistory' = 24
    'MaximumPasswordAge'     = 60
    'MinimumPasswordAge'     = 0
    'MinimumPasswordLength'  = 10
    'PasswordMustMeetComplexity' = $true
    'StorePasswordUsingReversibleEncryption' = $false
}


Set-LocalPolicy -Name 'LockoutPolicy' -Value @{
    'AccountLockoutDuration'   = '00:30:00'
    'AccountLockoutThreshold'  = 10
    'ResetAccountLockoutCounterAfter' = 30
}