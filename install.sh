#/usr/bin/env bash

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    echo ln -s $f ~/.
done

if [[ true ]]; then
    echo ln -s cygwin-setup.sh /usr/local/bin/.
    echo ln -s dein_installer.sh ~/.
fi
