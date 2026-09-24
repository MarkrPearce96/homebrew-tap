# homebrew-tap

Personal Homebrew tap for Mark Pearce's apps.

## Install

```bash
brew tap markrpearce96/tap
brew trust markrpearce96/tap
brew install --cask <name>
```

The `brew trust` step is needed because Homebrew refuses to install casks
from a third-party tap until you explicitly trust it — a one-time,
per-Mac step.

## Casks

- **dock-for-google** — [Dock for Google](https://github.com/MarkrPearce96/Dock-for-Google), a searchable grid launcher for Google web apps in Safari.
- **web-capture** — [Web Capture](https://github.com/MarkrPearce96/Web-Capture), a Safari full-page screenshot and annotation extension.
