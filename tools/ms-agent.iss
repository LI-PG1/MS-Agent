; MS-Agent (Interview Assistant) Vision Edition - Inno Setup 6 script
#define MyAppName "MS-Agent（面试助手Agent）视觉版"
; 版本号由 build-release.ps1 从 git tag 通过 /DMyAppVersion= 注入（避免写死导致
; 安装包名与实际代码版本脱节）；未注入时回退到下方默认值
#ifndef MyAppVersion
#define MyAppVersion "0.4.18"
#endif
#define MyAppPublisher "LinusLI"
#define MyAppURL "https://github.com/LI-PG1/MS-Agent"
#define MyAppExeName "启动面试助手Agent.bat"

[Setup]
AppId={{4569721A-53C7-4066-8177-ECCF721E8FE8}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={localappdata}\MS-Agent
DefaultGroupName=MS-Agent
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
OutputDir=_dist
OutputBaseFilename=MS-Agent-v{#MyAppVersion}-setup
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
UninstallDisplayName={#MyAppName}

[Languages]
Name: "chinesesimplified"; MessagesFile: "languages\ChineseSimplified.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "startmenuicon"; Description: "创建开始菜单快捷方式"; GroupDescription: "快捷方式："
Name: "desktopicon"; Description: "创建桌面快捷方式"; GroupDescription: "快捷方式："; Flags: unchecked

[Files]
Source: "_staging\*"; DestDir: "{app}"; Flags: recursesubdirs createallsubdirs ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; Tasks: startmenuicon
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "启动 MS-Agent"; Flags: postinstall nowait skipifsilent

; Uninstall removes program-generated files (unpacked runtime, deps, local config).
; User materials under 30_产出 / 10_知识库 are kept intentionally.
[UninstallDelete]
Type: filesandordirs; Name: "{app}\runtime\node"
Type: filesandordirs; Name: "{app}\MS-Agent工程文件\20_执行\node_modules"
Type: files; Name: "{app}\MS-Agent工程文件\20_执行\config.json"
