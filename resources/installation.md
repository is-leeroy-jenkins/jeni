# Jeni Windows Installation

Jeni opens in a dedicated Microsoft Edge WebView2 window without browser tabs or an address bar. Its provider chat, financial guidance, document analysis, embedding, and vector database controls remain available. Closing the window stops the local Streamlit server.

## Requirements

- Windows x64.
- Microsoft [Edge WebView2 Runtime](https://developer.microsoft.com/en-us/microsoft-edge/webview2/).
- Disk space for the bundled scientific and machine-learning dependencies.
- Internet connectivity and your own provider credentials for online services, model downloads.

A built installer includes Python and the application dependencies. A separate Python installation is required only when building from source. No administrator privileges are required for the default per-user installation.

## Install from PyPI

After publication:

```powershell
python -m pip install jeni-py
jeni
```

`jeni` launches the tabless Windows window by default. Use `jeni-browser`
for standard browser mode, including on other operating systems.
Pywebview is included automatically when installing on Windows.
Install in a Python 3.11 or 3.12 virtual environment.
See [PyPI release instructions](pypi-release.md).

## Gemini configuration

Set `GEMINI_API_KEY` to your own Gemini API key before launching provider features.
Google Cloud Storage operations require your own Google Cloud authentication
and permissions. No credentials or user databases are bundled.

The current app uses Gemini. Provider clients and Google Cloud permissions remain configured by the user.

## Build and download from GitHub

1. Open [Jeni Actions](https://github.com/is-leeroy-jenkins/jeni/actions/workflows/windows-installer.yml).
2. Select **Build Jeni Windows desktop installer**, then **Run workflow** and the branch to build. The workflow becomes available on the default branch after the installer changes are merged.
3. Wait for all build steps to succeed.
4. Download **Jeni-Windows-Installer** from the run's **Artifacts** section and extract the ZIP.
5. Locate `Jeni-Setup-0.1.0.exe`.

The workflow builds on Windows using Python 3.11, PyInstaller, and Inno Setup 6. It runs manually and uploads an installer artifact; it does not automatically publish a GitHub Release. The source configuration is supplied here; a successful Windows build and a Windows installation test are still required before treating the installer as validated.

## Install and launch

1. Run the Setup executable downloaded from your intended workflow run. Builds are unsigned unless signing is configured separately; verify the source before accepting any Windows warning.
2. Confirm the installation directory, normally `%LOCALAPPDATA%\Programs\Jeni`.
3. Choose whether to create a desktop shortcut.
4. Finish the wizard and select **Launch Jeni**, or use the Start Menu shortcut.
5. Allow startup to complete. The launcher waits up to approximately two minutes for the local server.

The application window displays Jeni's existing Streamlit interface. “Tabless” refers to the desktop browser window; Jeni's internal workflow tabs remain available. The server binds only to `127.0.0.1` on an available port.

## Data and configuration

Writable resources, configuration, SQLite/vector data, and logs use:

```text
%LOCALAPPDATA%\Jeni
```

Bundled resources and Streamlit theme settings are copied only when a destination file does not exist. Existing user files are preserved across launches and upgrades. Development databases, logs, and `.streamlit/secrets.toml` are excluded from the executable build.

Provider credentials can be supplied using the environment variables defined in `config.py`, or through `%LOCALAPPDATA%\Jeni\.streamlit\secrets.toml` for features that read Streamlit secrets. Restart Jeni after changing environment variables. API keys are not supplied by the installer.

Sentence-transformer models require separate downloads. Provider chat and retrieval features require internet connectivity and your credentials. The installer is not a fully offline model bundle. Back up `%LOCALAPPDATA%\Jeni` before upgrades or resets.

## Build locally

Install Git, Python 3.11 x64, and [Inno Setup 6](https://jrsoftware.org/isinfo.php). In PowerShell:

```powershell
git clone https://github.com/is-leeroy-jenkins/jeni.git
cd jeni
py -3.11 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip setuptools wheel
python -m pip install -r requirements-desktop.txt
python desktop.py
```

Close the test window, then build:

```powershell
python -m PyInstaller --noconfirm --clean jeni.spec
& "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" "installer\jeni.iss"
```

The executable directory is `dist\Jeni`; distribute the Setup executable at `dist-installer\Jeni-Setup-0.1.0.exe`. Build on Windows, since PyInstaller does not cross-compile Windows executables from Linux.

## Troubleshooting

| Symptom | Action |
|---|---|
| Missing installer artifact | Inspect the failed workflow step; an artifact is uploaded only when the Setup executable exists. |
| Window fails to open | Install WebView2 Runtime and check `%LOCALAPPDATA%\Jeni\desktop.log`. |
| Startup server exits or times out | Inspect `desktop.log` for import errors or missing native dependencies. |
| Provider request fails | Check the applicable credentials and internet connection. |
| Local embedding model fails | Check that the selected corpus or model has been downloaded and is accessible. |
| Database or log write fails | Confirm `%LOCALAPPDATA%\Jeni` is writable. |

Before distributing a build, test startup, representative loading/processing/embedding/vector operations, persistence after restart, window-close cleanup, and uninstall on a clean Windows x64 machine with WebView2 installed.

## Upgrade and uninstall

Close Jeni, back up its user data, and run the newer Setup executable to upgrade. Uninstall through **Windows Settings → Apps → Jeni → Uninstall**. User data under `%LOCALAPPDATA%\Jeni` remains; delete it separately only if you intend to remove your documents, credentials, and databases.

[Return to README](../README.md)
