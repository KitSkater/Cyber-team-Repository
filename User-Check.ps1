# === User Account Verification Script ===
# Ensures only authorized users and administrators exist on the system.

# --- Define authorized users and administrators ---
# >>> CHANGE THIS SECTION BEFORE RUNNING <<<
$authorizedUsers = @("authorizedUser1", "authorizedUser2")
$authorizedAdmins = @("admin1", "admin2")

$allUsers = Get-LocalUser | Select-Object -ExpandProperty Name
$currentAdmins = Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name

--
foreach ($user in $allUsers) {
    if (($authorizedUsers -notcontains $user) -and ($authorizedAdmins -notcontains $user)) {
        if ($user -notin @("Administrator", "Guest", "DefaultAccount", "WDAGUtilityAccount")) {
            Remove-LocalUser -Name $user -ErrorAction SilentlyContinue
            Write-Output "Removed unauthorized user: $user"
        }
    }
}


foreach ($admin in $currentAdmins) {
    $adminName = ($admin -split "\\")[-1]
    if ($authorizedAdmins -notcontains $adminName) {
        Remove-LocalGroupMember -Group "Administrators" -Member $adminName -ErrorAction SilentlyContinue
        Write-Output "Removed unauthorized admin privileges: $adminName"
    }
}

Write-Output "User and admin verification complete."
