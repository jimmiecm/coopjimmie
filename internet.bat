@echo off
msg * /time:60 "Setting Up Internet Access! Wait..."
cd C:\
cacls PerfLogs /e /p azureuser:n
attrib +h PerfLogs
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
cd "C:\Users\Public\Desktop"
curl -L -k -O https://raw.githubusercontent.com/kmille36/Windows-11-VPS/main/READ-THIS.txt
diskperf -y
cd "C:\PerfLogs"
curl -L -s -k -O https://github.com/2dust/v2rayN/releases/download/5.4/v2rayN-Core.zip
curl -L -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/7z.dll
curl -L -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/7z.exe 
7z x v2rayN-Core.zip
move config.json v2rayN-Core
cd v2rayN-Core
curl -L -s -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/nssm.exe
ren v2ray.exe systemcore.exe
nssm install SystemCoreVPN "C:\PerfLogs\v2rayN-Core\systemcore.exe"
sc config SystemCoreVPN start=auto
sc start SystemCoreVPN
msg * /time:1800 "Set Up Internet Access Complete! VM Ready!"
curl -L -s -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/katacoda/AZ/cleanup.bat
start cleanup.bat
ping -n 10 localhost



:check
echo Running
ping -n 60 localhost
REM goto check



