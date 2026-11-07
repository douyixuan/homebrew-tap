# iStickies2 CLI Homebrew tap

Installs the independent `istk` command, not the iStickies2 GUI App and not Apple Stickies/stk.
Apple Silicon Macs only, macOS 14 or later. Runtime CI uses macOS 26 ARM64.

```sh
brew install douyixuan/tap/istk
```

Update:

```sh
brew update && brew upgrade douyixuan/tap/istk
```

Try a new isolated profile:

```sh
istk version
profile="$(mktemp -d -t istk-demo)"
istk --dir "$profile" add 'Synthetic example'
istk --dir "$profile" list
istk --dir "$profile" search 'Synthetic'
istk --dir "$profile" get '<id returned by add>'
```

All data commands require an explicit `--dir`. The same profile lock as the App is used:
App-held locks permit reads but refuse writes. Old-profile writes upgrade to schema 10,
which old 0.3 clients cannot read. Do not point a trial at daily data. Before a real
upgrade, close the App normally and verify a complete profile backup. Rollback requires
the whole old profile and a compatible old App; rolling back the executable alone is insufficient.

CLI releases are ad-hoc signed and not notarized. No App launch, GUI installation,
account creation or security-setting changes occur. Formula tests use synthetic data.

Release source and acceptance evidence: https://github.com/douyixuan/stickies/releases/tag/cli-v1.0.0
The formula pins the real versioned release URL and SHA-256. Subsequent updates must
use the source repository's verified release formula generator; do not use `latest` URLs.
