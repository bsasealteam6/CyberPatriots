New-PSDrive HKCR Registry HKEY_CLASSES_ROOT
New-Item 'HKCR:\Microsoft.PowerShellScript.1\Shell\Run with PowerShell (Admin)'
New-Item 'HKCR:\Microsoft.PowerShellScript.1\Shell\Run with PowerShell (Admin)\Command'
Set-ItemProperty 'HKCR:\Microsoft.PowerShellScript.1\Shell\Run with PowerShell (Admin)\Command' '(Default)' '"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" "-Command" ""& {Start-Process PowerShell.exe -ArgumentList ''-ExecutionPolicy RemoteSigned -File \"%1\"'' -Verb RunAs}"'

New-Item 'HKCR:\Microsoft.PowerShellScript.1\Shell\Edit with PowerShell ISE (Admin)'
New-Item 'HKCR:\Microsoft.PowerShellScript.1\Shell\Edit with PowerShell ISE (Admin)\Command'
Set-ItemProperty 'HKCR:\Microsoft.PowerShellScript.1\Shell\Edit with PowerShell ISE (Admin)\Command' '(Default)' '"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" "-Command" ""& {Start-Process PowerShell_ISE.exe \"%1\"'' -Verb RunAs}"'
