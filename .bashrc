# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias dc='echo "use cd"'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export TERM=xterm-256color

# Sexy Solarized Bash Prompt, inspired by "Extravagant Zsh Prompt"
# Customized for the Solarized color scheme by Sean O'Neil
 
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then TERM=gnome-256color; fi
if tput setaf 1 &> /dev/null; then
tput sgr0
if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
BASE03=$(tput setaf 234)
BASE02=$(tput setaf 235)
BASE01=$(tput setaf 240)
BASE00=$(tput setaf 241)
BASE0=$(tput setaf 244)
BASE1=$(tput setaf 245)
BASE2=$(tput setaf 254)
BASE3=$(tput setaf 230)
YELLOW=$(tput setaf 136)
ORANGE=$(tput setaf 166)
RED=$(tput setaf 160)
MAGENTA=$(tput setaf 125)
VIOLET=$(tput setaf 61)
BLUE=$(tput setaf 33)
CYAN=$(tput setaf 37)
GREEN=$(tput setaf 64)
else
BASE03=$(tput setaf 8)
BASE02=$(tput setaf 0)
BASE01=$(tput setaf 10)
BASE00=$(tput setaf 11)
BASE0=$(tput setaf 12)
BASE1=$(tput setaf 14)
BASE2=$(tput setaf 7)
BASE3=$(tput setaf 15)
YELLOW=$(tput setaf 3)
ORANGE=$(tput setaf 9)
RED=$(tput setaf 1)
MAGENTA=$(tput setaf 5)
VIOLET=$(tput setaf 13)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
GREEN=$(tput setaf 2)
fi
BOLD=$(tput bold)
RESET=$(tput sgr0)
else
# Linux console colors. I don't have the energy
# to figure out the Solarized values
MAGENTA="\033[1;31m"
ORANGE="\033[1;33m"
GREEN="\033[1;32m"
PURPLE="\033[1;35m"
WHITE="\033[1;37m"
BOLD=""
RESET="\033[m"
fi
 
parse_git_dirty () {
[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
parse_git_branch () {
git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}
 
#PS1="\[${BOLD}${CYAN}\]\u\[$BASE0\]@\[$CYAN\]\h\[$BASE0\]: \[$BLUE\]\w\[$BASE0\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$YELLOW\]\$(parse_git_branch)\[$BASE0\]\n\$ \[$RESET\]"
PS1="\[${BOLD}${CYAN}\]\u\[$BASE0\]@\[$CYAN\]\h\[$BASE0\]: \[$BLUE\]\w\[$BASE0\]\n\$ \[$RESET\]"

# for matlab binaries
export MATLABROOT=/usr/local/MATLAB/R2014a/
export PATH=$PATH:$MATLABROOT/bin/
export PATH=$PATH:$MATLABROOT/bin/glnxa64/

# for easy reference to data-nix
export nix=/media/data-nix

# for VLFeat
export VLFEATROOT='/media/data-nix/Software/vision/vlfeat'

## for opencv
#export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/lib:/usr/lib32:/usr/local/lib

# for dircolors
eval `dircolors ~/Software/utils/dircolors/dircolors.256dark`

## YODA specific paths
### For htop
export PATH=$PATH:~/Software/utils/htop/install/bin
# for vim
export PATH=$PATH:~/Software/utils/vim/install/usr/local/bin

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/glog/lib/:/home/rgirdhar/Software/utils/gflags/install/lib/:/home/xiaolonw/leveldb/:/home/xiaolonw/mdb/libraries/liblmdb:/opt/atlas/st/lib/:/opt/atlas/mt/lib/:/usr/local/cuda-6.5/lib64/:/usr/local/cuda-5.5/lib64/
# for matlab
export PATH=/opt/matlab/8.1/bin/:$PATH
# for caffe
export CAFFE_ROOT=~/Software/vision/caffe
#export CUDA_PATH=/usr/local/cuda-5.5

# for autojump
[[ -s /home/rgirdhar/Software/utils/autojump/install/etc/profile.d/autojump.sh ]] && source /home/rgirdhar/Software/utils/autojump/install/etc/profile.d/autojump.sh
export PATH=$PATH:~/Software/utils/autojump/install/bin

# ctags
export PATH=$PATH:/home/rgirdhar/Software/utils/ctags/install/bin/ 

# boost
# avoid using the system install (old)
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/boost/lib/:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/utils/boost/lib/:$LIBRARY_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/utils/boost/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/utils/boost/include/:$CPLUS_INCLUDE_PATH

# added by Anaconda 2.1.0 installer
export PATH="/home/rgirdhar/Software/pl/python/anaconda2/bin:$PATH"
export LD_LIBRARY_PATH="/home/rgirdhar/Software/pl/python/anaconda2/lib:${LD_LIBRARY_PATH}"
export LIBRARY_PATH="/home/rgirdhar/Software/pl/python/anaconda2/lib:${LIBRARY_PATH}"
export C_INCLUDE_PATH="/home/rgirdhar/Software/pl/python/anaconda2/include:${C_INCLUDE_PATH}"
export CPLUS_INCLUDE_PATH="/home/rgirdhar/Software/pl/python/anaconda2/include:${CPLUS_INCLUDE_PATH}"

# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ashrivas/cv-libs/lib/

# yoda scripts
export PATH=$PATH:/home/rgirdhar/Software/yoda-scripts/
alias get_node_x="qsub -X -I -l nodes=1:ppn=8,walltime=99:99:99"
alias get_node="qsub -I -l nodes=1:ppn=8,walltime=99:99:99"
alias get_node_big="qsub -I -l nodes=1:ppn=12,walltime=99:99:99 -q big-mem"
alias get_node_big8="qsub -I -l nodes=1:ppn=8,walltime=99:99:99 -q big-mem"

# for cmake
export PATH=$PATH:/home/rgirdhar/Software/utils/cmake/bin/

## for opencv
#export PKG_CONFIG_PATH=/home/rgirdhar/Software/vision/opencv/install/lib/pkgconfig:$PKG_CONFIG_PATH
#export LD_LIBRARY_PATH=/home/rgirdhar/Software/vision/opencv/install/lib/:$LD_LIBRARY_PATH

# for ispc compiler
export PATH=$PATH:/home/rgirdhar/Software/pl/ispc/ispc-v1.8.2-linux/

# for lapack
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/rgirdhar/Software/math/lapack/lapack-3.5.0/
export LIBRARY_PATH=$LIBRARY_PATH:/home/rgirdhar/Software/math/lapack/lapack-3.5.0/

# for libevent
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/rgirdhar/Software/utils/libevent/install/lib/
export LIBRARY_PATH=$LIBRARY_PATH:/home/rgirdhar/Software/utils/libevent/install/lib/
export INCLUDE_PATH=$INCLUDE_PATH:/home/rgirdhar/Software/utils/libevent/install/include/

# for libjpeg
export CMAKE_PREFIX_PATH=/home/rgirdhar/Software/utils/libjpeg/install/:$CMAKE_PREFIX_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/libjpeg/install/lib/:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/utils/libjpeg/install/lib/:$LIBRARY_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/utils/libjpeg/install/include:$CPLUS_INCLUDE_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/utils/libjpeg/install/include:$C_INCLUDE_PATH
# anaconda opencv needs jpeg8, so here it goes
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/libjpeg/install-8d/lib/:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/utils/libjpeg/install-8d/lib/:$LIBRARY_PATH

# for cudnn
export LD_LIBRARY_PATH=/home/rgirdhar/Software/gpu/cudnn/lib64/:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/gpu/cudnn/lib64/:$LIBRARY_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/gpu/cudnn/include:$CPLUS_INCLUDE_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/gpu/cudnn/include:$C_INCLUDE_PATH

# # cudnn v4
# export LD_LIBRARY_PATH=/home/xinleic/tools/cudnn-v4/lib64:$LD_LIBRARY_PATH
# export LIBRARY_PATH=/home/xinleic/tools/cudnn-v4/lib64:$LIBRARY_PATH
# export CPLUS_INCLUDE_PATH=/home/xinleic/tools/cudnn-v4/include:$CPLUS_INCLUDE_PATH
# export C_INCLUDE_PATH=/home/xinleic/tools/cudnn-v4/include:$C_INCLUDE_PATH

# for other caffe libs
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/opt/glog/include/:/home/rgirdhar/Software/utils/gflags/install/include/
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/opt/atlas/st/include/:/opt/atlas/mt/include
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/home/xiaolonw/leveldb/include/:/home/xiaolonw/mdb/libraries/liblmdb
export C_INCLUDE_PATH=/home/rgirdhar/Software/vision/opencv/install/include/:$C_INCLUDE_PATH
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/local/cuda-6.5/include/
export C_INCLUDE_PATH=/home/rgirdhar/Software/utils/gflags/install/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/opt/glog/include/:/home/rgirdhar/Software/utils/gflags/install/include/
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/opt/atlas/st/include/:/opt/atlas/mt/include
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/home/xiaolonw/leveldb/include/:/home/xiaolonw/mdb/libraries/liblmdb
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/vision/opencv/install/include/:$CPLUS_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/cuda-6.5/include/
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/utils/gflags/install/include/:$CPLUS_INCLUDE_PATH

export LIBRARY_PATH=$LIBRARY_PATH:/opt/glog/lib/:/home/rgirdhar/Software/utils/gflags/install/lib/
export LIBRARY_PATH=$LIBRARY_PATH:/home/xiaolonw/leveldb/:/home/xiaolonw/mdb/libraries/liblmdb
export LIBRARY_PATH=$LIBRARY_PATH:/home/rgirdhar/Software/vision/opencv/install/lib/
export PKG_CONFIG_PATH=/home/rgirdhar/Software/vision/opencv/install/lib/pkgconfig:$PKG_CONFIG_PATH 
export LIBRARY_PATH=$LIBRARY_PATH:/opt/atlas/st/lib/:/opt/atlas/mt/lib/
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/cuda-6.5/lib64/
export LIBRARY_PATH=/home/rgirdhar/Software/utils/gflags/install/lib/:$LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/glog/lib/:/home/rgirdhar/Software/utils/gflags/install/lib/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/xiaolonw/leveldb/:/home/xiaolonw/mdb/libraries/liblmdb
export LD_LIBRARY_PATH=/home/rgirdhar/Software/vision/opencv/install/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/atlas/st/lib/:/opt/atlas/mt/lib/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-6.5/lib64/
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/gflags/install/lib/:$LD_LIBRARY_PATH

# ## opencv, using this as it includes opencv-contrib
# export CMAKE_PREFIX_PATH=/home/ashrivas/cv-libs/opencv/:$CMAKE_PREFIX_PATH
# export LIBRARY_PATH=/home/ashrivas/cv-libs/opencv/lib/:$LIBRARY_PATH
# export LD_LIBRARY_PATH=/home/ashrivas/cv-libs/opencv/lib/:$LD_LIBRARY_PATH
# export C_INCLUDE_PATH=/home/ashrivas/cv-libs/opencv/include/:$C_INCLUDE_PATH
# export CPLUS_INCLUDE_PATH=/home/ashrivas/cv-libs/opencv/include/:$CPLUS_INCLUDE_PATH
# export PKG_CONFIG_PATH=/home/ashrivas/cv-libs/opencv/lib/pkgconfig/:$PKG_CONFIG_PATH
# export PYTHONPATH=/home/ashrivas/cv-libs/opencv/lib/python2.6/site-packages/:$PYTHONPATH

# # stick with my own installation
# export CMAKE_PREFIX_PATH=/home/rgirdhar/Software/vision/opencv/install/:$CMAKE_PREFIX_PATH
# export PATH=/home/rgirdhar/Software/vision/opencv/install/bin/:$PATH
# export LIBRARY_PATH=/home/rgirdhar/Software/vision/opencv/install/lib/:$LIBRARY_PATH
# export LD_LIBRARY_PATH=/home/rgirdhar/Software/vision/opencv/install/lib/:$LD_LIBRARY_PATH
# export C_INCLUDE_PATH=/home/rgirdhar/Software/vision/opencv/install/include/:$C_INCLUDE_PATH
# export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/vision/opencv/install/include/:$CPLUS_INCLUDE_PATH
# export PKG_CONFIG_PATH=/home/rgirdhar/Software/vision/opencv/install/lib/pkgconfig/:$PKG_CONFIG_PATH

export PATH=$PATH:/usr/local/cuda-7.0/bin/
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ashrivas/cv-libs/cuda-5.5/lib64/

# alias python=ipython

# for go and hub
export GOROOT=/home/rgirdhar/Software/utils/go
export PATH=$PATH:$GOROOT/bin/
export PATH=$PATH:/home/rgirdhar/Software/utils/hub/

# for libsodium and libzmq
export CMAKE_PREFIX_PATH=/home/rgirdhar/Software/utils/libzmq/install/:$CMAKE_PREFIX_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/libzmq/install/lib/:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/utils/libzmq/install/lib/:$LIBRARY_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/utils/libzmq/install/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/utils/libzmq/install/include/:$CPLUS_INCLUDE_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/utils/libzmq/cppzmq/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/utils/libzmq/cppzmq/:$CPLUS_INCLUDE_PATH

# for libhdf5
export CMAKE_PREFIX_PATH=/home/rgirdhar/Software/utils/libhdf5/install:$CMAKE_PREFIX_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/libhdf5/install/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/utils/libhdf5/install/lib:$LIBRARY_PATH
export C_INCLUDE_PATH=home/rgirdhar/Software/utils/libhdf5/install/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=home/rgirdhar/Software/utils/libhdf5/install/include:$CPLUS_INCLUDE_PATH

# autoconf/autoreconf
export PATH=/home/rgirdhar/Software/utils/autoreconf/bin:$PATH

# for intel mkl
export LIBRARY_PATH=$LIBRARY_PATH:/share/vol1/home/ashrivas/cv-libs/intel/composer_xe_2013_sp1.0.080/mkl/lib/intel64/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/share/vol1/home/ashrivas/cv-libs/intel/composer_xe_2013_sp1.0.080/mkl/lib/intel64/
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/share/vol1/home/ashrivas/cv-libs/intel/composer_xe_2013_sp1.0.080/mkl/include/
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/share/vol1/home/ashrivas/cv-libs/intel/composer_xe_2013_sp1.0.080/mkl/include/

# latest git
export PATH=/home/rgirdhar/Software/utils/git/bin/bin/:$PATH

# xclip
export PATH=/home/rgirdhar/Software/utils/xclip/:$PATH

# Autodesk FBX
export LD_LIBRARY_PATH=/home/rgirdhar/Software/visualization/fbx/lib/gcc4/x64/release/:$LD_LIBRARY_PATH

# premake
export PATH=/home/rgirdhar/Software/utils/premake:$PATH

# automake
export PATH=/home/rgirdhar/Software/utils/automake/automake-1.15/bin/:$PATH
export PKG_CONFIG_PATH=/home/rgirdhar/Software/utils/util-macros/install/share/pkgconfig:$PKG_CONFIG_PATH
export ACLOCAL_PATH=/home/rgirdhar/Software/utils/util-macros/install/share/aclocal:$ACLOCAL_PATH
#export ACLOCAL='aclocal -I /home/rgirdhar/Software/utils/util-macros/install/share/aclocal'

# libpciaccess
export LIBRARY_PATH=/home/rgirdhar/Software/visualization/opengl/libpciaccess/precomp/usr/lib/:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/visualization/opengl/libpciaccess/precomp/usr/lib/:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/visualization/opengl/libpciaccess/precomp/usr/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/visualization/opengl/libpciaccess/precomp/usr/include/:$CPLUS_INCLUDE_PATH
export PKG_CONFIG_PATH=/home/rgirdhar/Software/visualization/opengl/libpciaccess/precomp/usr/lib/pkgconfig:$PKG_CONFIG_PATH

# libdrm
export LIBRARY_PATH=/home/rgirdhar/Software/visualization/opengl/libdrm-2.4.65/installed/lib/:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/visualization/opengl/libdrm-2.4.65/installed/lib/:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/home/rgirdhar/Software/visualization/opengl/libdrm-2.4.65/installed/lib/pkgconfig/:$PKG_CONFIG_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/visualization/opengl/libdrm-2.4.65/installed/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/visualization/opengl/libdrm-2.4.65/installed/include/:$CPLUS_INCLUDE_PATH

# dri3proto
export PKG_CONFIG_PATH=/home/rgirdhar/Software/visualization/opengl/dri3proto/install/lib/pkgconfig/:$PKG_CONFIG_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/visualization/opengl/dri3proto/install/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/visualization/opengl/dri3proto/install/include/:$CPLUS_INCLUDE_PATH

# presentproto
export PKG_CONFIG_PATH=/home/rgirdhar/Software/visualization/opengl/presentproto/install/lib/pkgconfig/:$PKG_CONFIG_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/visualization/opengl/presentproto/install/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/visualization/opengl/presentproto/install/include/:$CPLUS_INCLUDE_PATH

# xcb
export PKG_CONFIG_PATH=/home/rgirdhar/Software/visualization/opengl/xcb-proto-1.11/install/lib/pkgconfig:$PKG_CONFIG_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/visualization/opengl/xcb-proto-1.11/install/lib/:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/visualization/opengl/xcb-proto-1.11/install/lib/:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/visualization/opengl/libxcb-1.11.1/install/lib/:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/visualization/opengl/libxcb-1.11.1/install/lib/:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/home/rgirdhar/Software/visualization/opengl/libxcb-1.11.1/install/lib/pkgconfig/:$PKG_CONFIG_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/visualization/opengl/libxcb-1.11.1/install/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/visualization/opengl/libxcb-1.11.1/install/include/:$CPLUS_INCLUDE_PATH

# flex
export LIBRARY_PATH=$LIBRARY_PATH:/home/rgirdhar/Software/utils/flex/install/lib/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/rgirdhar/Software/utils/flex/install/lib/
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/home/rgirdhar/Software/utils/flex/install/include
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/home/rgirdhar/Software/utils/flex/install/include
export PATH=$PATH:/home/rgirdhar/Software/utils/flex/install/bin/

# libtool
export PATH=/home/rgirdhar/Software/utils/libtool/help2man/help2man-1.47.2/install/bin/:$PATH
export LIBRARY_PATH=/home/rgirdhar/Software/utils/libtool/help2man/help2man-1.47.2/install/lib/:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/libtool/help2man/help2man-1.47.2/install/lib:$LD_LIBRARY_PATH

# makeinfo
export PATH=/home/rgirdhar/Software/utils/libtool/makeinfo/texinfo-6.0/install/bin/:$PATH

# libtool
export PATH=/home/rgirdhar/Software/utils/libtool/libtool-2.2.6b/install/bin/:$PATH
export LIBRARY_PATH=/home/rgirdhar/Software/utils/libtool/libtool-2.2.6b/install/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/libtool/libtool-2.2.6b/install/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/utils/libtool/libtool-2.2.6b/install/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/utils/libtool/libtool-2.2.6b/install/include/:$CPLUS_INCLUDE_PATH
export ACLOCAL_PATH=/home/rgirdhar/Software/utils/libtool/libtool-2.2.6b/install/share/aclocal:$ACLOCAL_PATH

export ACLOCAL_PATH=/usr/share/aclocal/:$ACLOCAL_PATH
export ACLOCAL_PATH=/usr/share/aclocal-1.11/:$ACLOCAL_PATH

export PATH=/home/rgirdhar/Software/utils/makedepend/makedepend-1.0.5/install/bin/:$PATH

# gl
export C_INCLUDE_PATH=/home/rgirdhar/Software/visualization/glut/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/visualization/glut/include/:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/visualization/glut/lib/:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/visualization/glut/lib/:$LD_LIBRARY_PATH

# fontsproto
export C_INCLUDE_PATH=/home/rgirdhar/Software/visualization/fontsproto/install/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/visualization/fontsproto/install/include/:$CPLUS_INCLUDE_PATH
export PKG_CONFIG_PATH=/home/rgirdhar/Software/visualization/fontsproto/install/lib/pkgconfig/:$PKG_CONFIG_PATH
# libtrans
export C_INCLUDE_PATH=/home/rgirdhar/Software/visualization/libxtrans/install/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/visualization/libxtrans/install/include:$CPLUS_INCLUDE_PATH
export ACLOCAL_PATH=/home/rgirdhar/Software/visualization/libxtrans/install/share/aclocal/:$ACLOCAL_PATH
export PKG_CONFIG_PATH=/home/rgirdhar/Software/visualization/libxtrans/install/share/pkgconfig:$PKG_CONFIG_PATH
# fontenc
export C_INCLUDE_PATH=/home/rgirdhar/Software/visualization/libfontenc/install/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/visualization/libfontenc/install/include:$CPLUS_INCLUDE_PATH
export PKG_CONFIG_PATH=/home/rgirdhar/Software/visualization/libfontenc/install/lib/pkgconfig:$PKG_CONFIG_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/visualization/libfontenc/install/lib/:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/visualization/libfontenc/install/lib/:$LD_LIBRARY_PATH
# libXfont
export C_INCLUDE_PATH=/home/rgirdhar/Software/visualization/libXfont/install/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/visualization/libXfont/install/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/visualization/libXfont/install/lib/:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/visualization/libXfont/install/lib/:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/home/rgirdhar/Software/visualization/libXfont/install/lib/pkgconfig/:$PKG_CONFIG_PATH

# XVFB installation
export PATH=$PATH:/home/rgirdhar/Software/visualization/headless/Xvfb_install/usr/X11R6/bin/

# hdf5 recent
export CMAKE_PREFIX_PATH=/home/rgirdhar/Software/utils/hdf5/hdf5-1.8.13-linux-x86_64-shared/:$CMAKE_PREFIX_PATH
export PATH=/home/rgirdhar/Software/utils/hdf5/hdf5-1.8.13-linux-x86_64-shared/bin/:$PATH
export LIBRARY_PATH=/home/rgirdhar/Software/utils/hdf5/hdf5-1.8.13-linux-x86_64-shared/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/hdf5/hdf5-1.8.13-linux-x86_64-shared/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/utils/hdf5/hdf5-1.8.13-linux-x86_64-shared/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/utils/hdf5/hdf5-1.8.13-linux-x86_64-shared/include:$CPLUS_INCLUDE_PATH

# ImageMagick
export CMAKE_PREFIX_PATH=/home/rgirdhar/Software/visualization/ImageMagick/install/:$CMAKE_PREFIX_PATH
export PATH=/home/rgirdhar/Software/visualization/ImageMagick/install/bin/:$PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/visualization/ImageMagick/install/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/visualization/ImageMagick/install/include/:$CPLUS_INCLUDE_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/visualization/ImageMagick/install/lib/:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/visualization/ImageMagick/install/lib/:$LIBRARY_PATH

# gnuplot
export PATH=$PATH:/home/rgirdhar/Software/visualization/gnuplot/install/bin/

# openSSL
export CMAKE_PREFIX_PATH=/home/rgirdhar/Software/utils/openssl/install/:$CMAKE_PREFIX_PATH
export PATH=$PATH:/home/rgirdhar/Software/utils/openssl/install/bin/
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/home/rgirdhar/Software/utils/openssl/install/include/
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/home/rgirdhar/Software/utils/openssl/install/include/
export LIBRARY_PATH=$LIBRARY_PATH:/home/rgirdhar/Software/utils/openssl/install/lib/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/rgirdhar/Software/utils/openssl/install/lib/

# latest g++ thanks to Xinlei
export CMAKE_PREFIX_PATH=/home/xinleic/tools/gcc/:$CMAKE_PREFIX_PATH
export CC=/home/xinleic/tools/gcc/bin/gcc
export CXX=/home/xinleic/tools/gcc/bin/g++
export PATH=/home/xinleic/tools/gcc/bin/:$PATH
export LIBRARY_PATH=/home/xinleic/tools/gcc/lib/:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/xinleic/tools/gcc/lib/:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=/home/xinleic/tools/gcc/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/xinleic/tools/gcc/include/:$CPLUS_INCLUDE_PATH
export LD_PRELOAD=/home/xinleic/tools/gcc/lib64/libstdc++.so.6

# use cuda7.5
# BASEDIR=/usr/local/cuda-7.5
BASEDIR=/home/rgirdhar/Software/gpu/cuda-7.5
export CMAKE_PREFIX_PATH=$BASEDIR:$CMAKE_PREFIX_PATH
export PATH=$BASEDIR/bin/:$PATH
export LIBRARY_PATH=$BASEDIR/lib64:$LIBRARY_PATH
export LD_LIBRARY_PATH=$BASEDIR/lib64:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$BASEDIR/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$BASEDIR/include/:$CPLUS_INCLUDE_PATH

#### Torch installation libs from Xinlei
#if [ "$TORCH" == 1 ]; then
#  export XHOME=/home/xinleic
#  export SCALA_HOME=$XHOME/Tools/scala
#  export SBT_HOME=$XHOME/Tools/sbt
#
#  export JAVA_HOME=$XHOME/jdk1.8.0_31
#  export PERL5LIB=$XHOME/Tools/lib/perl5/site_perl/5.8.8/
#  COOL_HOME=$XHOME/cools
#  TOOL_HOME=$XHOME/tools
#  CONDA_HOME=$XHOME/anaconda
#  export CC=$TOOL_HOME/gcc/bin/gcc
#  export CXX=$TOOL_HOME/gcc/bin/g++
#  export LD_PRELOAD=$TOOL_HOME/gcc/lib64/libstdc++.so.6
#  export MATLAB_ROOT=/opt/matlab/8.1
#
## export PYTHONPATH=$XHOME/caffe/python:$PYTHONPATH
#
#  if [ `uname -n` = "compute-1-19.local" ] || [ `uname -n` = "compute-1-23.local" ] || [ `uname -n` = "compute-1-24.local" ] || [ `uname -n` = "compute-1-25.local" ] || [ `uname -n` = "compute-1-26.local" ] || [ `uname -n` = "compute-1-28.local" ]; then
#      export PATH=$JAVA_HOME/bin:$SCALA_HOME/bin:$SBT_HOME:$COOL_HOME/protobuf/bin:/usr/local/cuda-7.0/bin:$XHOME/Tools/bin:$TOOL_HOME/cmake/bin:$MATLAB_ROOT/bin:$PATH
#      export PATH=$TOOL_HOME/gnuplot/bin:$TOOL_HOME/lz4/bin:$TOOL_HOME/zstd/bin:$TOOL_HOME/jemalloc/bin:$TOOL_HOME/flex/bin:$TOOL_HOME/bison/bin:$TOOL_HOME/numactl/bin:$PATH
#      export PATH=$XHOME/intel/mkl/bin:$TOOL_HOME/gcc/bin:$TOOL_HOME/autoconf/bin:$TOOL_HOME/automake/bin:$TOOL_HOME/libtool/bin:$TOOL_HOME/libjpeg/bin:$TOOL_HOME/ImageMagick/bin:$TOOL_HOME/readline/bin:$TOOL_HOME/ncurses/bin:$TOOL_HOME/fftw/bin:$TOOL_HOME/sox/bin:$CONDA_HOME/bin:$PATH
#
#      export LD_LIBRARY_PATH=$XHOME/opencvn/lib:/usr/local/cuda-7.0/lib64:$COOL_HOME/gflags/lib:$COOL_HOME/glog/lib:$COOL_HOME/protobuf/lib:$COOL_HOME/leveldb:$COOL_HOME/liblmdb:$COOL_HOME/snappy/lib:$TOOL_HOME/cudnn-v3/lib64:$XHOME/Tools/lib:$TOOL_HOME/cmake/lib:$LD_LIBRARY_PATH
#      export LIBRARY_PATH=$XHOME/opencvn/lib:/usr/local/cuda-7.0/lib64:$COOL_HOME/gflags/lib:$COOL_HOME/glog/lib:$COOL_HOME/protobuf/lib:$COOL_HOME/leveldb:$COOL_HOME/liblmdb:$COOL_HOME/snappy/lib:$TOOL_HOME/cudnn-v3/lib64:$XHOME/Tools/lib:$TOOL_HOME/cmake/lib:$LIBRARY_PATH
#      export C_INCLUDE_PATH=$XHOME/opencvn/include:/usr/local/cuda-7.0/include:$COOL_HOME/gflags/include:$COOL_HOME/glog/include:$COOL_HOME/protobuf/include:$COOL_HOME/leveldb:$COOL_HOME/liblmdb:$COOL_HOME/snappy/include:$TOOL_HOME/cudnn-v3/include:$XHOME/Tools/include:$TOOL_HOME/cmake/include:$C_INCLUDE_PATH
#      export CPLUS_INCLUDE_PATH=$XHOME/opencvn/include:/usr/local/cuda-7.0/include:$COOL_HOME/gflags/include:$COOL_HOME/glog/include:$COOL_HOME/protobuf/include:$COOL_HOME/leveldb:$COOL_HOME/liblmdb:$COOL_HOME/snappy/include:$TOOL_HOME/cudnn-v3/include:$XHOME/Tools/include:$TOOL_HOME/cmake/include:$CPLUS_INCLUDE_PATH
#      export LD_LIBRARY_PATH=$TOOL_HOME/folly/lib:$TOOL_HOME/wangle/lib:$TOOL_HOME/thrift/lib:$TOOL_HOME/thpp/lib:$TOOL_HOME/fblualib/lib:$TOOL_HOME/gtest/lib:$TOOL_HOME/gmock/lib:$LD_LIBRARY_PATH
#      export LIBRARY_PATH=$TOOL_HOME/folly/lib:$TOOL_HOME/wangle/lib:$TOOL_HOME/thrift/lib:$TOOL_HOME/thpp/lib:$TOOL_HOME/fblualib/lib:$TOOL_HOME/gtest/lib:$TOOL_HOME/gmock/lib:$LIBRARY_PATH
#      export LD_LIBRARY_PATH=$TOOL_HOME/matio/lib:$TOOL_HOME/lz4/lib:$TOOL_HOME/zstd/lib:$TOOL_HOME/double/lib:$TOOL_HOME/jemalloc/lib:$TOOL_HOME/flex/lib:$TOOL_HOME/bison/lib:$TOOL_HOME/numactl/lib:$TOOL_HOME/libedit/lib:$TOOL_HOME/sasl/lib:$LD_LIBRARY_PATH
#      export LIBRARY_PATH=$TOOL_HOME/matio/lib:$TOOL_HOME/lz4/lib:$TOOL_HOME/zstd/lib:$TOOL_HOME/double/lib:$TOOL_HOME/jemalloc/lib:$TOOL_HOME/flex/lib:$TOOL_HOME/bison/lib:$TOOL_HOME/numactl/lib:$TOOL_HOME/libedit/lib:$TOOL_HOME/sasl/lib:$LIBRARY_PATH
#      export LD_LIBRARY_PATH=$XHOME/intel/mkl/lib/intel64:$TOOL_HOME/gcc/lib64:$TOOL_HOME/libtool/lib:$TOOL_HOME/libjpeg/lib:$TOOL_HOME/ImageMagick/lib:$TOOL_HOME/readline/lib:$TOOL_HOME/ncurses/lib:$TOOL_HOME/fftw/lib:$TOOL_HOME/sox/lib:$CONDA_HOME/lib:$LD_LIBRARY_PATH
#      export LIBRARY_PATH=$XHOME/intel/mkl/lib/intel64:$TOOL_HOME/gcc/lib64:$TOOL_HOME/libtool/lib:$TOOL_HOME/libjpeg/lib:$TOOL_HOME/ImageMagick/lib:$TOOL_HOME/readline/lib:$TOOL_HOME/ncurses/lib:$TOOL_HOME/fftw/lib:$TOOL_HOME/sox/lib:$CONDA_HOME/lib:$LIBRARY_PATH
#      
#      #if [ -d $XHOME/ktorch/install/bin ]; then
#      #    . $XHOME/ktorch/install/bin/torch-activate
#      #fi
#  else
#      export PATH=$JAVA_HOME/bin:$SCALA_HOME/bin:$SBT_HOME:$XHOME/intel/mkl/bin:$COOL_HOME/protobuf/bin:$XHOME/cuda/bin:$XHOME/Tools/bin:$TOOL_HOME/cmake/bin:/opt/matlab/8.1/bin:$CONDA_HOME/bin:$PATH
#      export LD_LIBRARY_PATH=$XHOME/intel/mkl/lib/intel64:$XHOME/opencvc/lib:$XHOME/cuda/lib64:$COOL_HOME/gflags/lib:$COOL_HOME/glog/lib:$COOL_HOME/protobuf/lib:$COOL_HOME/leveldb:$COOL_HOME/liblmdb:$COOL_HOME/snappy/lib:$XHOME/Tools/lib:$TOOL_HOME/cmake/lib:$CONDA_HOME/lib:$LD_LIBRARY_PATH
#      export LIBRARY_PATH=$XHOME/intel/mkl/lib/intel64:$XHOME/opencvc/lib:$XHOME/cuda/lib64:$COOL_HOME/gflags/lib:$COOL_HOME/glog/lib:$COOL_HOME/protobuf/lib:$COOL_HOME/leveldb:$COOL_HOME/liblmdb:$COOL_HOME/snappy/lib:$XHOME/Tools/lib:$TOOL_HOME/cmake/lib:$CONDA_HOME/lib:$LIBRARY_PATH
#      export C_INCLUDE_PATH=$XHOME/intel/mkl/include:$XHOME/opencvc/include:$XHOME/cuda/include:$COOL_HOME/gflags/include:$COOL_HOME/glog/include:$COOL_HOME/protobuf/include:$COOL_HOME/leveldb:$COOL_HOME/liblmdb:$COOL_HOME/snappy/include:$XHOME/Tools/include:$TOOL_HOME/cmake/include:$CONDA_HOME/include:$C_INCLUDE_PATH
#      export CPLUS_INCLUDE_PATH=$XHOME/intel/mkl/include:$XHOME/opencvc/include:$XHOME/cuda/include:$COOL_HOME/gflags/include:$COOL_HOME/glog/include:$COOL_HOME/protobuf/include:$COOL_HOME/leveldb:$COOL_HOME/liblmdb:$COOL_HOME/snappy/include:$XHOME/Tools/include:$TOOL_HOME/cmake/include:$CONDA_HOME/include:$CPLUS_INCLUDE_PATH
#  fi
#fi

# for tmux
export PATH=~/Software/utils/tmux/install/bin:$PATH
export LD_LIBRARY_PATH=~/Software/utils/libevent/install/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=~/Software/utils/libevent/install/lib:$LIBRARY_PATH
export C_INCLUDE_PATH=~/Software/utils/libevent/install/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=~/Software/utils/libevent/install/include:$CPLUS_INCLUDE_PATH

# protobuf
export CMAKE_PREFIX_PATH=/home/rgirdhar/Software/utils/google-protobuf/install/:$CMAKE_PREFIX_PATH
export PATH=/home/rgirdhar/Software/utils/google-protobuf/install/bin/:$PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/google-protobuf/install/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/utils/google-protobuf/install/lib:$LIBRARY_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/utils/google-protobuf/install/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/utils/google-protobuf/install/include:$CPLUS_INCLUDE_PATH

# . /home/rgirdhar/Software/vision/torch/torch/install/bin/torch-activate

alias thinit="source ~/.bashrc_torch"

# for libpng/png++
export CMAKE_PREFIX_PATH=/home/rgirdhar/Software/utils/libpng/install/:$CMAKE_PREFIX_PATH
export LD_LIBRARY_PATH=/home/rgirdhar/Software/utils/libpng/install/lib/:$LD_LIBRARY_PATH
export LIBRARY_PATH=/home/rgirdhar/Software/utils/libpng/install/lib/:$LIBRARY_PATH
export CPLUS_INCLUDE_PATH=/home/rgirdhar/Software/utils/libpng/install/include/:$CPLUS_INCLUDE_PATH
export C_INCLUDE_PATH=/home/rgirdhar/Software/utils/libpng/install/include/:$C_INCLUDE_PATH
export PKG_CONFIG_PATH=/home/rgirdhar/Software/utils/libpng/install/lib/pkgconfig/:$PKG_CONFIG_PATH
export CMAKE_LIBRARY_PATH=/home/rgirdhar/Software/utils/libpng/install/lib/:$CMAKE_LIBRARY_PATH


. /home/rgirdhar/Software/vision/torch/torch/install/bin/torch-activate


export PATH=/home/rgirdhar/Software/utils/bazel/output:$PATH
export XHOME=/home/xinleic
export JAVA_HOME=$XHOME/jdk1.8.0_31
export LIBC17="/home/rgirdhar/Software/vision/tensorflow/other_libs/libc6_2.17"
alias tfpython="LD_LIBRARY_PATH=$LD_LIBRARY_PATH:\"$LIBC17/lib/x86_64-linux-gnu/:$LIBC17/usr/lib/x86_64-linux-gnu/\" /home/rgirdhar/Libs/ld-2.17.so /home/rgirdhar/Software/pl/python/anaconda2/bin/python"
alias tensorboard="LD_LIBRARY_PATH=$LD_LIBRARY_PATH:\"$LIBC17/lib/x86_64-linux-gnu/:$LIBC17/usr/lib/x86_64-linux-gnu/\" /home/rgirdhar/Software/pl/python/anaconda2/bin/tensorboard"

alias tfpython="LIBC17=\"/home/rgirdhar/Software/vision/tensorflow/other_libs/libc6_2.17\"; LD_LIBRARY_PATH=$LD_LIBRARY_PATH:\"$LIBC17/lib/x86_64-linux-gnu/:$LIBC17/usr/lib/x86_64-linux-gnu/\"; /home/rgirdhar/Libs/ld-2.17.so  /home/rgirdhar/Software/pl/python/anaconda2/bin/python"
