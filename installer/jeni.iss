#define MyAppName "Jeni"
#ifndef MyAppVersion
  #define MyAppVersion "0.1.0"
#endif

[Setup]
AppId={{F05C4F28-CFC3-4C24-9A43-2986F8197897}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher=is-leeroy-jenkins
DefaultDirName={localappdata}\Programs\Jeni
DefaultGroupName=Jeni
OutputDir=..\dist-installer
OutputBaseFilename=Jeni-Setup-{#MyAppVersion}
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
PrivilegesRequired=lowest
WizardStyle=modern
UninstallDisplayName=Jeni
UninstallDisplayIcon={app}\Jeni.exe
CloseApplications=yes

[Files]
Source: "..\dist\Jeni\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"

[Icons]
Name: "{group}\Jeni"; Filename: "{app}\Jeni.exe"
Name: "{autodesktop}\Jeni"; Filename: "{app}\Jeni.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\Jeni.exe"; Description: "Launch Jeni"; Flags: nowait postinstall skipifsilent
