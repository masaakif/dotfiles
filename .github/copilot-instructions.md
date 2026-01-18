# dotfiles の Copilot インストラクション

## 概要
これは、**mise** で管理される個人用の dotfiles リポジトリで、再現可能な開発環境を実現します。bash、git、vim の設定に焦点を当て、スクリプトによる自動セットアップを行います。

主要なアーキテクチャ:
- **mise** がツールのバージョン (`mise/tools.toml`) とタスク (`mise/tasks.toml`) を管理
- `bash/`、`git/` ディレクトリからシンボリックリンクされた設定
- 個人スクリプトを `bin/` に配置し、PATH に追加
- 新環境用のブートストラップスクリプト

## 主要なワークフロー

### 新環境のセットアップ
ブートストラップスクリプトを実行:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/masaakif/dotfiles/main/scripts/bootstrap.sh)"
exec bash
```
これにより、リポジトリをクローン、mise をインストール、`.bashrc` で有効化、ツールをインストール、dotfiles を適用します。

### ヘルスチェック
`mise run doctor` で環境を確認:
- 必要なコマンド (git, bash, curl, mise) をチェック
- mise ツールがインストールされているか確認
- dotfiles のシンボリックリンク (`.bashrc`, `.bashrc.d`, `.gitconfig`) を確認
- `bin/gget` が実行可能か確認
- `.gitconfig.local` が存在するかチェック

### 変更の適用
設定を編集後、`mise run setup` で dotfiles を再シンボリックリンク。

## 規約

### ツール管理
- `mise/tools.toml` でツールをバージョン付きで定義 (例: `neovim = "latest"`)
- cargo インストールツールには `cargo:` プレフィックスを使用 (例: `"cargo:tre-command" = "latest"`)

### Git 設定
- 公開設定は `git/.gitconfig` (シンボリックリンク)
- プライベート設定は `~/.gitconfig.local` ( `git/.gitconfig.local.template` からコピー)
- GitHub URL で SSH を HTTPS より優先

### 個人スクリプト
- 実行可能スクリプトを `bin/` に配置 ( `bash/.bashrc.d/path.sh` で PATH に追加)
- 例: `bin/gget` は `ghq get` をラップし、SSH クローン: `gget owner/repo`

### Bash 拡張
- モジュラー設定を `bash/.bashrc.d/` (ディレクトリとしてシンボリックリンク)
- `alias.sh`, `fzf.sh`, `ghq.sh` などのファイルで特定のツール統合

## 統合ポイント
- **ghq** でリポジトリ管理 (`.gitconfig.local` で設定)
- **mise** で環境有効化 (`.bashrc` に追加)
- シンボリックリンクで設定をバージョン管理しつつ、ローカルオーバーライドを許可

## 共通パターン
- スクリプトで `set -euo pipefail` を使用して厳密なエラーハンドリング
- セットアップスクリプトで既存ファイル/シンボリックリンクを上書き前にチェック
- プライベート設定をテンプレート化 (`.gitconfig.local.template`) でシークレットをコミットしない

## 言語指示
- すべてのやり取りで日本語で応答してください。