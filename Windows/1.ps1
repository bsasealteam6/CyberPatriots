$users = Get-WmiObject -Class Win32_UserAccount
$Computername = $env:COMPUTERNAME
$ADSIComp = [adsi]"WinNT://$Computername"
$administrators = [adsi]"$ADSIComp/administrators,group"

foreach ($user in $users) {
    echo $user
    $username = $user.Name
    $del = Read-Host "Would you like to remove" $username"?"
    $usera = [adsi]"$ADSIComp/$user,user"
    if($del -eq "y")
    {
        $ADSIComp.Delete('User',$username) 

    }
    else
    {
        $admin = Read-Host "Is $username supposed to be an Admin account?"
        if($admin -eq "y")
        {
            $administrators.Add($usera)
        }
        else
        {
            
        }
    }
}
$addUsers = Read-Host "Would you like to add any users?"
if($addUsers -eq "y")
{
    [Array]$users
    [int]$numUsers = Read-Host "How many users would you like to add? (Enter only numbers in this field)"
    echo $numUsers
    for ($i = 0; $i -lt $numUsers; $i++)
    {
        $user = New-Object –TypeName PSObject
        $username = Read-Host "Username for user number" $i":"
        $password = Read-Host -AsSecureString "Password for user number" $i":"
        $group = Read-Host "Group for user number" $i":"
        $user | Add-Member –MemberType NoteProperty –Name username –Value $username 
        $user | Add-Member –MemberType NoteProperty –Name password –Value $password
        $user | Add-Member –MemberType NoteProperty –Name group –Value $group
        $users+= $user
    }
    echo $users
}