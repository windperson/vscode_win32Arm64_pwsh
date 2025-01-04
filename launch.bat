@echo on
setlocal
pushd %~dp0
.\PowerShell-arm64\pwsh.exe -NoProfile -ExecutionPolicy RemoteSigned -File ".\launch.ps1"
endlocal