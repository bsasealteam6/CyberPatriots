$users = Get-WmiObject -Class Win32_UserAccount
$Computername = $env:COMPUTERNAME
$ADSIComp = [adsi]"WinNT://$Computername"
$administrators = [adsi]"$ADSIComp/Administrators,group"
$a = new-object -comobject wscript.shell
foreach ($user in $users) {
    echo $user
    $username = $user.Name
    $del = $a.popup("Do you want to remove "+$username+"?", 0,"Delete Files",4+256+32)
#    $del = Read-Host "Would you like to remove" $username"?"
    $usera = [adsi]"$ADSIComp/$user,user"
    if($del -eq 6)
    {
        $ADSIComp.Delete('User',$username) 

    }
    elseif(false)
    {
        $admin = $a.popup("Do you want "+$username+" to be an admin?", 0,"Delete Files",4+256+32)
        if($admin -eq "y")
        {
            $administrators.Add($usera.path)
            $administrators.SetInfo()
        }
        else
        {
            
        }
    }
}
$addUsers = $a.popup("Do you want to add any users?", 0,"Delete Files",4+256+32)
if($addUsers -eq "6")
{
    [Array]$users
    [int]$numUsers = Read-Host "How many users would you like to add? (Enter only numbers in this field)"
    echo $numUsers
    for ($i = 0; $i -lt $numUsers; $i++)
    {
        $i++
        $user = New-Object –TypeName PSObject
        $username = Read-Host "Username for user number" $i":"
        $password = Read-Host "Password for user number" $i":"
        $group = Read-Host "Group for user number" $i":"
        $user | Add-Member –MemberType NoteProperty –Name username –Value $username 
        $user | Add-Member –MemberType NoteProperty –Name password –Value $password
        $user | Add-Member –MemberType NoteProperty –Name group –Value $group
        $users+= $user
        $i--
    }
    echo $users
    foreach ($userinfo in $users)
    {
        $user = $ADSIComp.Create("User",$userinfo.username)
        $user.SetPassword($userinfo.password)
        $user.SetInfo()
    }
}