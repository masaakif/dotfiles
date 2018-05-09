#!/usr/bin/env bash
__dodot() {
    local target=$1
    local cwd=`pwd`
    local dest="$HOME/my_work/study/dotfiles"
    mv "$cwd/$target" "$dest/$target"
    ln -s "$dest/$target" "$cwd/$target"
}

__open_file_under_dropbox() {
    local filename=$1
    vi /c/Users/fujiwara/Dropbox/$1
}

function command_not_found_handle() {
    if [ -e /usr/local/bin/jp2a ]; then
        if [ -e ~/my_work/pictures/error_pics ]; then
            cols=`echo "$(tput cols) * 95 / 100" | bc`

            if [ 168 -le $cols ]; then
                cols=168
            fi
            jp2a --invert --colors --width=${cols} /home/fujiwara/my_work/pictures/error_pics/八九寺真宵_両頬に指をあてるぶりっこポーズ.jpg
            #jp2a --invert --colors --term-zoom --term-fit /home/fujiwara/my_work/pictures/error_pics/八九寺真宵_両頬に指をあてるぶりっこポーズ.jpg
        fi
    fi
    echo -e "\n\n$1…………失礼、噛みまみた"
}

__grep_error() {
    local target_dir=$1
    if [ `echo $target_dir | grep -i 'store' ` ]; then
        find $target_dir -name "*.php" -exec grep -nH -e "setFlash" -e "throw" {} \;
    else
        find $target_dir -type d \( -name vendor -o -name fusionchart -o -name htmlpurifier -o -name  Jsphone -name Net -name phpexcel-1.7.6 -name tcpdf \) -prune -o -name "*.php" -exec grep -nHF "'result' => " {} \; | grep -vi "=> TRUE"
    fi
}

__reload() {
  source ~/.bashrc
  return 0
}

__rsync_ssh() {
    rsync --update --progress --itemize-changes //bpfs003/share/Technical/運用管理/amazon_web_service/KeyPair/* /c/Users/fujiwara/.ssh/.
    rsync --update --progress --itemize-changes /c/Users/fujiwara/.ssh/* ~/.ssh/.
}

__edit_dwm() {
  DWM_HOME="${HOME}/work/cygwin_setup/dwm-6.1"
  cp ${DWM_HOME}/config.h ${DWM_HOME}/config.h.$(date +%Y%m%d-%H%M%S)
  vim ${DWM_HOME}/config.h
}

__make_dwm() {
  DWM_HOME="${HOME}/work/cygwin_setup/dwm-6.1"
  pushd $DWM_HOME
  make && make install
  popd
}

__scm_branch() {
    DIR=$@
    if [ "$DIR" = "" ]; then
        DIR=$(pwd)
    fi

    if [ "$(cd ${DIR};pwd)" = "/" ]; then
        exit 1
    fi

    if [ -d "${DIR}/.hg" -o -d "${DIR}/.git" ]; then
        if [ -d "${DIR}/.hg" ]; then
            echo -e "(hg:$(hg branch 2>/dev/null))"
        else
            local branch=$(git branch 2>/dev/null | grep '\*' | cut -d ' ' -f 2)
#            git status | grep add &>/dev/null

#            if [ $? -eq 0 ]; then
#                local modified="[✘]"
#            else
#                local modified=""
#            fi
            #echo -e "\e[35m(git:$(git branch 2>/dev/null | grep '\*' | cut -d ' ' -f 2)$modified_flag)"
            #echo -e "\e[35m(git:${branch}${modified})"
            echo -e "\e[35m(git:${branch})"
        fi
        exit 0
    else
        __scm_branch ${DIR}/..
    fi
}
#__scm_branchqqqq() {
#    local branch=`hg branch 2>/dev/null`
#    if [ -n "$branch" ]; then
#        echo -e "\n(hg:${branch})"
#    else
#        local branch=`git branch 2>/dev/null | grep "\*" | cut -d " " -f 2`
#        if [ -n "$branch" ]; then
#            echo -e "\n(git:${branch})"
#        fi
#    fi
#    return 0
#}

__git_branch() {
  git branch 1>/dev/null 2>&1
  if [ $? -eq 0 ]; then
    local branch=`git branch | grep "\*" | cut -d " " -f 2`
    echo -e "\n(git:${branch})"
  fi
  return 0
}

__hg_branch() {
    hg branch &>/dev/null
    if [ $? -eq 0 ]; then
        hg branch | awk '{print "\n(hg:" $1 ")"}'
    fi
    return 0
}

__datetime_ps1() {
  echo `date '+%Y/%m/%d %H:%M:%S'` 2>/dev/null
}

__git_push_origin_master() {
  git branch 1>/dev/null 2>&1
  if [ $? -eq 0 ]; then
    local branch=`git branch | grep "\*" | cut -d " " -f 2`
    git push origin ${branch}
  fi
  return 0
}

__git_checkout_with_partial_match() {
  local pattern=$1
  local option=$2
  git branch 1>/dev/null 2>&1
  if [ $? -eq 0 ]; then
    local branch=`git branch -a | grep $pattern | head -1 | sed -e "s/remotes\/origin\///"`
    if [[ ${branch} != "" ]]; then
      if [[ ${option} != "" ]]; then
        local gitcmd="git checkout $2 "
      else
        local gitcmd="git checkout "
      fi
      echo Change to ${branch}
      "${gitcmd} ${branch}"
    else
      echo Given branch $pattern does not exist.
    fi
  fi
  return 0
}

MSO_DIR="/c/Program\ Files\ \(x86\)/Microsoft\ Office/root/office16"
__mso_excel() {
  CMD="${MSO_DIR}/excel.exe  "'"$@" &'
  eval $CMD 1>/dev/null 2>&1

}

__cdgit() {
  cd ~/work/git/$1
}

__cdprj() {
  cd ~/work/projects/$1
}

__cdmy() {
  cd ~/my_work/$1
}

__mkdir_and_cd() {
  mkdir $1
  cd $1
}

__google() {
  CMD="/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe 'https://www.google.co.jp/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=$@'"
  eval $CMD
}

__redmine() {
  CMD="/c/Users/fujiwara/AppData/Local/Vivaldi/Application/vivaldi.exe 'http://redmine.bplats-dev.com/issues/$@'"
  eval $CMD
}

__tar_profile() {
  DATE=`date +%Y%m%d-%H%M%S`
  pushd ${HOME} 1>/dev/null
  tar zcvf cygwin_profiles_${DATE}.tar.gz .bash_aliases .bash_functions .bash_profile .bashrc .gitconfig .gitignore_global .inpurc .profile .ssh .vim .viminfo .vimrc .Xauthority  .xinitrc .Xresources  startdwm xmodmap.jp
  popd

  pushd /c/users/fujiwara/.ssh
  tar zcvf ${HOME}/ssh_keys_${DATE}.tar.gz ./*
  popd

  pushd ${HOME}/work/projects/全プロジェクト共通/ライセンスなど
  tar zcvf ${HOME}/connections_${DATE}.tar.gz ./*
  popd
}
#
# Some example functions:
#
# a) function settitle
# settitle ()
# {
#   echo -ne "\e]2;$@\a\e]1;$@\a";
# }
#
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}

__zip_rails()
{
  if [[ $# -ne 1 ]]; then
    echo "usage __zip_rails <zip file name>"
    return 0
  fi
  local zip_name=$1
  zip -r $1 app bin config config.ru db Gemfile Gemfile.lock lib log public Rakefile README.rdoc test vendor
}

axr()
{
    /c/apps/PortableApps/afxw64/AFXWCMD.exe -r"$(cygpath -w `pwd`)"
}

axl()
{
    /c/apps/PortableApps/afxw64/AFXWCMD.exe -l"$(cygpath -w `pwd`)"
}
