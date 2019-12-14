:: Set files permissions ::
set key=C:\Users\%username%\.ssh
:: Remove Inheritance ::
cmd /c icacls %key% /c /t /inheritance:d
:: Set Ownership to Owner ::
cmd /c icacls %key% /c /t /grant %username%:F
:: Remove All Users, except for Owner ::
cmd /c icacls %key%  /c /t /remove Administrator "Authenticated Users" BUILTIN\Administrators BUILTIN Everyone System Users
:: Verify ::
:: cmd /c icacls %key%

:: Start SSH demon
set my_host_key=my_host_key
cd %key%
if exist  %my_host_key% (
  rem file exists
) else (
  ssh-keygen.exe -t rsa -f %my_host_key% -N ""
)
c:\windows\system32\OpenSsh\sshd.exe -h "%cd%\%my_host_key%"
