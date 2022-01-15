#last edit 3oct16
Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v1.1.12653/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -OutFile "C:\PS\WinGet.msixbundle"
Add-AppxPackage "C:\PS\WinGet.msixbundle"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
$users = Get-WmiObject -Class Win32_UserAccount
$Computername = $env:COMPUTERNAME
$ADSIComp = [adsi]"WinNT://$Computername"
$administrators = [adsi]"$ADSIComp/Administrators,group"
$a = new-object -comobject wscript.shell
foreach ($user in $users) {
    #echo $user
    $username = $user.Name
    $del = $a.popup("Do you want to remove "+$username+"?", 0,"Delete Files",4+256+32)
#    $del = Read-Host "Would you like to remove" $username"?"
    $usera = [adsi]"$ADSIComp/$user,user"
    if($del -eq 6)
    {
        $ADSIComp.Delete('User',$username) 

    }
    elseif(false)
    #else
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
$users = Get-WmiObject -Class Win32_UserAccount
#echo $users
$addUsers = $a.popup("Do you want to add any users?", 0,"Delete Files",4+256+32)
if($addUsers -eq "6")
{
    [Array]$newUsers = @()
    [int]$numUsers = Read-Host "How many users would you like to add? (Enter only numbers in this field)"
    #echo $numUsers
    for ($i = 0; $i -lt $numUsers; $i++)
    {
        $i++
        $user = New-Object �TypeName PSObject
        [String]$username = Read-Host "Username for user number" $i":"
        $password = Read-Host -AsSecureString "Password for user number" $i":"
#        $group = Read-Host "Group for user number" $i":"
        $user | Add-Member �MemberType NoteProperty �Name username �Value $username 
        $user | Add-Member �MemberType NoteProperty �Name password �Value $password
#        $user | Add-Member �MemberType NoteProperty �Name group �Value $group
        $newUsers+= $user
        $i--
    }
    #echo $users
    foreach ($userinfo in $newUsers)
    {
        #$CompObject = [ADSI]"WinNT://$Computer"
        #$NewObj = $CompObject.Create("$ObjectType",$ObjectName)
        echo $userinfo.username
        
        $user = $ADSIComp.Create("User",$userinfo.username)
        $BSTR = [system.runtime.interopservices.marshal]::SecureStringToBSTR($userinfo.password)

        $_password = [system.runtime.interopservices.marshal]::PtrToStringAuto($BSTR)
        #Set password on account 

        $user.SetPassword($_password)

        $user.SetInfo()


        #Cleanup 

        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR) 

        Remove-Variable Password,BSTR,_password 
        
    }
}
choco install -y Malwarebytes 0patch virtualbox-guest-additions-guest.install nano 
Get-WindowsUpdate
Install-WindowsUpdate
winget upgrade --all