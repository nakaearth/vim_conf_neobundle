# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす


# homebrewを優先
export PATH=~/bin:/usr/local/bin:$PATH

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する 
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }


# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors
# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

### Title (user@hostname) ###
case "${TERM}" in
kterm*|xterm*|)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;
esac

#rvm
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

M2_HOME=/usr/local/libs/apache-maven-3.0.4
GRAILS_HOME=/usr/local/libs/grails-2.2.4
PLAY_HOME=/usr/local/libs/play-2.1.3
ANT_HOME=/usr/local/libs/apache-ant-1.9.3
PATH=$PATH:/bin:/usr/bin:/usr/local/bin
PATH=/usr/local/sbin:$PATH
# homebrewを優先
#export PATH=~/bin:/usr/local/bin:$PATH
PATH=/opt/ImageMagick/bin:$PATH
PATH=/usr/local/heroku/bin:$PATH
PATH=$M2_HOME/bin:$PATH
PATH=$GRAILS_HOME/bin:$PATH
PATH=$PATH:$PLAY_HOME
PATH=$PATH:$ANT_HOME
PATH=/usr/local/libs/packer:$PATH
PATH=/usr/local/Cellar/git/1.8.3.4/bin:$PATH
PATH=/usr/local/libs/gitsetting:$PATH

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
### RVM ###
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

#awscli
#complete -C aws_completer aws
export AWS_CONFIG_FILE=~/.aws/cli.conf
export AWS_DEFAULT_OUTPUT=text
export AWS_DEFAULT_PROFILE=girlscamera

export TREASURE_DATA_API_KEY=35ce8ef4bf3edc5fe52f3fe570cecee418e05fc5
export DEV_MAIL_USER=naka5313
export DEV_MAIL_PASSWD=earth!

export DROP_BOX_APP_KEY=dpiszttj2gcumrs
export DROP_BOX_APP_SECRET=g8lle79btop96jt

export PANDASTREAM_URL=https://f889aba2dfc556805d76:9a6ccafe6399a4554b85@api.pandastream.com/3860f5eba6d42dd2bb7b9d106629e13f

### Aliases ###
alias r=rails
alias v=vim


