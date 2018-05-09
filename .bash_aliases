#!/usr/bin/env bash

# --- Convert result of Windows command to UTF-8 from Shift-JIS
alias ping="cocot ping"
alias ipconfig="cocot ipconfig"
alias netstat="cocot netstat"
alias netsh="cocot netsh"
alias ping="cocot ping"
alias where="cocot where"
#alias java="cocot /c/apps/PortableApps/jdk-9.0.1/bin/java"
#alias javac="cocot /c/apps/PortableApps/jdk-9.0.1/bin/javac"
alias javaw="cocot javaw"
alias java="cocot java"
alias javac="cocot javac"
alias ipconifg="cocot /c/windows/system32/ipconfig.exe"

# --- Useful shortcuts
alias sb="source ~/.bashrc"
alias ls="ls -GF --color"
alias grep="rg"
alias pp="pushd `pwd`"
alias ppd="popd"
alias hosts="vim /c/Windows/System32/drivers/etc/hosts"
alias apt-get=apt-cyg
alias acsa="apt-cyg searchall"
alias vi=vim
alias gvim="/c/apps/PortableApps/vim74/gvim.exe $@ &"
alias nvim="/c/apps/PortableApps/Neovim/bin/nvim.exe $@ &"
alias show_ssh_hosts="grep Host ${HOME}/.ssh/config"
alias show_alias="grep ^alias ${HOME}/.bash_aliases"
alias rr="ssh-keygen -R"
alias google=__google
alias redmine=__redmine
alias e="explorer ."
alias midori="midori &>/dev/null &"
alias zip_rails="__zip_rails $@"
alias jmeter="cocot /cygdrive/c/apps/PortableApps/jMeter/bin/jmeter.bat $@"
alias mcd=__mkdir_and_cd
alias remove_remoho="ssh-keygen -R $@"
alias vidrop=__open_file_under_dropbox

alias dodot=__dodot

# Shortcuts for changing environment
alias edit_bashrc="vim ${HOME}/.bashrc"
alias edit_alias="vim ${HOME}/.bash_aliases"
alias edit_func="vim ${HOME}/.bash_functions"
alias edit_ssh_config="vim ${HOME}/.ssh/config"
alias edit_dwm=__edit_dwm
alias make_dwm=__make_dwm

# Shortcuts for SSH
alias hikari="ssh hikari-local"
alias b2c="ssh pana-local"
alias fanuc="ssh fanuc-local"
alias bpxy="sshpass -p zuSBuk90ia ssh bpxy"
alias rhikari-s="sshpass -p zuSBuk90ia ssh rhikari-s" 
alias rhikari-p="sshpass -p zuSBuk90ia ssh rhikari-p" 

# Shortcuts for quick move to specific directory
alias cdgit=__cdgit
alias cdcpp="cd ${HOME}/my_work/study/cpp"
alias cdsvn="cd ${HOME}/work/svn/saasplats/src/branches"
alias cdrls="cd ${HOME}/work/release"
#alias cdprj="cd ${HOME}/work/projects"
alias cdprj=__cdprj
alias cdmy=__cdmy
alias cdwork="cd ${HOME}/work"

# alias term="exo-open --launch TerminalEmulator"

# Shortcuts for Vagrant/Git
alias valv="/c/Program\ Files/Oracle/VirtualBox/VBoxManage.exe list vms"
alias vagrant="vagrant.exe"

alias gico=__git_checkout_with_partial_match
alias gipush=__git_push_origin_master

# --- Shortcuts for Windows products
alias excel=__mso_excel
__bc4() {
    "/c/apps/portableapps/Beyond Compare 4/BComp.exe" $@ &
}
__st() {
    "/c/apps/portableapps/SublimeText/sublime_text.exe" $@ &
}
__pdf() {
    FILES=$@
    for F in ${FILES[@]}; do
        FILE=$(cygpath -w $@)
        echo $FILE
        "/c/apps/PortableApps/FoxitReaderPortable/App/Foxit Reader/FoxitReader.exe" $FILE &
    done
}
alias bc4=__bc4
alias pdf=__pdf
alias st=__st

# --- Shortcuts for very long commmands
# 1.Mysql connection to hikari-dev via SSH Tunneling
alias count_line='find admin/bplats store -type d \( -name plugins -or -name tmp -or -name uploadfiles -or -name tests -or -name vendor -or -name Test -or -name Vendor -or -name Plugin -or -name tmp \) -prune -o -type f \( -name "*.sh" -or -name "*.php" -or -name "*.tpl" -or -name "*.js" -or -name "*.json" -or -name "*.ctp" -or -name "*.css" \) -exec wc -l {} \; | awk "{print \$2,\$1}" | sort'
alias sum_2='awk "{s += \$2} END {print s}" < '
alias ssh-tunnel-hikari-dev="ssh -f -N -L 12001:hikari-stg.cl1vmkosph2j.ap-northeast-1.rds.amazonaws.com:3306 hikari-dev"
alias mysql-hikari-dev="mysql --host 127.0.0.1 --port=12001 -udev-hikari -pxt7MZgHk dev-hikari2"
alias mysqldump-hikari-dev="mysqldump --host 127.0.0.1 --port=12001 -udev-hikari -pxt7MZgHk dev-hikari2"

# --- Shortcuts for rsync of projects
MY_RSYNC="rsync -rzthu --delete --progress --itemize-changes --exclude='~\$*.*' --exclude='*sql' --max-size=10M"
MY_RSYNC_LARGE="rsync -rthu --delete --progress --itemize-changes --exclude='~\$*.*' --exclude='*sql' --max-size=100M"
#alias rsync-2016-from="${MY_RSYNC} //bpfs003/share/Project/2016/. ~/work/projects/Projects_on_Server/2016"
alias rsync-2017-from="${MY_RSYNC} //bpfs003/share/Project/2017/. ~/work/projects/Projects_on_Server/2017"
alias rsync-hikari-from="${MY_RSYNC} //bpfs003/dev_partner/project/光通信/Ph2_mypage/. ~/work/projects/Projects_on_Server/光通信/Ph2_mypage"
alias rsync-prgr-from="${MY_RSYNC} //bpfs003/dev_partner/進捗管理/. ~/work/projects/Projects_on_Server/進捗管理"
alias rsync-b2b-from="${MY_RSYNC} //bpfs003/dev_partner/project/Panasonic/. ~/work/projects/Projects_on_Server/Panasonic"
alias rsync-b2c-from="${MY_RSYNC} //bpfs003/dev_partner/project/Panasonic\(BtoC\)/. ~/work/projects/Projects_on_Server/Panasonic\(BtoC\)"
alias rsync-fanuc-from="${MY_RSYNC} //bpfs003/dev_partner/project/fanuc/. ~/work/projects/Projects_on_Server/fanuc"
alias rsync-v7-from="${MY_RSYNC} //bpfs003/dev_partner/project/Bplats7.0/. ~/work/projects/Projects_on_Server/bplats-7.0"
alias rsync-v8-from="${MY_RSYNC} //bpfs003/dev_partner/project/Bplats8.0/. ~/work/projects/Projects_on_Server/bplats-8.0"
alias rsync-sales-fanuc-from="${MY_RSYNC_LARGE} //bpfs003/sales/営業本部/【個別案件】/ファナック（Bplats）【富士通】/. ~/work/projects/Projects_on_Server/sales/fanuc"
alias rsync-sales-pana-from="${MY_RSYNC_LARGE} //bpfs003/sales/営業本部/【個別案件】/パナソニックAVCネットワークス→PSTC（Bplats）【富士通】/. ~/work/projects/Projects_on_Server/sales/panasonic"
alias rsync-from="rsync-2017-from; rsync-hikari-from; rsync-b2b-from; rsync-b2c-from; rsync-fanuc-from"
alias rsync-cdrive="${MY_RSYNC} /cygdrive/c/. /cygdrive/d/bplats"
