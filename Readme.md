# Portable VSCode PowerShell development environment

This is a portable development environment for PowerShell using [Visual Studio Code Portable Mode](https://code.visualstudio.com/docs/editor/portable), so the User computer can use it without installing VSCode, git, PowerShell v7+.

The benefit to use this portable development environment is providing a cleaner PowerShell environment for TDD( Test Driven Development), it will not being affected by host machine's *Windows PowerShell* module, and by using a open-sourced [ModuleFast](https://github.com/JustinGrote/ModuleFast) to install PowerShell modules, the testing modules will not pollute User computer.

## Pre-requisites

- Windows 10 or Windows 11 x64 environment
- Download the portable (zip) distribution from the release page:
  - [VSCode ARM64 zip](https://code.visualstudio.com/download)
  - [PowerShell v7.+ stable release zip(PowerShell-7.x.x-win-arm64.zip)](https://github.com/PowerShell/PowerShell/releases/)
  - [.NET v8.x SDK ARM64 zip](https://dotnet.microsoft.com/download/dotnet/8.0)
  - [Git Portable ARM64(PortableGit-x.x.x-arm64.7z.exe)](https://github.com/git-for-windows/git/releases)
  - (Optional) [im-select x64 pre-build executable](https://github.com/daipeihust/im-select/tree/master/win/out/x64) if you want to use Vim extension in VSCode.
- Extract the zip file to the desired location:
  - VSCode to **VSCode-win32-arm64** folder, be sure to not overwrite the `data` folder symbolic link.
  - PowerShell to **PowerShell-arm64** folder.
  - .NET SDK to **cli-tools\dotnet\sdks\8.0** folder, and add this folder's absolute path to the `PATH` environment variable(either User Level or System Level are fine).
  - Git to **PortableGit** folder.
  - (Optional) im-select.exe to **cli-tools** folder if you want to use Vim extension in VSCode.
- Download latest [PowerShell for Visual Studio Code extension install file(*.vsix*)](https://github.com/PowerShell/vscode-powershell/releases/)
- Download [**.NET Install Tool**](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.vscode-dotnet-runtime).
- Download [**C# for Visual Studio Code** x64 version](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp)
- (Optional) Download [Vim Visual Studio Code extension install file(*.vsix*)](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim) if you want to use Vim extension in VSCode.
- Download [ModuleFast v0.5.1 zip](https://github.com/JustinGrote/ModuleFast/releases/tag/v0.5.1) PowerShell module and extract to **pwsh_modules\ModuleFast\0.5.1** folder.

## Modify settings.json before first run

1: The configuration file is at  **vscode_data\user-data\User\settings.json**, open it with a text editor and modify all absolute path value (default is written as `D:\\vscode_portable\\`) to match the actual path in your computer.

2: Make sure the `data` folder symbolic link in **VSCode-win32-arm64** folder is not broken (It will point to upper directory **vscode_data**).

If not, recreate the symbolic link in **VSCode-win32-arm64** folder:

```powershell
rm data
New-Item -ItemType SymbolicLink -Path data -Target .\..\vscode_data\
```

3: Make sure the `VSCode` symbolic link in top directory is not broken (It will point to *VSCode-win32-arm64/Code.exe*).

If not, recreate the symbolic link in top folder:

```powershell
rm VSCode
New-Item -ItemType SymbolicLink -Path VSCode -Target .\VSCode-win32-arm64\Code.exe
```

---

The **Update-SymLinks.ps1** script in **pwsh-scripts** folder can automate the above step 2 and 3, on cmd or Windows PowerShell with Administrator right (or turn on Developer mode in Settings in Windows10/11), run:

```powershell
.\PowerShell-arm64\pwsh.exe -nop -c .\pwsh-scripts\Update-SymLinks.ps1 
```

Optional:  
If you want to use Vim extension, be sure to un-comment and update the related setting below `// Vim extension settings`.

## Start VSCode

Run `VSCode-win32-arm64\Code.exe` or the **VSCode** symbolic link in root folder to start the portable VSCode, and install the *PowerShell*, *.NET Install Tool*, *C# for Visual Studio Code*, and (Optional) *Vim* extensions from the ***.vsix*** files that download before.  
([how to install VSCode extension from ***.vsix*** file](https://code.visualstudio.com/docs/editor/extension-marketplace#_install-from-a-vsix).)

## How to install PowerShell modules

This portable development environment has configure the **pwsh_modules** folder to be the first PowerShell module probing path, so we can use `Install-ModuleFast` cmdlet of [ModuleFast](https://github.com/JustinGrote/ModuleFast) to install PowerShell modules to **pwsh_modules** folder without polluting the host machine.

For example, to install [dumPS](https://github.com/deadlydog/PowerShell.dumPS) PowerShell module from PowerShell Gallery, in Integrated Terminal of VSCode, run:

```powershell
Install-ModuleFast -Name dumPS -Destination D:\vscode_portable\pwsh_modules
```

To install test framework [Pester](https://pester.dev/) from nuget.org and specify to install version v5.5.0 , in Integrated Terminal of VSCode, run:

```powershell
@{ModuleName='Pester';ModuleVersion='5.5.0'} | Install-ModuleFast -Source api.nuget.org/v3 -Destination D:\vscode_portable\pwsh_modules
```

so the Pester module will be installed to `pwsh_modules\Pester\5.5.0` folder, and ready for using in this portable development environment.

## How to update various components

- When you want to update the VSCode portable version, just replace all file except the `data` folder symbolic link with the updated VSCode zip distribution in **VSCode-Win32-arm64** directory.
- When you want to update the PowerShell version, just replace all file with the updated PowerShell zip distribution in **PowerShell-arm64** directory.
- When you want to update the Git portable version, just replace all file with the updated Git zip distribution in **PortableGit** directory.
