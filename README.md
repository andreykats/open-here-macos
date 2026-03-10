# Open-Here for macOS Finder

Finder toolbar buttons to open the current folder in VSCode or iTerm.

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/) installed in `/Applications`
- [iTerm2](https://iterm2.com/) installed in `/Applications`

## Build

```bash
./build.sh
```

This creates two `.app` bundles in `dist/`.

## Install

1. Open the `dist/` folder in Finder
2. Hold **Cmd** and drag each `.app` onto the Finder toolbar

## Uninstall

Hold **Cmd** and drag the icon off the Finder toolbar.

## Permissions

On first use, macOS will ask to allow the app to control Finder and the target app. Click **OK** to grant access. If the button does nothing, check **System Settings > Privacy & Security > Automation**.
