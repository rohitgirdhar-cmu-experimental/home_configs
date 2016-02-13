# gcc
export PATH=/home/rgirdhar/Software/utils/gcc/install/bin/:$PATH
export LIBRARY_PATH=/home/rgirdhar/Software/utils/gcc/install/lib64/:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/gcc/install/lib64/:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/utils/gcc/install/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/utils/gcc/install/include/:$CPLUS_INCLUDE_PATH


# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac


function smart_pwd {
    local pwdmaxlen=100
    local trunc_symbol=".."
    local dir=${PWD##*/}
    local tmp=""
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        tmp=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        tmp=${trunc_symbol}/${tmp#*/}
        if [ "${#tmp}" -lt "${#NEW_PWD}" ]; then
            NEW_PWD=$tmp
        fi
    fi
}

function boldtext {
    echo "\\[\\033[1m\\]"$1"\\[\\033[0m\\]"
}

function bgcolor {
    echo "\\[\\033[48;5;"$1"m\\]"
}

function fgcolor {
    echo "\\[\\033[38;5;"$1"m\\]"
}

function resetcolor {
    echo "\\[\\e[0m\\]"
}

function fancyprompt {
    PROMPT_COMMAND="smart_pwd"
    PS1="$(fgcolor 117)\u$(fgcolor 114)@$(fgcolor 117)\h$(fgcolor 190)$(boldtext :)$(fgcolor 86) \$NEW_PWD$(resetcolor)$(fgcolor 220)$(resetcolor)$(fgcolor 208)\n\$ $(resetcolor)"
}

function dullprompt {
    PROMPT_COMMAND=""
    PS1="\u@\h:\w\n\$ "
}
case "$TERM" in
xterm-color|xterm-256color|rxvt*|screen-256color)
        fancyprompt
    ;;
*)
        dullprompt
    ;;
esac

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

alias get_node="qsub -X -I -l nodes=1:ppn=8,walltime=99:99:99"

# added by Anaconda2 2.5.0 installer
export PATH="/home/rgirdhar/Software/pl/python/anaconda2/bin:$PATH"
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/pl/python/anaconda2/include/python2.7/:$CPLUS_INCLUDE_PATH

# libevent
export CMAKE_PREFIX_PATH=/home/rgirdhar/Software/utils/libevent/install:$CMAKE_PREFIX_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/libevent/install/lib/:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/utils/libevent/install/lib/:$LIBRARY_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/utils/libevent/install/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/utils/libevent/install/include:$CPLUS_INCLUDE_PATH

## ncurses
#export CMAKE_PREFIX_PATH=/home/rgirdhar/Software/utils/ncurses/install/:$CMAKE_PREFIX_PATH
#export PATH=/home/rgirdhar/Software/utils/ncurses/install/bin/:$PATH
#export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/ncurses/install/lib/:$LD_LIBRARY_PATH
#export LIBRARY_PATH=/home/rgirdhar/Software/utils/ncurses/install/lib/:$LIBRARY_PATH
#export C_INCLUDE_PATH=/home/rgirdhar/Software/utils/ncurses/install/include/:$C_INCLUDE_PATH
#export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/utils/ncurses/install/include/:$CPLUS_INCLUDE_PATH

# tmux
export PATH=/home/rgirdhar/Software/utils/tmux/install/bin/:$PATH

# htop
export PATH=/home/rgirdhar/Software/utils/htop/install/bin/:$PATH

# cmake
export PATH=/home/rgirdhar/Software/utils/cmake/cmake-3.5.0-rc2-Linux-x86_64/bin/:$PATH

# boost
export C_INCLUDE_PATH=/home/rgirdhar/Software/pl/cpp/boost/boost_1_60_0/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/pl/cpp/boost/boost_1_60_0/:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/pl/cpp/boost/boost_1_60_0/stage/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/pl/cpp/boost/boost_1_60_0/stage/lib:$LD_LIBRARY_PATH

# protobuf
BASE_PATH=/home/rgirdhar/Software/utils/protobuf/install
export CMAKE_PREFIX_PATH=$BASE_PATH:$PATH
export PATH=$BASE_PATH/bin:$PATH
export LIBRARY_PATH=$BASE_PATH/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$BASE_PATH/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$BASE_PATH/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$BASE_PATH/include:$CPLUS_INCLUDE_PATH

# protobuf
BASE_PATH=/home/rgirdhar/Software/utils/gflags/install
export CMAKE_PREFIX_PATH=$BASE_PATH:$PATH
export PATH=$BASE_PATH/bin:$PATH
export LIBRARY_PATH=$BASE_PATH/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$BASE_PATH/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$BASE_PATH/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$BASE_PATH/include:$CPLUS_INCLUDE_PATH

# autoconf
BASE_PATH=/home/rgirdhar/Software/utils/autoconf/install
export CMAKE_PREFIX_PATH=$BASE_PATH:$PATH
export PATH=$BASE_PATH/bin:$PATH

# glog
BASE_PATH=/home/rgirdhar/Software/utils/glog/install
export CMAKE_PREFIX_PATH=$BASE_PATH:$PATH
export PATH=$BASE_PATH/bin:$PATH
export LIBRARY_PATH=$BASE_PATH/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$BASE_PATH/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$BASE_PATH/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$BASE_PATH/include:$CPLUS_INCLUDE_PATH

# atlas
export C_INCLUDE_PATH=/opt/atlas/local/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/opt/atlas/local/include/:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=/opt/atlas/local/lib/:$LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/atlas/local/lib/:$LD_LIBRARY_PATH

# opencv
BASE_PATH=/home/rgirdhar/Software/vision/opencv/install
export CMAKE_PREFIX_PATH=$BASE_PATH:$PATH
export PATH=$BASE_PATH/bin:$PATH
export LIBRARY_PATH=$BASE_PATH/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$BASE_PATH/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$BASE_PATH/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$BASE_PATH/include:$CPLUS_INCLUDE_PATH
export PYTHONPATH=$BASE_PATH/lib/python2.7/site-packages/:$PYTHONPATH
export PKG_CONFIG_PATH=$BASE_PATH/lib/pkgconfig/:$PKG_CONFIG_PATH

