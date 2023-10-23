@echo off

net SESSION 1>nul 2>nul
if %errorlevel% NEQ 0 (
  
  powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Executa como admin burrolol!', 'DEIXE DE SER MULA!', 'ok', [System.Windows.Forms.MessageBoxIcon]::Error);}"
  goto end
)




set server=br.chat.si.riotgames.com

FOR /f "tokens=1,3 delims=: " %%A IN ('ping -n 1 %server% -4') DO (
  IF %%A==Reply (
    set IPV4=%%B
  )
)

FOR /f "delims=[] tokens=2  " %%a IN ('ping -n 1 %server% -6 ^|findstr "["') DO (
   set IPV6=%%a
 )





 netsh advfirewall firewall show rule name="lolchatIPV4" | findstr /c:"No rules match the specified criteria." > NUL 2>&1
    IF %ERRORLEVEL% EQU 0 (
  color 4
  netsh advfirewall firewall add rule name="lolchatIPV4" dir=out remoteip=%IPV4% protocol=TCP action=block
  netsh advfirewall firewall add rule name="lolchatIPV6" dir=out remoteip=%IPV6% protocol=TCP action=block
  set check1=1
) else (
  color A
  netsh advfirewall firewall delete rule name=lolchatIPV4
  netsh advfirewall firewall delete rule name=lolchatIPV6
  set check1=2
)



 IF %check1%==1 (
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('OFF', 'Rules has been created!', 'ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
) else (
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('ON', 'Rules has been deleted', 'ok', [System.Windows.Forms.MessageBoxIcon]::Information);}"
)

:end

