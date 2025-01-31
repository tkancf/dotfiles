# tkancf/dotfiles

## 事前準備

- [homebrew](https://brew.sh/)のインストール
- [chezmoi](https://www.chezmoi.io/)のインストール

### homebrewのインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### chezmoiのインストール

```bash
brew install chezmoi
```

## 初期設定

```bash
chezmoi init tkancf --apply --ssh -v
```

