$env:DOTNET_ROOT = "$PSScriptRoot\cli-tools\dotnet\sdks\8.0"
$env:Path = "$env:DOTNET_ROOT;$env:Path"
& "$PSScriptRoot\VSCode-win32-arm64\Code.exe"