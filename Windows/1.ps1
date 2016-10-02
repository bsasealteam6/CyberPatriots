$users = Get-WmiObject -Class Win32_UserAccount
foreach ($user in $users) {
    echo $user
    $del = Read-Host 'Would you like to remove this account?'
    if($del == "y")
    {
        $users[$user].delete
    }
}
