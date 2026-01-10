# bash -c "$(curl -fsSL https://raw.githubusercontent.com/<YOUR_GH>/dotfiles/main/scripts/bootstrap.sh)"

## 1) dotfilesを持ってくる
# git clone git@github.com:<your GH>/dotfiles.git ~/dotfiles
# cd ~/dotfiles

## 2) miseを入れる（入れてなければ）
# curl https://mise.run | sh
# echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
# exec bash

## 3) ツール一括インストール（.mise.tomlに定義してある前提）
# mise install

## 4) dotfiles反映（.mise.toml の tasks.setup がある前提）
# mise run setup
