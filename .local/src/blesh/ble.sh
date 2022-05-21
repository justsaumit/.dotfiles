# this script is a part of blesh (https://github.com/akinomyoga/ble.sh) under BSD-3-Clause license
{
_ble_init_version=0.4.0-devel3+a4a779e
  _ble_init_exit=
  _ble_init_command=
  for _ble_init_arg; do
    case $_ble_init_arg in
    --version)
      _ble_init_exit=0
      echo "ble.sh (Bash Line Editor), version $_ble_init_version" ;;
    --help)
      _ble_init_exit=0
      printf '%s\n' \
             "# ble.sh (Bash Line Editor), version $_ble_init_version" \
             'usage: source ble.sh [OPTION...]' \
             '' \
             'OPTION' \
             '' \
             '  --help' \
             '    Show this help and exit' \
             '  --version' \
             '    Show version and exit' \
             '  --test' \
             '    Run test and exit' \
             '  --update' \
             '    Update ble.sh and exit' \
             '  --clear-cache' \
             '    Clear ble.sh cache and exit' \
             '' \
             '  --rcfile=BLERC' \
             '  --init-file=BLERC' \
             '    Specify the ble init file. The default is ~/.blerc.' \
             '' \
             '  --norc' \
             '    Do not load the ble init file.' \
             '' \
             '  --attach=ATTACH' \
             '  --noattach' \
             '    The option "--attach" selects the strategy of "ble-attach" from the' \
             '    list: ATTACH = "attach" | "prompt" | "none". The default strategy is' \
             '    "prompt". The option "--noattach" is a synonym for "--attach=none".' \
             '' \
             '  --noinputrc' \
             '    Do not read inputrc settings for ble.sh' \
             '' \
             '  --keep-rlvars' \
             '    Do not change readline settings for ble.sh' \
             '' \
             '  -o BLEOPT=VALUE' \
             '    Set a value for the specified bleopt option.' \
             '  --debug-bash-output' \
             '    Internal settings for debugging' \
             '' ;;
    --test | --update | --clear-cache) _ble_init_command=1 ;;
    esac
  done
  if [ -n "$_ble_init_exit" ]; then
    unset _ble_init_version
    unset _ble_init_arg
    unset _ble_init_exit
    unset _ble_init_command
    return 0 2>/dev/null || exit 0
  fi
} 2>/dev/null # set -x 対策 #D0930
if [ -z "${BASH_VERSION-}" ]; then
  echo "ble.sh: This shell is not Bash. Please use this script with Bash." >&3
  return 1 2>/dev/null || exit 1
fi 3>&2 >/dev/null 2>&1 # set -x 対策 #D0930
if [ -z "${BASH_VERSINFO-}" ] || [ "${BASH_VERSINFO-0}" -lt 3 ]; then
  echo "ble.sh: Bash with a version under 3.0 is not supported." >&3
  return 1 2>/dev/null || exit 1
fi 3>&2 >/dev/null 2>&1 # set -x 対策 #D0930
if [[ ! $_ble_init_command ]]; then
  if [[ ${BASH_EXECUTION_STRING+set} ]]; then
    return 1 2>/dev/null || builtin exit 1
  fi
  if ((BASH_SUBSHELL)); then
    builtin echo "ble.sh: ble.sh cannot be loaded into a subshell." >&3
    return 1 2>/dev/null || builtin exit 1
  elif [[ $- != *i* ]]; then
    case " ${BASH_SOURCE[*]##*/} " in
    (*' .bashrc '* | *' .bash_profile '* | *' .profile '* | *' bashrc '* | *' profile '*) false ;;
    esac  &&
      builtin echo "ble.sh: This is not an interactive session." >&3 || ((1))
    return 1 2>/dev/null || builtin exit 1
  elif ! [[ -t 0 && -t 1 ]] && ! ((1)) >/dev/tty; then
    builtin echo "ble.sh: cannot find a controlling TTY/PTY in this session." >&3
    return 1 2>/dev/null || builtin exit 1
  fi
fi 3>&2 &>/dev/null # set -x 対策 #D0930
{
  _ble_bash_POSIXLY_CORRECT_adjusted=1
  _ble_bash_POSIXLY_CORRECT_set=${POSIXLY_CORRECT+set}
  _ble_bash_POSIXLY_CORRECT=${POSIXLY_CORRECT-}
  POSIXLY_CORRECT=y
  _ble_bash_expand_aliases=
  \shopt -q expand_aliases &&
    _ble_bash_expand_aliases=1 &&
    \shopt -u expand_aliases || ((1))
  _ble_bash_FUNCNEST_adjusted=
  _ble_bash_FUNCNEST=
  _ble_bash_FUNCNEST_set=
  _ble_bash_FUNCNEST_adjust='
    if [[ ! $_ble_bash_FUNCNEST_adjusted ]]; then
      _ble_bash_FUNCNEST_adjusted=1
      _ble_bash_FUNCNEST_set=${FUNCNEST+set}
      _ble_bash_FUNCNEST=${FUNCNEST-}
      builtin unset -v FUNCNEST
    fi 2>/dev/null'
  _ble_bash_FUNCNEST_restore='
    if [[ $_ble_bash_FUNCNEST_adjusted ]]; then
      _ble_bash_FUNCNEST_adjusted=
      if [[ $_ble_bash_FUNCNEST_set ]]; then
        FUNCNEST=$_ble_bash_FUNCNEST
      else
        builtin unset -v FUNCNEST
      fi
    fi 2>/dev/null'
  \builtin eval -- "$_ble_bash_FUNCNEST_adjust"
  \builtin unset -v POSIXLY_CORRECT
} 2>/dev/null
function ble/base/workaround-POSIXLY_CORRECT {
  true
}
function ble/base/unset-POSIXLY_CORRECT {
  if [[ ${POSIXLY_CORRECT+set} ]]; then
    builtin unset -v POSIXLY_CORRECT
    ble/base/workaround-POSIXLY_CORRECT
  fi
}
function ble/base/adjust-POSIXLY_CORRECT {
  if [[ $_ble_bash_POSIXLY_CORRECT_adjusted ]]; then return 0; fi # Note: set -e 対策
  _ble_bash_POSIXLY_CORRECT_adjusted=1
  _ble_bash_POSIXLY_CORRECT_set=${POSIXLY_CORRECT+set}
  _ble_bash_POSIXLY_CORRECT=${POSIXLY_CORRECT-}
  if [[ $_ble_bash_POSIXLY_CORRECT_set ]]; then
    builtin unset -v POSIXLY_CORRECT
  fi
  ble/base/workaround-POSIXLY_CORRECT
}
function ble/base/restore-POSIXLY_CORRECT {
  if [[ ! $_ble_bash_POSIXLY_CORRECT_adjusted ]]; then return 0; fi # Note: set -e の為 || は駄目
  _ble_bash_POSIXLY_CORRECT_adjusted=
  if [[ $_ble_bash_POSIXLY_CORRECT_set ]]; then
    POSIXLY_CORRECT=$_ble_bash_POSIXLY_CORRECT
  else
    ble/base/unset-POSIXLY_CORRECT
  fi
}
function ble/base/is-POSIXLY_CORRECT {
  if [[ $_ble_bash_POSIXLY_CORRECT_adjusted ]]; then
    [[ $_ble_bash_POSIXLY_CORRECT_set ]]
  else
    [[ ${POSIXLY_CORRECT+set} ]]
  fi
}
{
  _ble_bash_builtins_adjusted=
  _ble_bash_builtins_save=
} 2>/dev/null # set -x 対策
function ble/base/adjust-builtin-wrappers/.assign {
  if [[ ${_ble_util_assign_base-} ]]; then
    local _ble_local_tmpfile; ble/util/assign/.mktmp
    builtin eval -- "$1" >| "$_ble_local_tmpfile"
    IFS= builtin read -r -d '' defs < "$_ble_local_tmpfile"
    ble/util/assign/.rmtmp
  else
    defs=$(builtin eval -- "$1")
  fi || ((1))
}
function ble/base/adjust-builtin-wrappers-1 {
  unset -f builtin
  builtin local POSIXLY_CORRECT=y builtins1 keywords1
  builtins1=(builtin unset enable unalias return break continue declare local typeset readonly eval exec set)
  keywords1=(if then elif else case esac while until for select do done '{' '}' '[[' function)
  if [[ ! $_ble_bash_builtins_adjusted ]]; then
    _ble_bash_builtins_adjusted=1
    builtin local defs
    ble/base/adjust-builtin-wrappers/.assign '
      \builtin declare -f "${builtins1[@]}" || ((1))
      \builtin alias "${builtins1[@]}" "${keywords1[@]}" || ((1))' # set -e 対策
    _ble_bash_builtins_save=$defs
  fi
  builtin unset -f "${builtins1[@]}"
  builtin unalias "${builtins1[@]}" "${keywords1[@]}" || ((1)) # set -e 対策
  ble/base/unset-POSIXLY_CORRECT
} 2>/dev/null
function ble/base/adjust-builtin-wrappers-2 {
  local defs
  ble/base/adjust-builtin-wrappers/.assign 'LC_ALL= LC_MESSAGES=C builtin type :; alias :' || ((1)) # set -e 対策
  defs=${defs#$': is a function\n'}
  _ble_bash_builtins_save=$_ble_bash_builtins_save$'\n'$defs
  builtin unset -f :
  builtin unalias : || ((1)) # set -e 対策
} 2>/dev/null
function ble/base/restore-builtin-wrappers {
  if [[ $_ble_bash_builtins_adjusted ]]; then
    _ble_bash_builtins_adjusted=
    builtin eval -- "$_ble_bash_builtins_save"
  fi
}
{
  ble/base/adjust-builtin-wrappers-1
  ble/base/adjust-builtin-wrappers-2
  if [[ $_ble_bash_expand_aliases ]]; then
    shopt -s expand_aliases
  fi
} 2>/dev/null # set -x 対策
function ble/variable#copy-state {
  local src=$1 dst=$2
  if [[ ${!src+set} ]]; then
    builtin eval -- "$dst=\${$src}"
  else
    builtin unset -v "$dst[0]" 2>/dev/null || builtin unset -v "$dst"
  fi
}
function ble/base/.adjust-bash-options {
  builtin eval -- "$1=\$-"
  set +exvukT -B
  [[ $2 == shopt ]] || local shopt
  if ((_ble_bash>=40100)); then
    shopt=$BASHOPTS
  else
    shopt=
    shopt -q extdebug 2>/dev/null && shopt=$shopt:extdebug
    shopt -q nocasematch 2>/dev/null && shopt=$shopt:nocasematch
  fi
  [[ $2 == shopt ]] || builtin eval -- "$2=\$shopt"
  shopt -u extdebug
  shopt -u nocasematch 2>/dev/null
  return 0
} 2>/dev/null # set -x 対策
function ble/base/.restore-bash-options {
  local set=${!1} shopt=${!2}
  [[ :$shopt: == *:nocasematch:* ]] && shopt -s nocasematch
  [[ :$shopt: == *:extdebug:* ]] && shopt -s extdebug
  [[ $set == *B* ]] || set +B
  [[ $set == *T* ]] && set -T
  [[ $set == *k* ]] && set -k
  [[ $set == *u* ]] && set -u
  [[ $set == *v* ]] && set -v
  [[ $set == *x* ]] && set -x
  [[ $set == *e* ]] && set -e # set -e は最後
  return 0
} 2>/dev/null # set -x 対策
{
  : "${_ble_bash_options_adjusted=}"
  _ble_bash_set=$-
  _ble_bash_shopt=${BASHOPTS-}
} 2>/dev/null # set -x 対策
function ble/base/adjust-bash-options {
  [[ $_ble_bash_options_adjusted ]] && return 1 || ((1)) # set -e 対策
  _ble_bash_options_adjusted=1
  ble/base/.adjust-bash-options _ble_bash_set _ble_bash_shopt
  _ble_bash_expand_aliases=
  shopt -q expand_aliases 2>/dev/null &&
    _ble_bash_expand_aliases=1
  ble/variable#copy-state LC_ALL _ble_bash_LC_ALL
  if [[ ${LC_ALL-} ]]; then
    ble/variable#copy-state LC_CTYPE    _ble_bash_LC_CTYPE
    ble/variable#copy-state LC_MESSAGES _ble_bash_LC_MESSAGES
    ble/variable#copy-state LC_NUMERIC  _ble_bash_LC_NUMERIC
    ble/variable#copy-state LC_TIME     _ble_bash_LC_TIME
    ble/variable#copy-state LANG        _ble_bash_LANG
    [[ ${LC_CTYPE-}    ]] && LC_CTYPE=$LC_ALL
    [[ ${LC_MESSAGES-} ]] && LC_MESSAGES=$LC_ALL
    [[ ${LC_NUMERIC-}  ]] && LC_NUMERIC=$LC_ALL
    [[ ${LC_TIME-}     ]] && LC_TIME=$LC_ALL
    LANG=$LC_ALL
    LC_ALL=
  fi
  ble/variable#copy-state LC_COLLATE _ble_bash_LC_COLLATE
  LC_COLLATE=C
  if local TMOUT= 2>/dev/null; then # #D1630 WA
    _ble_bash_tmout_wa=()
  else
    _ble_bash_tmout_wa=(-t 2147483647)
  fi
} 2>/dev/null # set -x 対策 #D0930 / locale 変更
function ble/base/restore-bash-options {
  [[ $_ble_bash_options_adjusted ]] || return 1
  _ble_bash_options_adjusted=
  ble/variable#copy-state _ble_bash_LC_COLLATE LC_COLLATE
  if [[ $_ble_bash_LC_ALL ]]; then
    ble/variable#copy-state _ble_bash_LC_CTYPE    LC_CTYPE
    ble/variable#copy-state _ble_bash_LC_MESSAGES LC_MESSAGES
    ble/variable#copy-state _ble_bash_LC_NUMERIC  LC_NUMERIC
    ble/variable#copy-state _ble_bash_LC_TIME     LC_TIME
    ble/variable#copy-state _ble_bash_LANG        LANG
  fi
  ble/variable#copy-state _ble_bash_LC_ALL LC_ALL
  [[ $_ble_bash_nocasematch ]] && shopt -s nocasematch
  ble/base/.restore-bash-options _ble_bash_set _ble_bash_shopt
} 2>/dev/null # set -x 対策 #D0930 / locale 変更
function ble/base/recover-bash-options {
  if [[ $_ble_bash_expand_aliases ]]; then
    shopt -s expand_aliases
  else
    shopt -u expand_aliases
  fi
}
{ ble/base/adjust-bash-options; } &>/dev/null # set -x 対策 #D0930
builtin bind &>/dev/null # force to load .inputrc
if [[ $OSTYPE == msys* ]]; then
  [[ $(builtin bind -m emacs -p | grep '"\\C-?"') == '"\C-?": backward-kill-line' ]] &&
    builtin bind -m emacs '"\C-?": backward-delete-char'
fi
if [[ ! -o emacs && ! -o vi && ! $_ble_init_command ]]; then
  builtin echo "ble.sh: ble.sh is not intended to be used with the line-editing mode disabled (--noediting)." >&2
  ble/base/restore-bash-options
  ble/base/restore-builtin-wrappers
  ble/base/restore-POSIXLY_CORRECT
  builtin eval -- "$_ble_bash_FUNCNEST_restore"
  return 1 2>/dev/null || builtin exit 1
fi
if shopt -q restricted_shell; then
  builtin echo "ble.sh: ble.sh is not intended to be used in restricted shells (--restricted)." >&2
  ble/base/restore-bash-options
  ble/base/restore-builtin-wrappers
  ble/base/restore-POSIXLY_CORRECT
  builtin eval -- "$_ble_bash_FUNCNEST_restore"
  return 1 2>/dev/null || builtin exit 1
fi
function ble/init/adjust-IFS {
  _ble_init_original_IFS_set=${IFS+set}
  _ble_init_original_IFS=$IFS
  IFS=$' \t\n'
}
function ble/init/restore-IFS {
  if [[ $_ble_init_original_IFS_set ]]; then
    IFS=$_ble_init_original_IFS
  else
    builtin unset -v IFS
  fi
  builtin unset -v _ble_init_original_IFS_set
  builtin unset -v _ble_init_original_IFS
}
if ((_ble_bash>=50100)); then
  _ble_bash_BASH_REMATCH_level=0
  _ble_bash_BASH_REMATCH=()
  function ble/base/adjust-BASH_REMATCH {
    ((_ble_bash_BASH_REMATCH_level++==0)) || return 0
    _ble_bash_BASH_REMATCH=("${BASH_REMATCH[@]}")
  }
  function ble/base/restore-BASH_REMATCH {
    ((_ble_bash_BASH_REMATCH_level>0&&
        --_ble_bash_BASH_REMATCH_level==0)) || return 0
    BASH_REMATCH=("${_ble_bash_BASH_REMATCH[@]}")
  }
else
  _ble_bash_BASH_REMATCH_level=0
  _ble_bash_BASH_REMATCH=()
  _ble_bash_BASH_REMATCH_rex=none
  function ble/base/adjust-BASH_REMATCH/increase {
    local delta=$1
    ((delta)) || return 1
    ((i+=delta))
    if ((delta==1)); then
      rex=$rex.
    else
      rex=$rex.{$delta}
    fi
  }
  function ble/base/adjust-BASH_REMATCH/is-updated {
    local i n=${#_ble_bash_BASH_REMATCH[@]}
    ((n!=${#BASH_REMATCH[@]})) && return 0
    for ((i=0;i<n;i++)); do
      [[ ${_ble_bash_BASH_REMATCH[i]} != "${BASH_REMATCH[i]}" ]] && return 0
    done
    return 1
  }
  function ble/base/adjust-BASH_REMATCH/.find-substr {
    local t=${1#*"$2"}
    ((ret=${#1}-${#t}-${#2},ret<0&&(ret=-1),ret>=0))
  }
  function ble/base/adjust-BASH_REMATCH {
    ((_ble_bash_BASH_REMATCH_level++==0)) || return 0
    ble/base/adjust-BASH_REMATCH/is-updated || return 1
    local size=${#BASH_REMATCH[@]}
    if ((size==0)); then
      _ble_bash_BASH_REMATCH=()
      _ble_bash_BASH_REMATCH_rex=none
      return 0
    fi
    local rex= i=0
    local text=$BASH_REMATCH sub ret isub
    local -a rparens=()
    local isub rex i=0 count=0
    for ((isub=1;isub<size;isub++)); do
      local sub=${BASH_REMATCH[isub]}
      while ((count>=1)); do
        local end=${rparens[count-1]}
        if ble/base/adjust-BASH_REMATCH/.find-substr "${text:i:end-i}" "$sub"; then
          ble/base/adjust-BASH_REMATCH/increase "$ret"
          ((rparens[count++]=i+${#sub}))
          rex=$rex'('
          break
        else
          ble/base/adjust-BASH_REMATCH/increase $((end-i))
          rex=$rex')'
          builtin unset -v 'rparens[--count]'
        fi
      done
      ((count>0)) && continue
      if ble/base/adjust-BASH_REMATCH/.find-substr "${text:i}" "$sub"; then
        ble/base/adjust-BASH_REMATCH/increase "$ret"
        ((rparens[count++]=i+${#sub}))
        rex=$rex'('
      else
        break # 復元失敗
      fi
    done
    while ((count>=1)); do
      local end=${rparens[count-1]}
      ble/base/adjust-BASH_REMATCH/increase $((end-i))
      rex=$rex')'
      builtin unset -v 'rparens[--count]'
    done
    ble/base/adjust-BASH_REMATCH/increase $((${#text}-i))
    _ble_bash_BASH_REMATCH=("${BASH_REMATCH[@]}")
    _ble_bash_BASH_REMATCH_rex=$rex
  }
  function ble/base/restore-BASH_REMATCH {
    ((_ble_bash_BASH_REMATCH_level>0&&
        --_ble_bash_BASH_REMATCH_level==0)) || return 0
    [[ $_ble_bash_BASH_REMATCH =~ $_ble_bash_BASH_REMATCH_rex ]]
  }
fi
ble/init/adjust-IFS
ble/base/adjust-BASH_REMATCH
function ble/init/clean-up {
  local ext=$? opts=$1 # preserve exit status
  builtin unset -v _ble_init_version
  builtin unset -v _ble_init_arg
  builtin unset -v _ble_init_exit
  builtin unset -v _ble_init_command
  builtin unset -v _ble_init_attached
  ble/base/restore-BASH_REMATCH
  ble/init/restore-IFS
  if [[ :$opts: != *:check-attach:* && ! $_ble_attached ]]; then
    ble/base/restore-bash-options
    ble/base/restore-POSIXLY_CORRECT
    ble/base/restore-builtin-wrappers
    builtin eval -- "$_ble_bash_FUNCNEST_restore"
  fi
  return "$ext"
}
function ble/util/put { builtin printf '%s' "$1"; }
function ble/util/print { builtin printf '%s\n' "$1"; }
function ble/util/print-lines { builtin printf '%s\n' "$@"; }
_ble_base_arguments_opts=
_ble_base_arguments_attach=
_ble_base_arguments_rcfile=
function ble/base/read-blesh-arguments {
  local opts=
  local opt_attach=prompt
  _ble_init_command= # 再解析
  while (($#)); do
    local arg=$1; shift
    case $arg in
    (--noattach|noattach)
      opt_attach=none ;;
    (--attach=*) opt_attach=${arg#*=} ;;
    (--attach)
      if (($#)); then
        opt_attach=$1; shift
      else
        opt_attach=attach
        opts=$opts:E
        ble/util/print "ble.sh ($arg): an option argument is missing." >&2
      fi ;;
    (--noinputrc)
      opts=$opts:noinputrc ;;
    (--rcfile=*|--init-file=*|--rcfile|--init-file)
      if [[ $arg != *=* ]]; then
        local rcfile=$1; shift
      else
        local rcfile=${arg#*=}
      fi
      _ble_base_arguments_rcfile=${rcfile:-/dev/null}
      if [[ ! $rcfile || ! -e $rcfile ]]; then
        ble/util/print "ble.sh ($arg): '$rcfile' does not exist." >&2
        opts=$opts:E
      elif [[ ! -r $rcfile ]]; then
        ble/util/print "ble.sh ($arg): '$rcfile' is not readable." >&2
        opts=$opts:E
      fi ;;
    (--norc)
      _ble_base_arguments_rcfile=/dev/null ;;
    (--keep-rlvars)
      opts=$opts:keep-rlvars ;;
    (--debug-bash-output)
      bleopt_internal_suppress_bash_output= ;;
    (--test | --update | --clear-cache)
      if [[ $_ble_init_command ]]; then
        ble/util/print "ble.sh ($arg): the option '--$_ble_init_command' has already been specified." >&2
        opts=$opts:E
      else
        _ble_init_command=${arg#--}
      fi ;;
    (--*)
      ble/util/print "ble.sh: unrecognized long option '$arg'" >&2
      opts=$opts:E ;;
    (-?*)
      local i c
      for ((i=1;i<${#arg};i++)); do
        c=${arg:i:1}
        case -$c in
        (-o)
          if ((i+1<${#arg})); then
            local oarg=${arg:i+1}
            i=${#arg}
          elif (($#)); then
            local oarg=$1; shift
          else
            opts=$opts:E
            i=${#arg}
            continue
          fi
          local rex='^[_a-zA-Z][_a-zA-Z0-9]*='
          if [[ $oarg =~ $rex ]]; then
            builtin eval -- "bleopt_${oarg%%=*}=\${oarg#*=}"
          else
            ble/util/print "ble.sh: unrecognized option '-o $oarg'" >&2
            opts=$opts:E
          fi ;;
        (-*)
          ble/util/print "ble.sh: unrecognized option '-$c'" >&2
          opts=$opts:E ;;
        esac
      done
      ;;
    (*)
      ble/util/print "ble.sh: unrecognized argument '$arg'" >&2
      opts=$opts:E ;;
    esac
  done
  _ble_base_arguments_opts=$opts
  _ble_base_arguments_attach=$opt_attach
  [[ :$opts: != *:E:* ]]
}
if ! ble/base/read-blesh-arguments "$@"; then
  builtin echo "ble.sh: cancel initialization." >&2
  ble/init/clean-up 2>/dev/null # set -x 対策 #D0930
  return 2 2>/dev/null || builtin exit 2
fi
if [[ ${_ble_base-} ]]; then
  [[ $_ble_init_command ]] && _ble_init_attached=$_ble_attached
  if ! ble/base/unload-for-reload; then
    builtin echo "ble.sh: an old version of ble.sh seems to be already loaded." >&2
    ble/init/clean-up 2>/dev/null # set -x 対策 #D0930
    return 1 2>/dev/null || builtin exit 1
  fi
fi
case ${BASH_VERSINFO[4]} in
(alp*|bet*|dev*|rc*|releng*|maint*)
  ble/util/print-lines \
    "ble.sh may become very slow because this is a debug version of Bash" \
    "  (version '$BASH_VERSION', release status: '${BASH_VERSINFO[4]}')." \
    "  We recommend using ble.sh with a release version of Bash." >&2 ;;
esac
_ble_bash=$((BASH_VERSINFO[0]*10000+BASH_VERSINFO[1]*100+BASH_VERSINFO[2]))
_ble_bash_loaded_in_function=0
local _ble_local_test 2>/dev/null && _ble_bash_loaded_in_function=1
_ble_version=0
BLE_VERSION=$_ble_init_version
function ble/base/initialize-version-information {
  local version=$BLE_VERSION
  local hash=
  if [[ $version == *+* ]]; then
    hash=${version#*+}
    version=${version%%+*}
  fi
  local status=release
  if [[ $version == *-* ]]; then
    status=${version#*-}
    version=${version%%-*}
  fi
  local major=${version%%.*}; version=${version#*.}
  local minor=${version%%.*}; version=${version#*.}
  local patch=${version%%.*}
  BLE_VERSINFO=("$major" "$minor" "$patch" "$hash" "$status" noarch)
  ((_ble_version=major*10000+minor*100+patch))
}
ble/base/initialize-version-information
function ble/util/assign { builtin eval "$1=\$(builtin eval -- \"\$2\")"; }
function ble/bin/.default-utility-path {
  local cmd
  for cmd; do
    builtin eval "function ble/bin/$cmd { command $cmd \"\$@\"; }"
  done
}
function ble/bin/.freeze-utility-path {
  local cmd path q=\' Q="'\''" fail=
  for cmd; do
    ble/bin#has "ble/bin/.frozen:$cmd" && continue
    if ble/util/assign path "builtin type -P -- $cmd 2>/dev/null" && [[ $path ]]; then
      builtin eval "function ble/bin/$cmd { '${path//$q/$Q}' \"\$@\"; }"
    else
      fail=1
    fi
  done
  ((!fail))
}
if ((_ble_bash>=40000)); then
  function ble/bin#has { type -t "$@" &>/dev/null; }
else
  function ble/bin#has {
    local cmd
    for cmd; do type -t "$cmd" || return 1; done &>/dev/null
    return 0
  }
fi
_ble_init_posix_command_list=(sed date rm mkdir mkfifo sleep stty tty sort awk chmod grep cat wc mv sh od cp ps)
function ble/init/check-environment {
  if ! ble/bin#has "${_ble_init_posix_command_list[@]}"; then
    local cmd commandMissing=
    for cmd in "${_ble_init_posix_command_list[@]}"; do
      if ! type "$cmd" &>/dev/null; then
        commandMissing="$commandMissing\`$cmd', "
      fi
    done
    ble/util/print "ble.sh: insane environment: The command(s), ${commandMissing}not found. Check your environment variable PATH." >&2
    local default_path=$(command -p getconf PATH 2>/dev/null)
    [[ $default_path ]] || return 1
    local original_path=$PATH
    export PATH=${default_path}${PATH:+:}${PATH}
    [[ :$PATH: == *:/bin:* ]] || PATH=/bin${PATH:+:}$PATH
    [[ :$PATH: == *:/usr/bin:* ]] || PATH=/usr/bin${PATH:+:}$PATH
    if ! ble/bin#has "${_ble_init_posix_command_list[@]}"; then
      PATH=$original_path
      return 1
    fi
    ble/util/print "ble.sh: modified PATH=${PATH::${#PATH}-${#original_path}}\$PATH" >&2
  fi
  if [[ ! $USER ]]; then
    ble/util/print "ble.sh: insane environment: \$USER is empty." >&2
    if type id &>/dev/null; then
      export USER=$(id -un)
      ble/util/print "ble.sh: modified USER=$USER" >&2
    fi
  fi
  ble/bin/.default-utility-path "${_ble_init_posix_command_list[@]}"
  return 0
}
if ! ble/init/check-environment; then
  ble/util/print "ble.sh: failed to adjust the environment. canceling the load of ble.sh." 1>&2
  builtin unset -v _ble_bash BLE_VERSION BLE_VERSINFO
  ble/init/clean-up 2>/dev/null # set -x 対策 #D0930
  return 1
fi
_ble_bin_awk_type=
function ble/bin/awk/.instantiate {
  local path q=\' Q="'\''"
  if [[ $OSTYPE == solaris* ]] && type /usr/xpg4/bin/awk >/dev/null; then
    _ble_bin_awk_type=xpg4
    function ble/bin/awk { /usr/xpg4/bin/awk -v AWKTYPE=xpg4 "$@"; }
  elif ble/util/assign path "builtin type -P -- nawk 2>/dev/null" && [[ $path ]]; then
    _ble_bin_awk_type=nawk
    builtin eval "function ble/bin/awk { '${path//$q/$Q}' -v AWKTYPE=nawk \"\$@\"; }"
  elif ble/util/assign path "builtin type -P -- mawk 2>/dev/null" && [[ $path ]]; then
    _ble_bin_awk_type=mawk
    builtin eval "function ble/bin/awk { '${path//$q/$Q}' -v AWKTYPE=mawk \"\$@\"; }"
  elif ble/util/assign path "builtin type -P -- gawk 2>/dev/null" && [[ $path ]]; then
    _ble_bin_awk_type=gawk
    builtin eval "function ble/bin/awk { '${path//$q/$Q}' -v AWKTYPE=gawk \"\$@\"; }"
  elif ble/util/assign path "builtin type -P -- awk 2>/dev/null" && [[ $path ]]; then
    local version
    ble/util/assign version '"$path" --version 2>&1'
    if [[ $version == *'GNU Awk'* ]]; then
      _ble_bin_awk_type=gawk
    elif [[ $version == *mawk* ]]; then
      _ble_bin_awk_type=mawk
    elif [[ $version == 'awk version '[12][0-9][0-9][0-9][01][0-9][0-3][0-9] ]]; then
      _ble_bin_awk_type=nawk
    else
      _ble_bin_awk_type=unknown
    fi
    builtin eval "function ble/bin/awk { '${path//$q/$Q}' -v AWKTYPE=$_ble_bin_awk_type \"\$@\"; }"
  else
    return 1
  fi
}
function ble/bin/awk {
  ble/bin/awk/.instantiate &&
    ble/bin/awk "$@"
}
function ble/bin/.frozen:awk { :; }
function ble/util/mkd {
  local dir
  for dir; do
    [[ -d $dir ]] && continue
    [[ -e $dir || -L $dir ]] && ble/bin/rm -f "$dir"
    ble/bin/mkdir -p "$dir"
  done
}
_ble_bin_awk_supports_null_RS=
function ble/bin/awk.supports-null-record-separator {
  if [[ ! $_ble_bin_awk_supports_null_RS ]]; then
    local count=0 awk_script='BEGIN { RS = "\0"; } { count++; } END { print count; }'
    ble/util/assign count 'printf "a\0b\0" | ble/bin/awk "$awk_script" '
    if ((count==2)); then
      _ble_bin_awk_supports_null_RS=yes
    else
      _ble_bin_awk_supports_null_RS=no
    fi
  fi
  [[ $_ble_bin_awk_supports_null_RS == yes ]]
}
if ((_ble_bash>=40000)); then
  _ble_util_readlink_visited_init='local -A visited=()'
  function ble/util/readlink/.visited {
    [[ ${visited[$1]+set} ]] && return 0
    visited[$1]=1
    return 1
  }
else
  _ble_util_readlink_visited_init="local -a visited=()"
  function ble/util/readlink/.visited {
    local key
    for key in "${visited[@]}"; do
      [[ $1 == "$key" ]] && return 0
    done
    visited=("$1" "${visited[@]}")
    return 1
  }
fi
function ble/util/readlink/.readlink {
  local path=$1
  if ble/bin#has ble/bin/readlink; then
    ble/util/assign link 'ble/bin/readlink -- "$path"'
    [[ $link ]]
  elif ble/bin#has ble/bin/ls; then
    ble/util/assign link 'ble/bin/ls -ld -- "$path"' &&
      [[ $link == *" $path -> "?* ]] &&
      link=${link#*" $path -> "}
  else
    false
  fi
} 2>/dev/null
function ble/util/readlink/.resolve-physical-directory {
  [[ $path == */?* ]] || return 0
  local PWD=$PWD OLDPWD=$OLDPWD CDPATH=
  builtin cd -L . &&
    local pwd=$PWD &&
    builtin cd -P "${path%/*}/" &&
    path=${PWD%/}/${path##*/}
  builtin cd -L "$pwd"
  return 0
}
function ble/util/readlink/.resolve-loop {
  local path=$ret
  builtin eval -- "$_ble_util_readlink_visited_init"
  while [[ -h $path ]]; do
    local link
    ble/util/readlink/.visited "$path" && break
    ble/util/readlink/.readlink "$path" || break
    if [[ $link == /* || $path != */* ]]; then
      path=$link
    else
      ble/util/readlink/.resolve-physical-directory
      path=${path%/}/$link
    fi
    while [[ $path == ?*/ ]]; do path=${path%/}; done
  done
  ret=$path
}
function ble/util/readlink/.resolve {
  _ble_util_readlink_type=
  case $OSTYPE in
  (cygwin | msys | linux-gnu)
    local readlink
    ble/util/assign readlink 'type -P readlink'
    case $readlink in
    (/bin/readlink | /usr/bin/readlink)
      _ble_util_readlink_type=readlink-f
      builtin eval "function ble/util/readlink/.resolve { ble/util/assign ret '$readlink -f -- \"\$ret\"'; }" ;;
    esac ;;
  esac
  if [[ ! $_ble_util_readlink_type ]]; then
    _ble_util_readlink_type=loop
    ble/bin/.freeze-utility-path readlink ls
    function ble/util/readlink/.resolve { ble/util/readlink/.resolve-loop; }
  fi
  ble/util/readlink/.resolve
}
function ble/util/readlink {
  ret=$1
  if [[ -h $ret ]]; then ble/util/readlink/.resolve; fi
}
_ble_bash_path=
function ble/bin/.load-builtin {
  local name=$1 path=$2
  if [[ ! $_ble_bash_path ]]; then
    local ret; ble/util/readlink "$BASH"
    _ble_bash_path=$ret
  fi
  if [[ ! $path ]]; then
    local bash_prefix=${ret%/*/*}
    path=$bash_prefix/lib/bash/$name
    [[ -s $path ]] || return 1
  fi
  if (enable -f "$path" "$name") &>/dev/null; then
    enable -f "$path" "$name"
    builtin eval -- "function ble/bin/$name { builtin $name \"\$@\"; }"
    return 0
  else
    return 1
  fi
}
function ble/base/.create-user-directory {
  local var=$1 dir=$2
  if [[ ! -d $dir ]]; then
    [[ ! -e $dir && -h $dir ]] && ble/bin/rm -f "$dir"
    if [[ -e $dir || -h $dir ]]; then
      ble/util/print "ble.sh: cannot create a directory '$dir' since there is already a file." >&2
      return 1
    fi
    if ! (umask 077; ble/bin/mkdir -p "$dir" && [[ -O $dir ]]); then
      ble/util/print "ble.sh: failed to create a directory '$dir'." >&2
      return 1
    fi
  elif ! [[ -r $dir && -w $dir && -x $dir ]]; then
    ble/util/print "ble.sh: permission of '$dir' is not correct." >&2
    return 1
  elif [[ ! -O $dir ]]; then
    ble/util/print "ble.sh: owner of '$dir' is not correct." >&2
    return 1
  fi
  builtin eval "$var=\$dir"
}
function ble/base/initialize-base-directory {
  local src=$1
  local defaultDir=${2-}
  _ble_base_blesh_raw=$src
  if [[ -h $src ]]; then
    local ret; ble/util/readlink "$src"; src=$ret
  fi
  _ble_base_blesh=$src
  if [[ -s $src && $src != */* ]]; then
    _ble_base=$PWD
  elif [[ $src == */* ]]; then
    local dir=${src%/*}
    if [[ ! $dir ]]; then
      _ble_base=/
    elif [[ $dir != /* ]]; then
      _ble_base=$PWD/$dir
    else
      _ble_base=$dir
    fi
  else
    _ble_base=${defaultDir:-$HOME/.local/share/blesh}
  fi
  [[ -d $_ble_base ]]
}
if ! ble/base/initialize-base-directory "${BASH_SOURCE[0]}"; then
  ble/util/print "ble.sh: ble base directory not found!" 1>&2
  builtin unset -v _ble_bash BLE_VERSION BLE_VERSINFO
  ble/init/clean-up 2>/dev/null # set -x 対策 #D0930
  return 1
fi
function ble/base/initialize-runtime-directory/.xdg {
  local runtime_dir=
  if [[ $XDG_RUNTIME_DIR ]]; then
    if [[ ! -d $XDG_RUNTIME_DIR ]]; then
      ble/util/print "ble.sh: XDG_RUNTIME_DIR='$XDG_RUNTIME_DIR' is not a directory." >&2
      return 1
    elif [[ -O $XDG_RUNTIME_DIR ]]; then
      runtime_dir=$XDG_RUNTIME_DIR
    else
      false
    fi
  fi
  if [[ ! $runtime_dir ]]; then
    runtime_dir=/run/user/$UID
    [[ -d $runtime_dir && -O $runtime_dir ]] || return 1
  fi
  if ! [[ -r $runtime_dir && -w $runtime_dir && -x $runtime_dir ]]; then
    [[ $runtime_dir == "$XDG_RUNTIME_DIR" ]] &&
      ble/util/print "ble.sh: XDG_RUNTIME_DIR='$XDG_RUNTIME_DIR' doesn't have a proper permission." >&2
    return 1
  fi
  ble/base/.create-user-directory _ble_base_run "$runtime_dir/blesh"
}
function ble/base/initialize-runtime-directory/.tmp {
  [[ -r /tmp && -w /tmp && -x /tmp ]] || return 1
  local tmp_dir=/tmp/blesh
  if [[ ! -d $tmp_dir ]]; then
    [[ ! -e $tmp_dir && -h $tmp_dir ]] && ble/bin/rm -f "$tmp_dir"
    if [[ -e $tmp_dir || -h $tmp_dir ]]; then
      ble/util/print "ble.sh: cannot create a directory '$tmp_dir' since there is already a file." >&2
      return 1
    fi
    ble/bin/mkdir -p "$tmp_dir" || return 1
    ble/bin/chmod a+rwxt "$tmp_dir" || return 1
  elif ! [[ -r $tmp_dir && -w $tmp_dir && -x $tmp_dir ]]; then
    ble/util/print "ble.sh: permission of '$tmp_dir' is not correct." >&2
    return 1
  fi
  ble/base/.create-user-directory _ble_base_run "$tmp_dir/$UID"
}
function ble/base/initialize-runtime-directory {
  ble/base/initialize-runtime-directory/.xdg && return 0
  ble/base/initialize-runtime-directory/.tmp && return 0
  local tmp_dir=$_ble_base/run
  if [[ ! -d $tmp_dir ]]; then
    ble/bin/mkdir -p "$tmp_dir" || return 1
    ble/bin/chmod a+rwxt "$tmp_dir" || return 1
  fi
  ble/base/.create-user-directory _ble_base_run "$tmp_dir/${USER:-$UID}@$HOSTNAME"
}
if ! ble/base/initialize-runtime-directory; then
  ble/util/print "ble.sh: failed to initialize \$_ble_base_run." 1>&2
  builtin unset -v _ble_bash BLE_VERSION BLE_VERSINFO
  ble/init/clean-up 2>/dev/null # set -x 対策 #D0930
  return 1
fi
: >| "$_ble_base_run/$$.load"
function ble/base/clean-up-runtime-directory {
  local file pid mark removed
  mark=() removed=()
  for file in "$_ble_base_run"/[1-9]*.*; do
    [[ -e $file ]] || continue
    pid=${file##*/}; pid=${pid%%.*}
    [[ ${mark[pid]+set} ]] && continue
    mark[pid]=1
    if ! builtin kill -0 "$pid" &>/dev/null; then
      removed=("${removed[@]}" "$_ble_base_run/$pid."*)
    fi
  done
  ((${#removed[@]})) && ble/bin/rm -rf "${removed[@]}"
}
if shopt -q failglob &>/dev/null; then
  shopt -u failglob
  ble/base/clean-up-runtime-directory
  shopt -s failglob
else
  ble/base/clean-up-runtime-directory
fi
function ble/base/initialize-cache-directory/.xdg {
  [[ $_ble_base != */out ]] || return 1
  local cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
  if [[ ! -d $cache_dir ]]; then
    [[ $XDG_CACHE_HOME ]] &&
      ble/util/print "ble.sh: XDG_CACHE_HOME='$XDG_CACHE_HOME' is not a directory." >&2
    return 1
  fi
  if ! [[ -r $cache_dir && -w $cache_dir && -x $cache_dir ]]; then
    [[ $XDG_CACHE_HOME ]] &&
      ble/util/print "ble.sh: XDG_CACHE_HOME='$XDG_CACHE_HOME' doesn't have a proper permission." >&2
    return 1
  fi
  local ver=${BLE_VERSINFO[0]}.${BLE_VERSINFO[1]}
  ble/base/.create-user-directory _ble_base_cache "$cache_dir/blesh/$ver"
}
function ble/base/initialize-cache-directory {
  ble/base/initialize-cache-directory/.xdg && return 0
  local cache_dir=$_ble_base/cache.d
  if [[ ! -d $cache_dir ]]; then
    ble/bin/mkdir -p "$cache_dir" || return 1
    ble/bin/chmod a+rwxt "$cache_dir" || return 1
    local old_cache_dir=$_ble_base/cache
    if [[ -d $old_cache_dir && ! -h $old_cache_dir ]]; then
      mv "$old_cache_dir" "$cache_dir/$UID"
      ln -s "$cache_dir/$UID" "$old_cache_dir"
    fi
  fi
  ble/base/.create-user-directory _ble_base_cache "$cache_dir/$UID"
}
function ble/base/migrate-cache-directory/.move {
  local old=$1 new=$2
  [[ -e $old ]] || return 0
  if [[ -e $new || -L $old ]]; then
    ble/bin/rm -rf "$old"
  else
    ble/bin/mv "$old" "$new"
  fi
}
function ble/base/migrate-cache-directory/.check-old-prefix {
  local old_prefix=$_ble_base_cache/$1
  local new_prefix=$_ble_base_cache/$2
  local file
  for file in "$old_prefix"*; do
    local old=$file
    local new=$new_prefix${file#"$old_prefix"}
    ble/base/migrate-cache-directory/.move "$old" "$new"
  done
}
function ble/base/migrate-cache-directory {
  local failglob=
  shopt -q failglob && { failglob=1; shopt -u failglob; }
  ble/base/migrate-cache-directory/.check-old-prefix cmap+default.binder-source decode.cmap.allseq
  ble/base/migrate-cache-directory/.check-old-prefix cmap+default decode.cmap
  ble/base/migrate-cache-directory/.check-old-prefix ble-decode-bind decode.bind
  local file
  for file in "$_ble_base_cache"/*.term; do
    local old=$file
    local new=$_ble_base_cache/term.${file#"$_ble_base_cache/"}; new=${new%.term}
    ble/base/migrate-cache-directory/.move "$old" "$new"
  done
  ble/base/migrate-cache-directory/.move "$_ble_base_cache/man" "$_ble_base_cache/complete.mandb"
  [[ $failglob ]] && shopt -s failglob
}
if ! ble/base/initialize-cache-directory; then
  ble/util/print "ble.sh: failed to initialize \$_ble_base_cache." 1>&2
  builtin unset -v _ble_bash BLE_VERSION BLE_VERSINFO
  ble/init/clean-up 2>/dev/null # set -x 対策 #D0930
  return 1
fi
ble/base/migrate-cache-directory
function ble/base/print-usage-for-no-argument-command {
  local name=${FUNCNAME[1]} desc=$1; shift
  ble/util/print-lines \
    "usage: $name" \
    "$desc" >&2
  [[ $1 != --help ]] && return 2
  return 0
}
function ble-reload { source "$_ble_base/ble.sh"; }
_ble_base_repository='/home/saumit/ble.sh'
_ble_base_branch=master
function ble-update/.check-install-directory-ownership {
  if [[ ! -O $_ble_base ]]; then
    ble/uti/print 'ble-update: install directory is owned by another user:' >&2
    ls -ld "$_ble_base"
    return 1
  elif [[ ! -r $_ble_base || ! -w $_ble_base || ! -x $_ble_base ]]; then
    ble/uti/print 'ble-update: install directory permission denied:' >&2
    ls -ld "$_ble_base"
    return 1
  fi
}
function ble-update/.make {
  local sudo=
  if [[ $1 == --sudo ]]; then
    sudo=1
    shift
  fi
  if ! "$MAKE" -q "$@"; then
    if [[ $sudo ]]; then
      sudo "$MAKE" "$@"
    else
      "$MAKE" "$@"
    fi
  else
    return 6
  fi
}
function ble-update/.reload {
  local ext=$1
  if [[ $ext -eq 0 || $ext -eq 6 && $_ble_base/ble.sh -nt $_ble_base_run/$$.load ]]; then
    if [[ ! -e $_ble_base/ble.sh ]]; then
      ble/util/print "ble-update: new ble.sh not found at '$_ble_base/ble.sh'." >&2
      return 1
    elif [[ ! -s $_ble_base/ble.sh ]]; then
      ble/util/print "ble-update: new ble.sh '$_ble_base/ble.sh' is empty." >&2
      return 1
    elif [[ $- == *i* && $_ble_attached ]] && ! ble/util/is-running-in-subshell; then
      ble-reload
    fi
    return $?
  fi
  ((ext==6)) && ext=0
  return "$ext"
}
function ble-update {
  if (($#)); then
    ble/base/print-usage-for-no-argument-command 'Update and reload ble.sh.' "$@"
    return "$?"
  fi
  if [[ $_ble_base_package_type ]] && ble/is-function ble/base/package:"$_ble_base_package_type"/update; then
    ble/util/print "ble-update: delegate to '$_ble_base_package_type' package manager..." >&2
    ble/base/package:"$_ble_base_package_type"/update; local ext=$?
    if ((ext==125)); then
      ble/util/print 'ble-update: fallback to the default update process.' >&2
    else
      ble-update/.reload "$ext"
      return $?
    fi
  fi
  local MAKE=
  if type gmake &>/dev/null; then
    MAKE=gmake
  elif type make &>/dev/null && make --version 2>&1 | ble/bin/grep -qiF 'GNU Make'; then
    MAKE=make
  else
    ble/util/print "ble-update: GNU Make is not available." >&2
    return 1
  fi
  if ! ble/bin#has git gawk; then
    local command
    for command in git gawk; do
      type "$command" &>/dev/null ||
        ble/util/print "ble-update: '$command' command is not available." >&2
    done
    return 1
  fi
  local insdir_doc=$_ble_base/doc
  [[ ! -d $insdir_doc && -d ${_ble_base%/*}/doc/blesh ]] &&
    insdir_doc=${_ble_base%/*}/doc/blesh
  if [[ $_ble_base_repository && $_ble_base_repository != release:* ]]; then
    if [[ ! -e $_ble_base_repository/.git ]]; then
      ble/util/print "ble-update: git repository not found at '$_ble_base_repository'." >&2
    elif [[ ! -O $_ble_base_repository ]]; then
      ble/util/print "ble-update: git repository is owned by another user:" >&2
      ls -ld "$_ble_base_repository"
    elif [[ ! -r $_ble_base_repository || ! -w $_ble_base_repository || ! -x $_ble_base_repository ]]; then
      ble/util/print 'ble-update: git repository permission denied:' >&2
      ls -ld "$_ble_base_repository"
    else
      ( ble/util/print "cd into $_ble_base_repository..." >&2 &&
          builtin cd "$_ble_base_repository" &&
          git pull && git submodule update --recursive --remote &&
          if [[ $_ble_base == "$_ble_base_repository"/out ]]; then
            ble-update/.make all
          elif ((EUID!=0)) && ! ble-update/.check-install-directory-ownership; then
            ble-update/.make all
            ble-update/.make --sudo INSDIR="$_ble_base" INSDIR_DOC="$insdir_doc" install
          else
            ble-update/.make INSDIR="$_ble_base" INSDIR_DOC="$insdir_doc" install
          fi )
      ble-update/.reload $?
      return $?
    fi
  fi
  if ((EUID!=0)) && ! ble-update/.check-install-directory-ownership; then
    sudo "$BASH" "$_ble_base/ble.sh" --update &&
      ble-update/.reload 6
    return $?
  else
    local branch=${_ble_base_branch:-master}
    ( ble/bin/mkdir -p "$_ble_base/src" && builtin cd "$_ble_base/src" &&
        git clone --recursive --depth 1 https://github.com/akinomyoga/ble.sh "$_ble_base/src/ble.sh" -b "$branch" &&
        builtin cd ble.sh && "$MAKE" all &&
        "$MAKE" INSDIR="$_ble_base" INSDIR_DOC="$insdir_doc" install ) &&
      ble-update/.reload
    return "$?"
  fi
  return 1
}
_ble_attached=
BLE_ATTACHED=
_ble_term_nl=$'\n'
_ble_term_FS=$'\034'
_ble_term_SOH=$'\001'
_ble_term_DEL=$'\177'
_ble_term_IFS=$' \t\n'
_ble_term_CR=$'\r'
function blehook/declare {
  local name=$1
  builtin eval "_ble_hook_h_$name=()"
  builtin eval "_ble_hook_c_$name=0"
}
blehook/declare EXIT
blehook/declare INT
blehook/declare ERR
blehook/declare unload
blehook/declare ATTACH
blehook/declare DETACH
blehook/declare DA1R
blehook/declare DA2R
blehook/declare color_defface_load
blehook/declare color_setface_load
blehook/declare ADDHISTORY
blehook/declare history_reset_background
blehook/declare history_onleave
blehook/declare history_delete
blehook/declare history_insert
blehook/declare history_clear
blehook/declare history_message
blehook/declare WINCH
blehook/declare CHPWD
blehook/declare PRECMD
blehook/declare PREEXEC
blehook/declare POSTEXEC
blehook/declare widget_bell
blehook/declare textarea_render_defer
blehook/declare info_reveal
function ble-edit/prompt/print { ble/prompt/print "$@"; }
function ble-edit/prompt/process-prompt-string { ble/prompt/process-prompt-string "$@"; }
blehook/declare keymap_load
blehook/declare keymap_vi_load
blehook/declare keymap_emacs_load
blehook/declare syntax_load
blehook/declare complete_load
blehook/declare complete_insert
function blehook/.compatibility-ble-0.3 {
  blehook keymap_load+='ble/util/invoke-hook _ble_keymap_default_load_hook'
  blehook keymap_emacs_load+='ble/util/invoke-hook _ble_keymap_emacs_load_hook'
  blehook keymap_vi_load+='ble/util/invoke-hook _ble_keymap_vi_load_hook'
  blehook complete_load+='ble/util/invoke-hook _ble_complete_load_hook'
}
function blehook/.compatibility-ble-0.3/check {
  if ble/is-array _ble_keymap_default_load_hook ||
      ble/is-array _ble_keymap_vi_load_hook ||
      ble/is-array _ble_keymap_emacs_load_hook ||
      ble/is-array _ble_complete_load_hook
  then
    ble/bin/cat << EOF
# [Change in ble-0.4.0]
#
# Please update your blerc settings for ble-0.4+.
# In ble-0.4+, use the following form:
# 
#   blehook/eval-after-load keymap SHELL-COMMAND
#   blehook/eval-after-load keymap_vi SHELL-COMMAND
#   blehook/eval-after-load keymap_emacs SHELL-COMMAND
#   blehook/eval-after-load complete SHELL-COMMAND
# 
# instead of the following older form:
# 
#   ble/array#push _ble_keymap_default_load_hook SHELL-COMMAND
#   ble/array#push _ble_keymap_vi_load_hook SHELL-COMMAND
#   ble/array#push _ble_keymap_emacs_load_hook SHELL-COMMAND
#   ble/array#push _ble_complete_load_hook SHELL-COMMAND
# 
# Note: "blehook/eval-after-load" should be called
#   after you defined SHELL-COMMAND.
#
EOF
  fi
}
function ble/complete/action/inherit-from {
  ble/complete/action#inherit-from "$@"
}
function bleopt/.read-arguments/process-option {
  local name=$1
  case $name in
  (help)
    flags=H$flags ;;
  (color|color=always)
    flags=c${flags//[cn]} ;;
  (color=never)
    flags=n${flags//[cn]} ;;
  (color=auto)
    flags=${flags//[cn]} ;;
  (color=*)
    ble/util/print "bleopt: '${name#*=}': unrecognized option argument for '--color'." >&2
    flags=E$flags ;;
  (reset)   flags=r$flags ;;
  (changed) flags=u$flags ;;
  (initialize) flags=I$flags ;;
  (*)
    ble/util/print "bleopt: unrecognized long option '--$name'." >&2
    flags=E$flags ;;
  esac
}
function bleopt/expand-variable-pattern {
  ret=()
  local pattern=$1
  if [[ $pattern == *@* ]]; then
    builtin eval -- "ret=(\"\${!${pattern%%@*}@}\")"
    ble/array#filter-by-glob ret "${pattern//@/?*}"
  elif [[ ${!pattern+set} || :$opts: == :allow-undefined: ]]; then
    ret=("$pattern")
  fi
  ((${#ret[@]}))
}
function bleopt/.read-arguments {
  flags= pvars=() specs=()
  while (($#)); do
    local arg=$1; shift
    case $arg in
    (--)
      ble/array#push specs "$@"
      break ;;
    (-)
      ble/util/print "bleopt: unrecognized argument '$arg'." >&2
      flags=E$flags ;;
    (--*)
      bleopt/.read-arguments/process-option "${arg:2}" ;;
    (-*)
      local i c
      for ((i=1;i<${#arg};i++)); do
        c=${arg:i:1}
        case $c in
        (r) bleopt/.read-arguments/process-option reset ;;
        (u) bleopt/.read-arguments/process-option changed ;;
        (I) bleopt/.read-arguments/process-option initialize ;;
        (*)
          ble/util/print "bleopt: unrecognized option '-$c'." >&2
          flags=E$flags ;;
        esac
      done ;;
    (*)
      if local rex='^([_a-zA-Z0-9@]+)(:?=|$)(.*)'; [[ $arg =~ $rex ]]; then
        local name=${BASH_REMATCH[1]#bleopt_}
        local var=bleopt_$name
        local op=${BASH_REMATCH[2]}
        local value=${BASH_REMATCH[3]}
        if [[ $op == ':=' ]]; then
          if [[ $var == *@* ]]; then
            ble/util/print "bleopt: \`${var#bleopt_}': wildcard cannot be used in the definition." >&2
            flags=E$flags
            continue
          fi
        else
          local ret; bleopt/expand-variable-pattern "$var"
          var=()
          local v i=0
          for v in "${ret[@]}"; do
            ble/is-function "bleopt/obsolete:${v#bleopt_}" && continue
            var[i++]=$v
          done
          [[ ${#var[@]} == 0 ]] && var=("${ret[@]}")
          if ((${#var[@]}==0)); then
            ble/util/print "bleopt: option \`$name' not found" >&2
            flags=E$flags
            continue
          fi
        fi
        if [[ $op ]]; then
          var=("${var[@]}") # #D1570: WA bash-3.0 ${scal[@]/x} bug
          if ((_ble_bash>=40300)) && ! shopt -q compat42; then
            ble/array#push specs "${var[@]/%/"=$value"}" # #D1570 #D1751 WA checked
          else
            ble/array#push specs "${var[@]/%/=$value}" # #D1570 #D1738 WA checked
          fi
        else
          ble/array#push pvars "${var[@]}"
        fi
      else
        ble/util/print "bleopt: unrecognized argument '$arg'" >&2
        flags=E$flags
      fi ;;
    esac
  done
}
function bleopt/changed.predicate {
  local cur=$1 def=_ble_opt_def_${1#bleopt_}
  [[ ! ${!def+set} || ${!cur} != "${!def}" ]]
}
function bleopt {
  local flags pvars specs
  bleopt/.read-arguments "$@"
  if [[ $flags == *E* ]]; then
    return 2
  elif [[ $flags == *H* ]]; then
    ble/util/print-lines \
      'usage: bleopt [OPTION] [NAME|NAME=VALUE|NAME:=VALUE]...' \
      '    Set ble.sh options. Without arguments, this prints all the settings.' \
      '' \
      '  Options' \
      '    --help           Print this help.' \
      '    -r, --reset      Reset options to the default values' \
      '    -I, --initialize Re-initialize settings' \
      '    -u, --changed    Only select changed options' \
      '    --color[=always|never|auto]' \
      '                     Change color settings.' \
      '' \
      '  Arguments' \
      '    NAME        Print the value of the option.' \
      '    NAME=VALUE  Set the value to the option.' \
      '    NAME:=VALUE Set or create the value to the option.' \
      '' \
      '  NAME can contain "@" as a wildcard.' \
      ''
    return 0
  fi
  if ((${#pvars[@]}==0&&${#specs[@]}==0)); then
    local var ip=0
    for var in "${!bleopt_@}"; do
      ble/is-function "bleopt/obsolete:${var#bleopt_}" && continue
      pvars[ip++]=$var
    done
  fi
  [[ $flags == *u* ]] &&
    ble/array#filter pvars bleopt/changed.predicate
  if [[ $flags == *r* ]]; then
    local var
    for var in "${pvars[@]}"; do
      local name=${var#bleopt_}
      ble/is-function bleopt/obsolete:"$name" && continue
      local def=_ble_opt_def_$name
      [[ ${!def+set} && ${!var-} != "${!def}" ]] &&
        ble/array#push specs "$var=${!def}"
    done
    pvars=()
  elif [[ $flags == *I* ]]; then
    local var
    for var in "${pvars[@]}"; do
      bleopt/reinitialize "${var#bleopt_}"
    done
    pvars=()
  fi
  if ((${#specs[@]})); then
    local spec
    for spec in "${specs[@]}"; do
      local var=${spec%%=*} value=${spec#*=}
      [[ ${!var+set} && ${!var} == "$value" ]] && continue
      if ble/is-function bleopt/check:"${var#bleopt_}"; then
        local bleopt_source=${BASH_SOURCE[1]}
        local bleopt_lineno=${BASH_LINENO[0]}
        if ! bleopt/check:"${var#bleopt_}"; then
          flags=E$flags
          continue
        fi
      fi
      builtin eval -- "$var=\"\$value\""
    done
  fi
  if ((${#pvars[@]})); then
    local sgr0= sgr1= sgr2= sgr3=
    if [[ $flags == *c* || $flags != *n* && -t 1 ]]; then
      local ret
      ble/color/face2sgr command_function; sgr1=$ret
      ble/color/face2sgr syntax_varname; sgr2=$ret
      ble/color/face2sgr syntax_quoted; sgr3=$ret
      sgr0=$_ble_term_sgr0
    fi
    local var
    for var in "${pvars[@]}"; do
      local ret
      ble/string#quote-word "${!var}" sgrq="$sgr3":sgr0="$sgr0"
      ble/util/print "${sgr1}bleopt$sgr0 ${sgr2}${var#bleopt_}$sgr0=$ret"
    done
  fi
  [[ $flags != *E* ]]
}
function bleopt/declare/.check-renamed-option {
  var=bleopt_$2
  local sgr0= sgr1= sgr2= sgr3=
  if [[ -t 2 ]]; then
    sgr0=$_ble_term_sgr0
    sgr1=${_ble_term_setaf[2]}
    sgr2=${_ble_term_setaf[1]}$_ble_term_bold
    sgr3=${_ble_term_setaf[4]}$_ble_term_bold
  fi
  local locate=$sgr1${BASH_SOURCE[3]-'(stdin)'}:${BASH_LINENO[2]}$sgr0
  ble/util/print "$locate (bleopt): The option '$sgr2$1$sgr0' has been renamed. Please use '$sgr3$2$sgr0' instead." >&2
  if ble/is-function bleopt/check:"$2"; then
    bleopt/check:"$2"
    return "$?"
  fi
  return 0
}
function bleopt/declare {
  local type=$1 name=bleopt_$2 default_value=$3
  case $type in
  (-o)
    builtin eval -- "$name='[obsolete: renamed to $3]'"
    builtin eval -- "function bleopt/check:$2 { bleopt/declare/.check-renamed-option $2 $3; }"
    builtin eval -- "function bleopt/obsolete:$2 { :; }" ;;
  (-n)
    builtin eval -- "_ble_opt_def_$2=\$3"
    builtin eval -- ": \"\${$name:=\$default_value}\"" ;;
  (*)
    builtin eval -- "_ble_opt_def_$2=\$3"
    builtin eval -- ": \"\${$name=\$default_value}\"" ;;
  esac
  return 0
}
function bleopt/reinitialize {
  local name=$1
  local defname=_ble_opt_def_$name
  local varname=bleopt_$name
  [[ ${!defname+set} ]] || return 1
  [[ ${!varname} == "${!defname}" ]] && return 0
  ble/is-function bleopt/obsolete:"$name" && return 0
  ble/is-function bleopt/check:"$name" || return 0
  local value=${!varname}
  builtin eval -- "$varname=\$$defname"
  bleopt/check:"$name" &&
    builtin eval "$varname=\$value"
}
bleopt/declare -n input_encoding UTF-8
function bleopt/check:input_encoding {
  if ! ble/is-function "ble/encoding:$value/decode"; then
    ble/util/print "bleopt: Invalid value input_encoding='$value'." \
                 "A function 'ble/encoding:$value/decode' is not defined." >&2
    return 1
  elif ! ble/is-function "ble/encoding:$value/b2c"; then
    ble/util/print "bleopt: Invalid value input_encoding='$value'." \
                 "A function 'ble/encoding:$value/b2c' is not defined." >&2
    return 1
  elif ! ble/is-function "ble/encoding:$value/c2bc"; then
    ble/util/print "bleopt: Invalid value input_encoding='$value'." \
                 "A function 'ble/encoding:$value/c2bc' is not defined." >&2
    return 1
  elif ! ble/is-function "ble/encoding:$value/generate-binder"; then
    ble/util/print "bleopt: Invalid value input_encoding='$value'." \
                 "A function 'ble/encoding:$value/generate-binder' is not defined." >&2
    return 1
  elif ! ble/is-function "ble/encoding:$value/is-intermediate"; then
    ble/util/print "bleopt: Invalid value input_encoding='$value'." \
                 "A function 'ble/encoding:$value/is-intermediate' is not defined." >&2
    return 1
  fi
  if [[ $bleopt_input_encoding != "$value" ]]; then
    local bleopt_input_encoding=$value
    ble/decode/rebind
  fi
  return 0
}
bleopt/declare -v internal_stackdump_enabled 0
bleopt/declare -n openat_base 30
bleopt/declare -v pager ''
bleopt/declare -v editor ''
shopt -s checkwinsize
function ble/util/setexit { return "$1"; }
_ble_util_upvar_setup='local var=ret ret; [[ $1 == -v ]] && var=$2 && shift 2'
_ble_util_upvar='local "${var%%\[*\]}" && ble/util/upvar "$var" "$ret"'
if ((_ble_bash>=50000)); then
  function ble/util/unlocal {
    if shopt -q localvar_unset; then
      shopt -u localvar_unset
      builtin unset -v "$@"
      shopt -s localvar_unset
    else
      builtin unset -v "$@"
    fi
  }
  function ble/util/upvar { ble/util/unlocal "${1%%\[*\]}" && builtin eval "$1=\"\$2\""; }
  function ble/util/uparr { ble/util/unlocal "$1" && builtin eval "$1=(\"\${@:2}\")"; }
else
  function ble/util/unlocal { builtin unset -v "$@"; }
  function ble/util/upvar { builtin unset -v "${1%%\[*\]}" && builtin eval "$1=\"\$2\""; }
  function ble/util/uparr { builtin unset -v "$1" && builtin eval "$1=(\"\${@:2}\")"; }
fi
function ble/util/save-vars {
  local __name __prefix=$1; shift
  for __name; do
    if ble/is-array "$__name"; then
      builtin eval "$__prefix$__name=(\"\${$__name[@]}\")"
    else
      builtin eval "$__prefix$__name=\"\$$__name\""
    fi
  done
}
function ble/util/restore-vars {
  local __name __prefix=$1; shift
  for __name; do
    if ble/is-array "$__prefix$__name"; then
      builtin eval "$__name=(\"\${$__prefix$__name[@]}\")"
    else
      builtin eval "$__name=\"\$$__prefix$__name\""
    fi
  done
}
function ble/debug/setdbg {
  ble/bin/rm -f "$_ble_base_run/dbgerr"
  local ret
  ble/util/readlink /proc/self/fd/3 3>&1
  ln -s "$ret" "$_ble_base_run/dbgerr"
}
function ble/debug/print {
  if [[ -e $_ble_base_run/dbgerr ]]; then
    ble/util/print "$1" >> "$_ble_base_run/dbgerr"
  else
    ble/util/print "$1" >&2
  fi
}
_ble_debug_check_leak_variable='local @var=__t1wJltaP9nmow__'
function ble/debug/.check-leak-variable {
  if [[ ${!1} != __t1wJltaP9nmow__ ]]; then
    local IFS=$_ble_term_IFS
    ble/util/print "$1=${!1}:${*:2}" >> a.txt # DEBUG_LEAKVAR
    builtin eval "$1=__t1wJltaP9nmow__"
  fi
}
function ble/debug/.list-leak-variable {
  local _ble_local_exclude_file=${_ble_base_repository:-$_ble_base}/make/debug.leakvar.exclude-list.txt
  if [[ ! -f $_ble_local_exclude_file ]]; then
    ble/util/print "$_ble_local_exclude_file: not found." >&2
    return 1
  fi
  set | ble/bin/grep -Eo '^[[:alnum:]_]+=' | ble/bin/grep -Evf "$_ble_local_exclude_file"
}
function ble/debug/print-variables/.append {
  local q=\' Q="'\''"
  _ble_local_out=$_ble_local_out"$1='${2//$q/$Q}'"
}
function ble/debug/print-variables/.append-array {
  local ret; ble/string#quote-words "${@:2}"
  _ble_local_out=$_ble_local_out"$1=($ret)"
}
function ble/debug/print-variables {
  (($#)) || return 0
  local flags= tag= arg
  local -a _ble_local_vars=()
  while (($#)); do
    arg=$1; shift
    case $arg in
    (-t) tag=$1; shift ;;
    (-*) ble/util/print "print-variables: unknown option '$arg'" >&2
         flags=${flags}e ;;
    (*) ble/array#push _ble_local_vars "$arg" ;;
    esac
  done
  [[ $flags == *e* ]] && return 1
  local _ble_local_out= _ble_local_var=
  [[ $tag ]] && _ble_local_out="$tag: "
  ble/util/unlocal flags tag arg
  for _ble_local_var in "${_ble_local_vars[@]}"; do
    if ble/is-array "$_ble_local_var"; then
      builtin eval -- "ble/debug/print-variables/.append-array \"\$_ble_local_var\" \"\${$_ble_local_var[@]}\""
    else
      ble/debug/print-variables/.append "$_ble_local_var" "${!_ble_local_var}"
    fi
    _ble_local_out=$_ble_local_out' '
  done
  ble/debug/print "${_ble_local_out%' '}"
}
if ((_ble_bash>=40400)); then
  function ble/variable#get-attr { attr=${!1@a}; }
  function ble/variable#has-attr { [[ ${!1@a} == *["$2"]* ]]; }
else
  function ble/variable#get-attr {
    attr=
    local __ble_tmp=$1
    ble/util/assign __ble_tmp 'declare -p "$__ble_tmp" 2>/dev/null'
    local rex='^declare -([a-zA-Z]*)'
    [[ $__ble_tmp =~ $rex ]] && attr=${BASH_REMATCH[1]}
    return 0
  }
  function ble/variable#has-attr {
    local __ble_tmp=$1
    ble/util/assign __ble_tmp 'declare -p "$__ble_tmp" 2>/dev/null'
    local rex='^declare -([a-zA-Z]*)'
    [[ $__ble_tmp =~ $rex && ${BASH_REMATCH[1]} == *["$2"]* ]]
  }
fi
function ble/is-inttype { ble/variable#has-attr "$1" i; }
function ble/is-readonly { ble/variable#has-attr "$1" r; }
function ble/is-transformed { ble/variable#has-attr "$1" luc; }
function ble/variable#is-global/.test { ! local "$1" 2>/dev/null; }
function ble/variable#is-global {
  (readonly "$1"; ble/variable#is-global/.test "$1")
}
function ble/variable#copy-state {
  local src=$1 dst=$2
  if [[ ${!src+set} ]]; then
    builtin eval -- "$dst=\${$src}"
  else
    builtin unset -v "$dst[0]" 2>/dev/null || builtin unset -v "$dst"
  fi
}
_ble_array_prototype=()
function ble/array#reserve-prototype {
  local n=$1 i
  for ((i=${#_ble_array_prototype[@]};i<n;i++)); do
    _ble_array_prototype[i]=
  done
}
if ((_ble_bash>=40400)); then
  function ble/is-array { [[ ${!1@a} == *a* ]]; }
  function ble/is-assoc { [[ ${!1@a} == *A* ]]; }
else
  function ble/is-array {
    local "decl$1"
    ble/util/assign "decl$1" "declare -p $1" 2>/dev/null || return 1
    local rex='^declare -[b-zA-Z]*a'
    builtin eval "[[ \$decl$1 =~ \$rex ]]"
  }
  function ble/is-assoc {
    local "decl$1"
    ble/util/assign "decl$1" "declare -p $1" 2>/dev/null || return 1
    local rex='^declare -[a-zB-Z]*A'
    builtin eval "[[ \$decl$1 =~ \$rex ]]"
  }
  ((_ble_bash>=40000)) ||
    function ble/is-assoc { false; }
fi
function ble/array#set { builtin eval "$1=(\"\${@:2}\")"; }
if ((_ble_bash>=40000)); then
  function ble/array#push {
    builtin eval "$1+=(\"\${@:2}\")"
  }
elif ((_ble_bash>=30100)); then
  function ble/array#push {
    IFS=$_ble_term_IFS builtin eval "$1+=(\"\${@:2}\")"
  }
else
  function ble/array#push {
    while (($#>=2)); do
      builtin eval -- "$1[\${#$1[@]}]=\"\$2\""
      set -- "$1" "${@:3}"
    done
  }
fi
function ble/array#pop {
  builtin eval "local i$1=\$((\${#$1[@]}-1))"
  if ((i$1>=0)); then
    builtin eval "ret=\${$1[i$1]}"
    builtin unset -v "$1[i$1]"
    return 0
  else
    ret=
    return 1
  fi
}
function ble/array#unshift {
  builtin eval -- "$1=(\"\${@:2}\" \"\${$1[@]}\")"
}
function ble/array#shift {
  builtin eval -- "$1=(\"\${$1[@]:$((${2:-1}))}\")"
}
function ble/array#reverse {
  builtin eval "
  set -- \"\${$1[@]}\"; $1=()
  local e$1 i$1=\$#
  for e$1; do $1[--i$1]=\"\$e$1\"; done"
}
function ble/array#insert-at {
  builtin eval "$1=(\"\${$1[@]::$2}\" \"\${@:3}\" \"\${$1[@]:$2}\")"
}
function ble/array#insert-after {
  local _ble_local_script='
    local iARR=0 eARR aARR=
    for eARR in "${ARR[@]}"; do
      ((iARR++))
      [[ $eARR == "$2" ]] && aARR=iARR && break
    done
    [[ $aARR ]] && ble/array#insert-at "$1" "$aARR" "${@:3}"
  '; builtin eval -- "${_ble_local_script//ARR/$1}"
}
function ble/array#insert-before {
  local _ble_local_script='
    local iARR=0 eARR aARR=
    for eARR in "${ARR[@]}"; do
      [[ $eARR == "$2" ]] && aARR=iARR && break
      ((iARR++))
    done
    [[ $aARR ]] && ble/array#insert-at "$1" "$aARR" "${@:3}"
  '; builtin eval -- "${_ble_local_script//ARR/$1}"
}
function ble/array#filter {
  local _ble_local_script='
    local -a aARR=() eARR
    for eARR in "${ARR[@]}"; do
      "$2" "$eARR" && ble/array#push "aARR" "$eARR"
    done
    ARR=("${aARR[@]}")
  '; builtin eval -- "${_ble_local_script//ARR/$1}"
}
function ble/array#filter/not.predicate { ! "$_ble_local_pred" "$1"; }
function ble/array#remove-if {
  local _ble_local_pred=$2
  ble/array#filter "$1" ble/array#filter/not.predicate
}
function ble/array#filter/regex.predicate { [[ $1 =~ $_ble_local_rex ]]; }
function ble/array#filter-by-regex {
  local _ble_local_rex=$2
  local LC_ALL= LC_COLLATE=C 2>/dev/null
  ble/array#filter "$1" ble/array#filter/regex.predicate
  ble/util/unlocal LC_COLLATE LC_ALL 2>/dev/null
}
function ble/array#remove-by-regex {
  local _ble_local_rex=$2
  local LC_ALL= LC_COLLATE=C 2>/dev/null
  ble/array#remove-if "$1" ble/array#filter/regex.predicate
  ble/util/unlocal LC_COLLATE LC_ALL 2>/dev/null
}
function ble/array#filter/glob.predicate { [[ $1 == $_ble_local_glob ]]; }
function ble/array#filter-by-glob {
  local _ble_local_glob=$2
  local LC_ALL= LC_COLLATE=C 2>/dev/null
  ble/array#filter "$1" ble/array#filter/glob.predicate
  ble/util/unlocal LC_COLLATE LC_ALL 2>/dev/null
}
function ble/array#remove-by-glob {
  local _ble_local_glob=$2
  local LC_ALL= LC_COLLATE=C 2>/dev/null
  ble/array#remove-if "$1" ble/array#filter/glob.predicate
  ble/util/unlocal LC_COLLATE LC_ALL 2>/dev/null
}
function ble/array#remove/.predicate { [[ $1 != "$_ble_local_value" ]]; }
function ble/array#remove {
  local _ble_local_value=$2
  ble/array#filter "$1" ble/array#remove/.predicate
}
function ble/array#index {
  local _ble_local_script='
    local eARR iARR=0
    for eARR in "${ARR[@]}"; do
      if [[ $eARR == "$2" ]]; then ret=$iARR; return 0; fi
      ((++iARR))
    done
    ret=-1; return 1
  '; builtin eval -- "${_ble_local_script//ARR/$1}"
}
function ble/array#last-index {
  local _ble_local_script='
    local eARR iARR=${#ARR[@]}
    while ((iARR--)); do
      [[ ${ARR[iARR]} == "$2" ]] && { ret=$iARR; return 0; }
    done
    ret=-1; return 1
  '; builtin eval -- "${_ble_local_script//ARR/$1}"
}
function ble/array#remove-at {
  local _ble_local_script='
    builtin unset -v "ARR[$2]"
    ARR=("${ARR[@]}")
  '; builtin eval -- "${_ble_local_script//ARR/$1}"
}
function ble/array#fill-range {
  ble/array#reserve-prototype $(($3-$2))
  local _ble_script='
      local -a sARR; sARR=("${_ble_array_prototype[@]::$3-$2}")
      ARR=("${ARR[@]::$2}" "${sARR[@]/#/$4}" "${ARR[@]:$3}")' # WA #D1570 #D1738 checked
  ((_ble_bash>=40300)) && ! shopt -q compat42 &&
    _ble_script=${_ble_script//'$4'/'"$4"'}
  builtin eval -- "${_ble_script//ARR/$1}"
}
function ble/idict#replace {
  local _ble_local_script='
    local iARR=0 extARR=1
    for iARR in "${!ARR[@]}"; do
      [[ ${ARR[iARR]} == "$2" ]] || continue
      extARR=0
      if (($#>=3)); then
        ARR[iARR]=$3
      else
        builtin unset -v '\''ARR[iARR]'\''
      fi
    done
    return "$extARR"
  '; builtin eval -- "${_ble_local_script//ARR/$1}"
}
function ble/idict#copy {
  local _ble_script='
    '$1'=()
    local i'$1$2'
    for i'$1$2' in "${!'$2'[@]}"; do
      '$1'[i'$1$2']=${'$2'[i'$1$2']}
    done'
  builtin eval -- "$_ble_script"
}
_ble_string_prototype='        '
function ble/string#reserve-prototype {
  local n=$1 c
  for ((c=${#_ble_string_prototype};c<n;c*=2)); do
    _ble_string_prototype=$_ble_string_prototype$_ble_string_prototype
  done
}
function ble/string#repeat {
  ble/string#reserve-prototype "$2"
  ret=${_ble_string_prototype::$2}
  ret=${ret// /"$1"}
}
function ble/string#common-prefix {
  local a=$1 b=$2
  ((${#a}>${#b})) && local a=$b b=$a
  b=${b::${#a}}
  if [[ $a == "$b" ]]; then
    ret=$a
    return 0
  fi
  local l=0 u=${#a} m
  while ((l+1<u)); do
    ((m=(l+u)/2))
    if [[ ${a::m} == "${b::m}" ]]; then
      ((l=m))
    else
      ((u=m))
    fi
  done
  ret=${a::l}
}
function ble/string#common-suffix {
  local a=$1 b=$2
  ((${#a}>${#b})) && local a=$b b=$a
  b=${b:${#b}-${#a}}
  if [[ $a == "$b" ]]; then
    ret=$a
    return 0
  fi
  local l=0 u=${#a} m
  while ((l+1<u)); do
    ((m=(l+u+1)/2))
    if [[ ${a:m} == "${b:m}" ]]; then
      ((u=m))
    else
      ((l=m))
    fi
  done
  ret=${a:u}
}
function ble/string#split {
  if [[ -o noglob ]]; then
    IFS=$2 builtin eval "$1=(\${*:3}\$2)"
  else
    set -f
    IFS=$2 builtin eval "$1=(\${*:3}\$2)"
    set +f
  fi
}
function ble/string#split-words {
  if [[ -o noglob ]]; then
    IFS=$_ble_term_IFS builtin eval "$1=(\${*:2})"
  else
    set -f
    IFS=$_ble_term_IFS builtin eval "$1=(\${*:2})"
    set +f
  fi
}
if ((_ble_bash>=40000)); then
  function ble/string#split-lines {
    mapfile -t "$1" <<< "$2"
  }
else
  function ble/string#split-lines {
    ble/util/mapfile "$1" <<< "$2"
  }
fi
function ble/string#count-char {
  local text=$1 char=$2
  text=${text//[!"$char"]}
  ret=${#text}
}
function ble/string#count-string {
  local text=${1//"$2"}
  ((ret=(${#1}-${#text})/${#2}))
}
function ble/string#index-of {
  local haystack=$1 needle=$2 count=${3:-1}
  ble/string#repeat '*"$needle"' "$count"; local pattern=$ret
  builtin eval "local transformed=\${haystack#$pattern}"
  ((ret=${#haystack}-${#transformed}-${#needle},
    ret<0&&(ret=-1),ret>=0))
}
function ble/string#last-index-of {
  local haystack=$1 needle=$2 count=${3:-1}
  ble/string#repeat '"$needle"*' "$count"; local pattern=$ret
  builtin eval "local transformed=\${haystack%$pattern}"
  if [[ $transformed == "$haystack" ]]; then
    ret=-1
  else
    ret=${#transformed}
  fi
  ((ret>=0))
}
_ble_util_string_lower_list=abcdefghijklmnopqrstuvwxyz
_ble_util_string_upper_list=ABCDEFGHIJKLMNOPQRSTUVWXYZ
function ble/string#toggle-case.impl {
  local LC_ALL= LC_COLLATE=C
  local text=$1 ch i
  local -a buff
  for ((i=0;i<${#text};i++)); do
    ch=${text:i:1}
    if [[ $ch == [A-Z] ]]; then
      ch=${_ble_util_string_upper_list%%"$ch"*}
      ch=${_ble_util_string_lower_list:${#ch}:1}
    elif [[ $ch == [a-z] ]]; then
      ch=${_ble_util_string_lower_list%%"$ch"*}
      ch=${_ble_util_string_upper_list:${#ch}:1}
    fi
    ble/array#push buff "$ch"
  done
  IFS= builtin eval 'ret="${buff[*]-}"'
}
function ble/string#toggle-case {
  ble/string#toggle-case.impl "$1" 2>/dev/null # suppress locale error #D1440
}
if ((_ble_bash>=40000)); then
  function ble/string#tolower { ret=${1,,}; }
  function ble/string#toupper { ret=${1^^}; }
else
  function ble/string#tolower.impl {
    local LC_ALL= LC_COLLATE=C
    local i text=$1 ch
    local -a buff=()
    for ((i=0;i<${#text};i++)); do
      ch=${text:i:1}
      if [[ $ch == [A-Z] ]]; then
        ch=${_ble_util_string_upper_list%%"$ch"*}
        ch=${_ble_util_string_lower_list:${#ch}:1}
      fi
      ble/array#push buff "$ch"
    done
    IFS= builtin eval 'ret="${buff[*]-}"'
  }
  function ble/string#toupper.impl {
    local LC_ALL= LC_COLLATE=C
    local i text=$1 ch
    local -a buff=()
    for ((i=0;i<${#text};i++)); do
      ch=${text:i:1}
      if [[ $ch == [a-z] ]]; then
        ch=${_ble_util_string_lower_list%%"$ch"*}
        ch=${_ble_util_string_upper_list:${#ch}:1}
      fi
      ble/array#push buff "$ch"
    done
    IFS= builtin eval 'ret="${buff[*]-}"'
  }
  function ble/string#tolower {
    ble/string#tolower.impl "$1" 2>/dev/null # suppress locale error #D1440
  }
  function ble/string#toupper {
    ble/string#toupper.impl "$1" 2>/dev/null # suppress locale error #D1440
  }
fi
function ble/string#capitalize {
  local tail=$1
  local rex='^[^a-zA-Z0-9]*'
  [[ $tail =~ $rex ]]
  local out=$BASH_REMATCH
  tail=${tail:${#BASH_REMATCH}}
  rex='^[a-zA-Z0-9]+[^a-zA-Z0-9]*'
  while [[ $tail =~ $rex ]]; do
    local rematch=$BASH_REMATCH
    ble/string#toupper "${rematch::1}"; out=$out$ret
    ble/string#tolower "${rematch:1}" ; out=$out$ret
    tail=${tail:${#rematch}}
  done
  ret=$out$tail
}
function ble/string#trim {
  ret=$1
  local rex=$'^[ \t\n]+'
  [[ $ret =~ $rex ]] && ret=${ret:${#BASH_REMATCH}}
  local rex=$'[ \t\n]+$'
  [[ $ret =~ $rex ]] && ret=${ret::${#ret}-${#BASH_REMATCH}}
}
function ble/string#ltrim {
  ret=$1
  local rex=$'^[ \t\n]+'
  [[ $ret =~ $rex ]] && ret=${ret:${#BASH_REMATCH}}
}
function ble/string#rtrim {
  ret=$1
  local rex=$'[ \t\n]+$'
  [[ $ret =~ $rex ]] && ret=${ret::${#ret}-${#BASH_REMATCH}}
}
if ((_ble_bash>=50200)); then
  function ble/string#escape-characters {
    ret=$1
    if [[ $ret == *["$2"]* ]]; then
      if [[ ! $3 ]]; then
        local patsub_replacement=
        shopt -q patsub_replacement && patsub_replacement=1
        shopt -s patsub_replacement
        ret=${ret//["$2"]/\\&} # #D1738 patsub_replacement
        [[ $patsub_replacement ]] || shopt -u patsub_replacement
      else
        local chars1=$2 chars2=${3:-$2}
        local i n=${#chars1} a b
        for ((i=0;i<n;i++)); do
          a=${chars1:i:1} b=\\${chars2:i:1} ret=${ret//"$a"/"$b"}
        done
      fi
    fi
  }
else
  function ble/string#escape-characters {
    ret=$1
    if [[ $ret == *["$2"]* ]]; then
      local chars1=$2 chars2=${3:-$2}
      local i n=${#chars1} a b
      for ((i=0;i<n;i++)); do
        a=${chars1:i:1} b=\\${chars2:i:1} ret=${ret//"$a"/"$b"}
      done
    fi
  }
fi
function ble/string#escape-for-sed-regex {
  ble/string#escape-characters "$1" '\.[*^$/'
}
function ble/string#escape-for-awk-regex {
  ble/string#escape-characters "$1" '\.[*?+|^$(){}/'
}
function ble/string#escape-for-extended-regex {
  ble/string#escape-characters "$1" '\.[*?+|^$(){}'
}
function ble/string#escape-for-bash-glob {
  ble/string#escape-characters "$1" '\*?[('
}
function ble/string#escape-for-bash-single-quote {
  local q="'" Q="'\''"
  ret=${1//$q/$Q}
}
function ble/string#escape-for-bash-double-quote {
  ble/string#escape-characters "$1" '\"$`'
  local a b
  a='!' b='"\!"' ret=${ret//"$a"/"$b"} # WA #D1751 checked
}
function ble/string#escape-for-bash-escape-string {
  ble/string#escape-characters "$1" $'\\\a\b\e\f\n\r\t\v'\' '\abefnrtv'\'
}
function ble/string#escape-for-bash-specialchars {
  local chars='\ "'\''`$|&;<>()!^'
  [[ $2 != *G* ]] && chars=$chars'*?['
  [[ $2 == *c* ]] && chars=$chars'=:'
  [[ $2 == *b* ]] && chars=$chars'{,}'
  ble/string#escape-characters "$1" "$chars"
  [[ $2 != *[HT]* && $ret == '~'* ]] && ret=\\$ret
  [[ $2 != *H* && $ret == '#'* ]] && ret=\\$ret
  if [[ $ret == *[$']\n\t']* ]]; then
    local a b
    a=']'   b=\\$a     ret=${ret//"$a"/"$b"}
    a=$'\n' b="\$'\n'" ret=${ret//"$a"/"$b"} # WA #D1751 checked
    a=$'\t' b=$'\\\t'  ret=${ret//"$a"/"$b"}
  fi
  if [[ $2 == *G* ]] && shopt -q extglob; then
    a='!\(' b='!(' ret=${ret//"$a"/"$b"}
    a='@\(' b='@(' ret=${ret//"$a"/"$b"}
    a='?\(' b='?(' ret=${ret//"$a"/"$b"}
    a='*\(' b='*(' ret=${ret//"$a"/"$b"}
    a='+\(' b='+(' ret=${ret//"$a"/"$b"}
  fi
}
function ble/string#escape-for-display {
  local head= tail=$1 opts=$2
  local sgr0= sgr1=
  local rex_csi=$'\e\\[[ -?]*[@-~]'
  if [[ :$opts: == *:revert:* ]]; then
    ble/color/g2sgr "$_ble_color_gflags_Revert"
    sgr1=$ret sgr0=$_ble_term_sgr0
  else
    if local rex=':sgr1=(('$rex_csi'|[^:])*):'; [[ :$opts: =~ $rex ]]; then
      sgr1=${BASH_REMATCH[1]} sgr0=$_ble_term_sgr0
    fi
    if local rex=':sgr0=(('$rex_csi'|[^:])*):'; [[ :$opts: =~ $rex ]]; then
      sgr0=${BASH_REMATCH[1]}
    fi
  fi
  while [[ $tail ]]; do
    if ble/util/isprint+ "$tail"; then
      head=$head${BASH_REMATCH}
      tail=${tail:${#BASH_REMATCH}}
    else
      ble/util/s2c "${tail::1}"
      local code=$ret
      if ((code<32)); then
        ble/util/c2s $((code+64))
        ret=$sgr1^$ret$sgr0
      elif ((code==127)); then
        ret=$sgr1^?$sgr0
      elif ((128<=code&&code<160)); then
        ble/util/c2s $((code-64))
        ret=${sgr1}M-^$ret$sgr0
      else
        ret=${tail::1}
      fi
      head=$head$ret
      tail=${tail:1}
    fi
  done
  ret=$head
}
if ((_ble_bash>=40400)); then
  function ble/string#quote-words {
    local IFS=$_ble_term_IFS
    ret="${*@Q}"
  }
  function ble/string#quote-command {
    local IFS=$_ble_term_IFS
    ret=$1; shift
    (($#)) && ret="$ret ${*@Q}"
  }
else
  function ble/string#quote-words {
    local q=\' Q="'\''" IFS=$_ble_term_IFS
    ret=("${@//$q/$Q}")
    ret=("${ret[@]/%/$q}") # WA #D1570 #D1738 ok
    ret="${ret[*]/#/$q}"   # WA #D1570 #D1738 ok
  }
  function ble/string#quote-command {
    if (($#<=1)); then
      ret=$1
      return
    fi
    local q=\' Q="'\''" IFS=$_ble_term_IFS
    ret=("${@:2}")
    ret=("${ret[@]//$q/$Q}")  # WA #D1570 #D1738 ok
    ret=("${ret[@]/%/$q}")    # WA #D1570 #D1738 ok
    ret="$1 ${ret[*]/#/$q}"   # WA #D1570 #D1738 ok
  }
fi
function ble/string#quote-word {
  ret=$1
  local rex_csi=$'\e\\[[ -?]*[@-~]'
  local opts=$2 sgrq= sgr0=
  if [[ $opts ]]; then
    local rex=':sgrq=(('$rex_csi'|[^:])*):'
    [[ :$opts: =~ $rex ]] &&
      sgrq=${BASH_REMATCH[1]} sgr0=$_ble_term_sgr0
    rex=':sgr0=(('$rex_csi'|[^:])*):'
    if [[ :$opts: =~ $rex ]]; then
      sgr0=${BASH_REMATCH[1]}
    elif [[ :$opts: == *:ansi:* ]]; then
      sgr0=$'\e[m'
    fi
  fi
  if [[ ! $ret ]]; then
    [[ :$opts: == *:quote-empty:* ]] &&
      ret=$sgrq\'\'$sgr0
    return
  fi
  local chars=$'\a\b\e\f\n\r\t\v'
  if [[ $ret == *["$chars"]* ]]; then
    ble/string#escape-for-bash-escape-string "$ret"
    ret=$sgrq\$\'$ret\'$sgr0
    return
  fi
  local chars=$_ble_term_IFS'"`$\<>()|&;*?[]!^=:{,}#~' q=\'
  if [[ $ret == *["$chars"]* ]]; then
    local Q="'$sgr0\'$sgrq'"
    ret=$sgrq$q${ret//$q/$Q}$q$sgr0
    ret=${ret#"$sgrq$q$q$sgr0"} ret=${ret%"$sgrq$q$q$sgr0"}
  elif [[ $ret == *["$q"]* ]]; then
    local Q="\'"
    ret=${ret//$q/$Q}
  fi
}
function ble/string#match { [[ $1 =~ $2 ]]; }
function ble/string#create-unicode-progress-bar/.block {
  local block=$1
  if ((block<=0)); then
    ble/util/c2w $((0x2588))
    ble/string#repeat ' ' "$ret"
  elif ((block>=8)); then
    ble/util/c2s $((0x2588))
    ((${#ret}==1)) || ret='*' # LC_CTYPE が非対応の文字の時
  else
    ble/util/c2s $((0x2590-block))
    if ((${#ret}!=1)); then
      ble/util/c2w $((0x2588))
      ble/string#repeat ' ' $((ret-1))
      ret=$block$ret
    fi
  fi
}
function ble/string#create-unicode-progress-bar {
  local value=$1 max=$2 width=$3 opts=:$4:
  local opt_unlimited=
  if [[ $opts == *:unlimited:* ]]; then
    opt_unlimited=1
    ((value%=max,width--))
  fi
  local progress=$((value*8*width/max))
  local progress_fraction=$((progress%8)) progress_integral=$((progress/8))
  local out=
  if ((progress_integral)); then
    if [[ $opt_unlimited ]]; then
      ble/string#create-unicode-progress-bar/.block 0
    else
      ble/string#create-unicode-progress-bar/.block 8
    fi
    ble/string#repeat "$ret" "$progress_integral"
    out=$ret
  fi
  if ((progress_fraction)); then
    if [[ $opt_unlimited ]]; then
      ble/string#create-unicode-progress-bar/.block "$progress_fraction"
      out=$out$'\e[7m'$ret$'\e[27m'
    fi
    ble/string#create-unicode-progress-bar/.block "$progress_fraction"
    out=$out$ret
    ((progress_integral++))
  else
    if [[ $opt_unlimited ]]; then
      ble/string#create-unicode-progress-bar/.block 8
      out=$out$ret
    fi
  fi
  if ((progress_integral<width)); then
    ble/string#create-unicode-progress-bar/.block 0
    ble/string#repeat "$ret" $((width-progress_integral))
    out=$out$ret
  fi
  ret=$out
}
function ble/util/strlen.impl {
  local LC_ALL= LC_CTYPE=C
  ret=${#1}
}
function ble/util/strlen {
  ble/util/strlen.impl "$@" 2>/dev/null # suppress locale error #D1440
}
function ble/util/substr.impl {
  local LC_ALL= LC_CTYPE=C
  ret=${1:$2:$3}
}
function ble/util/substr {
  ble/util/substr.impl "$@" 2>/dev/null # suppress locale error #D1440
}
function ble/path#append {
  local _ble_local_script='opts=$opts${opts:+:}$2'
  _ble_local_script=${_ble_local_script//opts/"$1"}
  builtin eval -- "$_ble_local_script"
}
function ble/path#prepend {
  local _ble_local_script='opts=$2${opts:+:}$opts'
  _ble_local_script=${_ble_local_script//opts/"$1"}
  builtin eval -- "$_ble_local_script"
}
function ble/path#remove {
  [[ $2 ]] || return 1
  local _ble_local_script='
    opts=:${opts//:/::}:
    opts=${opts//:"$2":}
    opts=${opts//::/:} opts=${opts#:} opts=${opts%:}'
  _ble_local_script=${_ble_local_script//opts/"$1"}
  builtin eval -- "$_ble_local_script"
}
function ble/path#remove-glob {
  [[ $2 ]] || return 1
  local _ble_local_script='
    opts=:${opts//:/::}:
    opts=${opts//:$2:}
    opts=${opts//::/:} opts=${opts#:} opts=${opts%:}'
  _ble_local_script=${_ble_local_script//opts/"$1"}
  builtin eval -- "$_ble_local_script"
}
function ble/path#contains {
  builtin eval "[[ :\${$1}: == *:\"\$2\":* ]]"
}
function ble/opts#has {
  local rex=':'$2'[=[]'
  [[ :$1: =~ $rex ]]
}
function ble/opts#extract-first-optarg {
  ret=
  local rex=':'$2'(=[^:]*)?:'
  [[ :$1: =~ $rex ]] || return 1
  if [[ ${BASH_REMATCH[1]} ]]; then
    ret=${BASH_REMATCH[1]:1}
  elif [[ ${3+set} ]]; then
    ret=$3
  fi
  return 0
}
function ble/opts#extract-last-optarg {
  ret=
  local rex='.*:'$2'(=[^:]*)?:'
  [[ :$1: =~ $rex ]] || return 1
  if [[ ${BASH_REMATCH[1]} ]]; then
    ret=${BASH_REMATCH[1]:1}
  elif [[ ${3+set} ]]; then
    ret=$3
  fi
  return 0
}
function ble/opts#extract-all-optargs {
  ret=()
  local value=:$1: rex=':'$2'(=[^:]*)?(:.*)$' count=0
  while [[ $value =~ $rex ]]; do
    ((count++))
    if [[ ${BASH_REMATCH[1]} ]]; then
      ble/array#push ret "${BASH_REMATCH[1]:1}"
    elif [[ ${3+set} ]]; then
      ble/array#push ret "$3"
    fi
    value=${BASH_REMATCH[2]}
  done
  ((count))
}
if ((_ble_bash>=40000)); then
  _ble_util_set_declare=(declare -A NAME)
  function ble/set#add { builtin eval -- "$1[x\$2]=1"; }
  function ble/set#remove { builtin unset -v "$1[x\$2]"; }
  function ble/set#contains { builtin eval "[[ \${$1[x\$2]+set} ]]"; }
else
  _ble_util_set_declare=(declare NAME)
  function ble/set#.escape {
    _ble_local_value=${_ble_local_value//$_ble_term_FS/"$_ble_term_FS$_ble_term_FS"}
    _ble_local_value=${_ble_local_value//:/"$_ble_term_FS."}
  }
  function ble/set#add {
    local _ble_local_value=$2; ble/set#.escape
    ble/path#append "$1" "$_ble_local_value"
  }
  function ble/set#remove {
    local _ble_local_value=$2; ble/set#.escape
    ble/path#remove "$1" "$_ble_local_value"
  }
  function ble/set#contains {
    local _ble_local_value=$2; ble/set#.escape
    builtin eval "[[ :\$$1: == *:\"\$_ble_local_value\":* ]]"
  }
fi
_ble_util_adict_declare='declare NAME NAME_keylist'
function ble/adict#.resolve {
  _ble_local_key=$2
  _ble_local_key=${_ble_local_key//$_ble_term_FS/"$_ble_term_FS,"}
  _ble_local_key=${_ble_local_key//:/"$_ble_term_FS."}
  local keylist=${1}_keylist; keylist=:${!keylist}
  local vec=${keylist%%:"$_ble_local_key":*}
  if [[ $vec != "$keylist" ]]; then
    vec=${vec//[!:]}
    _ble_local_index=${#vec}
  else
    _ble_local_index=-1
  fi
}
function ble/adict#set {
  local _ble_local_key _ble_local_index
  ble/adict#.resolve "$1" "$2"
  if ((_ble_local_index>=0)); then
    builtin eval -- "$1[_ble_local_index]=\$3"
  else
    local _ble_local_script='
      local _ble_local_vec=${NAME_keylist//[!:]}
      NAME[${#_ble_local_vec}]=$3
      NAME_keylist=$NAME_keylist$_ble_local_key:
    '
    builtin eval -- "${_ble_local_script//NAME/$1}"
  fi
  return 0
}
function ble/adict#get {
  local _ble_local_key _ble_local_index
  ble/adict#.resolve "$1" "$2"
  if ((_ble_local_index>=0)); then
    builtin eval -- "ret=\${$1[_ble_local_index]}; [[ \${$1[_ble_local_index]+set} ]]"
  else
    builtin eval -- ret=
    return 1
  fi
}
function ble/adict#unset {
  local _ble_local_key _ble_local_index
  ble/adict#.resolve "$1" "$2"
  ((_ble_local_index>=0)) &&
    builtin eval -- "builtin unset -v '$1[_ble_local_index]'"
  return 0
}
function ble/adict#has {
  local _ble_local_key _ble_local_index
  ble/adict#.resolve "$1" "$2"
  ((_ble_local_index>=0)) &&
    builtin eval -- "[[ \${$1[_ble_local_index]+set} ]]"
}
function ble/adict#clear {
  builtin eval -- "${1}_keylist= $1=()"
}
function ble/adict#keys {
  local _ble_local_keylist=${1}_keylist
  _ble_local_keylist=${!_ble_local_keylist%:}
  ble/string#split ret : "$_ble_local_keylist"
  if [[ $_ble_local_keylist == *"$_ble_term_FS"* ]]; then
    ret=("${ret[@]//$_ble_term_FS./:}")             # WA #D1570 checked
    ret=("${ret[@]//$_ble_term_FS,/$_ble_term_FS}") # WA #D1570 #D1738 checked
  fi
  local _ble_local_keys _ble_local_i _ble_local_ref=$1[_ble_local_i]
  _ble_local_keys=("${ret[@]}") ret=()
  for _ble_local_i in "${!_ble_local_keys[@]}"; do
    [[ ${_ble_local_ref+set} ]] &&
      ble/array#push ret "${_ble_local_keys[_ble_local_i]}"
  done
}
if ((_ble_bash>=40000)); then
  _ble_util_dict_declare='declare -A NAME'
  function ble/dict#set   { builtin eval -- "$1[x\$2]=\$3"; }
  function ble/dict#get   { builtin eval -- "ret=\${$1[x\$2]-}; [[ \${$1[x\$2]+set} ]]"; }
  function ble/dict#unset { builtin eval -- "builtin unset -v '$1[x\$2]'"; }
  function ble/dict#has   { builtin eval -- "[[ \${$1[x\$2]+set} ]]"; }
  function ble/dict#clear { builtin eval -- "$1=()"; }
  function ble/dict#keys  { builtin eval -- 'ret=("${!'"$1"'[@]}"); ret=("${ret[@]#x}")'; }
else
  _ble_util_dict_declare='declare NAME NAME_keylist='
  function ble/dict#set   { ble/adict#set   "$@"; }
  function ble/dict#get   { ble/adict#get   "$@"; }
  function ble/dict#unset { ble/adict#unset "$@"; }
  function ble/dict#has   { ble/adict#has   "$@"; }
  function ble/dict#clear { ble/adict#clear "$@"; }
  function ble/dict#keys  { ble/adict#keys  "$@"; }
fi
if ((_ble_bash>=40200)); then
  _ble_util_gdict_declare='{ builtin unset -v NAME; declare -gA NAME; NAME=(); }'
  function ble/gdict#set   { ble/dict#set   "$@"; }
  function ble/gdict#get   { ble/dict#get   "$@"; }
  function ble/gdict#unset { ble/dict#unset "$@"; }
  function ble/gdict#has   { ble/dict#has   "$@"; }
  function ble/gdict#clear { ble/dict#clear "$@"; }
  function ble/gdict#keys  { ble/dict#keys  "$@"; }
elif ((_ble_bash>=40000)); then
  _ble_util_gdict_declare='{ if ! ble/is-assoc NAME; then if local _ble_local_test 2>/dev/null; then NAME_keylist=; else builtin unset -v NAME NAME_keylist; declare -A NAME; fi fi; NAME=(); }'
  function ble/gdict#.is-adict {
    local keylist=${1}_keylist
    [[ ${!keylist+set} ]]
  }
  function ble/gdict#set   { if ble/gdict#.is-adict "$1"; then ble/adict#set   "$@"; else ble/dict#set   "$@"; fi; }
  function ble/gdict#get   { if ble/gdict#.is-adict "$1"; then ble/adict#get   "$@"; else ble/dict#get   "$@"; fi; }
  function ble/gdict#unset { if ble/gdict#.is-adict "$1"; then ble/adict#unset "$@"; else ble/dict#unset "$@"; fi; }
  function ble/gdict#has   { if ble/gdict#.is-adict "$1"; then ble/adict#has   "$@"; else ble/dict#has   "$@"; fi; }
  function ble/gdict#clear { if ble/gdict#.is-adict "$1"; then ble/adict#clear "$@"; else ble/dict#clear "$@"; fi; }
  function ble/gdict#keys  { if ble/gdict#.is-adict "$1"; then ble/adict#keys  "$@"; else ble/dict#keys  "$@"; fi; }
else
  _ble_util_gdict_declare='{ builtin unset -v NAME NAME_keylist; NAME_keylist= NAME=(); }'
  function ble/gdict#set   { ble/adict#set   "$@"; }
  function ble/gdict#get   { ble/adict#get   "$@"; }
  function ble/gdict#unset { ble/adict#unset "$@"; }
  function ble/gdict#has   { ble/adict#has   "$@"; }
  function ble/gdict#clear { ble/adict#clear "$@"; }
  function ble/gdict#keys  { ble/adict#keys  "$@"; }
fi
function ble/dict/.print {
  declare -p "$2" &>/dev/null || return 1
  local ret _ble_local_key _ble_local_value
  ble/util/print "builtin eval -- \"\${_ble_util_${1}_declare//NAME/$2}\""
  ble/"$1"#keys "$2"
  for _ble_local_key in "${ret[@]}"; do
    ble/"$1"#get "$2" "$_ble_local_key"
    ble/string#quote-word "$ret" quote-empty
    _ble_local_value=$ret
    ble/string#quote-word "$_ble_local_key" quote-empty
    _ble_local_key=$ret
    ble/util/print "ble/$1#set $2 $_ble_local_key $_ble_local_value"
  done
}
function ble/dict#print { ble/dict/.print dict "$1"; }
function ble/adict#print { ble/dict/.print adict "$1"; }
function ble/gdict#print { ble/dict/.print gdict "$1"; }
function ble/dict/.copy {
  local ret
  ble/"$1"#keys "$2"
  ble/"$1"#clear "$3"
  local _ble_local_key
  for _ble_local_key in "${ret[@]}"; do
    ble/"$1"#get "$2" "$_ble_local_key"
    ble/"$1"#set "$3" "$_ble_local_key" "$ret"
  done
}
function ble/dict#cp { ble/dict/.copy dict "$1" "$2"; }
function ble/adict#cp { ble/dict/.copy adict "$1" "$2"; }
function ble/gdict#cp { ble/dict/.copy gdict "$1" "$2"; }
function blehook/.print {
  (($#)) || return
  local out= q=\' Q="'\''" nl=$'\n'
  local sgr0= sgr1= sgr2= sgr3=
  if [[ $flags == *c* ]]; then
    local ret
    ble/color/face2sgr command_function; sgr1=$ret
    ble/color/face2sgr syntax_varname; sgr2=$ret
    ble/color/face2sgr syntax_quoted; sgr3=$ret
    sgr0=$_ble_term_sgr0
    Q=$q$sgr0"\'"$sgr3$q
  fi
  local elem code='
    if ((${#_ble_hook_h_NAME[@]})); then
      for elem in "${_ble_hook_h_NAME[@]}"; do
        out="${out}${sgr1}blehook$sgr0 ${sgr2}NAME$sgr0+=${sgr3}$q${elem//$q/$Q}$q$sgr0$nl"
      done
    else
      out="${out}${sgr1}blehook$sgr0 ${sgr2}NAME$sgr0=$nl"
    fi'
  local hookname
  for hookname; do
    ble/is-array "$hookname" || continue
    builtin eval -- "${code//NAME/${hookname#_ble_hook_h_}}"
  done
  ble/util/put "$out"
}
function blehook/.print-help {
  ble/util/print-lines \
    'usage: blehook [NAME[[=|+=|-=|-+=]COMMAND]]...' \
    '    Add or remove hooks. Without arguments, this prints all the existing hooks.' \
    '' \
    '  Options:' \
    '    --help      Print this help.' \
    '    -a, --all   Print all including internal hooks.' \
    '    --color[=always|never|auto]' \
    '                  Change color settings.' \
    '' \
    '  Arguments:' \
    '    NAME            Print the corresponding hooks.' \
    '    NAME=COMMAND    Set hook after removing the existing hooks.' \
    '    NAME+=COMMAND   Add hook.' \
    '    NAME-=COMMAND   Remove hook.' \
    '    NAME!=COMMAND   Add hook if the command is not registered.' \
    '    NAME-+=COMMAND  Append the hook and remove the duplicates.' \
    '    NAME+-=COMMAND  Prepend the hook and remove the duplicates.' \
    ''
}
function blehook/.read-arguments {
  flags= print=() process=()
  local opt_color=always
  while (($#)); do
    local arg=$1; shift
    if [[ $arg == -* ]]; then
      case $arg in
      (--help)
        flags=H$flags ;;
      (--color) opt_color=always ;;
      (--color=always|--color=auto|--color=never)
        opt_color=${arg#*=} ;;
      (--color=*)
        ble/util/print "blehook: '${arg#*=}': unrecognized option argument for '--color'." >&2
        flags=E$flags ;;
      (--all) flags=a$flags ;;
      (--*)
        ble/util/print "blehook: unrecognized long option '$arg'." >&2
        flags=E$flags ;;
      (-)
        ble/util/print "blehook: unrecognized argument '$arg'." >&2
        flags=E$flags ;;
      (*)
        local i c
        for ((i=1;i<${#arg};i++)); do
          c=${arg:i:1}
          case $c in
          (a) flags=a$flags ;;
          (*)
            ble/util/print "blehook: unrecognized option '-$c'." >&2
            flags=E$flags ;;
          esac
        done ;;
      esac
    elif [[ $arg =~ $rex1 ]]; then
      local hookvar=_ble_hook_h_$arg
      if ble/is-array "$hookvar"; then
        ble/array#push print "$hookvar"
      else
        ble/util/print "blehook: undefined hook '$arg'." >&2
        flags=E$flags
      fi
    elif [[ $arg =~ $rex2 ]]; then
      local name=${BASH_REMATCH[1]}
      local var_counter=_ble_hook_c_$name
      if [[ ! ${!var_counter+set} ]]; then
        if [[ ${BASH_REMATCH[2]} == :* ]]; then
          (($var_counter=0))
        else
          ble/util/print "blehook: hook \"$name\" is not defined." >&2
          flags=E$flags
        fi
      fi
      ble/array#push process "$arg"
    else
      ble/util/print "blehook: invalid hook spec \"$arg\"" >&2
      flags=E$flags
    fi
  done
  [[ $opt_color == always || $opt_color == auto && -t 1 ]] && flags=c$flags
}
function blehook {
  local set shopt
  ble/base/adjust-BASH_REMATCH
  ble/base/.adjust-bash-options set shopt
  local flags print process
  local rex1='^([a-zA-Z_][a-zA-Z_0-9]*)$'
  local rex2='^([a-zA-Z_][a-zA-Z_0-9]*)(:?([-+!]|-\+|\+-)?=)(.*)$'
  blehook/.read-arguments "$@"
  if [[ $flags == *[HE]* ]]; then
    if [[ $flags == *H* ]]; then
      [[ $flags == *E* ]] &&
        ble/util/print >&2
      blehook/.print-help
    fi
    [[ $flags != *E* ]]; local ext=$?
    ble/base/.restore-bash-options set shopt
    ble/base/restore-BASH_REMATCH
    return "$ext"
  fi
  if ((${#print[@]}==0&&${#process[@]}==0)); then
    print=("${!_ble_hook_h_@}")
    [[ $flags == *a* ]] || ble/array#remove-by-glob print '_ble_hook_h_*[a-z]*'
  fi
  local proc ext=0
  for proc in "${process[@]}"; do
    [[ $proc =~ $rex2 ]]
    local name=${BASH_REMATCH[1]}
    local type=${BASH_REMATCH[3]}
    local value=${BASH_REMATCH[4]}
    local append=$value
    case $type in
    (*-*) # -=, -+=, +-=
      local ret
      ble/array#last-index "_ble_hook_h_$name" "$value"
      if ((ret>=0)); then
        ble/array#remove-at "_ble_hook_h_$name" "$ret"
      elif [[ ${type#:} == '-=' ]]; then
        ext=1
      fi
      if [[ $type != -+ ]]; then
        append=
        [[ $type == +- ]] &&
          ble/array#unshift "_ble_hook_h_$name" "$value"
      fi ;;
    ('!') # !=
      local ret
      ble/array#last-index "_ble_hook_h_$name" "$value"
      ((ret>=0)) && append= ;;
    ('') builtin eval "_ble_hook_h_$name=()" ;; # =
    ('+'|*) ;; # +=
    esac
    [[ $append ]] && ble/array#push "_ble_hook_h_$name" "$append"
  done
  if ((${#print[@]})); then
    blehook/.print "${print[@]}"
  fi
  ble/base/.restore-bash-options set shopt
  ble/base/restore-BASH_REMATCH
  return "$ext"
}
blehook/.compatibility-ble-0.3
function blehook/has-hook {
  builtin eval "local count=\${#_ble_hook_h_$1[@]}"
  ((count))
}
function blehook/invoke.sandbox {
  if type "$_ble_local_hook" &>/dev/null; then
    ble/util/setexit "$_ble_local_lastexit" "$_ble_local_lastarg"
    "$_ble_local_hook" "$@" 2>&3
  else
    ble/util/setexit "$_ble_local_lastexit" "$_ble_local_lastarg"
    builtin eval -- "$_ble_local_hook" 2>&3
  fi
}
function blehook/invoke {
  local _ble_local_lastexit=$? _ble_local_lastarg=$_ FUNCNEST=
  ((_ble_hook_c_$1++))
  local -a _ble_local_hooks
  builtin eval "_ble_local_hooks=(\"\${_ble_hook_h_$1[@]}\")"; shift
  local _ble_local_hook _ble_local_ext=0
  for _ble_local_hook in "${_ble_local_hooks[@]}"; do
    blehook/invoke.sandbox "$@" || _ble_local_ext=$?
  done
  return "$_ble_local_ext"
} 3>&2 2>/dev/null # set -x 対策 #D0930
function blehook/eval-after-load {
  local hook_name=${1}_load value=$2
  if ((_ble_hook_c_$hook_name)); then
    builtin eval -- "$value"
  else
    blehook "$hook_name+=$value"
  fi
}
function ble/builtin/trap/.read-arguments {
  flags= command= sigspecs=()
  while (($#)); do
    local arg=$1; shift
    if [[ $arg == -?* && flags != *A* ]]; then
      if [[ $arg == -- ]]; then
        flags=A$flags
        continue
      elif [[ $arg == --* ]]; then
        case $arg in
        (--help)
          flags=h$flags
          continue ;;
        (*)
          ble/util/print "ble/builtin/trap: unknown long option \"$arg\"." >&2
          flags=E$flags
          continue ;;
        esac
      fi
      local i
      for ((i=1;i<${#arg};i++)); do
        case ${arg:i:1} in
        (l) flags=l$flags ;;
        (p) flags=p$flags ;;
        (*)
          ble/util/print "ble/builtin/trap: unknown option \"-${arg:i:1}\"." >&2
          flags=E$flags ;;
        esac
      done
    else
      if [[ $flags != *[pc]* ]]; then
        command=$arg
        flags=c$flags
      else
        ble/array#push sigspecs "$arg"
      fi
    fi
  done
  if [[ $flags != *[hlpE]* ]]; then
    if [[ $flags != *c* ]]; then
      flags=p$flags
    elif ((${#sigspecs[@]}==0)); then
      sigspecs=("$command")
      command=-
    fi
  fi
}
_ble_builtin_trap_signames=()
_ble_builtin_trap_reserved=()
_ble_builtin_trap_handlers=()
_ble_builtin_trap_DEBUG=
_ble_builtin_trap_inside=  # ble/builtin/trap 処理中かどうか
_ble_builtin_trap_processing= # ble/buitlin/trap/.handler 実行中かどうか
builtin eval -- "${_ble_util_gdict_declare//NAME/_ble_builtin_trap_n2i}"
function ble/builtin/trap/.register {
  local index=$1 name=$2
  _ble_builtin_trap_signames[index]=$name
  ble/gdict#set _ble_builtin_trap_n2i "$name" "$index"
}
function ble/builtin/trap/.get-sig-index {
  if [[ $1 && ! ${1//[0-9]} ]]; then
    ret=$1
    return 0
  else
    ble/gdict#get _ble_builtin_trap_n2i "$1"
    [[ $ret ]] && return 0
    ble/string#toupper "$1"; local upper=$ret
    ble/gdict#get _ble_builtin_trap_n2i "$upper" ||
      ble/gdict#get _ble_builtin_trap_n2i "SIG$upper" ||
      return 1
    ble/gdict#set _ble_builtin_trap_n2i "$1" "$ret"
    return 0
  fi
}
function ble/builtin/trap/.initialize {
  function ble/builtin/trap/.initialize { :; }
  local ret i
  ble/util/assign ret 'builtin trap -l' 2>/dev/null
  ble/string#split-words ret "$ret"
  for ((i=0;i<${#ret[@]};i+=2)); do
    local index=${ret[i]%')'}
    local name=${ret[i+1]}
    ble/builtin/trap/.register "$index" "$name"
  done
  ble/builtin/trap/.register 0 EXIT
  ble/builtin/trap/.register 1000 DEBUG
  ble/builtin/trap/.register 1001 RETURN
  ble/builtin/trap/.register 1002 ERR
  _ble_builtin_trap_DEBUG=1000
}
function ble/builtin/trap/reserve {
  local ret
  ble/builtin/trap/.initialize
  ble/builtin/trap/.get-sig-index "$1" || return 1
  _ble_builtin_trap_reserved[ret]=1
}
function ble/builtin/trap/finalize {
  local sig
  for sig in "${!_ble_builtin_trap_reserved[@]}"; do
    local name=${_ble_builtin_trap_signames[index]}
    [[ $name && ${_ble_builtin_trap_reserved[sig]} ]] || continue
    if [[ ${_ble_builtin_trap_handlers[sig]+set} ]]; then
      builtin trap -- "${_ble_builtin_trap_handlers[sig]+set}" "$name"
    else
      builtin trap -- - "$name"
    fi
  done
}
function ble/builtin/trap {
  local set shopt; ble/base/.adjust-bash-options set shopt
  local flags command sigspecs
  ble/builtin/trap/.read-arguments "$@"
  if [[ $flags == *h* ]]; then
    builtin trap --help
    ble/base/.restore-bash-options set shopt
    return 2
  elif [[ $flags == *E* ]]; then
    builtin trap --usage 2>&1 1>/dev/null | ble/bin/grep ^trap >&2
    ble/base/.restore-bash-options set shopt
    return 2
  elif [[ $flags == *l* ]]; then
    builtin trap -l
  fi
  [[ ! $_ble_attached || $_ble_edit_exec_inside_userspace ]] &&
    ble/base/adjust-BASH_REMATCH
  if [[ $flags == *p* ]]; then
    ble/builtin/trap/.initialize
    local -a indices=()
    if ((${#sigspecs[@]})); then
      local spec ret
      for spec in "${sigspecs[@]}"; do
        if ! ble/builtin/trap/.get-sig-index "$spec"; then
          ble/util/print "ble/builtin/trap: invalid signal specification \"$spec\"." >&2
          continue
        fi
        ble/array#push indices "$ret"
      done
    else
      indices=("${!_ble_builtin_trap_handlers[@]}")
    fi
    local q=\' Q="'\''" index
    for index in "${indices[@]}"; do
      if [[ ${_ble_builtin_trap_handlers[index]+set} ]]; then
        local h=${_ble_builtin_trap_handlers[index]}
        local n=${_ble_builtin_trap_signames[index]}
        ble/util/print "trap -- '${h//$q/$Q}' $n"
      fi
    done
  else
    local _ble_builtin_trap_inside=1
    local spec ret
    for spec in "${sigspecs[@]}"; do
      if ! ble/builtin/trap/.get-sig-index "$spec"; then
        ble/util/print "ble/builtin/trap: invalid signal specification \"$spec\"." >&2
        continue
      fi
      if [[ $command == - ]]; then
        builtin unset -v "_ble_builtin_trap_handlers[ret]"
      else
        _ble_builtin_trap_handlers[ret]=$command
      fi
      if [[ ${_ble_builtin_trap_reserved[ret]} ]]; then
        ble/function#try ble/builtin/trap:"${_ble_builtin_trap_signames[ret]}" "$command" "$spec"
      else
        builtin trap -- "$command" "$spec"
      fi
    done
  fi
  [[ ! $_ble_attached || $_ble_edit_exec_inside_userspace ]] &&
    ble/base/restore-BASH_REMATCH
  ble/base/.restore-bash-options set shopt
  return 0
}
function trap { ble/builtin/trap "$@"; }
_ble_builtin_trap_user_lastcmd=
_ble_builtin_trap_user_lastarg=
_ble_builtin_trap_user_lastexit=
function ble/builtin/trap/invoke.sandbox {
  local _ble_trap_count
  for ((_ble_trap_count=0;_ble_trap_count<1;_ble_trap_count++)); do
    _ble_trap_done=return
    ble/util/setexit "$_ble_trap_lastexit" "$_ble_trap_lastarg"
    builtin eval -- "$_ble_trap_handler"$'\n_ble_trap_lastexit=$? _ble_trap_lastarg=$_' 2>&3
    _ble_trap_done=done
    return 0
  done
  _ble_trap_lastexit=$? _ble_trap_lastarg=$_
  if ((_ble_trap_count==0)); then
    _ble_trap_done=break
  else
    _ble_trap_done=continue
  fi
  return 0
}
function ble/builtin/trap/invoke {
  local _ble_trap_lastexit=$? _ble_trap_lastarg=$_ _ble_trap_sig=$1
  if [[ ${_ble_trap_sig//[0-9]} ]]; then
    local ret
    ble/builtin/trap/.initialize
    ble/builtin/trap/.get-sig-index "$1" || return 1
    _ble_trap_sig=$ret
  fi
  local _ble_trap_handler=${_ble_builtin_trap_handlers[_ble_trap_sig]-}
  [[ $_ble_trap_handler ]] || return 0
  if [[ $_ble_attached && ! $_ble_edit_exec_inside_userspace ]]; then
    if [[ $_ble_builtin_trap_user_lastcmd != $_ble_edit_CMD ]]; then
      _ble_builtin_trap_user_lastcmd=$_ble_edit_CMD
      _ble_builtin_trap_user_lastexit=$_ble_edit_exec_lastexit
      _ble_builtin_trap_user_lastarg=$_ble_edit_exec_lastarg
    fi
    _ble_trap_lastexit=$_ble_builtin_trap_user_lastexit
    _ble_trap_lastarg=$_ble_builtin_trap_user_lastarg
  fi
  local _ble_trap_done=
  ble/builtin/trap/invoke.sandbox; local ext=$?
  case $_ble_trap_done in
  (done)
    _ble_builtin_trap_lastarg=$_ble_trap_lastarg
    _ble_builtin_trap_postproc="ble/util/setexit $_ble_trap_lastexit" ;;
  (break | continue)
    _ble_builtin_trap_lastarg=$_ble_trap_lastarg
    if ble/string#match "$_ble_trap_lastarg" '^-?[0-9]+$'; then
      _ble_builtin_trap_postproc="$_ble_trap_done $_ble_trap_lastarg"
    else
      _ble_builtin_trap_postproc=$_ble_trap_done
    fi ;;
  (return)
    _ble_builtin_trap_lastarg=$ext
    _ble_builtin_trap_postproc="return $ext" ;;
  (exit)
    _ble_builtin_trap_lastarg=$_ble_trap_lastarg
    _ble_builtin_trap_postproc="ble/builtin/exit $_ble_trap_lastarg" ;;
  esac
  if [[ $_ble_attached && ! $_ble_edit_exec_inside_userspace ]]; then
    _ble_builtin_trap_user_lastexit=$_ble_trap_lastexit
    _ble_builtin_trap_user_lastarg=$_ble_trap_lastarg
  fi
  return 0
} 3>&2 2>/dev/null # set -x 対策 #D0930
function ble/builtin/trap/.handler {
  local _ble_trap_lastexit=$? _ble_trap_lastarg=$_ FUNCNEST=
  local _ble_trap_sig=$1 _ble_trap_name=$2
  local FUNCNEST= IFS=$_ble_term_IFS
  local set shopt; ble/base/.adjust-bash-options set shopt
  local _ble_builtin_trap_processing=$_ble_trap_sig
  local _ble_local_q=\' _ble_local_Q="'\''"
  _ble_builtin_trap_lastarg=$_ble_trap_lastarg
  _ble_builtin_trap_postproc="ble/util/setexit $_ble_trap_lastexit"
  if [[ $_ble_builtin_exit_processing ]]; then
    exec 1>&- 1>&"$_ble_builtin_exit_stdout"
    exec 2>&- 2>&"$_ble_builtin_exit_stderr"
  fi
  ble/util/joblist.check
  ble/util/setexit "$_ble_trap_lastexit" "$_ble_trap_lastarg"
  blehook/invoke "$_ble_trap_name"
  ble/util/joblist.check ignore-volatile-jobs
  ble/util/setexit "$_ble_trap_lastexit" "$_ble_trap_lastarg"
  ble/builtin/trap/invoke "$_ble_trap_sig"
  if [[ $_ble_builtin_trap_processing == exit:* && $_ble_builtin_trap_postproc != 'ble/builtin/exit '* ]]; then
    _ble_builtin_trap_postproc="ble/builtin/exit ${_ble_builtin_trap_processing#exit:}"
  fi
  [[ $_ble_builtin_trap_lastarg == *$'\n'* ]] &&
    _ble_builtin_trap_lastarg=
  ((_ble_trap_sig==0)) && ble/base/unload
  ble/base/.restore-bash-options set shopt
}
function ble/builtin/trap/install-hook {
  local ret opts=:${2-}:
  ble/builtin/trap/.initialize
  ble/builtin/trap/.get-sig-index "$1"
  local sig=$ret name=${_ble_builtin_trap_signames[ret]}
  ble/builtin/trap/reserve "$sig"
  local handler="ble/builtin/trap/.handler $sig ${name#SIG}; builtin eval -- \"\$_ble_builtin_trap_postproc\" \\# \"\$_ble_builtin_trap_lastarg\""
  local trap_command="trap -- '$handler' $name"
  local trap_string; ble/util/assign trap_string "builtin trap -p $name"
  if [[ $opts == *:readline:* ]] && ! ble/util/is-running-in-subshell; then
    [[ $trap_command == "$trap_string" ]] && return 0
  fi
  builtin eval "builtin $trap_command"; local ext=$?
  case $trap_string in
  ("trap -- 'ble/builtin/trap/"*) ;; # ble-0.4
  ("trap -- 'ble/base/unload"*|"trap -- 'ble-edit/"*) ;; # bash-0.3 以前
  ("trap -- '"*)
    [[ ! ${_ble_builtin_trap_handlers[sig]+set} ]] &&
      ((sig<1000)) &&
      builtin eval -- "ble/builtin/$trap_string" ;;
  esac
  return "$ext"
}
if ((_ble_bash>=40000)); then
  function ble/util/readfile { # 155ms for man bash
    local -a _ble_local_buffer=()
    mapfile _ble_local_buffer < "$2"; local _ble_local_ext=$?
    IFS= builtin eval "$1=\"\${_ble_local_buffer[*]-}\""
    return "$_ble_local_ext"
  }
  function ble/util/mapfile {
    mapfile -t "$1"
  }
else
  function ble/util/readfile { # 465ms for man bash
    [[ -r $2 && ! -d $2 ]] || return 1
    local TMOUT= 2>/dev/null # #D1630 WA readonly TMOUT
    IFS= builtin read "${_ble_bash_tmout_wa[@]}" -r -d '' "$1" < "$2"
    return 0
  }
  function ble/util/mapfile {
    local IFS= TMOUT= 2>/dev/null # #D1630 WA readonly TMOUT
    local _ble_local_i=0 _ble_local_val _ble_local_arr; _ble_local_arr=()
    while builtin read "${_ble_bash_tmout_wa[@]}" -r _ble_local_val || [[ $_ble_local_val ]]; do
      _ble_local_arr[_ble_local_i++]=$_ble_local_val
    done
    builtin eval "$1=(\"\${_ble_local_arr[@]}\")"
  }
fi
function ble/util/copyfile {
  local src=$1 dst=$2 content
  ble/util/readfile content "$1" || return $?
  ble/util/put "$content" >| "$dst"
}
function ble/util/writearray/.read-arguments {
  _ble_local_array=
  _ble_local_nlfix=
  _ble_local_delim=$'\n'
  local flags=
  while (($#)); do
    local arg=$1; shift
    if [[ $flags != *-* && $arg == -* ]]; then
      case $arg in
      (--nlfix) _ble_local_nlfix=1 ;;
      (-d)
        if (($#)); then
          _ble_local_delim=$1; shift
        else
          ble/util/print "${FUNCNAME[1]}: '$arg': missing option argument." >&2
          flags=E$flags
        fi ;;
      (--) flags=-$flags ;;
      (*)
        ble/util/print "${FUNCNAME[1]}: '$arg': unrecognized option." >&2
        flags=E$flags ;;
      esac
    else
      if local rex='^[a-zA-Z_][a-zA-Z_0-9]*$'; ! [[ $arg =~ $rex ]]; then
        ble/util/print "${FUNCNAME[1]}: '$arg': invalid array name." >&2
        flags=E$flags
      elif [[ $flags == *A* ]]; then
        ble/util/print "${FUNCNAME[1]}: '$arg': an array name has been already specified." >&2
        flags=E$flags
      else
        _ble_local_array=$arg
        flags=A$flags
      fi
    fi
  done
  [[ $_ble_local_nlfix ]] && _ble_local_delim=$'\n'
  [[ $flags != *E* ]]
}
function ble/util/writearray {
  local _ble_local_array
  local -x _ble_local_nlfix _ble_local_delim
  ble/util/writearray/.read-arguments "$@" || return 2
  local rex_dq='^"([^\\"]|\\.)*"'
  local rex_es='^\$'\''([^\\'\'']|\\.)*'\'''
  local rex_sq='^'\''([^'\'']|'\'\\\\\'\'')*'\'''
  local rex_normal='^[^[:space:]$`"'\''()|&;<>\\]' # Note: []{}?*#!~^, @(), +() は quote されていなくても OK とする
  declare -p "$_ble_local_array" | ble/bin/awk -v _ble_bash="$_ble_bash" '
    BEGIN {
      DELIM = ENVIRON["_ble_local_delim"];
      FLAG_NLFIX = ENVIRON["_ble_local_nlfix"];
      if (FLAG_NLFIX) DELIM = "\n";
      IS_GAWK = AWKTYPE == "gawk";
      IS_XPG4 = AWKTYPE == "xpg4";
      REP_SL = "\\";
      if (IS_XPG4) REP_SL = "\\\\";
      REP_DBL_SL = "\\\\";
      sub(/.*/, REP_DBL_SL, tmp);
      if (tmp == "\\") REP_DBL_SL = "\\\\\\\\";
      s2i_initialize();
      c2s_initialize();
      es_initialize();
      decl = "";
    }
    function str2rep(str) {
      if (IS_XPG4) sub(/\\/, "\\\\\\\\", str);
      return str;
    }
    function s2i_initialize() {
      for (i = 0; i < 16; i++)
        xdigit2int[sprintf("%x", i)] = i;
      for (i = 10; i < 16; i++)
        xdigit2int[sprintf("%X", i)] = i;
    }
    function s2i(s, base, _, i, n, r) {
      if (!base) base = 10;
      r = 0;
      n = length(s);
      for (i = 1; i <= n; i++)
        r = r * base + xdigit2int[substr(s, i, 1)];
      return r;
    }
    function c2s_initialize(_, i) {
      if (sprintf("%c", 945) == "α") {
        C2S_UNICODE_PRINTF_C = 1;
      } else {
        C2S_UNICODE_PRINTF_C = 0;
        for (i = 1; i <= 255; i++)
          c2s_byte2char[i] = sprintf("%c", i);
      }
    }
    function c2s(code, _, leadbyte_mark, leadbyte_sup, tail) {
      if (C2S_UNICODE_PRINTF_C)
        return sprintf("%c", code);
      leadbyte_sup = 128; # 0x80
      leadbyte_mark = 0;
      tail = "";
      while (leadbyte_sup && code >= leadbyte_sup) {
        leadbyte_sup /= 2;
        leadbyte_mark = leadbyte_mark ? leadbyte_mark / 2 : 65472; # 0xFFC0
        tail = c2s_byte2char[128 + int(code % 64)] tail;
        code = int(code / 64);
      }
      return c2s_byte2char[(leadbyte_mark + code) % 256] tail;
    }
    function es_initialize() {
      es_control_chars["a"] = "\a";
      es_control_chars["b"] = "\b";
      es_control_chars["t"] = "\t";
      es_control_chars["n"] = "\n";
      es_control_chars["v"] = "\v";
      es_control_chars["f"] = "\f";
      es_control_chars["r"] = "\r";
      es_control_chars["e"] = "\033";
      es_control_chars["E"] = "\033";
      es_control_chars["?"] = "?";
      es_control_chars["'\''"] = "'\''";
      es_control_chars["\""] = "\"";
      es_control_chars["\\"] = "\\";
      for (c = 32; c < 127; c++)
        es_s2c[sprintf("%c", c)] = c;
    }
    function es_unescape(s, _, head, c) {
      head = "";
      while (match(s, /^[^\\]*\\/)) {
        head = head substr(s, 1, RLENGTH - 1);
        s = substr(s, RLENGTH + 1);
        if ((c = es_control_chars[substr(s, 1, 1)])) {
          head = head c;
          s = substr(s, 2);
        } else if (match(s, /^[0-9]([0-9][0-9]?)?/)) {
          head = head c2s(s2i(substr(s, 1, RLENGTH), 8) % 256);
          s = substr(s, RLENGTH + 1);
        } else if (match(s, /^x[0-9a-fA-F][0-9a-fA-F]?/)) {
          head = head c2s(s2i(substr(s, 2, RLENGTH - 1), 16));
          s = substr(s, RLENGTH + 1);
        } else if (match(s, /^U[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]([0-9a-fA-F]([0-9a-fA-F][0-9a-fA-F]?)?)?/)) {
          head = head c2s(s2i(substr(s, 2, RLENGTH - 1), 16));
          s = substr(s, RLENGTH + 1);
        } else if (match(s, /^[uU][0-9a-fA-F]([0-9a-fA-F]([0-9a-fA-F][0-9a-fA-F]?)?)?/)) {
          head = head c2s(s2i(substr(s, 2, RLENGTH - 1), 16));
          s = substr(s, RLENGTH + 1);
        } else if (match(s, /^c[ -~]/)) {
          c = es_s2c[substr(s, 2, 1)];
          head = head c2s(_ble_bash >= 40400 && c == 63 ? 127 : c % 32);
          s = substr(s, 3);
        } else {
          head = head "\\";
        }
      }
      return head s;
    }
    function unquote_dq(s, _, head) {
      head = "";
      while (match(s, /^([^\\]|\\[^$`"\\])*\\[$`"\\]/)) {
        head = head substr(s, 1, RLENGTH - 2) substr(s, RLENGTH, 1);
        s = substr(s, RLENGTH + 1);
      }
      return head s;
    }
    function unquote_sq(s) {
      gsub(/'\'\\\\\'\''/, "'\''", s);
      return s;
    }
    function unquote(s, _, c) {
      c = substr(s, 1, 1);
      if (c == "\"")
        return unquote_dq(substr(s, 2, length(s) - 2));
      else if (c == "$")
        return es_unescape(substr(s, 3, length(s) - 3));
      else if (c == "'\''")
        return unquote_sq(substr(s, 2, length(s) - 2));
      else if (c == "\\")
        return substr(s, 2, 1);
      else
        return s;
    }
    function analyze_elements_dq(decl, _, arr, i, n) {
      if (decl ~ /^\[[0-9]+\]="([^'$'\1\2''"\n\\]|\\.)*"( \[[0-9]+\]="([^\1\2"\\]|\\.)*")*$/) {
        if (IS_GAWK) {
          decl = gensub(/\[[0-9]+\]="(([^"\\]|\\.)*)" ?/, "\\1\001", "g", decl);
          sub(/\001$/, "", decl);
          decl = gensub(/\\([\\$"`])/, "\\1", decl);
        } else {
          gsub(/\[[0-9]+\]="([^"\\]|\\.)*" /, "&\001", decl);
          gsub(/" \001\[[0-9]+\]="/, "\001", decl);
          sub(/^\[[0-9]+\]="/, "", decl);
          sub(/"$/, "", decl);
          gsub(/\\\\/, "\002", decl);
          gsub(/\\\$/, "$", decl);
          gsub(/\\"/, "\"", decl);
          gsub(/\\`/, "`", decl);
          gsub(/\002/, REP_SL, decl);
        }
        if (DELIM != "") {
          gsub(/\001/, str2rep(DELIM), decl);
          printf("%s", decl DELIM);
        } else {
          n = split(decl, arr, /\001/);
          for (i = 1; i <= n; i++)
            printf("%s%c", arr[i], 0);
        }
        if (FLAG_NLFIX) printf("\n");
        return 1;
      }
      return 0;
    }
    function analyze_elements_general(decl, _, arr, i, n, nlfix_indices) {
      n = split(decl, arr, / /);
      nlfix_indices = "";
      for (i = 1; i <= n; i++) {
        elem = arr[i];
        sub(/^\[[0-9]+\]=/, "", elem);
        line = "";
        while (1) {
          if (match(elem, /'"$rex_dq"'|'"$rex_es"'|'"$rex_sq"'|'"$rex_normal"'|^\\./)) {
            mlen = RLENGTH;
            line = line unquote(substr(elem, 1, mlen));
            elem = substr(elem, mlen + 1);
          } else if (elem ~ /^[$"'\''\\]/ && i + 1 <= n) {
            elem = elem " " arr[++i];
          } else {
            break;
          }
        }
        if (FLAG_NLFIX) {
          if (line ~ /\n/) {
            gsub(/\\/, REP_DBL_SL, line);
            gsub(/'\''/, REP_SL "'\''", line);
            gsub(/\a/, REP_SL "a", line);
            gsub(/\b/, REP_SL "b", line);
            gsub(/\t/, REP_SL "t", line);
            gsub(/\n/, REP_SL "n", line);
            gsub(/\v/, REP_SL "v", line);
            gsub(/\f/, REP_SL "f", line);
            gsub(/\r/, REP_SL "r", line);
            printf("$'\''%s'\''\n", line);
            nlfix_indices = nlfix_indices != "" ? nlfix_indices " " (i - 1) : (i - 1);
          } else {
            printf("%s\n", line);
          }
        } else if (DELIM != "") {
          printf("%s", line DELIM);
        } else {
          printf("%s%c", line, 0);
        }
      }
      if (FLAG_NLFIX)
        printf("%s\n", nlfix_indices);
      return 1;
    }
    function process_declaration(decl, _, mlen, line) {
      sub(/^declare +(-[-aAilucnrtxfFgGI]+ +)?(-- +)?/, "", decl);
      if (decl ~ /^([_a-zA-Z][_a-zA-Z0-9]*)='\''\(.*\)'\''$/) {
        sub(/='\''\(/, "=(", decl);
        sub(/\)'\''$/, ")", decl);
        gsub(/'\'\\\\\'\''/, "'\''", decl);
      }
      if (_ble_bash < 30100) gsub(/\\\n/, "\n", decl);
      if (_ble_bash < 40400) {
        gsub(/\001\001/, "\001", decl);
        gsub(/\001\177/, "\177", decl);
      }
      sub(/^([_a-zA-Z][_a-zA-Z0-9]*)=\([[:space:]]*/, "", decl);
      sub(/[[:space:]]*\)[[:space:]]*$/, "", decl);
      if (decl == "") return 1;
      if (AWKTYPE != "mawk" && analyze_elements_dq(decl)) return 1;
      return analyze_elements_general(decl);
    }
    { decl = decl ? decl "\n" $0: $0; }
    END { process_declaration(decl); }
  '
}
function ble/util/readarray {
  local _ble_local_array
  local -x _ble_local_nlfix _ble_local_delim
  ble/util/writearray/.read-arguments "$@" || return 2
  if ((_ble_bash>=40400)); then
    local _ble_local_script='
      mapfile -t -d "$_ble_local_delim" ARR'
  elif ((_ble_bash>=40000)) && [[ $_ble_local_delim == $'\n' ]]; then
    local _ble_local_script='
      mapfile -t ARR'
  else
    local _ble_local_script='
      local IFS= ARRI=0; ARR=()
      while builtin read -r -d "" "ARR[ARRI++]"; do :; done'
  fi
  if [[ $_ble_local_nlfix ]]; then
    _ble_local_script=$_ble_local_script'
      local ARRN=${#ARR[@]} ARRF ARRI
      if ((ARRN--)); then
        ble/string#split-words ARRF "${ARR[ARRN]}"
        builtin unset -v "ARR[ARRN]"
        for ARRI in "${ARRF[@]}"; do
          builtin eval -- "ARR[ARRI]=${ARR[ARRI]}"
        done
      fi'
  fi
  builtin eval -- "${_ble_local_script//ARR/$_ble_local_array}"
}
_ble_util_assign_base=$_ble_base_run/$$.util.assign.tmp
_ble_util_assign_level=0
if ((_ble_bash>=40000)); then
  function ble/util/assign/.mktmp {
    _ble_local_tmpfile=$_ble_util_assign_base.$((_ble_util_assign_level++))
    ((BASH_SUBSHELL)) && _ble_local_tmpfile=$_ble_local_tmpfile.$BASHPID
  }
else
  function ble/util/assign/.mktmp {
    _ble_local_tmpfile=$_ble_util_assign_base.$((_ble_util_assign_level++))
    ((BASH_SUBSHELL)) && _ble_local_tmpfile=$_ble_local_tmpfile.$RANDOM
  }
fi
function ble/util/assign/.rmtmp {
  ((_ble_util_assign_level--))
  if ((BASH_SUBSHELL)); then
    printf 'caller %s\n' "${FUNCNAME[@]}" >| "$_ble_local_tmpfile"
  else
    : >| "$_ble_local_tmpfile"
  fi
}
if ((_ble_bash>=40000)); then
  function ble/util/assign {
    local _ble_local_tmpfile; ble/util/assign/.mktmp
    builtin eval -- "$2" >| "$_ble_local_tmpfile"
    local _ble_local_ret=$? _ble_local_arr=
    mapfile -t _ble_local_arr < "$_ble_local_tmpfile"
    ble/util/assign/.rmtmp
    IFS=$'\n' builtin eval "$1=\"\${_ble_local_arr[*]}\""
    return "$_ble_local_ret"
  }
else
  function ble/util/assign {
    local _ble_local_tmpfile; ble/util/assign/.mktmp
    builtin eval -- "$2" >| "$_ble_local_tmpfile"
    local _ble_local_ret=$? TMOUT= 2>/dev/null # #D1630 WA readonly TMOUT
    IFS= builtin read "${_ble_bash_tmout_wa[@]}" -r -d '' "$1" < "$_ble_local_tmpfile"
    ble/util/assign/.rmtmp
    builtin eval "$1=\${$1%$_ble_term_nl}"
    return "$_ble_local_ret"
  }
fi
if ((_ble_bash>=40000)); then
  function ble/util/assign-array {
    local _ble_local_tmpfile; ble/util/assign/.mktmp
    builtin eval -- "$2" >| "$_ble_local_tmpfile"
    local _ble_local_ret=$?
    mapfile -t "$1" < "$_ble_local_tmpfile"
    ble/util/assign/.rmtmp
    return "$_ble_local_ret"
  }
else
  function ble/util/assign-array {
    local _ble_local_tmpfile; ble/util/assign/.mktmp
    builtin eval -- "$2" >| "$_ble_local_tmpfile"
    local _ble_local_ret=$?
    ble/util/mapfile "$1" < "$_ble_local_tmpfile"
    ble/util/assign/.rmtmp
    return "$_ble_local_ret"
  }
fi
if ! ((_ble_bash>=40400)); then
  function ble/util/assign-array0 {
    local _ble_local_tmpfile; ble/util/assign/.mktmp
    builtin eval -- "$2" >| "$_ble_local_tmpfile"
    local _ble_local_ret=$?
    mapfile -d '' -t "$1" < "$_ble_local_tmpfile"
    ble/util/assign/.rmtmp
    return "$_ble_local_ret"
  }
else
  function ble/util/assign-array0 {
    local _ble_local_tmpfile; ble/util/assign/.mktmp
    builtin eval -- "$2" >| "$_ble_local_tmpfile"
    local _ble_local_ret=$?
    local IFS= i=0 _ble_local_arr
    while builtin read -r -d '' "_ble_local_arr[i++]"; do :; done < "$_ble_local_tmpfile"
    ble/util/assign/.rmtmp
    [[ ${_ble_local_arr[--i]} ]] || builtin unset -v "_ble_local_arr[i]"
    ble/util/unlocal i IFS
    builtin eval "$1=(\"\${_ble_local_arr[@]}\")"
    return "$_ble_local_ret"
  }
fi
function ble/util/assign.has-output {
  local _ble_local_tmpfile; ble/util/assign/.mktmp
  builtin eval -- "$1" >| "$_ble_local_tmpfile"
  [[ -s $_ble_local_tmpfile ]]
  local _ble_local_ret=$?
  ble/util/assign/.rmtmp
  return "$_ble_local_ret"
}
ble/bin/awk/.instantiate
if ((_ble_bash>=30200)); then
  function ble/is-function {
    declare -F "$1" &>/dev/null
  }
else
  function ble/is-function {
    local type
    ble/util/type type "$1"
    [[ $type == function ]]
  }
fi
if ((_ble_bash>=30200)); then
  function ble/function#getdef {
    local name=$1
    ble/is-function "$name" || return 1
    if [[ -o posix ]]; then
      ble/util/assign def 'type "$name"'
      def=${def#*$'\n'}
    else
      ble/util/assign def 'declare -f "$name"'
    fi
  }
else
  function ble/function#getdef {
    local name=$1
    ble/is-function "$name" || return 1
    ble/util/assign def 'type "$name"'
    def=${def#*$'\n'}
  }
fi
function ble/function#evaldef {
  local reset_extglob=
  if ! shopt -q extglob; then
    reset_extglob=1
    shopt -s extglob
  fi
  builtin eval -- "$1"; local ext=$?
  [[ $reset_extglob ]] && shopt -u extglob
  return "$ext"
}
builtin eval -- "${_ble_util_gdict_declare//NAME/_ble_util_function_traced}"
function ble/function#trace {
  declare -ft "$1" &>/dev/null &&
    ble/gdict#set _ble_util_function_traced "$1" 1
}
function ble/function#has-trace {
  ble/gdict#has _ble_util_function_traced "$1"
}
function ble/function/is-global-trace-context {
  local func depth=1 ndepth=${#FUNCNAME[*]}
  for func in "${FUNCNAME[@]:1}"; do
    local src=${BASH_SOURCE[depth]}
    [[ $- == *T* && ( $func == ble || $func == ble[-/]* || $func == source && $src == "$_ble_base_blesh_raw" ) ]] ||
      [[ $func == source && depth -eq ndepth-1 && BASH_LINENO[depth] -eq 0 && ( ${src##*/} == .bashrc || ${src##*/} == .bash_profile || ${src##*/} == .profile ) ]] ||
      ble/gdict#has _ble_util_function_traced "$func" || return 1
    ((depth++))
  done
  return 0
}
function ble/function#try {
  local lastexit=$?
  ble/is-function "$1" || return 127
  ble/util/setexit "$lastexit"
  "$@"
}
function ble/function#get-source-and-lineno {
  local ret unset_extdebug=
  shopt -q extdebug || { unset_extdebug=1; shopt -s extdebug; }
  ble/util/assign ret "declare -F '$1' 2>/dev/null"; local ext=$?
  [[ ! $unset_extdebug ]] || shopt -u extdebug
  if ((ext==0)); then
    ret=${ret#*' '}
    lineno=${ret%%' '*}
    source=${ret#*' '}
    [[ $lineno && ! ${lineno//[0-9]} && $source ]] || return 1
  fi
  return "$ext"
}
function ble/function#advice/do {
  ble/function#advice/original:"${ADVICE_WORDS[@]}"
  ADVICE_EXIT=$?
}
function ble/function#advice/.proc {
  local ADVICE_WORDS ADVICE_EXIT=127
  ADVICE_WORDS=("$@")
  ble/function#try "ble/function#advice/before:$1"
  if ble/is-function "ble/function#advice/around:$1"; then
    "ble/function#advice/around:$1"
  else
    ble/function#advice/do
  fi
  ble/function#try "ble/function#advice/after:$1"
  return "$ADVICE_EXIT"
}
function ble/function#advice {
  local type=$1 name=$2 proc=$3
  if ! ble/is-function "$name"; then
    local t=; ble/util/type t "$name"
    case $t in
    (builtin|file) builtin eval "function $name { : ZBe85Oe28nBdg; command $name \"\$@\"; }" ;;
    (*)
      ble/util/print "ble/function#advice: $name is not a function." >&2
      return 1 ;;
    esac
  fi
  local def; ble/function#getdef "$name"
  case $type in
  (remove)
    if [[ $def == *'ble/function#advice/.proc'* ]]; then
      ble/function#getdef "ble/function#advice/original:$name"
      if [[ $def ]]; then
        if [[ $def == *ZBe85Oe28nBdg* ]]; then
          builtin unset -f "$name"
        else
          ble/function#evaldef "${def#*:}"
        fi
      fi
    fi
    builtin unset -f ble/function#advice/{before,after,around,original}:"$name" 2>/dev/null
    return 0 ;;
  (before|after|around)
    if [[ $def != *'ble/function#advice/.proc'* ]]; then
      ble/function#evaldef "ble/function#advice/original:$def"
      builtin eval "function $name { ble/function#advice/.proc \"\${FUNCNAME#*:}\" \"\$@\"; }"
    fi
    local q=\' Q="'\''"
    builtin eval "ble/function#advice/$type:$name() { builtin eval '${proc//$q/$Q}'; }"
    return 0 ;;
  (*)
    ble/util/print "ble/function#advice unknown advice type '$type'" >&2
    return 2 ;;
  esac
}
function ble/function#push {
  local name=$1 proc=$2
  if ble/is-function "$name"; then
    local index=0
    while ble/is-function "ble/function#push/$index:$name"; do
      ((index++))
    done
    local def; ble/function#getdef "$name"
    ble/function#evaldef "ble/function#push/$index:$def"
  fi
  if [[ $proc ]]; then
    local q=\' Q="'\''"
    builtin eval "function $name { builtin eval -- '${proc//$q/$Q}'; }"
  else
    builtin unset -f "$name"
  fi
  return 0
}
function ble/function#pop {
  local name=$1 proc=$2
  local index=-1
  while ble/is-function "ble/function#push/$((index+1)):$name"; do
    ((index++))
  done
  if ((index<0)); then
    if ble/is-function "$name"; then
      builtin unset -f "$name"
      return 0
    else
      ble/util/print "ble/function#push: $name is not a function." >&2
      return 1
    fi
  else
    local def; ble/function#getdef "ble/function#push/$index:$name"
    ble/function#evaldef "${def#*:}"
    builtin unset -f "ble/function#push/$index:$name"
    return 0
  fi
}
function ble/function#push/call-top {
  local func=${FUNCNAME[1]}
  if ! ble/is-function "$func"; then
    ble/util/print "ble/function#push/call-top: This function should be called from a function" >&2
    return 1
  fi
  local index=0
  if [[ $func == ble/function#push/?*:?* ]]; then
    index=${func#*/*/}; index=${index%%:*}
    func=${func#*:}
  else
    while ble/is-function "ble/function#push/$index:$func"; do ((index++)); done
  fi
  if ((index==0)); then
    command "$func" "$@"
  else
    "ble/function#push/$((index-1)):$func" "$@"
  fi
}
: "${_ble_util_lambda_count:=0}"
function ble/function#lambda {
  local _ble_local_q=\' _ble_local_Q="'\''"
  ble/util/set "$1" ble/function#lambda/$((_ble_util_lambda_count++))
  builtin eval -- "function ${!1} { builtin eval -- '${2//$_ble_local_q/$_ble_local_Q}'; }"
}
function ble/function#suppress-stderr {
  local name=$1
  if ! ble/is-function "$name"; then
    ble/util/print "$FUNCNAME: '$name' is not a function name" >&2
    return 2
  fi
  local lambda=ble/function#suppress-stderr:$name
  if ! ble/is-function "$lambda"; then
    local def; ble/function#getdef "$name"
    ble/function#evaldef "ble/function#suppress-stderr:$def"
  fi
  builtin eval "function $name { $lambda \"\$@\" 2>/dev/null; }"
  return 0
}
if ((_ble_bash>=40100)); then
  function ble/util/set {
    builtin printf -v "$1" %s "$2"
  }
else
  function ble/util/set {
    builtin eval -- "$1=\"\$2\""
  }
fi
if ((_ble_bash>=30100)); then
  function ble/util/sprintf {
    builtin printf -v "$@"
  }
else
  function ble/util/sprintf {
    local -a args; args=("${@:2}")
    ble/util/assign "$1" 'builtin printf "${args[@]}"'
  }
fi
function ble/util/type {
  ble/util/assign-array "$1" 'builtin type -a -t -- "$3" 2>/dev/null' "$2"; local ext=$?
  return "$ext"
}
if ((_ble_bash>=40000)); then
  function ble/is-alias {
    [[ ${BASH_ALIASES[$1]+set} ]]
  }
  function ble/alias#active {
    shopt -q expand_aliases &&
      [[ ${BASH_ALIASES[$1]+set} ]]
  }
  function ble/alias#expand {
    ret=$1
    shopt -q expand_aliases &&
      ret=${BASH_ALIASES[$ret]-$ret}
  }
  function ble/alias/list {
    ret=("${!BASH_ALIASES[@]}")
  }
else
  function ble/is-alias {
    [[ $1 != *=* ]] && alias "$1" &>/dev/null
  }
  function ble/alias#active {
    shopt -q expand_aliases &&
      [[ $1 != *=* ]] && alias "$1" &>/dev/null
  }
  function ble/alias#expand {
    ret=$1
    local type; ble/util/type type "$ret"
    [[ $type != alias ]] && return 1
    local data; ble/util/assign data 'LC_ALL=C alias "$ret"' &>/dev/null
    [[ $data == 'alias '*=* ]] && builtin eval "ret=${data#alias *=}"
  }
  function ble/alias/list {
    ret=()
    local data iret=0
    ble/util/assign-array data 'alias -p'
    for data in "${data[@]}"; do
      [[ $data == 'alias '*=* ]] &&
        data=${data%%=*} &&
        builtin eval "ret[iret++]=${data#alias }"
    done
  }
fi
if ((_ble_bash>=40000)); then
  function ble/util/is-stdin-ready {
    local IFS= LC_ALL= LC_CTYPE=C
    builtin read -t 0
  }
  ble/function#suppress-stderr ble/util/is-stdin-ready
else
  function ble/util/is-stdin-ready { false; }
fi
if ((_ble_bash>=40000)); then
  function ble/util/getpid { :; }
  function ble/util/is-running-in-subshell { [[ $$ != $BASHPID ]]; }
else
  function ble/util/getpid {
    local command='echo $PPID'
    ble/util/assign BASHPID 'ble/bin/sh -c "$command"'
  }
  function ble/util/is-running-in-subshell {
    ((BASH_SUBSHELL==0)) || return 0
    local BASHPID; ble/util/getpid
    [[ $$ != $BASHPID ]]
  }
fi
function ble/fd#is-open { : >&"$1"; } 2>/dev/null
_ble_util_openat_nextfd=
function ble/fd#alloc/.nextfd {
  [[ $_ble_util_openat_nextfd ]] ||
    _ble_util_openat_nextfd=$bleopt_openat_base
  while ble/fd#is-open "$_ble_util_openat_nextfd"; do
    ((_ble_util_openat_nextfd++))
  done
  (($1=_ble_util_openat_nextfd++))
}
_ble_util_openat_fdlist=()
function ble/fd#alloc {
  local _ble_local_preserve=
  if [[ :$3: == *:inherit:* ]]; then
    [[ ${!1-} ]] &&
      ble/fd#is-open "${!1}" &&
      return 0
  fi
  if [[ :$3: == *:share:* ]]; then
    local _ble_local_ret='[<>]&['$_ble_term_IFS']*([0-9]+)['$_ble_term_IFS']*$'
    if [[ $2 =~ $rex ]]; then
      builtin eval -- "$1=${BASH_REMATCH[1]}"
      return 0
    fi
  fi
  if [[ ${!1-} && :$3: == *:overwrite:* ]]; then
    _ble_local_preserve=1
    builtin eval "exec ${!1}$2"
  elif ((_ble_bash>=40100)) && [[ :$3: != *:base:* ]]; then
    builtin eval "exec {$1}$2"
  else
    ble/fd#alloc/.nextfd "$1"
    builtin eval "exec ${!1}>&- ${!1}$2"
  fi; local _ble_local_ext=$?
  if [[ :$3: == *:inherit:* || :$3: == *:export:* ]]; then
    export "$1"
  elif [[ ! $_ble_local_preserve ]]; then
    ble/array#push _ble_util_openat_fdlist "${!1}"
  fi
  return "$_ble_local_ext"
}
function ble/fd#finalize {
  local fd
  for fd in "${_ble_util_openat_fdlist[@]}"; do
    builtin eval "exec $fd>&-"
  done
  _ble_util_openat_fdlist=()
}
function ble/fd#close {
  set -- $(($1))
  (($1>=3)) || return 1
  builtin eval "exec $1>&-"
  ble/array#remove _ble_util_openat_fdlist "$1"
  return 0
}
if [[ $_ble_init_command ]]; then
  _ble_util_fd_stdin=0
  _ble_util_fd_stdout=1
  _ble_util_fd_stderr=2
else
  if [[ -t 0 ]]; then
    ble/fd#alloc _ble_util_fd_stdin '<&0' base:overwrite:export
  else
    ble/fd#alloc _ble_util_fd_stdin '< /dev/tty' base:inherit
  fi
  if [[ -t 1 ]]; then
    ble/fd#alloc _ble_util_fd_stdout '>&1' base:overwrite:export
  else
    ble/fd#alloc _ble_util_fd_stdout '> /dev/tty' base:inherit
  fi
  if [[ -t 2 ]]; then
    ble/fd#alloc _ble_util_fd_stderr '>&2' base:overwrite:export
  else
    ble/fd#alloc _ble_util_fd_stderr ">&$_ble_util_fd_stdout" base:inherit:share
  fi
fi
ble/fd#alloc _ble_util_fd_null '<> /dev/null' base:inherit
[[ -c /dev/zero ]] &&
  ble/fd#alloc _ble_util_fd_zero '< /dev/zero' base:inherit
function ble/util/print-quoted-command {
  local ret; ble/string#quote-command "$@"
  ble/util/print "$ret"
}
function ble/util/declare-print-definitions {
  (($#==0)) && return 0
  declare -p "$@" | ble/bin/awk -v _ble_bash="$_ble_bash" -v OSTYPE="$OSTYPE" '
    BEGIN {
      decl = "";
      flag_escape_cr = OSTYPE == "msys";
    }
    function fix_value(value) {
      if (_ble_bash < 30100) gsub(/\\\n/, "\n", value);
      if (_ble_bash < 30100) {
        gsub(/\001\001/, "\"\"${_ble_term_SOH}\"\"", value);
        gsub(/\001\177/, "\"\"${_ble_term_DEL}\"\"", value);
      } else if (_ble_bash < 40400) {
        gsub(/\001\001/, "${_ble_term_SOH}", value);
        gsub(/\001\177/, "${_ble_term_DEL}", value);
      }
      if (flag_escape_cr)
        gsub(/\015/, "${_ble_term_CR}", value);
      return value;
    }
    function print_array_elements(decl, _, name, out, key, value) {
      if (match(decl, /^[_a-zA-Z][_a-zA-Z0-9]*=\(/) == 0) return 0;
      name = substr(decl, 1, RLENGTH - 2);
      decl = substr(decl, RLENGTH + 1, length(decl) - RLENGTH - 1);
      sub(/^[[:space:]]+/, decl);
      out = name "=()\n";
      while (match(decl, /^\[[0-9]+\]=/)) {
        key = substr(decl, 2, RLENGTH - 3);
        decl = substr(decl, RLENGTH + 1);
        value = "";
        if (match(decl, /^('\''[^'\'']*'\''|\$'\''([^\\'\'']|\\.)*'\''|\$?"([^\\"]|\\.)*"|\\.|[^[:space:]"'\''`;&|()])*/)) {
          value = substr(decl, 1, RLENGTH)
          decl = substr(decl, RLENGTH + 1)
        }
        out = out name "[" key "]=" fix_value(value) "\n";
        sub(/^[[:space:]]+/, decl);
      }
      if (decl != "") return 0;
      print out;
      return 1;
    }
    function declflush(_, isArray) {
      if (!decl) return 0;
      isArray = (decl ~ /^declare +-[ilucnrtxfFgGI]*[aA]/);
      sub(/^declare +(-[-aAilucnrtxfFgGI]+ +)?(-- +)?/, "", decl);
      if (isArray) {
        if (decl ~ /^([_a-zA-Z][_a-zA-Z0-9]*)='\''\(.*\)'\''$/) {
          sub(/='\''\(/, "=(", decl);
          sub(/\)'\''$/, ")", decl);
          gsub(/'\'\\\\\'\''/, "'\''", decl);
        }
        if (_ble_bash < 40000 && decl ~ /[\001\177]/)
          if (print_array_elements(decl))
            return 1;
      }
      print fix_value(decl);
      decl = "";
      return 1;
    }
    /^declare / {
      declflush();
      decl = $0;
      next;
    }
    { decl = decl "\n" $0; }
    END { declflush(); }
  '
}
function ble/util/print-global-definitions/.save-decl {
  local __ble_name=$1
  if [[ ! ${!__ble_name+set} ]]; then
    __ble_decl="declare $__ble_name; builtin unset -v $__ble_name"
  elif ble/variable#has-attr "$__ble_name" aA; then
    if ((_ble_bash>=40000)); then
      ble/util/assign __ble_decl "declare -p $__ble_name" 2>/dev/null
      __ble_decl=${__ble_decl#declare -* }
    else
      ble/util/assign __ble_decl "ble/util/declare-print-definitions $__ble_name" 2>/dev/null
    fi
    if ble/is-array "$__ble_name"; then
      __ble_decl="declare -a $__ble_decl"
    else
      __ble_decl="declare -A $__ble_decl"
    fi
  else
    __ble_decl=${!__ble_name}
    __ble_decl="declare $__ble_name='${__ble_decl//$__ble_q/$__ble_Q}'"
  fi
}
function ble/util/print-global-definitions {
  local __ble_hidden_only=
  [[ $1 == --hidden-only ]] && { __ble_hidden_only=1; shift; }
  (
    ((_ble_bash>=50000)) && shopt -u localvar_unset
    __ble_error=
    __ble_q="'" __ble_Q="'\''"
    __ble_MaxLoop=20
    for __ble_name; do
      [[ ${__ble_name//[0-9a-zA-Z_]} || $__ble_name == __ble_* ]] && continue
      ((__ble_processed_$__ble_name)) && continue
      ((__ble_processed_$__ble_name=1))
      [[ $__ble_name == __ble_* ]] && continue
      __ble_decl=
      if ((_ble_bash>=40200)); then
        declare -g -r "$__ble_name"
        for ((__ble_i=0;__ble_i<__ble_MaxLoop;__ble_i++)); do
          if ! builtin unset -v "$__ble_name"; then
            ble/variable#is-global "$__ble_name" &&
              ble/util/print-global-definitions/.save-decl "$__ble_name"
            break
          fi
        done
      else
        for ((__ble_i=0;__ble_i<__ble_MaxLoop;__ble_i++)); do
          if ble/variable#is-global "$__ble_name"; then
            ble/util/print-global-definitions/.save-decl "$__ble_name"
            break
          fi
          builtin unset -v "$__ble_name" || break
        done
      fi
      [[ $__ble_decl ]] ||
        __ble_error=1 __ble_decl="declare $__ble_name; builtin unset -v $__ble_name" # not found
      [[ $__ble_hidden_only && $__ble_i == 0 ]] && continue
      ble/util/print "$__ble_decl"
    done
    [[ ! $__ble_error ]]
  ) 2>/dev/null
}
function ble/util/has-glob-pattern {
  [[ $1 ]] || return 1
  local restore=:
  if ! shopt -q nullglob 2>/dev/null; then
    restore="$restore;shopt -u nullglob"
    shopt -s nullglob
  fi
  if shopt -q failglob 2>/dev/null; then
    restore="$restore;shopt -s failglob"
    shopt -u failglob
  fi
  local dummy=$_ble_base_run/$$.dummy ret
  builtin eval "ret=(\"\$dummy\"/${1#/})" 2>/dev/null
  builtin eval -- "$restore"
  [[ ! $ret ]]
}
function ble/util/is-cygwin-slow-glob {
  [[ ( $OSTYPE == cygwin || $OSTYPE == msys ) && ${1#\'} == //* && ! -o noglob ]] &&
    ble/util/has-glob-pattern "$1"
}
function ble/util/eval-pathname-expansion {
  ret=()
  if ble/util/is-cygwin-slow-glob; then # Note: #D1168
    if shopt -q failglob &>/dev/null; then
      return 1
    elif shopt -q nullglob &>/dev/null; then
      return 0
    else
      set -f
      ble/util/eval-pathname-expansion "$1"; local ext=$1
      set +f
      return "$ext"
    fi
  fi
  local canon=
  if [[ :$2: == *:canonical:* ]]; then
    canon=1
    local set=$- shopt=$BASHOPTS gignore=$GLOBIGNORE
    shopt -u failglob
    shopt -s nullglob
    shopt -s extglob
    set +f
    GLOBIGNORE=
  fi
  builtin eval "ret=($1)" 2>/dev/null; local ext=$?
  if [[ $canon ]]; then
    GLOBIGNORE=$gignore
    if [[ :$shopt: == *:dotglob:* ]]; then shopt -s dotglob; else shopt -u dotglob; fi
    [[ $set == *f* ]] && set -f
    [[ :$shopt: != *:extglob:* ]] && shopt -u extglob
    [[ :$shopt: != *:nullglob:* ]] && shopt -u nullglob
    [[ :$shopt: == *:failglob:* ]] && shopt -s failglob
  fi
  return "$ext"
}
_ble_util_rex_isprint='^[ -~]+'
function ble/util/isprint+ {
  local LC_ALL= LC_COLLATE=C
  [[ $1 =~ $_ble_util_rex_isprint ]]
}
ble/function#suppress-stderr ble/util/isprint+
if ((_ble_bash>=40200)); then
  function ble/util/strftime {
    if [[ $1 = -v ]]; then
      builtin printf -v "$2" "%($3)T" "${4:--1}"
    else
      builtin printf "%($1)T" "${2:--1}"
    fi
  }
else
  function ble/util/strftime {
    if [[ $1 = -v ]]; then
      local fmt=$3 time=$4
      ble/util/assign "$2" 'ble/bin/date +"$fmt" $time'
    else
      ble/bin/date +"$1" $2
    fi
  }
fi
if ! type ble/util/print &>/dev/null; then
  function ble/util/unlocal { builtin unset -v "$@"; }
  function ble/util/print { builtin printf '%s\n' "$1"; }
  function ble/util/print-lines { builtin printf '%s\n' "$@"; }
fi
function ble-measure/.loop {
  builtin eval "function _target { ${2:+$2; }return 0; }"
  local _i _n=$1
  for ((_i=0;_i<_n;_i++)); do
    _target
  done
}
if [[ ${ZSH_VERSION-} ]]; then
  _ble_measure_resolution=1000 # [usec]
  function ble-measure/.time {
    local result
    result=$({ time ( ble-measure/.loop "$n" "$1" ; ) } 2>&1 )
    result=${result##*cpu }
    local rex='(([0-9]+):)?([0-9]+)\.([0-9]+) total$'
    if [[ $result =~ $rex ]]; then
      if [[ -o KSH_ARRAYS ]]; then
        local m=${match[1]} s=${match[2]} ms=${match[3]}
      else
        local m=${match[1]} s=${match[2]} ms=${match[3]}
      fi
      m=${m:-0} ms=${ms}000; ms=${ms:0:3}
      ((utot=((10#0$m*60+10#0$s)*1000+10#0$ms)*1000,
        usec=utot/n))
      return 0
    else
      builtin echo "ble-measure: failed to read the result of \`time': $result." >&2
      utot=0 usec=0
      return 1
    fi
  }
elif ((BASH_VERSINFO[0]>=5)); then
  _ble_measure_resolution=1 # [usec]
  function ble-measure/.get-realtime {
    local LC_ALL= LC_NUMERIC=C
    time=$EPOCHREALTIME
  }
  function ble-measure/.time {
    local command=$1
    local time
    ble-measure/.get-realtime 2>/dev/null; local time1=${time//.}
    ble-measure/.loop "$n" "$command" &>/dev/null
    ble-measure/.get-realtime 2>/dev/null; local time2=${time//.}
    ((utot=time2-time1,usec=utot/n))
    ((utot>0))
  }
else
  _ble_measure_resolution=1000 # [usec]
  function ble-measure/.time {
    utot=0 usec=0
    local result TIMEFORMAT='[%R]' command=$1
    if declare -f ble/util/assign &>/dev/null; then
      ble/util/assign result '{ time ble-measure/.loop "$n" "$command" &>/dev/null;} 2>&1'
    else
      result=$({ time ble-measure/.loop "$n" "$1" &>/dev/null;} 2>&1)
    fi
    local rex='\[([0-9]+)(\.([0-9]+))?\]'
    [[ $result =~  $rex ]] || return 1
    local s=${BASH_REMATCH[1]}
    local ms=${BASH_REMATCH[3]}000; ms=${ms::3}
    ((utot=(10#0$s*1000+10#0$ms)*1000,usec=utot1/n))
    return 0
  }
fi
_ble_measure_base= # [nsec]
_ble_measure_base_real=()
_ble_measure_base_nestcost=0 # [nsec/10]
_ble_measure_count=1 # 同じ倍率で _ble_measure_count 回計測して最小を取る。
_ble_measure_threshold=100000 # 一回の計測が threshold [usec] 以上になるようにする
function ble-measure/calibrate.0 { ble-measure -qc"$calibrate_count" ''; }
function ble-measure/calibrate.1 { ble-measure/calibrate.0; }
function ble-measure/calibrate.2 { ble-measure/calibrate.1; }
function ble-measure/calibrate.3 { ble-measure/calibrate.2; }
function ble-measure/calibrate.4 { ble-measure/calibrate.3; }
function ble-measure/calibrate.5 { ble-measure/calibrate.4; }
function ble-measure/calibrate.6 { ble-measure/calibrate.5; }
function ble-measure/calibrate.7 { ble-measure/calibrate.6; }
function ble-measure/calibrate.8 { ble-measure/calibrate.7; }
function ble-measure/calibrate.9 { ble-measure/calibrate.8; }
function ble-measure/calibrate.A { ble-measure/calibrate.9; }
function ble-measure/calibrate {
  local ret nsec
  local calibrate_count=1
  _ble_measure_base=0
  _ble_measure_base_nestcost=0
  local nest0=$((${#FUNCNAME[@]}+2))
  ble-measure/calibrate.0; local x0=$nsec
  ble-measure/calibrate.A; local xA=$nsec
  local nest_cost=$((xA-x0))
  _ble_measure_base=$((x0-nest_cost*nest0/10))
  _ble_measure_base_nestcost=$nest_cost
}
function ble-measure/fit {
  local ret nsec
  _ble_measure_base=0
  _ble_measure_base_nestcost=0
  local calibrate_count=10
  local c nest_level=${#FUNCNAME[@]}
  for c in {0..9} A; do
    "ble-measure/calibrate.$c"
    ble/util/print "$((nest_level++)) $nsec"
  done > a.txt
  gnuplot - <<EOF
f(x) = a * x + b
b=4500;a=100
fit f(x) 'a.txt' via a,b
EOF
}
function ble-measure/.read-arguments.get-optarg {
  if ((i+1<${#arg})); then
    optarg=${arg:i+1}
    i=${#arg}
    return 0
  elif ((iarg<${#args[@]})); then
    optarg=${args[iarg++]}
    return 0
  else
    ble/util/print "ble-measure: missing option argument for '-$c'."
    flags=E$flags
    return 1
  fi
}
function ble-measure/.read-arguments {
  local -a args; args=("$@")
  local iarg=0 optarg=
  while [[ ${args[iarg]} == -* ]]; do
    local arg=${args[iarg++]}
    case $arg in
    (--) break ;;
    (--help) flags=h$flags ;;
    (--*)
      ble/util/print "ble-measure: unrecognized option '$arg'."
      flags=E$flags ;;
    (-?*)
      local i c
      for ((i=1;i<${#arg};i++)); do
        c=${arg:i:1}
        case $c in
        (q) flags=q$flags ;;
        ([ca])
          [[ $c == a ]] && flags=a$flags
          ble-measure/.read-arguments.get-optarg && count=$optarg ;;
        (T)
          ble-measure/.read-arguments.get-optarg &&
            measure_threshold=$optarg ;;
        (B)
          ble-measure/.read-arguments.get-optarg &&
            __base=$optarg ;;
        (*)
          ble/util/print "ble-measure: unrecognized option '-$c'."
          flags=E$flags ;;
        esac
      done ;;
    (-)
      ble/util/print "ble-measure: unrecognized option '$arg'."
      flags=E$flags ;;
    esac
  done
  local IFS=$' \t\n'
  command="${args[*]:iarg}"
  [[ $flags != *E* ]]
}
function ble-measure {
  local __level=${#FUNCNAME[@]} __base=
  local flags= command= count=$_ble_measure_count
  local measure_threshold=$_ble_measure_threshold
  ble-measure/.read-arguments "$@" || return "$?"
  if [[ $flags == *h* ]]; then
    ble/util/print-lines \
      'usage: ble-measure [-q|-ac COUNT|-TB TIME] [--] COMMAND' \
      '    Measure the time of command.' \
      '' \
      '  Options:' \
      '    -q        Do not print results to stdout.' \
      '    -a COUNT  Measure COUNT times and average.' \
      '    -c COUNT  Measure COUNT times and take minimum.' \
      '    -T TIME   Set minimal measuring time.' \
      '    -B BASE   Set base time (overhead of ble-measure).' \
      '    --        The rest arguments are treated as command.' \
      '    --help    Print this help.' \
      '' \
      '  Arguments:' \
      '    COMMAND   Command to be executed repeatedly.' \
      '' \
      '  Exit status:' \
      '    Returns 1 for the failure in measuring the time.  Returns 2 after printing' \
      '    help.  Otherwise, returns 0.'
    return 2
  fi
  if [[ ! $__base ]]; then
    if [[ $_ble_measure_base ]]; then
      __base=$((_ble_measure_base+_ble_measure_base_nestcost*__level/10))
    else
      if [[ ! $ble_measure_calibrate && ! ${_ble_measure_base[__level]} ]]; then
        if [[ ! ${_ble_measure_base_real[__level+1]} ]]; then
          local ble_measure_calibrate=1
          local a; ble-measure -qc3 -B 0 ''
          ble/util/unlocal ble_measure_calibrate a
          _ble_measure_base_real[__level+1]=$nsec
          _ble_measure_base[__level+1]=$nsec
        fi
        local A=6598 B=435675
        nsec=${_ble_measure_base_real[__level+1]}
        _ble_measure_base[__level]=$((nsec*(B+A*(__level-1))/(B+A*__level)))
        ble/util/unlocal A B
      fi
      __base=${_ble_measure_base[__level]:-0}
    fi
  fi
  local prev_n= prev_utot=
  local -i n
  for n in {1,10,100,1000,10000}\*{1,2,5}; do
    [[ $prev_n ]] && ((n/prev_n<=10 && prev_utot*n/prev_n<measure_threshold*2/5 && n!=50000)) && continue
    local utot=0 usec=0
    [[ $flags != *q* ]] && printf '%s (x%d)...' "$command" "$n" >&2
    ble-measure/.time "$command" || return 1
    [[ $flags != *q* ]] && printf '\r\e[2K' >&2
    ((utot >= measure_threshold)) || continue
    prev_n=$n prev_utot=$utot
    local min_utot=$utot
    if [[ $count ]]; then
      local sum_utot=$utot sum_count=1 i
      for ((i=2;i<=count;i++)); do
        [[ $flags != *q* ]] && printf '%s' "$command (x$n $i/$count)..." >&2
        if ble-measure/.time "$command"; then
          ((utot<min_utot)) && min_utot=$utot
          ((sum_utot+=utot,sum_count++))
        fi
        [[ $flags != *q* ]] && printf '\r\e[2K' >&2
      done
      if [[ $flags == *a* ]]; then
        ((utot=sum_utot/sum_count))
      else
        utot=$min_utot
      fi
    fi
    if ((min_utot<0x7FFFFFFFFFFFFFFF/1000)); then
      local __real=$((min_utot*1000/n))
      [[ ${_ble_measure_base_real[__level]} ]] &&
        ((__real<_ble_measure_base_real[__level])) &&
        _ble_measure_base_real[__level]=$__real
      [[ ${_ble_measure_base[__level]} ]] &&
        ((__real<_ble_measure_base[__level])) &&
        _ble_measure_base[__level]=$__real
      ((__real<__base)) &&
        __base=$__real
    fi
    local nsec0=$__base
    if [[ $flags != *q* ]]; then
      local reso=$_ble_measure_resolution
      local awk=ble/bin/awk
      type "$awk" &>/dev/null || awk=awk
      "$awk" -v utot=$utot -v nsec0=$nsec0 -v n=$n -v reso=$reso -v title="$command (x$n)" \
             ' function genround(x, mod) { return int(x / mod + 0.5) * mod; }
          BEGIN { printf("%12.3f usec/eval: %s\n", genround(utot / n - nsec0 / 1000, reso / 10.0 / n), title); exit }'
    fi
    ((ret=utot/n))
    if ((n>=1000)); then
      ((nsec=utot/(n/1000)))
    else
      ((nsec=utot*1000/n))
    fi
    ((ret-=nsec0/1000,nsec-=nsec0))
    return 0
  done
}
function ble/util/msleep/.check-builtin-sleep {
  local ret; ble/util/readlink "$BASH"
  local bash_prefix=${ret%/*/*}
  if [[ -s $bash_prefix/lib/bash/sleep ]] &&
    (enable -f "$bash_prefix/lib/bash/sleep" sleep && builtin sleep 0.0) &>/dev/null; then
    enable -f "$bash_prefix/lib/bash/sleep" sleep
    return 0
  else
    return 1
  fi
}
function ble/util/msleep/.check-sleep-decimal-support {
  local version; ble/util/assign version 'LC_ALL=C ble/bin/sleep --version 2>&1' 2>/dev/null # suppress locale error #D1440
  [[ $version == *'GNU coreutils'* || $OSTYPE == darwin* && $version == 'usage: sleep seconds' ]]
}
_ble_util_msleep_delay=2000 # [usec]
function ble/util/msleep/.core {
  local sec=${1%%.*}
  ((10#0${1##*.}&&sec++)) # 小数部分は切り上げ
  ble/bin/sleep "$sec"
}
function ble/util/msleep {
  local v=$((1000*$1-_ble_util_msleep_delay))
  ((v<=0)) && v=0
  ble/util/sprintf v '%d.%06d' $((v/1000000)) $((v%1000000))
  ble/util/msleep/.core "$v"
}
_ble_util_msleep_calibrate_count=0
function ble/util/msleep/.calibrate-loop {
  local _ble_measure_threshold=10000
  local ret nsec _ble_measure_count=1 v=0
  _ble_util_msleep_delay=0 ble-measure 'ble/util/msleep 1'
  local delay=$((nsec/1000-1000)) count=$_ble_util_msleep_calibrate_count
  ((count<=0||delay<_ble_util_msleep_delay)) && _ble_util_msleep_delay=$delay # 最小値
}
function ble/util/msleep/calibrate {
  ble/util/msleep/.calibrate-loop &>/dev/null
  ((++_ble_util_msleep_calibrate_count<5)) &&
    ble/util/idle.continue
}
function ble/util/msleep/.use-read-timeout {
  local msleep_type=$1 opts=${2-}
  _ble_util_msleep_fd=
  case $msleep_type in
  (socket)
    _ble_util_msleep_delay1=10000 # short msleep にかかる時間 [usec]
    _ble_util_msleep_delay2=50000 # /bin/sleep 0 にかかる時間 [usec]
    function ble/util/msleep/.core2 {
      ((v-=_ble_util_msleep_delay2))
      ble/bin/sleep $((v/1000000))
      ((v%=1000000))
    }
    function ble/util/msleep {
      local v=$((1000*$1-_ble_util_msleep_delay1))
      ((v<=0)) && v=100
      ((v>1000000+_ble_util_msleep_delay2)) &&
        ble/util/msleep/.core2
      ble/util/sprintf v '%d.%06d' $((v/1000000)) $((v%1000000))
      ! builtin read -t "$v" v < /dev/udp/0.0.0.0/80
    }
    function ble/util/msleep/.calibrate-loop {
      local _ble_measure_threshold=10000
      local ret nsec _ble_measure_count=1 v=0
      _ble_util_msleep_delay1=0 ble-measure 'ble/util/msleep 1'
      local delay=$((nsec/1000-1000)) count=$_ble_util_msleep_calibrate_count
      ((count<=0||delay<_ble_util_msleep_delay1)) && _ble_util_msleep_delay1=$delay # 最小値
      _ble_util_msleep_delay2=0 ble-measure 'ble/util/msleep/.core2'
      local delay=$((nsec/1000))
      ((count<=0||delay<_ble_util_msleep_delay2)) && _ble_util_msleep_delay2=$delay # 最小値
    } ;;
  (procsub)
    _ble_util_msleep_delay=300
    ble/fd#alloc _ble_util_msleep_fd '< <(
      [[ $- == *i* ]] && builtin trap -- '' INT QUIT
      while kill -0 $$; do command sleep 300; done &>/dev/null
    )'
    function ble/util/msleep {
      local v=$((1000*$1-_ble_util_msleep_delay))
      ((v<=0)) && v=100
      ble/util/sprintf v '%d.%06d' $((v/1000000)) $((v%1000000))
      ! builtin read -t "$v" -u "$_ble_util_msleep_fd" v
    } ;;
  (*.*)
    if local rex='^(fifo|zero|ptmx)\.(open|exec)([12])(-[a-z]+)?$'; [[ $msleep_type =~ $rex ]]; then
      local file=${BASH_REMATCH[1]}
      local open=${BASH_REMATCH[2]}
      local direction=${BASH_REMATCH[3]}
      local fall=${BASH_REMATCH[4]}
      case $file in
      (fifo)
        _ble_util_msleep_tmp=$_ble_base_run/$$.util.msleep.pipe
        if [[ ! -p $_ble_util_msleep_tmp ]]; then
          [[ -e $_ble_util_msleep_tmp ]] && ble/bin/rm -rf "$_ble_util_msleep_tmp"
          ble/bin/mkfifo "$_ble_util_msleep_tmp"
        fi ;;
      (zero)
        open=dup
        _ble_util_msleep_tmp=$_ble_util_fd_zero ;;
      (ptmx)
        _ble_util_msleep_tmp=/dev/ptmx ;;
      esac
      local redir='<'
      ((direction==2)) && redir='<>'
      if [[ $open == dup ]]; then
        _ble_util_msleep_fd=$_ble_util_msleep_tmp
        _ble_util_msleep_read='! builtin read -t "$v" -u "$_ble_util_msleep_fd" v'
      elif [[ $open == exec ]]; then
        ble/fd#alloc _ble_util_msleep_fd "$redir \"\$_ble_util_msleep_tmp\""
        _ble_util_msleep_read='! builtin read -t "$v" -u "$_ble_util_msleep_fd" v'
      else
        _ble_util_msleep_read='! builtin read -t "$v" v '$redir' "$_ble_util_msleep_tmp"'
      fi
      if [[ $fall == '-coreutil' ]]; then
        _ble_util_msleep_switch=200 # [msec]
        _ble_util_msleep_delay1=2000 # short msleep にかかる時間 [usec]
        _ble_util_msleep_delay2=50000 # /bin/sleep 0 にかかる時間 [usec]
        function ble/util/msleep {
          if (($1<_ble_util_msleep_switch)); then
            local v=$((1000*$1-_ble_util_msleep_delay1))
            ((v<=0)) && v=100
            ble/util/sprintf v '%d.%06d' $((v/1000000)) $((v%1000000))
            builtin eval -- "$_ble_util_msleep_read"
          else
            local v=$((1000*$1-_ble_util_msleep_delay2))
            ((v<=0)) && v=100
            ble/util/sprintf v '%d.%06d' $((v/1000000)) $((v%1000000))
            ble/bin/sleep "$v"
          fi
        }
        function ble/util/msleep/.calibrate-loop {
          local _ble_measure_threshold=10000
          local ret nsec _ble_measure_count=1
          _ble_util_msleep_switch=200
          _ble_util_msleep_delay1=0 ble-measure 'ble/util/msleep 1'
          local delay=$((nsec/1000-1000)) count=$_ble_util_msleep_calibrate_count
          ((count<=0||delay<_ble_util_msleep_delay1)) && _ble_util_msleep_delay1=$delay # 最小値を選択
          _ble_util_msleep_delay2=0 ble-measure 'ble/bin/sleep 0'
          local delay=$((nsec/1000))
          ((count<=0||delay<_ble_util_msleep_delay2)) && _ble_util_msleep_delay2=$delay # 最小値を選択
          ((_ble_util_msleep_switch=_ble_util_msleep_delay2/1000+10))
        }
      else
        function ble/util/msleep {
          local v=$((1000*$1-_ble_util_msleep_delay))
          ((v<=0)) && v=100
          ble/util/sprintf v '%d.%06d' $((v/1000000)) $((v%1000000))
          builtin eval -- "$_ble_util_msleep_read"
        }
      fi
    fi ;;
  esac
  if [[ :$opts: == *:check:* && $_ble_util_msleep_fd ]]; then
    if builtin read -t 0.000001 -u "$_ble_util_msleep_fd" _ble_util_msleep_dummy 2>/dev/null; (($?<=128)); then
      ble/fd#close _ble_util_msleep_fd
      _ble_util_msleep_fd=
      return 1
    fi
  fi
  return 0
}
_ble_util_msleep_builtin_available=
if ((_ble_bash>=40400)) && ble/util/msleep/.check-builtin-sleep; then
  _ble_util_msleep_builtin_available=1
  _ble_util_msleep_delay=300
  function ble/util/msleep/.core { builtin sleep "$1"; }
  function ble/builtin/sleep/.read-time {
    a1=0 b1=0
    local unit= exp=
    if local rex='^\+?([0-9]*)\.([0-9]*)([eE][-+]?[0-9]+)?([smhd]?)$'; [[ $1 =~ $rex ]]; then
      a1=${BASH_REMATCH[1]}
      b1=${BASH_REMATCH[2]}00000000000000
      b1=$((10#0${b1::14}))
      exp=${BASH_REMATCH[3]}
      unit=${BASH_REMATCH[4]}
    elif rex='^\+?([0-9]+)([eE][-+]?[0-9]+)?([smhd]?)$'; [[ $1 =~ $rex ]]; then
      a1=${BASH_REMATCH[1]}
      exp=${BASH_REMATCH[2]}
      unit=${BASH_REMATCH[3]}
    else
      ble/util/print "ble/builtin/sleep: invalid time spec '$1'" >&2
      flags=E$flags
      return 2
    fi
    if [[ $exp ]]; then
      case $exp in
      ([eE]-*)
        ((exp=10#0${exp:2}))
        while ((exp--)); do
          ((b1=a1%10*frac_scale/10+b1/10,a1/=10))
        done ;;
      ([eE]*)
        exp=${exp:1}
        ((exp=${exp#+}))
        while ((exp--)); do
          ((b1*=10,a1=a1*10+b1/frac_scale,b1%=frac_scale))
        done ;;
      esac
    fi
    local scale=
    case $unit in
    (d) ((scale=24*3600)) ;;
    (h) ((scale=3600)) ;;
    (m) ((scale=60)) ;;
    esac
    if [[ $scale ]]; then
      ((b1*=scale))
      ((a1=a1*scale+b1/frac_scale))
      ((b1%=frac_scale))
    fi
    return 0
  }
  function ble/builtin/sleep {
    local set shopt; ble/base/.adjust-bash-options set shopt
    local frac_scale=100000000000000
    local a=0 b=0 flags=
    if (($#==0)); then
      ble/util/print "ble/builtin/sleep: no argument" >&2
      flags=E$flags
    fi
    while (($#)); do
      case $1 in
      (--version) flags=v$flags ;;
      (--help)    flags=h$flags ;;
      (-*)
        flags=E$flags
        ble/util/print "ble/builtin/sleep: unknown option '$1'" >&2 ;;
      (*)
        if local a1 b1; ble/builtin/sleep/.read-time "$1"; then
          ((b+=b1))
          ((a=a+a1+b/frac_scale))
          ((b%=frac_scale))
        fi ;;
      esac
      shift
    done
    if [[ $flags == *h* ]]; then
      ble/util/print-lines \
        'usage: sleep NUMBER[SUFFIX]...' \
        'Pause for the time specified by the sum of the arguments. SUFFIX is one of "s"' \
        '(seconds), "m" (minutes), "h" (hours) or "d" (days).' \
        '' \
        'OPTIONS' \
        '     --help    Show this help.' \
        '     --version Show version.'
    fi
    if [[ $flags == *v* ]]; then
      ble/util/print "sleep (ble) $BLE_VERSION"
    fi
    if [[ $flags == *E* ]]; then
      ble/util/setexit 2
    elif [[ $flags == *[vh]* ]]; then
      ble/util/setexit 0
    else
      b=00000000000000$b
      b=${b:${#b}-14}
      builtin sleep "$a.$b"
    fi
    local ext=$?
    ble/base/.restore-bash-options set shopt 1
    return "$ext"
  }
  function sleep { ble/builtin/sleep "$@"; }
elif [[ -f $_ble_base/lib/init-msleep.sh ]] &&
       source "$_ble_base/lib/init-msleep.sh" &&
       ble/util/msleep/.load-compiled-builtin
then
  function ble/util/msleep { ble/builtin/msleep "$1"; }
elif ((40000<=_ble_bash&&!(40300<=_ble_bash&&_ble_bash<50200))) &&
       [[ $OSTYPE != cygwin* && $OSTYPE != mingw* && $OSTYPE != haiku* && $OSTYPE != minix* ]]
then
  ble/util/msleep/.use-read-timeout fifo.exec2
elif ((_ble_bash>=40000)) && ble/fd#is-open "$_ble_util_fd_zero"; then
  ble/util/msleep/.use-read-timeout zero.exec1-coreutil
elif ble/bin/.freeze-utility-path sleepenh; then
  function ble/util/msleep/.core { ble/bin/sleepenh "$1" &>/dev/null; }
elif ble/bin/.freeze-utility-path usleep; then
  function ble/util/msleep {
    local v=$((1000*$1-_ble_util_msleep_delay))
    ((v<=0)) && v=0
    ble/bin/usleep "$v" &>/dev/null
  }
elif ble/util/msleep/.check-sleep-decimal-support; then
  function ble/util/msleep/.core { ble/bin/sleep "$1"; }
fi
function ble/util/sleep {
  local msec=$((${1%%.*}*1000))
  if [[ $1 == *.* ]]; then
    frac=${1##*.}000
    ((msec+=10#0${frac::3}))
  fi
  ble/util/msleep "$msec"
}
function ble/util/conditional-sync/.collect-descendant-pids {
  local pid=$1 awk_script='
    $1 ~ /^[0-9]+$/ && $2 ~ /^[0-9]+$/ {
      child[$2,child[$2]++]=$1;
    }
    function print_recursive(pid, _, n, i) {
      if (child[pid]) {
        n = child[pid];
        child[pid] = 0; # avoid infinite loop
        for (i = 0; i < n; i++) {
          print_recursive(child[pid, i]);
        }
      }
      print pid;
    }
    END { print_recursive(pid); }
  '
  ble/util/assign ret 'ble/bin/ps -A -o pid,ppid'
  ble/util/assign-array ret 'ble/bin/awk -v pid="$pid" "$awk_script" <<< "$ret"'
}
function ble/util/conditional-sync/.kill {
  local kill_pids
  if [[ :$__opts: == *:killall:* ]]; then
    ble/util/conditional-sync/.collect-descendant-pids "$__pid"
    kill_pids=("${ret[@]}")
  else
    kill_pids=("$__pid")
  fi
  if [[ :$__opts: == *:SIGKILL:* ]]; then
    builtin kill "${kill_pids[@]}" &>/dev/null
  else
    builtin kill -9 "${kill_pids[@]}" &>/dev/null
  fi
} &>/dev/null
function ble/util/conditional-sync {
  local __command=$1
  local __continue=${2:-'! ble/decode/has-input'}
  local __weight=$3; ((__weight<=0&&(__weight=100)))
  local __opts=$4
  local __timeout= __rex=':timeout=([^:]+):'
  [[ :$__opts: =~ $__rex ]] && ((__timeout=BASH_REMATCH[1]))
  [[ :$__opts: == *:progressive-weight:* ]] &&
    local __weight_max=$__weight __weight=1
  [[ $__timeout ]] && ((__timeout<=0)) && return 142
  builtin eval -- "$__continue" || return 148
  (
    builtin eval -- "$__command" & local __pid=$!
    while
      if [[ $__timeout ]]; then
        if ((__timeout<=0)); then
          ble/util/conditional-sync/.kill
          return 142
        fi
        ((__weight>__timeout)) && __weight=$__timeout
        ((__timeout-=__weight))
      fi
      ble/util/msleep "$__weight"
      [[ :$__opts: == *:progressive-weight:* ]] &&
        ((__weight<<=1,__weight>__weight_max&&(__weight=__weight_max)))
      builtin kill -0 "$__pid" &>/dev/null
    do
      if ! builtin eval -- "$__continue"; then
        ble/util/conditional-sync/.kill
        return 148
      fi
    done
    wait "$__pid"
  )
}
function ble/util/cat/.impl {
  local content= TMOUT= IFS= 2>/dev/null # #D1630 WA readonly TMOUT
  while builtin read "${_ble_bash_tmout_wa[@]}" -r -d '' content; do
    printf '%s\0' "$content"
  done
  [[ $content ]] && printf '%s' "$content"
}
function ble/util/cat {
  if (($#)); then
    local file
    for file; do ble/util/cat/.impl < "$1"; done
  else
    ble/util/cat/.impl
  fi
}
_ble_util_less_fallback=
function ble/util/get-pager {
  if [[ ! $_ble_util_less_fallback ]]; then
    if type -t less &>/dev/null; then
      _ble_util_less_fallback=less
    elif type -t pager &>/dev/null; then
      _ble_util_less_fallback=pager
    elif type -t more &>/dev/null; then
      _ble_util_less_fallback=more
    else
      _ble_util_less_fallback=cat
    fi
  fi
  builtin eval "$1=\${bleopt_pager:-\${PAGER:-\$_ble_util_less_fallback}}"
}
function ble/util/pager {
  local pager; ble/util/get-pager pager
  builtin eval -- "$pager \"\$@\""
}
if ble/bin/date -r / +%s &>/dev/null; then
  function ble/util/getmtime { ble/bin/date -r "$1" +'%s %N' 2>/dev/null; }
elif ble/bin/.freeze-utility-path stat; then
  if ble/bin/stat -c %Y / &>/dev/null; then
    function ble/util/getmtime { ble/bin/stat -c %Y "$1" 2>/dev/null; }
  elif ble/bin/stat -f %m / &>/dev/null; then
    function ble/util/getmtime { ble/bin/stat -f %m "$1" 2>/dev/null; }
  fi
fi
ble/is-function ble/util/getmtime ||
  function ble/util/getmtime { ble/util/strftime '%s %N'; }
_ble_util_buffer=()
function ble/util/buffer {
  _ble_util_buffer[${#_ble_util_buffer[@]}]=$1
}
function ble/util/buffer.print {
  ble/util/buffer "$1"$'\n'
}
function ble/util/buffer.flush {
  IFS= builtin eval 'local text="${_ble_util_buffer[*]-}"'
  [[ $_ble_term_state == internal ]] &&
    [[ $_ble_term_cursor_hidden_internal != hidden ]] &&
    text=$_ble_term_civis$text$_ble_term_cvvis
  ble/util/put "$text"
  _ble_util_buffer=()
}
function ble/util/buffer.clear {
  _ble_util_buffer=()
}
function ble/dirty-range#load {
  local _prefix=
  if [[ $1 == --prefix=* ]]; then
    _prefix=${1#--prefix=}
    ((beg=${_prefix}beg,
      end=${_prefix}end,
      end0=${_prefix}end0))
  fi
}
function ble/dirty-range#clear {
  local _prefix=
  if [[ $1 == --prefix=* ]]; then
    _prefix=${1#--prefix=}
    shift
  fi
  ((${_prefix}beg=-1,
    ${_prefix}end=-1,
    ${_prefix}end0=-1))
}
function ble/dirty-range#update {
  local _prefix=
  if [[ $1 == --prefix=* ]]; then
    _prefix=${1#--prefix=}
    shift
    [[ $_prefix ]] && local beg end end0
  fi
  local begB=$1 endB=$2 endB0=$3
  ((begB<0)) && return 1
  local begA endA endA0
  ((begA=${_prefix}beg,endA=${_prefix}end,endA0=${_prefix}end0))
  local delta
  if ((begA<0)); then
    ((beg=begB,
      end=endB,
      end0=endB0))
  else
    ((beg=begA<begB?begA:begB))
    if ((endA<0||endB<0)); then
      ((end=-1,end0=-1))
    else
      ((end=endB,end0=endA0,
        (delta=endA-endB0)>0?(end+=delta):(end0-=delta)))
    fi
  fi
  if [[ $_prefix ]]; then
    ((${_prefix}beg=beg,
      ${_prefix}end=end,
      ${_prefix}end0=end0))
  fi
}
function ble/urange#clear {
  local prefix=
  if [[ $1 == --prefix=* ]]; then
    prefix=${1#*=}; shift
  fi
  ((${prefix}umin=-1,${prefix}umax=-1))
}
function ble/urange#update {
  local prefix=
  if [[ $1 == --prefix=* ]]; then
    prefix=${1#*=}; shift
  fi
  local min=$1 max=$2
  ((0<=min&&min<max)) || return 1
  (((${prefix}umin<0||min<${prefix}umin)&&(${prefix}umin=min),
    (${prefix}umax<0||${prefix}umax<max)&&(${prefix}umax=max)))
}
function ble/urange#shift {
  local prefix=
  if [[ $1 == --prefix=* ]]; then
    prefix=${1#*=}; shift
  fi
  local dbeg=$1 dend=$2 dend0=$3 shift=$4
  ((dbeg>=0)) || return 1
  [[ $shift ]] || ((shift=dend-dend0))
  ((${prefix}umin>=0&&(
      dbeg<=${prefix}umin&&(${prefix}umin<=dend0?(${prefix}umin=dend):(${prefix}umin+=shift)),
      dbeg<=${prefix}umax&&(${prefix}umax<=dend0?(${prefix}umax=dbeg):(${prefix}umax+=shift))),
    ${prefix}umin<${prefix}umax||(
      ${prefix}umin=-1,
      ${prefix}umax=-1)))
}
_ble_util_joblist_jobs=
_ble_util_joblist_list=()
_ble_util_joblist_events=()
function ble/util/joblist {
  local opts=$1 jobs0
  ble/util/assign jobs0 'jobs'
  if [[ $jobs0 == "$_ble_util_joblist_jobs" ]]; then
    joblist=("${_ble_util_joblist_list[@]}")
    return 0
  elif [[ ! $jobs0 ]]; then
    _ble_util_joblist_jobs=
    _ble_util_joblist_list=()
    joblist=()
    return 0
  fi
  local lines list ijob
  ble/string#split lines $'\n' "$jobs0"
  if ((${#lines[@]})); then
    ble/util/joblist.split list "${lines[@]}"
  else
    list=()
  fi
  if [[ $jobs0 != "$_ble_util_joblist_jobs" ]]; then
    for ijob in "${!list[@]}"; do
      if [[ ${_ble_util_joblist_list[ijob]} && ${list[ijob]#'['*']'[-+ ]} != "${_ble_util_joblist_list[ijob]#'['*']'[-+ ]}" ]]; then
        if [[ ${list[ijob]} != *'__ble_suppress_joblist__'* ]]; then
          ble/array#push _ble_util_joblist_events "${list[ijob]}"
        fi
        list[ijob]=
      fi
    done
  fi
  ble/util/assign _ble_util_joblist_jobs 'jobs'
  _ble_util_joblist_list=()
  if [[ $_ble_util_joblist_jobs != "$jobs0" ]]; then
    ble/string#split lines $'\n' "$_ble_util_joblist_jobs"
    ble/util/joblist.split _ble_util_joblist_list "${lines[@]}"
    if [[ :$opts: != *:ignore-volatile-jobs:* ]]; then
      for ijob in "${!list[@]}"; do
        local job0=${list[ijob]}
        if [[ $job0 && ! ${_ble_util_joblist_list[ijob]} ]]; then
          if [[ $job0 != *'__ble_suppress_joblist__'* ]]; then
            ble/array#push _ble_util_joblist_events "$job0"
          fi
        fi
      done
    fi
  else
    for ijob in "${!list[@]}"; do
      [[ ${list[ijob]} ]] &&
        _ble_util_joblist_list[ijob]=${list[ijob]}
    done
  fi
  joblist=("${_ble_util_joblist_list[@]}")
} 2>/dev/null
function ble/util/joblist.split {
  local arr=$1; shift
  local line ijob= rex_ijob='^\[([0-9]+)\]'
  for line; do
    [[ $line =~ $rex_ijob ]] && ijob=${BASH_REMATCH[1]}
    [[ $ijob ]] && builtin eval "$arr[ijob]=\${$arr[ijob]}\${$arr[ijob]:+\$_ble_term_nl}\$line"
  done
}
function ble/util/joblist.check {
  local joblist
  ble/util/joblist "$@"
}
function ble/util/joblist.has-events {
  local joblist
  ble/util/joblist
  ((${#_ble_util_joblist_events[@]}))
}
function ble/util/joblist.flush {
  local joblist
  ble/util/joblist
  ((${#_ble_util_joblist_events[@]})) || return 1
  printf '%s\n' "${_ble_util_joblist_events[@]}"
  _ble_util_joblist_events=()
}
function ble/util/joblist.bflush {
  local joblist out
  ble/util/joblist
  ((${#_ble_util_joblist_events[@]})) || return 1
  ble/util/sprintf out '%s\n' "${_ble_util_joblist_events[@]}"
  ble/util/buffer "$out"
  _ble_util_joblist_events=()
}
function ble/util/joblist.clear {
  _ble_util_joblist_jobs=
  _ble_util_joblist_list=()
}
function ble/util/save-editing-mode {
  if [[ -o emacs ]]; then
    builtin eval "$1=emacs"
  elif [[ -o vi ]]; then
    builtin eval "$1=vi"
  else
    builtin eval "$1=none"
  fi
}
function ble/util/restore-editing-mode {
  case "${!1}" in
  (emacs) set -o emacs ;;
  (vi) set -o vi ;;
  (none) set +o emacs ;;
  esac
}
function ble/util/reset-keymap-of-editing-mode {
  if [[ -o emacs ]]; then
    set -o emacs
  elif [[ -o vi ]]; then
    set -o vi
  fi
}
function ble/util/test-rl-variable {
  local rl_variables; ble/util/assign rl_variables 'builtin bind -v'
  if [[ $rl_variables == *"set $1 on"* ]]; then
    return 0
  elif [[ $rl_variables == *"set $1 off"* ]]; then
    return 1
  elif (($#>=2)); then
    (($2))
    return "$?"
  else
    return 2
  fi
}
function ble/util/read-rl-variable {
  ret=$2
  local rl_variables; ble/util/assign rl_variables 'builtin bind -v'
  local rhs=${rl_variables#*$'\n'"set $1 "}
  [[ $rhs != "$rl_variables" ]] && ret=${rhs%%$'\n'*}
}
function ble/util/invoke-hook {
  local -a hooks; builtin eval "hooks=(\"\${$1[@]}\")"
  local hook ext=0
  for hook in "${hooks[@]}"; do builtin eval -- "$hook \"\${@:2}\"" || ext=$?; done
  return "$ext"
}
function ble/util/.read-arguments-for-no-option-command {
  local commandname=$1; shift
  flags= args=()
  local flag_literal=
  while (($#)); do
    local arg=$1; shift
    if [[ ! $flag_literal ]]; then
      case $arg in
      (--) flag_literal=1 ;;
      (--help) flags=h$flags ;;
      (-*)
        ble/util/print "$commandname: unrecognized option '$arg'" >&2
        flags=e$flags ;;
      (*)
        ble/array#push args "$arg" ;;
      esac
    else
      ble/array#push args "$arg"
    fi
  done
}
function ble/util/autoload {
  local file=$1; shift
  ble/util/import/is-loaded "$file" && return 0
  local q=\' Q="'\''" funcname
  for funcname; do
    builtin eval "function $funcname {
      builtin unset -f $funcname
      ble-import '${file//$q/$Q}' &&
        $funcname \"\$@\"
    }"
  done
}
function ble/util/autoload/.print-usage {
  ble/util/print 'usage: ble-autoload SCRIPTFILE FUNCTION...'
  ble/util/print '  Setup delayed loading of functions defined in the specified script file.'
} >&2
function ble/util/autoload/.read-arguments {
  file= flags= functions=()
  local args
  ble/util/.read-arguments-for-no-option-command ble-autoload "$@"
  local arg index=0
  for arg in "${args[@]}"; do
    if [[ ! $arg ]]; then
      if ((index==0)); then
        ble/util/print 'ble-autoload: the script filename should not be empty.' >&2
      else
        ble/util/print 'ble-autoload: function names should not be empty.' >&2
      fi
      flags=e$flags
    fi
    ((index++))
  done
  [[ $flags == *h* ]] && return 0
  if ((${#args[*]}==0)); then
    ble/util/print 'ble-autoload: script filename is not specified.' >&2
    flags=e$flags
  elif ((${#args[*]}==1)); then
    ble/util/print 'ble-autoload: function names are not specified.' >&2
    flags=e$flags
  fi
  file=${args[0]} functions=("${args[@]:1}")
}
function ble-autoload {
  local file flags
  local -a functions=()
  ble/util/autoload/.read-arguments "$@"
  if [[ $flags == *[eh]* ]]; then
    [[ $flags == *e* ]] && builtin printf '\n'
    ble/util/autoload/.print-usage
    [[ $flags == *e* ]] && return 2
    return 0
  fi
  ble/util/autoload "$file" "${functions[@]}"
}
_ble_util_import_files=()
bleopt/declare -n import_path "${XDG_DATA_HOME:-$HOME/.local/share}/blesh/local"
function ble/util/import/search/.check-directory {
  local name=$1 dir=${2%/}
  [[ -d ${dir:=/} ]] || return 1
  if [[ $name == lib/* ]]; then
    [[ $dir == */lib ]] || return 1
    dir=${dir%/lib}
  elif [[ $name == contrib/* ]]; then
    [[ $dir == */contrib ]] || return 1
    dir=${dir%/contrib}
  fi
  if [[ -f $dir/$name ]]; then
    ret=$dir/$name
    return 0
  elif [[ $name != *.bash && -f $dir/$name.bash ]]; then
    ret=$dir/$name.bash
    return 0
  elif [[ $name != *.sh && -f $dir/$name.sh ]]; then
    ret=$dir/$name.sh
    return 0
  fi
  return 1
}
function ble/util/import/search {
  ret=$1
  if [[ $ret != /* && $ret != ./* && $ret != ../* ]]; then
    local -a dirs=()
    if [[ $bleopt_import_path ]]; then
      local tmp; ble/string#split tmp : "$bleopt_import_path"
      ble/array#push dirs "${tmp[@]}"
    fi
    ble/array#push dirs "$_ble_base"{,/contrib,/lib}
    "${_ble_util_set_declare[@]//NAME/checked}" # #D1570
    local path
    for path in "${dirs[@]}"; do
      ble/set#contains checked "$path" && continue
      ble/set#add checked "$path"
      ble/util/import/search/.check-directory "$ret" "$path" && break
    done
  fi
  [[ -e $ret && ! -d $ret ]]
}
function ble/util/import/encode-filename {
  ret=$1
  local chars=%$'\t\n !"$&\'();<>\\^`|' # <emacs bug `>
  if [[ $ret == *["$chars"]* ]]; then
    local i n=${#chars} reps a b
    reps=(%{25,08,0A,2{0..2},24,2{6..9},3B,3C,3E,5C,5E,60,7C})
    for ((i=0;i<n;i++)); do
      a=${chars:i:1} b=${reps[i]} ret=${ret//"$a"/"$b"}
    done
  fi
  return 0
}
function ble/util/import/is-loaded {
  local ret
  ble/util/import/search "$1" &&
    ble/util/import/encode-filename "$ret" &&
    ble/is-function ble/util/import/guard:"$ret"
}
function ble/util/import/finalize {
  local file ret
  for file in "${_ble_util_import_files[@]}"; do
    ble/util/import/encode-filename "$file"; local enc=$ret
    local guard=ble/util/import/guard:$enc
    builtin unset -f "$guard"
    local onload=ble/util/import/onload:$enc
    if ble/is-function "$onload"; then
      "$onload" ble/util/unlocal
      builtin unset -f "$onload"
    fi
  done
  _ble_util_import_files=()
}
function ble/util/import/.read-arguments {
  flags= files=()
  local -a not_found=()
  while (($#)); do
    local arg=$1; shift
    if [[ $flags != *-* ]]; then
      case $arg in
      (--)
        flags=-$flags
        continue ;;
      (--*)
        case $arg in
        (--delay) flags=d$flags ;;
        (--help)  flags=h$flags ;;
        (--force) flags=f$flags ;;
        (*)
          ble/util/print "ble-import: unrecognized option '$arg'" >&2
          flags=E$flags ;;
        esac
        continue ;;
      (-?*)
        local i c
        for ((i=1;i<${#arg};i++)); do
          c=${arg:i:1}
          case $c in
          ([df]) flags=$c$flags ;;
          (*)
            ble/util/print "ble-import: unrecognized option '-$c'" >&2
            flags=E$flags ;;
          esac
        done
        continue ;;
      esac
    fi
    local ret
    if ! ble/util/import/search "$arg"; then
      ble/array#push not_found "$arg"
      continue
    fi; local file=$ret
    ble/array#push files "$file"
  done
  if [[ $flags != *f* ]] && ((${#not_found[@]})); then
    local file
    for file in "${not_found[@]}"; do
      ble/util/print "ble-import: file '$file' not found" >&2
    done
    flags=E$flags
  fi
  return 0
}
function ble/util/import {
  local file ext=0 ret enc
  for file; do
    ble/util/import/encode-filename "$file"; enc=$ret
    local guard=ble/util/import/guard:$enc
    ble/is-function "$guard" && return 0
    [[ -e $file ]] || return 1
    source "$file" || { ext=$?; continue; }
    builtin eval "function $guard { :; }"
    ble/array#push _ble_util_import_files "$file"
    local onload=ble/util/import/onload:$enc
    ble/function#try "$onload" ble/util/invoke-hook
  done
  return "$ext"
}
function ble-import {
  local files flags
  ble/util/import/.read-arguments "$@"
  if [[ $flags == *[Eh]* ]]; then
    [[ $flags == *E* ]] && ble/util/print
    {
      ble/util/print 'usage: ble-import [-df] SCRIPTFILE...'
      ble/util/print '  Search and source script files that have not yet been loaded.'
    } >&2
    [[ $flags == *E* ]] && return 2
    return 0
  elif ((!${#files[@]})); then
    [[ $flags == *f* ]] && return 0
    ble/util/print 'ble-import: files are not specified.' >&2
    return 2
  fi
  if [[ $flags == *d* ]] && ble/is-function ble/util/idle.push; then
    local ret
    ble/string#quote-command ble/util/import "${files[@]}"
    ble/util/idle.push "$ret"
    return 0
  fi
  ble/util/import "${files[@]}"
}
_ble_util_import_onload_count=0
function ble/util/import/eval-after-load {
  local ret file
  if ! ble/util/import/search "$1"; then
    ble/util/print "ble-import: file '$1' not found." >&2
    return 2
  fi; file=$ret
  ble/util/import/encode-filename "$file"; local enc=$ret
  local guard=ble/util/import/guard:$enc
  if ble/is-function "$guard"; then
    builtin eval -- "$2"
  else
    local onload=ble/util/import/onload:$enc
    if ! ble/is-function "$onload"; then
      local q=\' Q="'\''" list=_ble_util_import_onload_$((_ble_util_import_onload_count++))
      builtin eval -- "$list=(); function $onload { \"\$1\" $list \"\${@:2}\"; }"
    fi
    "$onload" ble/array#push "$2"
  fi
}
_ble_util_stackdump_title=stackdump
_ble_util_stackdump_start=
function ble/util/stackdump {
  ((bleopt_internal_stackdump_enabled)) || return 1
  local message=$1 nl=$'\n' IFS=$_ble_term_IFS
  message="$_ble_term_sgr0$_ble_util_stackdump_title: $message$nl"
  local extdebug= iarg=$BASH_ARGC args=
  shopt -q extdebug 2>/dev/null && extdebug=1
  local i i0=${_ble_util_stackdump_start:-1} iN=${#FUNCNAME[*]}
  for ((i=i0;i<iN;i++)); do
    if [[ $extdebug ]] && ((BASH_ARGC[i])); then
      args=("${BASH_ARGV[@]:iarg:BASH_ARGC[i]}")
      ble/array#reverse args
      args=" ${args[*]}"
      ((iarg+=BASH_ARGC[i]))
    else
      args=
    fi
    message="$message  @ ${BASH_SOURCE[i]}:${BASH_LINENO[i-1]} (${FUNCNAME[i]}$args)$nl"
  done
  ble/util/put "$message"
}
function ble-stackdump {
  local flags args
  ble/util/.read-arguments-for-no-option-command ble-stackdump "$@"
  if [[ $flags == *[eh]* ]]; then
    [[ $flags == *e* ]] && ble/util/print
    {
      ble/util/print 'usage: ble-stackdump command [message]'
      ble/util/print '  Print stackdump.'
    } >&2
    [[ $flags == *e* ]] && return 2
    return 0
  fi
  local _ble_util_stackdump_start=2
  local IFS=$_ble_term_IFS
  ble/util/stackdump "${args[*]}"
}
function ble/util/assert {
  local expr=$1 message=$2
  if ! builtin eval -- "$expr"; then
    shift
    local _ble_util_stackdump_title='assertion failure'
    local _ble_util_stackdump_start=3
    ble/util/stackdump "$expr$_ble_term_nl$message" >&2
    return 1
  else
    return 0
  fi
}
function ble-assert {
  local flags args
  ble/util/.read-arguments-for-no-option-command ble-assert "$@"
  if [[ $flags != *h* ]]; then
    if ((${#args[@]}==0)); then
      ble/util/print 'ble-assert: command is not specified.' >&2
      flags=e$flags
    fi
  fi
  if [[ $flags == *[eh]* ]]; then
    [[ $flags == *e* ]] && ble/util/print
    {
      ble/util/print 'usage: ble-assert command [message]'
      ble/util/print '  Evaluate command and print stackdump on fail.'
    } >&2
    [[ $flags == *e* ]] && return 2
    return 0
  fi
  local IFS=$_ble_term_IFS
  ble/util/assert "${args[0]}" "${args[*]:1}"
}
_ble_util_clock_base=
_ble_util_clock_reso=
_ble_util_clock_type=
function ble/util/clock/.initialize {
  local LC_ALL= LC_NUMERIC=C
  if ((_ble_bash>=50000)) && {
       local now=$EPOCHREALTIME
       [[ $now == *.???* && $now != $EPOCHREALTIME ]]; }; then
    readonly EPOCHREALTIME
    _ble_util_clock_base=$((10#0${now%.*}))
    _ble_util_clock_reso=1
    _ble_util_clock_type=EPOCHREALTIME
    function ble/util/clock {
      local LC_ALL= LC_NUMERIC=C
      local now=$EPOCHREALTIME
      local integral=$((10#0${now%%.*}-_ble_util_clock_base))
      local mantissa=${now#*.}000; mantissa=${mantissa::3}
      ((ret=integral*1000+10#0$mantissa))
    }
    ble/function#suppress-stderr ble/util/clock # locale
  elif [[ -r /proc/uptime ]] && {
         local uptime
         ble/util/readfile uptime /proc/uptime
         ble/string#split-words uptime "$uptime"
         [[ $uptime == *.* ]]; }; then
    _ble_util_clock_base=$((10#0${uptime%.*}))
    _ble_util_clock_reso=10
    _ble_util_clock_type=uptime
    function ble/util/clock {
      local now
      ble/util/readfile now /proc/uptime
      ble/string#split-words now "$now"
      local integral=$((10#0${now%%.*}-_ble_util_clock_base))
      local fraction=${now#*.}000; fraction=${fraction::3}
      ((ret=integral*1000+10#0$fraction))
    }
  elif ((_ble_bash>=40200)); then
    printf -v _ble_util_clock_base '%(%s)T'
    _ble_util_clock_reso=1000
    _ble_util_clock_type=printf
    function ble/util/clock {
      local now; printf -v now '%(%s)T'
      ((ret=(now-_ble_util_clock_base)*1000))
    }
  elif [[ $SECONDS && ! ${SECONDS//[0-9]} ]]; then
    readonly SECONDS
    _ble_util_clock_base=$SECONDS
    _ble_util_clock_reso=1000
    _ble_util_clock_type=SECONDS
    function ble/util/clock {
      local now=$SECONDS
      ((ret=(now-_ble_util_clock_base)*1000))
    }
  else
    ble/util/strftime -v _ble_util_clock_base '%s'
    _ble_util_clock_reso=1000
    _ble_util_clock_type=date
    function ble/util/clock {
      ble/util/strftime -v ret '%s'
      ((ret=(ret-_ble_util_clock_base)*1000))
    }
  fi
}
ble/util/clock/.initialize 2>/dev/null
if ((_ble_bash>=40000)); then
  function ble/util/idle/IS_IDLE { ! ble/util/is-stdin-ready; }
  _ble_util_idle_sclock=0
  function ble/util/idle/.sleep {
    local msec=$1
    ((msec<=0)) && return 0
    ble/util/msleep "$msec"
    ((_ble_util_idle_sclock+=msec))
  }
  function ble/util/idle.clock/.initialize {
    function ble/util/idle.clock/.initialize { :; }
    function ble/util/idle.clock/.restart { :; }
    if [[ ! $_ble_util_clock_type || $_ble_util_clock_type == date ]]; then
      function ble/util/idle.clock {
        ret=$_ble_util_idle_sclock
      }
    elif ((_ble_util_clock_reso<=100)); then
      function ble/util/idle.clock {
        ble/util/clock
      }
    else
      _ble_util_idle_aclock_shift=
      _ble_util_idle_aclock_tick_rclock=
      _ble_util_idle_aclock_tick_sclock=
      function ble/util/idle.clock/.restart {
        _ble_util_idle_aclock_shift=
        _ble_util_idle_aclock_tick_rclock=
        _ble_util_idle_aclock_tick_sclock=
      }
      function ble/util/idle/.adjusted-clock {
        local resolution=$_ble_util_clock_reso
        local sclock=$_ble_util_idle_sclock
        local ret; ble/util/clock; local rclock=$((ret/resolution*resolution))
        if [[ $_ble_util_idle_aclock_tick_rclock != "$rclock" ]]; then
          if [[ $_ble_util_idle_aclock_tick_rclock && ! $_ble_util_idle_aclock_shift ]]; then
            local delta=$((sclock-_ble_util_idle_aclock_tick_sclock))
            ((_ble_util_idle_aclock_shift=delta<resolution?resolution-delta:0))
          fi
          _ble_util_idle_aclock_tick_rclock=$rclock
          _ble_util_idle_aclock_tick_sclock=$sclock
        fi
        ((ret=rclock+(sclock-_ble_util_idle_aclock_tick_sclock)-_ble_util_idle_aclock_shift))
      }
      function ble/util/idle.clock {
        ble/util/idle/.adjusted-clock
      }
    fi
  }
  function ble/util/idle/.initialize-options {
    local interval='ble_util_idle_elapsed>600000?500:(ble_util_idle_elapsed>60000?200:(ble_util_idle_elapsed>5000?100:20))'
    ((_ble_bash>50000)) && [[ $_ble_util_msleep_builtin_available ]] && interval=20
    bleopt/declare -v idle_interval "$interval"
  }
  ble/util/idle/.initialize-options
  _ble_util_idle_task=()
  _ble_util_idle_lasttask=
  _ble_util_idle_SEP=$_ble_term_FS
  function ble/util/idle.do {
    local IFS=$_ble_term_IFS
    ble/util/idle/IS_IDLE || return 1
    ((${#_ble_util_idle_task[@]}==0)) && return 1
    ble/util/buffer.flush >&2
    local ret
    ble/util/idle.clock/.initialize
    ble/util/idle.clock/.restart
    ble/util/idle.clock
    local _idle_clock_start=$ret
    local _idle_sclock_start=$_ble_util_idle_sclock
    local _idle_is_first=1
    local _idle_processed=
    while :; do
      local _idle_key
      local _idle_next_time= _idle_next_itime= _idle_running= _idle_waiting=
      for _idle_key in "${!_ble_util_idle_task[@]}"; do
        ble/util/idle/IS_IDLE || { [[ $_idle_processed ]]; return "$?"; }
        local _idle_to_process=
        local _idle_status=${_ble_util_idle_task[_idle_key]%%"$_ble_util_idle_SEP"*}
        case ${_idle_status::1} in
        (R) _idle_to_process=1 ;;
        (I) [[ $_idle_is_first ]] && _idle_to_process=1 ;;
        (S) ble/util/idle/.check-clock "$_idle_status" && _idle_to_process=1 ;;
        (W) ble/util/idle/.check-clock "$_idle_status" && _idle_to_process=1 ;;
        (F) [[ -s ${_idle_status:1} ]] && _idle_to_process=1 ;;
        (E) [[ -e ${_idle_status:1} ]] && _idle_to_process=1 ;;
        (P) ! builtin kill -0 ${_idle_status:1} &>/dev/null && _idle_to_process=1 ;;
        (C) builtin eval -- "${_idle_status:1}" && _idle_to_process=1 ;;
        (Z) ;;
        (*) builtin unset -v '_ble_util_idle_task[_idle_key]'
        esac
        if [[ $_idle_to_process ]]; then
          local _idle_command=${_ble_util_idle_task[_idle_key]#*"$_ble_util_idle_SEP"}
          _idle_processed=1
          ble/util/idle.do/.call-task "$_idle_command"
        elif [[ $_idle_status == [FEPC]* ]]; then
          _idle_waiting=1
        fi
      done
      _idle_is_first=
      ble/util/idle.do/.sleep-until-next; local ext=$?
      ((ext==148)) && break
      [[ $_idle_next_itime$_idle_next_time$_idle_running$_idle_waiting ]] || break
    done
    [[ $_idle_processed ]]
  }
  function ble/util/idle.do/.call-task {
    local _command=$1
    local ble_util_idle_status=
    local ble_util_idle_elapsed=$((_ble_util_idle_sclock-_idle_sclock_start))
    builtin eval -- "$_command"; local ext=$?
    if ((ext==148)); then
      _ble_util_idle_task[_idle_key]=R$_ble_util_idle_SEP$_command
    elif [[ $ble_util_idle_status ]]; then
      _ble_util_idle_task[_idle_key]=$ble_util_idle_status$_ble_util_idle_SEP$_command
      if [[ $ble_util_idle_status == [WS]* ]]; then
        local scheduled_time=${ble_util_idle_status:1}
        if [[ $ble_util_idle_status == W* ]]; then
          local next=_idle_next_itime
        else
          local next=_idle_next_time
        fi
        if [[ ! ${!next} ]] || ((scheduled_time<next)); then
          builtin eval "$next=\$scheduled_time"
        fi
      elif [[ $ble_util_idle_status == R ]]; then
        _idle_running=1
      elif [[ $ble_util_idle_status == [FEPC]* ]]; then
        _idle_waiting=1
      fi
    else
      builtin unset -v '_ble_util_idle_task[_idle_key]'
    fi
    return "$ext"
  }
  function ble/util/idle/.check-clock {
    local status=$1
    if [[ $status == W* ]]; then
      local next=_idle_next_itime
      local current_time=$_ble_util_idle_sclock
    elif [[ $status == S* ]]; then
      local ret
      local next=_idle_next_time
      ble/util/idle.clock; local current_time=$ret
    else
      return 1
    fi
    local scheduled_time=${status:1}
    if ((scheduled_time<=current_time)); then
      return 0
    elif [[ ! ${!next} ]] || ((scheduled_time<next)); then
      builtin eval "$next=\$scheduled_time"
    fi
    return 1
  }
  function ble/util/idle.do/.sleep-until-next {
    ble/util/idle/IS_IDLE || return 148
    [[ $_idle_running ]] && return 0
    local isfirst=1
    while
      local sleep_amount=
      if [[ $_idle_next_itime ]]; then
        local clock=$_ble_util_idle_sclock
        local sleep1=$((_idle_next_itime-clock))
        if [[ ! $sleep_amount ]] || ((sleep1<sleep_amount)); then
          sleep_amount=$sleep1
        fi
      fi
      if [[ $_idle_next_time ]]; then
        local ret; ble/util/idle.clock; local clock=$ret
        local sleep1=$((_idle_next_time-clock))
        if [[ ! $sleep_amount ]] || ((sleep1<sleep_amount)); then
          sleep_amount=$sleep1
        fi
      fi
      [[ $isfirst && $_idle_waiting ]] || ((sleep_amount>0))
    do
      local ble_util_idle_elapsed=$((_ble_util_idle_sclock-_idle_sclock_start))
      local interval=$((bleopt_idle_interval))
      if [[ ! $sleep_amount ]] || ((interval<sleep_amount)); then
        sleep_amount=$interval
      fi
      ble/util/idle/.sleep "$sleep_amount"
      ble/util/idle/IS_IDLE || return 148
      isfirst=
    done
  }
  function ble/util/idle.push/.impl {
    local base=$1 entry=$2
    local i=$base
    while [[ ${_ble_util_idle_task[i]-} ]]; do ((i++)); done
    _ble_util_idle_task[i]=$entry
    _ble_util_idle_lasttask=$i
  }
  function ble/util/idle.push {
    local status=R nice=0
    while [[ $1 == -* ]]; do
      case $1 in
      (-[SWPFEC]) status=${1:1}$2; shift 2 ;;
      (-[SWPFECIRZ]*) status=${1:1}; shift ;;
      (-n) nice=$2; shift 2 ;;
      (-n*) nice=${1#-n}; shift ;;
      (*) break ;;
      esac
    done
    ble/util/idle.push/.impl "$nice" "$status$_ble_util_idle_SEP$1"
  }
  function ble/util/idle.push-background {
    ble/util/idle.push -n 10000 "$@"
  }
  function ble/util/idle.cancel {
    local command=$1 i removed=
    for i in "${!_ble_util_idle_task[@]}"; do
      [[ ${_ble_util_idle_task[i]} == *"$_ble_util_idle_SEP$command" ]] &&
        builtin unset -v '_ble_util_idle_task[i]' &&
        removed=1
    done
    [[ $removed ]]
  }
  function ble/util/is-running-in-idle {
    [[ ${ble_util_idle_status+set} ]]
  }
  function ble/util/idle.suspend {
    [[ ${ble_util_idle_status+set} ]] || return 2
    ble_util_idle_status=Z
  }
  function ble/util/idle.sleep {
    [[ ${ble_util_idle_status+set} ]] || return 2
    local ret; ble/util/idle.clock
    ble_util_idle_status=S$((ret+$1))
  }
  function ble/util/idle.isleep {
    [[ ${ble_util_idle_status+set} ]] || return 2
    ble_util_idle_status=W$((_ble_util_idle_sclock+$1))
  }
  function ble/util/idle.sleep-until {
    [[ ${ble_util_idle_status+set} ]] || return 2
    if [[ :$2: == *:checked:* ]]; then
      local ret; ble/util/idle.clock
      (($1>ret)) || return 1
    fi
    ble_util_idle_status=S$1
  }
  function ble/util/idle.isleep-until {
    [[ ${ble_util_idle_status+set} ]] || return 2
    if [[ :$2: == *:checked:* ]]; then
      (($1>_ble_util_idle_sclock)) || return 1
    fi
    ble_util_idle_status=W$1
  }
  function ble/util/idle.wait-user-input {
    [[ ${ble_util_idle_status+set} ]] || return 2
    ble_util_idle_status=I
  }
  function ble/util/idle.wait-process {
    [[ ${ble_util_idle_status+set} ]] || return 2
    ble_util_idle_status=P$1
  }
  function ble/util/idle.wait-file-content {
    [[ ${ble_util_idle_status+set} ]] || return 2
    ble_util_idle_status=F$1
  }
  function ble/util/idle.wait-filename {
    [[ ${ble_util_idle_status+set} ]] || return 2
    ble_util_idle_status=E$1
  }
  function ble/util/idle.wait-condition {
    [[ ${ble_util_idle_status+set} ]] || return 2
    ble_util_idle_status=C$1
  }
  function ble/util/idle.continue {
    [[ ${ble_util_idle_status+set} ]] || return 2
    ble_util_idle_status=R
  }
  function ble/util/idle/.delare-external-modifier {
    local name=$1
    builtin eval -- 'function ble/util/idle#'$name' {
      local index=$1
      [[ ${_ble_util_idle_task[index]+set} ]] || return 2
      local ble_util_idle_status=${_ble_util_idle_task[index]%%"$_ble_util_idle_SEP"*}
      local ble_util_idle_command=${_ble_util_idle_task[index]#*"$_ble_util_idle_SEP"}
      ble/util/idle.'$name' "${@:2}"
      _ble_util_idle_task[index]=$ble_util_idle_status$_ble_util_idle_SEP$ble_util_idle_command
    }'
  }
  ble/util/idle/.delare-external-modifier suspend
  ble/util/idle/.delare-external-modifier sleep
  ble/util/idle/.delare-external-modifier isleep
  ble/util/idle.push-background 'ble/util/msleep/calibrate'
else
  function ble/util/idle.do { false; }
fi
_ble_util_fiberchain=()
_ble_util_fiberchain_prefix=
function ble/util/fiberchain#initialize {
  _ble_util_fiberchain=()
  _ble_util_fiberchain_prefix=$1
}
function ble/util/fiberchain#resume/.core {
  _ble_util_fiberchain=()
  local fib_clock=0
  local fib_ntask=$#
  while (($#)); do
    ((fib_ntask--))
    local fiber=${1%%:*} fib_suspend= fib_kill=
    local argv; ble/string#split-words argv "$fiber"
    [[ $1 == *:* ]] && fib_suspend=${1#*:}
    "$_ble_util_fiberchain_prefix/$argv.fib" "${argv[@]:1}"
    if [[ $fib_kill ]]; then
      break
    elif [[ $fib_suspend ]]; then
      _ble_util_fiberchain=("$fiber:$fib_suspend" "${@:2}")
      return 148
    fi
    shift
  done
}
function ble/util/fiberchain#resume {
  ble/util/fiberchain#resume/.core "${_ble_util_fiberchain[@]}"
}
function ble/util/fiberchain#push {
  ble/array#push _ble_util_fiberchain "$@"
}
function ble/util/fiberchain#clear {
  _ble_util_fiberchain=()
}
bleopt/declare -v vbell_default_message ' Wuff, -- Wuff!! '
bleopt/declare -v vbell_duration 2000
bleopt/declare -n vbell_align left
function ble/term:cygwin/initialize.hook {
  printf '\eM\e[B' >&$_ble_util_fd_stderr
  _ble_term_ri=$'\e[A'
  function ble/canvas/put-dl.draw {
    local value=${1-1} i
    ((value)) || return 1
    DRAW_BUFF[${#DRAW_BUFF[*]}]=$'\e[2K'
    if ((value>1)); then
      local ret
      ble/string#repeat $'\e[B\e[2K' $((value-1)); local a=$ret
      DRAW_BUFF[${#DRAW_BUFF[*]}]=$ret$'\e['$((value-1))'A'
    fi
    DRAW_BUFF[${#DRAW_BUFF[*]}]=${_ble_term_dl//'%d'/$value}
  }
}
function ble/term/DA2R.hook {
  blehook DA2R-=ble/term/DA2R.hook
  case $_ble_term_TERM in
  (contra:*)
    _ble_term_cuu=$'\e[%dk'
    _ble_term_cud=$'\e[%de'
    _ble_term_cuf=$'\e[%da'
    _ble_term_cub=$'\e[%dj'
    _ble_term_cup=$'\e[%l;%cf' ;;
  (cygwin:*)
    ble/term:cygwin/initialize.hook ;;
  esac
}
function ble/term/.initialize {
  if [[ -s $_ble_base_cache/term.$TERM && $_ble_base_cache/term.$TERM -nt $_ble_base/lib/init-term.sh ]]; then
    source "$_ble_base_cache/term.$TERM"
  else
    source "$_ble_base/lib/init-term.sh"
  fi
  ble/string#reserve-prototype "$_ble_term_it"
  blehook DA2R+=ble/term/DA2R.hook
}
ble/term/.initialize
function ble/term/put {
  BUFF[${#BUFF[@]}]=$1
}
function ble/term/cup {
  local x=$1 y=$2 esc=$_ble_term_cup
  esc=${esc//'%x'/$x}
  esc=${esc//'%y'/$y}
  esc=${esc//'%c'/$((x+1))}
  esc=${esc//'%l'/$((y+1))}
  BUFF[${#BUFF[@]}]=$esc
}
function ble/term/flush {
  IFS= builtin eval 'ble/util/put "${BUFF[*]}"'
  BUFF=()
}
function ble/term/audible-bell {
  ble/util/put '' 1>&2
}
_ble_term_visible_bell_prev=()
_ble_term_visible_bell_ftime=$_ble_base_run/$$.visible-bell.time
_ble_term_visible_bell_show='%message%'
_ble_term_visible_bell_clear=
function ble/term/visible-bell:term/init {
  if [[ ! $_ble_term_visible_bell_clear ]]; then
    local -a BUFF=()
    ble/term/put "$_ble_term_ri_or_cuu1$_ble_term_sc$_ble_term_sgr0"
    ble/term/cup 0 0
    ble/term/put "$_ble_term_el%message%$_ble_term_sgr0$_ble_term_rc${_ble_term_cud//'%d'/1}"
    IFS= builtin eval '_ble_term_visible_bell_show="${BUFF[*]}"'
    BUFF=()
    ble/term/put "$_ble_term_sc$_ble_term_sgr0"
    ble/term/cup 0 0
    ble/term/put "$_ble_term_el2$_ble_term_rc"
    IFS= builtin eval '_ble_term_visible_bell_clear="${BUFF[*]}"'
  fi
  local cols=${COLUMNS:-80}
  ((_ble_term_xenl||cols--))
  local message=${1::cols}
  _ble_term_visible_bell_prev=(term "$message")
}
function ble/term/visible-bell:term/show {
  local sgr=$1 message=${_ble_term_visible_bell_prev[1]}
  message=${_ble_term_visible_bell_show//'%message%'/"$sgr$message"}
  ble/util/put "$message" >&2
}
function ble/term/visible-bell:term/update {
  ble/term/visible-bell:term/show "$@"
}
function ble/term/visible-bell:term/clear {
  local sgr=$1
  ble/util/put "$_ble_term_visible_bell_clear" >&2
}
function ble/term/visible-bell:canvas/init {
  local message=$1
  local lines=1 cols=${COLUMNS:-80}
  ((_ble_term_xenl||cols--))
  local x= y=
  local ret sgr0= sgr1=
  ble/canvas/trace-text "$message" nonewline:external-sgr
  message=$ret
  local x0=0 y0=0
  if [[ $bleopt_vbell_align == right ]]; then
    ((x0=COLUMNS-1-x,x0<0&&(x0=0)))
  elif [[ $bleopt_vbell_align == center ]]; then
    ((x0=(COLUMNS-1-x)/2,x0<0&&(x0=0)))
  fi
  _ble_term_visible_bell_prev=(canvas "$message" "$x0" "$y0" "$x" "$y")
}
function ble/term/visible-bell:canvas/show {
  local sgr=$1 opts=$2
  local message=${_ble_term_visible_bell_prev[1]}
  local x0=${_ble_term_visible_bell_prev[2]}
  local y0=${_ble_term_visible_bell_prev[3]}
  local x=${_ble_term_visible_bell_prev[4]}
  local y=${_ble_term_visible_bell_prev[5]}
  local -a DRAW_BUFF=()
  [[ :$opts: != *:update:* && $_ble_attached ]] && # WA #D1495
    [[ $_ble_term_ri || :$opts: != *:erased:* && :$opts: != *:update:* ]] &&
    ble/canvas/panel/ensure-tmargin.draw
  if [[ $_ble_term_rc ]]; then
    local ret=
    [[ :$opts: != *:update:* && $_ble_attached ]] && ble/canvas/panel/save-position goto-top-dock # WA #D1495
    ble/canvas/put.draw "$_ble_term_ri_or_cuu1$_ble_term_sc$_ble_term_sgr0"
    ble/canvas/put-cup.draw $((y0+1)) $((x0+1))
    ble/canvas/put.draw "$sgr$message$_ble_term_sgr0"
    ble/canvas/put.draw "$_ble_term_rc"
    ble/canvas/put-cud.draw 1
    [[ :$opts: != *:update:* && $_ble_attached ]] && ble/canvas/panel/load-position.draw "$ret" # WA #D1495
  else
    ble/canvas/put.draw "$_ble_term_ri_or_cuu1$_ble_term_sgr0"
    ble/canvas/put-hpa.draw $((1+x0))
    ble/canvas/put.draw "$sgr$message$_ble_term_sgr0"
    ble/canvas/put-cud.draw 1
    ble/canvas/put-hpa.draw $((1+_ble_canvas_x))
  fi
  ble/canvas/bflush.draw
  ble/util/buffer.flush >&2
}
function ble/term/visible-bell:canvas/update {
  ble/term/visible-bell:canvas/show "$@"
}
function ble/term/visible-bell:canvas/clear {
  local sgr=$1
  local x0=${_ble_term_visible_bell_prev[2]}
  local y0=${_ble_term_visible_bell_prev[3]}
  local x=${_ble_term_visible_bell_prev[4]}
  local y=${_ble_term_visible_bell_prev[5]}
  local -a DRAW_BUFF=()
  if [[ $_ble_term_rc ]]; then
    local ret=
    ble/canvas/put.draw "$_ble_term_sc$_ble_term_sgr0"
    ble/canvas/put-cup.draw $((y0+1)) $((x0+1))
    ble/canvas/put.draw "$sgr"
    ble/canvas/put-spaces.draw "$x"
    ble/canvas/put.draw "$_ble_term_sgr0$_ble_term_rc"
  else
    : # 親プロセスの _ble_canvas_x が分からないので座標がずれる
  fi
  ble/canvas/flush.draw >&2
}
function ble/term/visible-bell/defface.hook {
  ble/color/defface vbell       reverse
  ble/color/defface vbell_flash reverse,fg=green
  ble/color/defface vbell_erase bg=252
}
blehook color_defface_load+=ble/term/visible-bell/defface.hook
function ble/term/visible-bell/.show {
  local bell_type=${_ble_term_visible_bell_prev[0]}
  ble/term/visible-bell:"$bell_type"/show "$@"
}
function ble/term/visible-bell/.update {
  local bell_type=${_ble_term_visible_bell_prev[0]}
  ble/term/visible-bell:"$bell_type"/update "$1" "$2:update"
}
function ble/term/visible-bell/.clear {
  local bell_type=${_ble_term_visible_bell_prev[0]}
  ble/term/visible-bell:"$bell_type"/clear "$@"
  >| "$_ble_term_visible_bell_ftime"
}
function ble/term/visible-bell/.erase-previous-visible-bell {
  local ret workers
  ble/util/eval-pathname-expansion '"$_ble_base_run/$$.visible-bell."*' canonical
  workers=("${ret[@]}")
  local workerfile
  for workerfile in "${workers[@]}"; do
    if [[ -s $workerfile && ! ( $workerfile -ot $_ble_term_visible_bell_ftime ) ]]; then
      ble/term/visible-bell/.clear "$sgr0"
      return 0
    fi
  done
  return 1
}
function ble/term/visible-bell/.create-workerfile {
  local i=0
  while
    workerfile=$_ble_base_run/$$.visible-bell.$i
    [[ -s $workerfile ]]
  do ((i++)); done
  ble/util/print 1 >| "$workerfile"
}
function ble/term/visible-bell/.worker {
  ble/util/msleep 50
  [[ $workerfile -ot $_ble_term_visible_bell_ftime ]] && return 0 >| "$workerfile"
  ble/term/visible-bell/.update "$sgr2"
  if [[ :$opts: == *:persistent:* ]]; then
    local dead_workerfile=$_ble_base_run/$$.visible-bell.Z
    ble/util/print 1 >| "$dead_workerfile"
    return 0 >| "$workerfile"
  fi
  local msec=$bleopt_vbell_duration
  ble/util/msleep "$msec"
  [[ $workerfile -ot $_ble_term_visible_bell_ftime ]] && return 0 >| "$workerfile"
  ble/term/visible-bell/.clear "$sgr0"
  >| "$workerfile"
}
function ble/term/visible-bell {
  local message=$1 opts=$2
  message=${message:-$bleopt_vbell_default_message}
  ((LINES==1)) && return 0
  if ble/is-function ble/canvas/trace-text; then
    ble/term/visible-bell:canvas/init "$message"
  else
    ble/term/visible-bell:term/init "$message"
  fi
  local sgr0=$_ble_term_sgr0
  local sgr1=${_ble_term_setaf[2]}$_ble_term_rev
  local sgr2=$_ble_term_rev
  if ble/is-function ble/color/face2sgr; then
    local ret
    ble/color/face2sgr vbell_flash; sgr1=$ret
    ble/color/face2sgr vbell; sgr2=$ret
    ble/color/face2sgr vbell_erase; sgr0=$ret
  fi
  local show_opts=
  ble/term/visible-bell/.erase-previous-visible-bell && show_opts=erased
  ble/term/visible-bell/.show "$sgr1" "$show_opts"
  local workerfile; ble/term/visible-bell/.create-workerfile
  ( ble/term/visible-bell/.worker __ble_suppress_joblist__ 1>/dev/null & )
}
function ble/term/visible-bell/cancel-erasure {
  >| "$_ble_term_visible_bell_ftime"
}
function ble/term/visible-bell/erase {
  local sgr0=$_ble_term_sgr0
  if ble/is-function ble/color/face2sgr; then
    local ret
    ble/color/face2sgr vbell_erase; sgr0=$ret
  fi
  ble/term/visible-bell/.erase-previous-visible-bell
}
_ble_term_stty_state=
_ble_term_stty_flags_enter=()
_ble_term_stty_flags_leave=()
ble/array#push _ble_term_stty_flags_enter intr undef quit undef susp undef
ble/array#push _ble_term_stty_flags_leave intr '' quit '' susp ''
function ble/term/stty/.initialize-flags {
  if [[ $TERM == minix ]]; then
    local stty; ble/util/assign stty 'stty -a'
    if [[ $stty == *' rprnt '* ]]; then
      ble/array#push _ble_term_stty_flags_enter rprnt undef
      ble/array#push _ble_term_stty_flags_leave rprnt ''
    elif [[ $stty == *' reprint '* ]]; then
      ble/array#push _ble_term_stty_flags_enter reprint undef
      ble/array#push _ble_term_stty_flags_leave reprint ''
    fi
  fi
}
ble/term/stty/.initialize-flags
function ble/term/stty/initialize {
  ble/bin/stty -ixon -echo -nl -icrnl -icanon \
               "${_ble_term_stty_flags_enter[@]}"
  _ble_term_stty_state=1
}
function ble/term/stty/leave {
  [[ ! $_ble_term_stty_state ]] && return 0
  ble/bin/stty echo -nl icanon \
               "${_ble_term_stty_flags_leave[@]}"
  _ble_term_stty_state=
}
function ble/term/stty/enter {
  [[ $_ble_term_stty_state ]] && return 0
  ble/bin/stty -echo -nl -icrnl -icanon \
               "${_ble_term_stty_flags_enter[@]}"
  _ble_term_stty_state=1
}
function ble/term/stty/finalize {
  ble/term/stty/leave
}
function ble/term/stty/TRAPEXIT {
  ble/bin/stty echo -nl \
               "${_ble_term_stty_flags_leave[@]}"
}
bleopt/declare -v term_cursor_external 0
_ble_term_cursor_current=unknown
_ble_term_cursor_internal=0
_ble_term_cursor_hidden_current=unknown
_ble_term_cursor_hidden_internal=reveal
_ble_term_cursor_current=0
function ble/term/cursor-state/.update {
  local state=$(($1))
  [[ $_ble_term_cursor_current == "$state" ]] && return 0
  if [[ ! $_ble_term_Ss ]]; then
    case $_ble_term_TERM in
    (mintty:*|xterm:*|RLogin:*|kitty:*|screen:*|tmux:*|contra:*|cygwin:*|wezterm:*|wt:*)
      local _ble_term_Ss=$'\e[@1 q' ;;
    esac
  fi
  local ret=${_ble_term_Ss//@1/"$state"}
  [[ $ret && $ret != $'\eP'*$'\e\\' ]] &&
    ble/term/quote-passthrough "$ret" '' all
  ble/util/buffer "$ret"
  _ble_term_cursor_current=$state
}
function ble/term/cursor-state/set-internal {
  _ble_term_cursor_internal=$1
  [[ $_ble_term_state == internal ]] &&
    ble/term/cursor-state/.update "$1"
}
function ble/term/cursor-state/.update-hidden {
  local state=$1
  [[ $state != hidden ]] && state=reveal
  [[ $_ble_term_cursor_hidden_current == "$state" ]] && return 0
  if [[ $state == hidden ]]; then
    ble/util/buffer "$_ble_term_civis"
  else
    ble/util/buffer "$_ble_term_cvvis"
  fi
  _ble_term_cursor_hidden_current=$state
}
function ble/term/cursor-state/hide {
  _ble_term_cursor_hidden_internal=hidden
  [[ $_ble_term_state == internal ]] &&
    ble/term/cursor-state/.update-hidden hidden
}
function ble/term/cursor-state/reveal {
  _ble_term_cursor_hidden_internal=reveal
  [[ $_ble_term_state == internal ]] &&
    ble/term/cursor-state/.update-hidden reveal
}
function ble/term/bracketed-paste-mode/enter {
  ble/util/buffer $'\e[?2004h'
}
function ble/term/bracketed-paste-mode/leave {
  ble/util/buffer $'\e[?2004l'
}
if [[ $TERM == minix ]]; then
  function ble/term/bracketed-paste-mode/enter { :; }
  function ble/term/bracketed-paste-mode/leave { :; }
fi
_ble_term_TERM=()
_ble_term_DA1R=()
_ble_term_DA2R=()
function ble/term/DA2/initialize-term {
  local depth=$1
  local DA2R=${_ble_term_DA2R[depth]}
  local rex='^[0-9]*(;[0-9]*)*$'; [[ $DA2R =~ $rex ]] || return
  local da2r
  ble/string#split da2r ';' "$DA2R"
  da2r=("${da2r[@]/#/10#0}") # 0で始まっていても10進数で解釈 (#D1570 is-array OK)
  case $DA2R in
  ('0;0;0')
    _ble_term_TERM[depth]=wezterm:0 ;;
  ('0;10;1') # Windows Terminal
    _ble_term_TERM[depth]=wt:0 ;;
  ('0;'*';1')
    if ((da2r[1]>=1001)); then
      _ble_term_TERM[depth]=alacritty:$((da2r[1]))
    fi ;;
  ('1;0'?????';0')
    _ble_term_TERM[depth]=foot:${DA2R:3:5} ;;
  ('1;'*)
    if ((4000<=da2r[1]&&da2r[1]<=4009&&3<=da2r[2])); then
      _ble_term_TERM[depth]=kitty:$((da2r[1]-4000))
    elif ((2000<=da2r[1]&&da2r[1]<5400&&da2r[2]==0)); then
      local version=$((da2r[1]))
      _ble_term_TERM[depth]=vte:$version
      if ((version<4000)); then
        _ble_term_Ss=
      fi
    fi ;;
  ('65;'*)
    if ((5300<=da2r[1]&&da2r[2]==1)); then
      _ble_term_TERM[depth]=vte:$((da2r[1]))
    elif ((da2r[1]>=100)); then
      _ble_term_TERM[depth]=RLogin:$((da2r[1]))
    fi ;;
  ('67;'*)
    local rex='^67;[0-9]{3,};0$'
    if [[ $TERM == cygwin && $DA2R =~ $rex ]]; then
      _ble_term_TERM[depth]=cygwin:$((da2r[1]))
    fi ;;
  ('77;'*';0')
    _ble_term_TERM[depth]=mintty:$((da2r[1])) ;;
  ('83;'*)
    local rex='^83;[0-9]+;0$'
    [[ $DA2R =~ $rex ]] && _ble_term_TERM[depth]=screen:$((da2r[1])) ;;
  ('84;0;0')
    _ble_term_TERM[depth]=tmux:0 ;;
  ('99;'*)
    _ble_term_TERM[depth]=contra:$((da2r[1])) ;;
  esac
  [[ ${_ble_term_TERM[depth]} ]] && return 0
  if rex='^xterm(-|$)'; [[ $TERM =~ $rex ]]; then
    local version=$((da2r[1]))
    if rex='^1;[0-9]+;0$'; [[ $DA2R =~ $rex ]]; then
      true
    elif rex='^0;[0-9]+;0$'; [[ $DA2R =~ $rex ]]; then
      ((95<=version))
    elif rex='^(2|24|1[89]|41|6[145]);[0-9]+;0$'; [[ $DA2R =~ $rex ]]; then
      ((280<=version))
    elif rex='^32;[0-9]+;0$'; [[ $DA2R =~ $rex ]]; then
      ((354<=version&&version<2000))
    else
      false
    fi && { _ble_term_TERM[depth]=xterm:$version; return; }
  fi
  _ble_term_TERM[depth]=unknown:-
  return 0
}
function ble/term/DA1/notify { _ble_term_DA1R=$1; blehook/invoke DA1R; }
function ble/term/DA2/notify {
  local depth=${#_ble_term_DA2R[@]}
  if ((depth==0)) || ble/string#match "${_ble_term_TERM[depth-1]}" '^(screen|tmux):'; then
    _ble_term_DA2R[depth]=$1
    ble/term/DA2/initialize-term "$depth"
    case ${_ble_term_TERM[depth]} in
    (screen:*|tmux:*)
      local ret
      ble/term/quote-passthrough $'\e[>c' $((depth+1))
      ble/util/buffer "$ret" ;;
    (contra:*)
      if [[ ! ${_ble_term_Ss-} ]]; then
        _ble_term_Ss=$'\e[@1 q'
      fi ;;
    esac
    ((depth)) && return 0
  fi
  blehook/invoke DA2R
}
function ble/term/quote-passthrough {
  local seq=$1 level=${2:-$((${#_ble_term_DA2R[@]}-1))} opts=$3
  local all=; [[ :$opts: == *:all:* ]] && all=1
  ret=$seq
  [[ $seq ]] || return 0
  local i
  for ((i=level;--i>=0;)); do
    if [[ ${_ble_term_TERM[i]} == tmux:* ]]; then
      ret=$'\ePtmux;'${ret//$'\e'/$'\e\e'}$'\e\\'${all:+$seq}
    else
      ret=$'\eP'${ret//$'\e\\'/$'\e\e\\\eP\\'}$'\e\\'${all:+$seq}
    fi
  done
}
_ble_term_DECSTBM=
_ble_term_DECSTBM_reset=
function ble/term/test-DECSTBM.hook1 {
  (($1==2)) && _ble_term_DECSTBM=$'\e[%s;%sr'
}
function ble/term/test-DECSTBM.hook2 {
  if [[ $_ble_term_DECSTBM ]]; then
    if (($1==2)); then
      _ble_term_DECSTBM_reset=$'\e[r'
    else
      _ble_term_DECSTBM_reset=$'\e[;r'
    fi
  fi
}
function ble/term/test-DECSTBM {
  local -a DRAW_BUFF=()
  ble/canvas/panel/goto-top-dock.draw
  ble/canvas/put.draw "$_ble_term_sc"$'\e[1;2r'
  ble/canvas/put-cup.draw 2 1
  ble/canvas/put-cud.draw 1
  ble/term/CPR/request.draw ble/term/test-DECSTBM.hook1
  ble/canvas/put.draw $'\e[;r'
  ble/canvas/put-cup.draw 2 1
  ble/canvas/put-cud.draw 1
  ble/term/CPR/request.draw ble/term/test-DECSTBM.hook2
  ble/canvas/put.draw $'\e[r'"$_ble_term_rc"
  ble/canvas/bflush.draw
}
_ble_term_CPR_timeout=60
_ble_term_CPR_last_seconds=$SECONDS
_ble_term_CPR_hook=()
function ble/term/CPR/request.buff {
  ((SECONDS>_ble_term_CPR_last_seconds+_ble_term_CPR_timeout)) &&
    _ble_term_CPR_hook=()
  _ble_term_CPR_last_seconds=$SECONDS
  ble/array#push _ble_term_CPR_hook "$1"
  ble/util/buffer $'\e[6n'
  return 147
}
function ble/term/CPR/request.draw {
  ((SECONDS>_ble_term_CPR_last_seconds+_ble_term_CPR_timeout)) &&
    _ble_term_CPR_hook=()
  _ble_term_CPR_last_seconds=$SECONDS
  ble/array#push _ble_term_CPR_hook "$1"
  ble/canvas/put.draw $'\e[6n'
  return 147
}
function ble/term/CPR/notify {
  local hook=${_ble_term_CPR_hook[0]}
  ble/array#shift _ble_term_CPR_hook
  [[ ! $hook ]] || builtin eval -- "$hook $1 $2"
}
bleopt/declare -v term_modifyOtherKeys_external auto
bleopt/declare -v term_modifyOtherKeys_internal auto
_ble_term_modifyOtherKeys_current=
function ble/term/modifyOtherKeys/.update {
  [[ $1 == "$_ble_term_modifyOtherKeys_current" ]] && return 0
  case $_ble_term_TERM in
  (RLogin:*)
    case $1 in
    (0) ble/util/buffer $'\e[>5;0m' ;;
    (1) ble/util/buffer $'\e[>5;1m' ;;
    (2) ble/util/buffer $'\e[>5;1m\e[>5;2m' ;;
    esac ;;
  (kitty:*)
    local da2r
    ble/string#split da2r ';' "$_ble_term_DA2R"
    if ((da2r[2]>=23)); then
      case $1 in
      (0|1) # pop keyboard mode
        [[ $_ble_term_modifyOtherKeys_current ]] || return 0
        ((_ble_term_modifyOtherKeys_current>=2)) &&
          ble/util/buffer $'\e[<u' ;;
      (2) # push keyboard mode
        ((_ble_term_modifyOtherKeys_current>=2)) &&
          ble/util/buffer $'\e[>1u' ;;
      esac
    else
      case $1 in
      (0|1) ble/util/buffer $'\e[>4;0m\e[>4m' ;;
      (2) ble/util/buffer $'\e[>4;1m\e[>4;2m\e[m' ;;
      esac
    fi
    _ble_term_modifyOtherKeys_current=$1
    return 0 ;;
  esac
  case $1 in
  (0) ble/util/buffer $'\e[>4;0m\e[m' ;;
  (1) ble/util/buffer $'\e[>4;1m\e[m' ;;
  (2) ble/util/buffer $'\e[>4;1m\e[>4;2m\e[m' ;;
  esac
  _ble_term_modifyOtherKeys_current=$1
}
function ble/term/modifyOtherKeys/.supported {
  [[ $_ble_term_TERM == vte:* ]] && return 1
  [[ $MWG_LOGINTERM == rosaterm ]] && return 1
  case $TERM in
  (linux)
    return 1 ;;
  (minix|sun*)
    return 1 ;;
  (st|st-*)
    return 1 ;;
  esac
  return 0
}
function ble/term/modifyOtherKeys/enter {
  local value=$bleopt_term_modifyOtherKeys_internal
  if [[ $value == auto ]]; then
    value=2
    ble/term/modifyOtherKeys/.supported || value=
  fi
  ble/term/modifyOtherKeys/.update "$value"
}
function ble/term/modifyOtherKeys/leave {
  local value=$bleopt_term_modifyOtherKeys_external
  if [[ $value == auto ]]; then
    value=1
    ble/term/modifyOtherKeys/.supported || value=
  fi
  ble/term/modifyOtherKeys/.update "$value"
}
_ble_term_altscr_state=
function ble/term/enter-altscr {
  [[ $_ble_term_altscr_state ]] && return 0
  _ble_term_altscr_state=("$_ble_canvas_x" "$_ble_canvas_y")
  if [[ $_ble_term_rmcup ]]; then
    ble/util/buffer "$_ble_term_smcup"
  else
    local -a DRAW_BUFF=()
    ble/canvas/put.draw $'\e[?1049h'
    ble/canvas/put-cup.draw "$LINES" 0
    ble/canvas/put-ind.draw "$LINES"
    ble/canvas/bflush.draw
  fi
}
function ble/term/leave-altscr {
  [[ $_ble_term_altscr_state ]] || return 0
  if [[ $_ble_term_rmcup ]]; then
    ble/util/buffer "$_ble_term_rmcup"
  else
    local -a DRAW_BUFF=()
    ble/canvas/put-cup.draw "$LINES" 0
    ble/canvas/put-ind.draw
    ble/canvas/put.draw $'\e[?1049l'
    ble/canvas/bflush.draw
  fi
  _ble_canvas_x=${_ble_term_altscr_state[0]}
  _ble_canvas_y=${_ble_term_altscr_state[1]}
  _ble_term_altscr_state=()
}
_ble_term_rl_convert_meta_adjusted=
_ble_term_rl_convert_meta_external=
function ble/term/rl-convert-meta/enter {
  [[ $_ble_term_rl_convert_meta_adjusted ]] && return 0
  _ble_term_rl_convert_meta_adjusted=1
  if ble/util/test-rl-variable convert-meta; then
    _ble_term_rl_convert_meta_external=on
    builtin bind 'set convert-meta off'
  else
    _ble_term_rl_convert_meta_external=off
  fi
}
function ble/term/rl-convert-meta/leave {
  [[ $_ble_term_rl_convert_meta_adjusted ]] || return 1
  _ble_term_rl_convert_meta_adjusted=
  [[ $_ble_term_rl_convert_meta_external == on ]] &&
    builtin bind 'set convert-meta on'
}
function ble/term/enter-for-widget {
  ble/term/bracketed-paste-mode/enter
  ble/term/modifyOtherKeys/enter
  ble/term/cursor-state/.update "$_ble_term_cursor_internal"
  ble/term/cursor-state/.update-hidden "$_ble_term_cursor_hidden_internal"
}
function ble/term/leave-for-widget {
  ble/term/visible-bell/erase
  ble/term/bracketed-paste-mode/leave
  ble/term/modifyOtherKeys/leave
  ble/term/cursor-state/.update "$bleopt_term_cursor_external"
  ble/term/cursor-state/.update-hidden reveal
}
_ble_term_state=external
function ble/term/enter {
  [[ $_ble_term_state == internal ]] && return 0
  ble/term/stty/enter
  ble/term/rl-convert-meta/enter
  ble/term/enter-for-widget
  _ble_term_state=internal
}
function ble/term/leave {
  [[ $_ble_term_state == external ]] && return 0
  ble/term/stty/leave
  ble/term/rl-convert-meta/leave
  ble/term/leave-for-widget
  _ble_term_cursor_current=unknown # vim は復元してくれない
  _ble_term_cursor_hidden_current=unknown
  _ble_term_state=external
}
function ble/term/finalize {
  ble/term/stty/finalize
  ble/term/leave
  ble/util/buffer.flush >&2
}
function ble/term/initialize {
  ble/term/stty/initialize
  ble/term/test-DECSTBM
  ble/term/enter
}
_ble_util_s2c_table_enabled=
if ((_ble_bash>=40100)); then
  function ble/util/s2c {
    builtin printf -v ret %d "'$1"
  }
elif ((_ble_bash>=40000&&!_ble_bash_loaded_in_function)); then
  declare -A _ble_util_s2c_table
  _ble_util_s2c_table_enabled=1
  function ble/util/s2c {
    [[ $_ble_util_locale_triple != "$LC_ALL:$LC_CTYPE:$LANG" ]] &&
      ble/util/.cache/update-locale
    local s=${1::1}
    ret=${_ble_util_s2c_table[x$s]}
    [[ $ret ]] && return 0
    ble/util/sprintf ret %d "'$s"
    _ble_util_s2c_table[x$s]=$ret
  }
elif ((_ble_bash>=40000)); then
  function ble/util/s2c {
    ble/util/sprintf ret %d "'${1::1}"
  }
else
  function ble/util/s2c {
    local s=${1::1}
    if [[ $s == [$'\x01'-$'\x7F'] ]]; then
      if [[ $s == $'\x7F' ]]; then
        ret=127
      else
        ble/util/sprintf ret %d "'$s"
      fi
      return 0
    fi
    local bytes byte TMOUT= 2>/dev/null # #D1630 WA readonly TMOUT
    ble/util/assign bytes '
      while IFS= builtin read "${_ble_bash_tmout_wa[@]}" -r -n 1 byte; do
        builtin printf "%d " "'\''$byte"
      done <<< "$s"
    '
    "ble/encoding:$bleopt_input_encoding/b2c" $bytes
  }
fi
if ((_ble_bash>=40200)); then
  function ble/util/.has-bashbug-printf-uffff {
    ((40200<=_ble_bash&&_ble_bash<40500)) || return 1
    local LC_ALL=C.UTF-8 2>/dev/null # Workaround: CentOS 7 に C.UTF-8 がなかった
    local ret
    builtin printf -v ret '\uFFFF'
    ((${#ret}==2))
  }
  ble/function#suppress-stderr ble/util/.has-bashbug-printf-uffff
  if ble/util/.has-bashbug-printf-uffff; then
    function ble/util/c2s.impl {
      if ((0xE000<=$1&&$1<=0xFFFF)) && [[ $_ble_util_locale_encoding == UTF-8 ]]; then
        builtin printf -v ret '\\x%02x' $((0xE0|$1>>12&0x0F)) $((0x80|$1>>6&0x3F)) $((0x80|$1&0x3F))
      else
        builtin printf -v ret '\\U%08x' "$1"
      fi
      builtin eval "ret=\$'$ret'"
    }
    function ble/util/chars2s.impl {
      if [[ $_ble_util_locale_encoding == UTF-8 ]]; then
        local -a buff=()
        local c i=0
        for c; do
          ble/util/c2s.cached "$c"
          buff[i++]=$ret
        done
        IFS= builtin eval 'ret="${buff[*]}"'
      else
        builtin printf -v ret '\\U%08x' "$@"
        builtin eval "ret=\$'$ret'"
      fi
    }
  else
    function ble/util/c2s.impl {
      builtin printf -v ret '\\U%08x' "$1"
      builtin eval "ret=\$'$ret'"
    }
    function ble/util/chars2s.impl {
      builtin printf -v ret '\\U%08x' "$@"
      builtin eval "ret=\$'$ret'"
    }
  fi
else
  _ble_text_xdigit=(0 1 2 3 4 5 6 7 8 9 A B C D E F)
  _ble_text_hexmap=()
  for ((i=0;i<256;i++)); do
    _ble_text_hexmap[i]=${_ble_text_xdigit[i>>4&0xF]}${_ble_text_xdigit[i&0xF]}
  done
  function ble/util/c2s.impl {
    if (($1<0x80)); then
      builtin eval "ret=\$'\\x${_ble_text_hexmap[$1]}'"
      return 0
    fi
    local bytes i iN seq=
    ble/encoding:"$_ble_util_locale_encoding"/c2b "$1"
    for ((i=0,iN=${#bytes[@]};i<iN;i++)); do
      seq="$seq\\x${_ble_text_hexmap[bytes[i]&0xFF]}"
    done
    builtin eval "ret=\$'$seq'"
  }
  function ble/util/chars2s.loop {
    for c; do
      ble/util/c2s.cached "$c"
      buff[i++]=$ret
    done
  }
  function ble/util/chars2s.impl {
    local -a buff=()
    local c i=0 b N=$# B=160
    for ((b=0;b+B<N;b+=B)); do
      ble/util/chars2s.loop "${@:b+1:B}"
    done
    ble/util/chars2s.loop "${@:b+1:N-b}"
    IFS= builtin eval 'ret="${buff[*]}"'
  }
fi
_ble_util_c2s_table=()
function ble/util/c2s {
  [[ $_ble_util_locale_triple != "$LC_ALL:$LC_CTYPE:$LANG" ]] &&
    ble/util/.cache/update-locale
  ret=${_ble_util_c2s_table[$1]-}
  if [[ ! $ret ]]; then
    ble/util/c2s.impl "$1"
    _ble_util_c2s_table[$1]=$ret
  fi
}
function ble/util/c2s.cached {
  ret=${_ble_util_c2s_table[$1]-}
  if [[ ! $ret ]]; then
    ble/util/c2s.impl "$1"
    _ble_util_c2s_table[$1]=$ret
  fi
}
function ble/util/chars2s {
  [[ $_ble_util_locale_triple != "$LC_ALL:$LC_CTYPE:$LANG" ]] &&
    ble/util/.cache/update-locale
  ble/util/chars2s.impl "$@"
}
function ble/util/c2bc {
  "ble/encoding:$bleopt_input_encoding/c2bc" "$1"
}
_ble_util_locale_triple=
_ble_util_locale_ctype=
_ble_util_locale_encoding=UTF-8
function ble/util/.cache/update-locale {
  _ble_util_locale_triple=$LC_ALL:$LC_CTYPE:$LANG
  local ret; ble/string#tolower "${LC_ALL:-${LC_CTYPE:-$LANG}}"
  if [[ $_ble_util_locale_ctype != "$ret" ]]; then
    _ble_util_locale_ctype=$ret
    _ble_util_c2s_table=()
    [[ $_ble_util_s2c_table_enabled ]] &&
      _ble_util_s2c_table=()
    _ble_util_locale_encoding=C
    if local rex='\.([^@]+)'; [[ $_ble_util_locale_ctype =~ $rex ]]; then
      local enc=${BASH_REMATCH[1]}
      if [[ $enc == utf-8 || $enc == utf8 ]]; then
        enc=UTF-8
      fi
      ble/is-function "ble/encoding:$enc/b2c" &&
        _ble_util_locale_encoding=$enc
    fi
  fi
}
function ble/util/s2chars {
  local text=$1 n=${#1} i chars
  chars=()
  for ((i=0;i<n;i++)); do
    ble/util/s2c "${text:i:1}"
    ble/array#push chars "$ret"
  done
  ret=("${chars[@]}")
}
function ble/util/s2bytes {
  local LC_ALL= LC_CTYPE=C
  ble/util/s2chars "$1"
}
ble/function#suppress-stderr ble/util/s2bytes
function ble/util/c2keyseq {
  local char=$(($1))
  case $char in
  (7)   ret='\a' ;;
  (8)   ret='\b' ;;
  (9)   ret='\t' ;;
  (10)  ret='\n' ;;
  (11)  ret='\v' ;;
  (12)  ret='\f' ;;
  (13)  ret='\r' ;;
  (27)  ret='\e' ;;
  (92)  ret='\\' ;;
  (127) ret='\d' ;;
  (28)  ret='\x1c' ;; # workaround \C-\, \C-\\
  (156) ret='\x9c' ;; # workaround \M-\C-\, \M-\C-\\
  (*)
    if ((char<32||128<=char&&char<160)); then
      local char7=$((char&0x7F))
      if ((1<=char7&&char7<=26)); then
        ble/util/c2s $((char7+96))
      else
        ble/util/c2s $((char7+64))
      fi
      ret='\C-'$ret
      ((char&0x80)) && ret='\M-'$ret
    else
      ble/util/c2s "$char"
    fi ;;
  esac
}
function ble/util/chars2keyseq {
  local char str=
  for char; do
    ble/util/c2keyseq "$char"
    str=$str$ret
  done
  ret=$str
}
function ble/util/keyseq2chars {
  local keyseq=$1
  local -a chars=()
  local mods=
  local rex='^([^\]+)|^\\([CM]-|[0-7]{1,3}|x[0-9a-fA-F]{1,2}|.)?'
  while [[ $keyseq ]]; do
    local text=${keyseq::1}
    [[ $keyseq =~ $rex ]] &&
      text=${BASH_REMATCH[1]} esc=${BASH_REMATCH[2]}
    if [[ $text ]]; then
      keyseq=${keyseq:${#text}}
      ble/util/s2chars "$text"
    else
      keyseq=${keyseq:1+${#esc}}
      ret=()
      case $esc in
      ([CM]-)  mods=$mods${esc::1}; continue ;;
      (x?*)    ret=$((16#${esc#x})) ;;
      ([0-7]*) ret=$((8#$esc)) ;;
      (a) ret=7 ;;
      (b) ret=8 ;;
      (t) ret=9 ;;
      (n) ret=10 ;;
      (v) ret=11 ;;
      (f) ret=12 ;;
      (r) ret=13 ;;
      (e) ret=27 ;;
      (d) ret=127 ;;
      (*) ble/util/s2c "$esc" ;;
      esac
    fi
    [[ $mods == *C* ]] && ((ret=ret==63?127:(ret&0x1F)))
    [[ $mods == *M* ]] && ble/array#push chars 27
    mods=
    ble/array#push chars "${ret[@]}"
  done
  if [[ $mods ]]; then
    [[ $mods == *M* ]] && ble/array#push chars 27
    ble/array#push chars 0
  fi
  ret=("${chars[@]}")
}
function ble/encoding:UTF-8/b2c {
  local bytes b0 n i
  bytes=("$@")
  ret=0
  ((b0=bytes[0]&0xFF))
  ((n=b0>0xF0
    ?(b0>0xFC?5:(b0>0xF8?4:3))
    :(b0>0xE0?2:(b0>0xC0?1:0)),
    ret=n?b0&0x7F>>n:b0))
  for ((i=1;i<=n;i++)); do
    ((ret=ret<<6|0x3F&bytes[i]))
  done
}
function ble/encoding:UTF-8/c2b {
  local code=$1 n i
  ((code=code&0x7FFFFFFF,
    n=code<0x80?0:(
      code<0x800?1:(
        code<0x10000?2:(
          code<0x200000?3:(
            code<0x4000000?4:5))))))
  if ((n==0)); then
    bytes=("$code")
  else
    bytes=()
    for ((i=n;i;i--)); do
      ((bytes[i]=0x80|code&0x3F,
        code>>=6))
    done
    ((bytes[0]=code&0x3F>>n|0xFF80>>n&0xFF))
  fi
}
function ble/encoding:C/b2c {
  local byte=$1
  ((ret=byte&0xFF))
}
function ble/encoding:C/c2b {
  local code=$1
  bytes=($((code&0xFF)))
}
function ble/util/is-unicode-output {
  [[ $_ble_util_locale_triple != "$LC_ALL:$LC_CTYPE:$LANG" ]] &&
    ble/util/.cache/update-locale
  [[ $_ble_util_locale_encoding == UTF-8 ]]
}
ble/bin/.freeze-utility-path "${_ble_init_posix_command_list[@]}" # <- this uses ble/util/assign.
ble/bin/.freeze-utility-path man
ble/bin/.freeze-utility-path groff nroff mandoc gzip bzcat lzcat xzcat # used by core-complete.sh
ble/builtin/trap/install-hook EXIT
ble/builtin/trap/install-hook INT
blehook ERR+='ble/builtin/trap/invoke ERR'
blehook ERR+='ble/function#try TRAPERR'
bleopt/declare -v decode_error_char_abell ''
bleopt/declare -v decode_error_char_vbell 1
bleopt/declare -v decode_error_char_discard ''
bleopt/declare -v decode_error_cseq_abell ''
bleopt/declare -v decode_error_cseq_vbell ''
bleopt/declare -v decode_error_cseq_discard 1
bleopt/declare -v decode_error_kseq_abell 1
bleopt/declare -v decode_error_kseq_vbell 1
bleopt/declare -v decode_error_kseq_discard 1
bleopt/declare -n default_keymap auto
function bleopt/check:default_keymap {
  case $value in
  (auto|emacs|vi|safe)
    if [[ $_ble_decode_bind_state != none ]]; then
      local bleopt_default_keymap=$value
      ble/decode/reset-default-keymap
    fi
    return 0 ;;
  (*)
    ble/util/print "bleopt: Invalid value default_keymap='value'. The value should be one of \`auto', \`emacs', \`vi'." >&2
    return 1 ;;
  esac
}
function bleopt/get:default_keymap {
  ret=$bleopt_default_keymap
  if [[ $ret == auto ]]; then
    if [[ -o vi ]]; then
      ret=vi
    else
      ret=emacs
    fi
  fi
}
bleopt/declare -n decode_isolated_esc auto
function bleopt/check:decode_isolated_esc {
  case $value in
  (meta|esc|auto) ;;
  (*)
    ble/util/print "bleopt: Invalid value decode_isolated_esc='$value'. One of the values 'auto', 'meta' or 'esc' is expected." >&2
    return 1 ;;
  esac
}
function ble/decode/uses-isolated-esc {
  if [[ $bleopt_decode_isolated_esc == esc ]]; then
    return 0
  elif [[ $bleopt_decode_isolated_esc == auto ]]; then
    if local ret; bleopt/get:default_keymap; [[ $ret == vi ]]; then
      return 0
    elif [[ ! $_ble_decode_key__seq ]]; then
      local dicthead=_ble_decode_${_ble_decode_keymap}_kmap_ key=$((_ble_decode_Ctrl|91))
      builtin eval "local ent=\${$dicthead$_ble_decode_key__seq[key]-}"
      [[ ${ent:2} ]] && return 0
    fi
  fi
  return 1
}
bleopt/declare -n decode_abort_char 28
bleopt/declare -n decode_macro_limit 1024
_ble_decode_Meta=0x08000000
_ble_decode_Ctrl=0x04000000
_ble_decode_Shft=0x02000000
_ble_decode_Hypr=0x01000000
_ble_decode_Supr=0x00800000
_ble_decode_Altr=0x00400000
_ble_decode_MaskChar=0x001FFFFF
_ble_decode_MaskFlag=0x7FC00000
_ble_decode_Erro=0x40000000
_ble_decode_Macr=0x20000000
_ble_decode_Flag3=0x10000000 # unused
_ble_decode_FlagA=0x00200000 # unused
_ble_decode_IsolatedESC=$((0x07FF))
_ble_decode_EscapedNUL=$((0x07FE)) # charlog#encode で用いる
_ble_decode_FunctionKeyBase=0x110000
_ble_decode_kbd_ver=gdict
_ble_decode_kbd__n=0
_ble_decode_kbd__c2k=()
builtin eval -- "${_ble_util_gdict_declare//NAME/_ble_decode_kbd__k2c}"
ble/is-assoc _ble_decode_kbd__k2c || _ble_decode_kbd_ver=adict
function ble-decode-kbd/.set-keycode {
  local keyname=$1
  local code=$2
  : "${_ble_decode_kbd__c2k[code]:=$keyname}"
  ble/gdict#set _ble_decode_kbd__k2c "$keyname" "$code"
}
function ble-decode-kbd/.get-keycode {
  ble/gdict#get _ble_decode_kbd__k2c "$1"
}
function ble-decode-kbd/.get-keyname {
  local keycode=$1
  ret=${_ble_decode_kbd__c2k[keycode]}
  if [[ ! $ret ]] && ((keycode<_ble_decode_FunctionKeyBase)); then
    ble/util/c2s "$keycode"
  fi
}
function ble-decode-kbd/generate-keycode {
  local keyname=$1
  if ((${#keyname}==1)); then
    ble/util/s2c "$1"
  elif [[ $keyname && ! ${keyname//[a-zA-Z_0-9]} ]]; then
    ble-decode-kbd/.get-keycode "$keyname"
    if [[ ! $ret ]]; then
      ((ret=_ble_decode_FunctionKeyBase+_ble_decode_kbd__n++))
      ble-decode-kbd/.set-keycode "$keyname" "$ret"
    fi
  else
    ret=-1
    return 1
  fi
}
function ble-decode-kbd/.initialize {
  ble-decode-kbd/.set-keycode TAB  9
  ble-decode-kbd/.set-keycode RET  13
  ble-decode-kbd/.set-keycode NUL  0
  ble-decode-kbd/.set-keycode SOH  1
  ble-decode-kbd/.set-keycode STX  2
  ble-decode-kbd/.set-keycode ETX  3
  ble-decode-kbd/.set-keycode EOT  4
  ble-decode-kbd/.set-keycode ENQ  5
  ble-decode-kbd/.set-keycode ACK  6
  ble-decode-kbd/.set-keycode BEL  7
  ble-decode-kbd/.set-keycode BS   8
  ble-decode-kbd/.set-keycode HT   9  # aka TAB
  ble-decode-kbd/.set-keycode LF   10
  ble-decode-kbd/.set-keycode VT   11
  ble-decode-kbd/.set-keycode FF   12
  ble-decode-kbd/.set-keycode CR   13 # aka RET
  ble-decode-kbd/.set-keycode SO   14
  ble-decode-kbd/.set-keycode SI   15
  ble-decode-kbd/.set-keycode DLE  16
  ble-decode-kbd/.set-keycode DC1  17
  ble-decode-kbd/.set-keycode DC2  18
  ble-decode-kbd/.set-keycode DC3  19
  ble-decode-kbd/.set-keycode DC4  20
  ble-decode-kbd/.set-keycode NAK  21
  ble-decode-kbd/.set-keycode SYN  22
  ble-decode-kbd/.set-keycode ETB  23
  ble-decode-kbd/.set-keycode CAN  24
  ble-decode-kbd/.set-keycode EM   25
  ble-decode-kbd/.set-keycode SUB  26
  ble-decode-kbd/.set-keycode ESC  27
  ble-decode-kbd/.set-keycode FS   28
  ble-decode-kbd/.set-keycode GS   29
  ble-decode-kbd/.set-keycode RS   30
  ble-decode-kbd/.set-keycode US   31
  ble-decode-kbd/.set-keycode SP   32
  ble-decode-kbd/.set-keycode DEL  127
  ble-decode-kbd/.set-keycode PAD  128
  ble-decode-kbd/.set-keycode HOP  129
  ble-decode-kbd/.set-keycode BPH  130
  ble-decode-kbd/.set-keycode NBH  131
  ble-decode-kbd/.set-keycode IND  132
  ble-decode-kbd/.set-keycode NEL  133
  ble-decode-kbd/.set-keycode SSA  134
  ble-decode-kbd/.set-keycode ESA  135
  ble-decode-kbd/.set-keycode HTS  136
  ble-decode-kbd/.set-keycode HTJ  137
  ble-decode-kbd/.set-keycode VTS  138
  ble-decode-kbd/.set-keycode PLD  139
  ble-decode-kbd/.set-keycode PLU  140
  ble-decode-kbd/.set-keycode RI   141
  ble-decode-kbd/.set-keycode SS2  142
  ble-decode-kbd/.set-keycode SS3  143
  ble-decode-kbd/.set-keycode DCS  144
  ble-decode-kbd/.set-keycode PU1  145
  ble-decode-kbd/.set-keycode PU2  146
  ble-decode-kbd/.set-keycode STS  147
  ble-decode-kbd/.set-keycode CCH  148
  ble-decode-kbd/.set-keycode MW   149
  ble-decode-kbd/.set-keycode SPA  150
  ble-decode-kbd/.set-keycode EPA  151
  ble-decode-kbd/.set-keycode SOS  152
  ble-decode-kbd/.set-keycode SGCI 153
  ble-decode-kbd/.set-keycode SCI  154
  ble-decode-kbd/.set-keycode CSI  155
  ble-decode-kbd/.set-keycode ST   156
  ble-decode-kbd/.set-keycode OSC  157
  ble-decode-kbd/.set-keycode PM   158
  ble-decode-kbd/.set-keycode APC  159
  ble-decode-kbd/.set-keycode @ESC "$_ble_decode_IsolatedESC"
  ble-decode-kbd/.set-keycode @NUL "$_ble_decode_EscapedNUL"
  local ret
  ble-decode-kbd/generate-keycode __batch_char__
  _ble_decode_KCODE_BATCH_CHAR=$ret
  ble-decode-kbd/generate-keycode __defchar__
  _ble_decode_KCODE_DEFCHAR=$ret
  ble-decode-kbd/generate-keycode __default__
  _ble_decode_KCODE_DEFAULT=$ret
  ble-decode-kbd/generate-keycode __before_widget__
  _ble_decode_KCODE_BEFORE_WIDGET=$ret
  ble-decode-kbd/generate-keycode __after_widget__
  _ble_decode_KCODE_AFTER_WIDGET=$ret
  ble-decode-kbd/generate-keycode __attach__
  _ble_decode_KCODE_ATTACH=$ret
  ble-decode-kbd/generate-keycode __detach__
  _ble_decode_KCODE_DETACH=$ret
  ble-decode-kbd/generate-keycode shift
  _ble_decode_KCODE_SHIFT=$ret
  ble-decode-kbd/generate-keycode alter
  _ble_decode_KCODE_ALTER=$ret
  ble-decode-kbd/generate-keycode control
  _ble_decode_KCODE_CONTROL=$ret
  ble-decode-kbd/generate-keycode meta
  _ble_decode_KCODE_META=$ret
  ble-decode-kbd/generate-keycode super
  _ble_decode_KCODE_SUPER=$ret
  ble-decode-kbd/generate-keycode hyper
  _ble_decode_KCODE_HYPER=$ret
  ble-decode-kbd/generate-keycode __ignore__
  _ble_decode_KCODE_IGNORE=$ret
  ble-decode-kbd/generate-keycode __error__
  _ble_decode_KCODE_ERROR=$ret
  ble-decode-kbd/generate-keycode __line_limit__
  _ble_decode_KCODE_LINE_LIMIT=$ret
  ble-decode-kbd/generate-keycode mouse
  _ble_decode_KCODE_MOUSE=$ret
  ble-decode-kbd/generate-keycode mouse_move
  _ble_decode_KCODE_MOUSE_MOVE=$ret
  ble-decode-kbd/generate-keycode auto_complete_enter
}
ble-decode-kbd/.initialize
function ble-decode-kbd {
  local IFS=$_ble_term_IFS
  local spec="$*"
  case $spec in
  (keys:*)
    ret="${spec#*:}"
    return ;;
  (chars:*)
    local chars
    ble/string#split-words chars "${spec#*:}"
    ble/decode/cmap/decode-chars "${ret[@]}"
    ret="${keys[*]}"
    return ;;
  (keyseq:*) # i.e. untranslated keyseq
    local keys
    ble/util/keyseq2chars "${spec#*:}"
    ble/decode/cmap/decode-chars "${ret[@]}"
    ret="${keys[*]}"
    return ;;
  (raw:*) # i.e. translated keyseq
    ble/util/s2chars "${spec#*:}"
    ble/decode/cmap/decode-chars "${ret[@]}"
    ret="${keys[*]}"
    return ;;
  (kspecs:*)
    spec=${spec#*:} ;;
  esac
  local kspecs; ble/string#split-words kspecs "$spec"
  local kspec code codes
  codes=()
  for kspec in "${kspecs[@]}"; do
    code=0
    while [[ $kspec == ?-* ]]; do
      case "${kspec::1}" in
      (S) ((code|=_ble_decode_Shft)) ;;
      (C) ((code|=_ble_decode_Ctrl)) ;;
      (M) ((code|=_ble_decode_Meta)) ;;
      (A) ((code|=_ble_decode_Altr)) ;;
      (s) ((code|=_ble_decode_Supr)) ;;
      (H) ((code|=_ble_decode_Hypr)) ;;
      (*) ((code|=_ble_decode_Erro)) ;;
      esac
      kspec=${kspec:2}
    done
    if [[ $kspec == ? ]]; then
      ble/util/s2c "$kspec"
      ((code|=ret))
    elif [[ $kspec && ! ${kspec//[@_0-9a-zA-Z]} ]]; then
      ble-decode-kbd/.get-keycode "$kspec"
      [[ $ret ]] || ble-decode-kbd/generate-keycode "$kspec"
      ((code|=ret))
    elif [[ $kspec == ^? ]]; then
      if [[ $kspec == '^?' ]]; then
        ((code|=0x7F))
      elif [[ $kspec == '^`' ]]; then
        ((code|=0x20))
      else
        ble/util/s2c "${kspec:1}"
        ((code|=ret&0x1F))
      fi
    elif local rex='^U\+([0-9a-fA-F]+)$'; [[ $kspec =~ $rex ]]; then
      ((code|=0x${BASH_REMATCH[1]}))
    else
      ((code|=_ble_decode_Erro))
    fi
    codes[${#codes[@]}]=$code
  done
  ret="${codes[*]}"
}
function ble-decode-unkbd/.single-key {
  local key=$1
  local f_unknown=
  local char=$((key&_ble_decode_MaskChar))
  ble-decode-kbd/.get-keyname "$char"
  if [[ ! $ret ]]; then
    f_unknown=1
    ret=__UNKNOWN__
  fi
  ((key&_ble_decode_Shft)) && ret=S-$ret
  ((key&_ble_decode_Meta)) && ret=M-$ret
  ((key&_ble_decode_Ctrl)) && ret=C-$ret
  ((key&_ble_decode_Altr)) && ret=A-$ret
  ((key&_ble_decode_Supr)) && ret=s-$ret
  ((key&_ble_decode_Hypr)) && ret=H-$ret
  [[ ! $f_unknown ]]
}
function ble-decode-unkbd {
  local IFS=$_ble_term_IFS
  local -a kspecs
  local key
  for key in $*; do
    ble-decode-unkbd/.single-key "$key"
    kspecs[${#kspecs[@]}]=$ret
  done
  ret="${kspecs[*]}"
}
function ble-decode/PROLOGUE { :; }
function ble-decode/EPILOGUE { :; }
_ble_decode_input_buffer=()
_ble_decode_input_count=0
_ble_decode_input_original_info=()
_ble_decode_show_progress_hook=ble-decode/.hook/show-progress
_ble_decode_erase_progress_hook=ble-decode/.hook/erase-progress
function ble-decode/.hook/show-progress {
  if [[ $_ble_edit_info_scene == store ]]; then
    _ble_decode_input_original_info=("${_ble_edit_info[@]}")
    return 0
  elif [[ $_ble_edit_info_scene == default ]]; then
    _ble_decode_input_original_info=()
  elif [[ $_ble_edit_info_scene != decode_input_progress ]]; then
    return 0
  fi
  local progress_opts= opt_percentage=1
  if [[ $ble_batch_insert_count ]]; then
    local total=$ble_batch_insert_count
    local value=$ble_batch_insert_index
    local label='constructing text...'
    local sgr=$'\e[1;38;5;204;48;5;253m'
  elif ((${#_ble_decode_input_buffer[@]})); then
    local total=10000
    local value=$((${#_ble_decode_input_buffer[@]}%10000))
    local label="${#_ble_decode_input_buffer[@]} bytes received..."
    local sgr=$'\e[1;38;5;135;48;5;253m'
    progress_opts=unlimited
    opt_percentage=
  elif ((_ble_decode_input_count)); then
    local total=${#chars[@]}
    local value=$((total-_ble_decode_input_count-1))
    local label='decoding input...'
    local sgr=$'\e[1;38;5;69;48;5;253m'
  elif ((ble_decode_char_total)); then
    local total=$ble_decode_char_total
    local value=$((total-ble_decode_char_rest-1))
    local label='processing input...'
    local sgr=$'\e[1;38;5;71;48;5;253m'
  else
    return 0
  fi
  if [[ $opt_percentage ]]; then
    local mill=$((value*1000/total))
    local cent=${mill::${#mill}-1} frac=${mill:${#mill}-1}
    label="${cent:-0}.$frac% $label"
  fi
  local text="($label)"
  if ble/util/is-unicode-output; then
    local ret
    ble/string#create-unicode-progress-bar "$value" "$total" 10 "$progress_opts"
    text=$sgr$ret$'\e[m '$text
  fi
  ble/edit/info/show ansi "$text"
  _ble_edit_info_scene=decode_input_progress
}
function ble-decode/.hook/erase-progress {
  [[ $_ble_edit_info_scene == decode_input_progress ]] || return 1
  if ((${#_ble_decode_input_original_info[@]})); then
    ble/edit/info/show store "${_ble_decode_input_original_info[@]}"
  else
    ble/edit/info/default
  fi
}
function ble-decode/.check-abort {
  if (($1==bleopt_decode_abort_char)); then
    local nbytes=${#_ble_decode_input_buffer[@]}
    local nchars=${#_ble_decode_char_buffer[@]}
    ((nbytes||nchars)); return "$?"
  fi
  (($1==0x7e||$1==0x75)) || return 1
  local i=$((${#_ble_decode_input_buffer[@]}-1))
  local n
  ((n=bleopt_decode_abort_char,
    n+=(1<=n&&n<=26?96:64)))
  if (($1==0x7e)); then
    for ((;n;n/=10)); do
      ((i>=0)) && ((_ble_decode_input_buffer[i--]==n%10+48)) || return 1
    done
    ((i>=4)) || return 1
    ((_ble_decode_input_buffer[i--]==59)) || return 1
    ((_ble_decode_input_buffer[i--]==53)) || return 1
    ((_ble_decode_input_buffer[i--]==59)) || return 1
    ((_ble_decode_input_buffer[i--]==55)) || return 1
    ((_ble_decode_input_buffer[i--]==50)) || return 1
  elif (($1==0x75)); then
    ((i>=1)) || return 1
    ((_ble_decode_input_buffer[i--]==53)) || return 1
    ((_ble_decode_input_buffer[i--]==59)) || return 1
    for ((;n;n/=10)); do
      ((i>=0)) && ((_ble_decode_input_buffer[i--]==n%10+48)) || return 1
    done
  fi
  ((i>=0)) && ((_ble_decode_input_buffer[i]==62&&i--))
  ((i>=0)) || return 1
  if ((_ble_decode_input_buffer[i]==0x5B)); then
    if ((i>=1&&_ble_decode_input_buffer[i-1]==0x1B)); then
      ((i-=2))
    elif ((i>=2&&_ble_decode_input_buffer[i-1]==0x9B&&_ble_decode_input_buffer[i-2]==0xC0)); then
      ((i-=3))
    else
      return 1
    fi
  elif ((_ble_decode_input_buffer[i]==0x9B)); then
    ((--i>=0)) && ((_ble_decode_input_buffer[i--]==0xC2)) || return 1
  else
    return 1
  fi
  (((i>=0||${#_ble_decode_char_buffer[@]}))); return "$?"
  return 0
}
if ((_ble_bash>=40400)); then
  function ble/decode/nonblocking-read {
    local timeout=${1:-0.01} ntimeout=${2:-1} loop=${3:-100}
    local LC_ALL= LC_CTYPE=C IFS=
    local -a data=()
    local line buff ext
    while ((loop--)); do
      builtin read -t "$timeout" -r -d '' buff; ext=$?
      [[ $buff ]] && line=$line$buff
      if ((ext==0)); then
        ble/array#push data "$line"
        line=
      elif ((ext>128)); then
        ((--ntimeout)) || break
        [[ $buff ]] || break
      else
        break
      fi
    done
    ble/util/assign ret '{
      ((${#data[@]})) && printf %s\\0 "${data[@]}"
      [[ $line ]] && printf %s "$line"
    } | ble/bin/od -A n -t u1 -v'
    ble/string#split-words ret "$ret"
  }
  ble/function#suppress-stderr ble/decode/nonblocking-read
elif ((_ble_bash>=40000)); then
  function ble/decode/nonblocking-read {
    local timeout=${1:-0.01} ntimeout=${2:-1} loop=${3:-100}
    local LC_ALL= LC_CTYPE=C TMOUT= IFS= 2>/dev/null # #D1630 WA readonly TMOUT
    local -a data=()
    local line buff
    while ((loop--)); do
      builtin read -t 0 || break
      builtin read "${_ble_bash_tmout_wa[@]}" -r -d '' -n 1 buff || break
      if [[ $buff ]]; then
        line=$line$buff
      else
        ble/array#push data "$line"
        line=
      fi
    done
    ble/util/assign ret '{
      ((${#data[@]})) && printf %s\\0 "${data[@]}"
      [[ $line ]] && printf %s "$line"
    } | ble/bin/od -A n -t u1 -v'
    ble/string#split-words ret "$ret"
  }
  ble/function#suppress-stderr ble/decode/nonblocking-read
fi
_ble_decode_hook_Processing=
function ble-decode/.hook {
  if ble/util/is-stdin-ready; then
    ble/array#push _ble_decode_input_buffer "$@"
    local buflen=${#_ble_decode_input_buffer[@]}
    if ((buflen%257==0&&buflen>=2000)); then
      local IFS=$_ble_term_IFS
      ble-decode/PROLOGUE
      local char=${_ble_decode_input_buffer[buflen-1]}
      if ((_ble_bash<40000||char==0xC0||char==0xDF)); then
        builtin eval -- "$_ble_decode_show_progress_hook"
      else
        while ble/util/is-stdin-ready; do
          builtin eval -- "$_ble_decode_show_progress_hook"
          local ret; ble/decode/nonblocking-read 0.02 1 527
          ble/array#push _ble_decode_input_buffer "${ret[@]}"
        done
      fi
      ble-decode/EPILOGUE
      ble/array#pop _ble_decode_input_buffer
      ble-decode/.hook "$ret"
    fi
    return 0
  fi
  [[ $_ble_bash_options_adjusted ]] && set +v || :
  local IFS=$_ble_term_IFS
  local _ble_decode_hook_Processing=prologue
  ble-decode/PROLOGUE
  _ble_decode_hook_Processing=body
  if ble-decode/.check-abort "$1"; then
    _ble_decode_char__hook=
    _ble_decode_input_buffer=()
    _ble_decode_char_buffer=()
    ble/term/visible-bell "Abort by 'bleopt decode_abort_char=$bleopt_decode_abort_char'"
    shift
  fi
  local chars
  ble/array#set chars "${_ble_decode_input_buffer[@]}" "$@"
  _ble_decode_input_buffer=()
  _ble_decode_input_count=${#chars[@]}
  if ((_ble_decode_input_count>=200)); then
    local decode=ble/encoding:$bleopt_input_encoding/decode
    local i N=${#chars[@]}
    local B=$((N/100))
    ((B<100)) && B=100 || ((B>1000)) && B=1000
    for ((i=0;i<N;i+=B)); do
      ((_ble_decode_input_count=N-i-B))
      ((_ble_decode_input_count<0)) && _ble_decode_input_count=0
      builtin eval -- "$_ble_decode_show_progress_hook"
      ((_ble_debug_keylog_enabled)) && ble/array#push _ble_debug_keylog_bytes "${chars[@]:i:B}"
      "$decode" "${chars[@]:i:B}"
    done
  else
    local c
    for c in "${chars[@]}"; do
      ((--_ble_decode_input_count))
      ((_ble_debug_keylog_enabled)) && ble/array#push _ble_debug_keylog_bytes "$c"
      "ble/encoding:$bleopt_input_encoding/decode" "$c"
    done
  fi
  ble/decode/has-input || ble-decode-key/batch/flush
  builtin eval -- "$_ble_decode_erase_progress_hook"
  _ble_decode_hook_Processing=epilogue
  ble-decode/EPILOGUE
}
function ble-decode-byte {
  while (($#)); do
    "ble/encoding:$bleopt_input_encoding/decode" "$1"
    shift
  done
}
_ble_decode_csi_mode=0
_ble_decode_csi_args=
_ble_decode_csimap_tilde=()
_ble_decode_csimap_alpha=()
function ble-decode-char/csi/print/.print-csidef {
  local qalpha qkey ret q=\' Q="'\''"
  if [[ $sgrq ]]; then
    ble/string#quote-word "$1" quote-empty:sgrq="$sgrq":sgr0="$sgr0"; qalpha=$ret
    ble/string#quote-word "$2" quote-empty:sgrq="$sgrq":sgr0="$sgr0"; qkey=$ret
  else
    qalpha="'${1//$q/$Q}'"
    qkey="'${2//$q/$Q}'"
  fi
  ble/util/print "${sgrf}ble-bind$sgr0 $sgro--csi$sgr0 $qalpha $qkey"
}
function ble-decode-char/csi/print {
  [[ $ble_bind_print ]] || local sgr0= sgrf= sgrq= sgrc= sgro=
  local num ret
  for num in "${!_ble_decode_csimap_tilde[@]}"; do
    ble-decode-unkbd "${_ble_decode_csimap_tilde[num]}"
    ble-decode-char/csi/print/.print-csidef "$num~" "$ret"
  done
  for num in "${!_ble_decode_csimap_alpha[@]}"; do
    local s; ble/util/c2s "$num"; s=$ret
    ble-decode-unkbd "${_ble_decode_csimap_alpha[num]}"
    ble-decode-char/csi/print/.print-csidef "$s" "$ret"
  done
}
function ble-decode-char/csi/clear {
  _ble_decode_csi_mode=0
}
_ble_decode_csimap_kitty_u=()
function ble-decode/char/csi/.translate-kitty-csi-u {
  local name=${_ble_decode_csimap_kitty_u[key]}
  if [[ $name ]]; then
    local ret
    ble-decode-kbd/generate-keycode "$name"
    key=$ret
  fi
}
function ble-decode-char/csi/.modify-key {
  local mod=$(($1-1))
  if ((mod>=0)); then
    if ((33<=key&&key<_ble_decode_FunctionKeyBase)); then
      if (((mod&0x01)&&0x31<=key&&key<=0x39)) && [[ $_ble_term_TERM == RLogin:* ]]; then
        ((key-=16,mod&=~0x01))
      elif ((mod==0x01)); then
        mod=0
      elif ((65<=key&&key<=90)); then
        ((key|=0x20))
      fi
    fi
    ((mod&0x01&&(key|=_ble_decode_Shft),
      mod&0x02&&(key|=_ble_decode_Meta),
      mod&0x04&&(key|=_ble_decode_Ctrl),
      mod&0x08&&(key|=_ble_decode_Supr),
      mod&0x10&&(key|=_ble_decode_Hypr),
      mod&0x20&&(key|=_ble_decode_Altr)))
  fi
}
function ble-decode-char/csi/.decode {
  local char=$1 rex key
  if ((char==126)); then # ~
    if rex='^>?27;([0-9]+);?([0-9]+)$' && [[ $_ble_decode_csi_args =~ $rex ]]; then
      local param1=$((10#0${BASH_REMATCH[1]}))
      local param2=$((10#0${BASH_REMATCH[2]}))
      local key=$((param2&_ble_decode_MaskChar))
      ble-decode-char/csi/.modify-key "$param1"
      csistat=$key
      return 0
    fi
    if rex='^>?([0-9]+)(;([0-9]+))?$' && [[ $_ble_decode_csi_args =~ $rex ]]; then
      local param1=$((10#0${BASH_REMATCH[1]}))
      local param3=$((10#0${BASH_REMATCH[3]}))
      key=${_ble_decode_csimap_tilde[param1]}
      if [[ $key ]]; then
        ble-decode-char/csi/.modify-key "$param3"
        csistat=$key
        return 0
      fi
    fi
  elif ((char==117)); then # u
    if rex='^([0-9]*)(;[0-9]*)?$'; [[ $_ble_decode_csi_args =~ $rex ]]; then
      local rematch1=${BASH_REMATCH[1]}
      if [[ $rematch1 != 1 ]]; then
        local key=$((10#0$rematch1)) mods=$((10#0${BASH_REMATCH:${#rematch1}+1}))
        [[ $_ble_term_TERM == kitty:* ]] && ble-decode/char/csi/.translate-kitty-csi-u
        ble-decode-char/csi/.modify-key "$mods"
        csistat=$key
      fi
      return 0
    fi
  elif ((char==94||char==64)); then # ^, @
    if rex='^[0-9]+$' && [[ $_ble_decode_csi_args =~ $rex ]]; then
      local param1=$((10#0${BASH_REMATCH[1]}))
      local param3=$((10#0${BASH_REMATCH[3]}))
      key=${_ble_decode_csimap_tilde[param1]}
      if [[ $key ]]; then
        ((key|=_ble_decode_Ctrl,
          char==64&&(key|=_ble_decode_Shft)))
        ble-decode-char/csi/.modify-key "$param3"
        csistat=$key
        return 0
      fi
    fi
  elif ((char==99)); then # c
    if rex='^[?>]'; [[ $_ble_decode_csi_args =~ $rex ]]; then
      if [[ $_ble_decode_csi_args == '?'* ]]; then
        ble/term/DA1/notify "${_ble_decode_csi_args:1}"
      else
        ble/term/DA2/notify "${_ble_decode_csi_args:1}"
      fi
      csistat=$_ble_decode_KCODE_IGNORE
      return 0
    fi
  elif ((char==82||char==110)); then # R or n
    if rex='^([0-9]+);([0-9]+)$'; [[ $_ble_decode_csi_args =~ $rex ]]; then
      local param1=$((10#0${BASH_REMATCH[1]}))
      local param2=$((10#0${BASH_REMATCH[2]}))
      ble/term/CPR/notify "$param1" "$param2"
      csistat=$_ble_decode_KCODE_IGNORE
      return 0
    fi
  elif ((char==77||char==109)); then # M or m
    if rex='^<([0-9]+);([0-9]+);([0-9]+)$'; [[ $_ble_decode_csi_args =~ $rex ]]; then
      local param1=$((10#0${BASH_REMATCH[1]}))
      local param2=$((10#0${BASH_REMATCH[2]}))
      local param3=$((10#0${BASH_REMATCH[3]}))
      local button=$param1
      ((_ble_term_mouse_button=button&~0x1C,
        char==109&&(_ble_term_mouse_button|=0x70),
        _ble_term_mouse_x=param2-1,
        _ble_term_mouse_y=param3-1))
      local key=$_ble_decode_KCODE_MOUSE
      ((button&32)) && key=$_ble_decode_KCODE_MOUSE_MOVE
      ble-decode-char/csi/.modify-key $((button>>2&0x07))
      csistat=$key
      return 0
    fi
  elif ((char==116)); then # t
    if rex='^<([0-9]+);([0-9]+)$'; [[ $_ble_decode_csi_args =~ $rex ]]; then
      local param1=$((10#0${BASH_REMATCH[1]}))
      local param2=$((10#0${BASH_REMATCH[2]}))
      ((_ble_term_mouse_button=128,
        _ble_term_mouse_x=param1-1,
        _ble_term_mouse_y=param2-1))
      local key=$_ble_decode_KCODE_MOUSE
      csistat=$key
    fi
  fi
  key=${_ble_decode_csimap_alpha[char]}
  if [[ $key ]]; then
    if rex='^(1?|>?1;([0-9]+))$' && [[ $_ble_decode_csi_args =~ $rex ]]; then
      local param2=$((10#0${BASH_REMATCH[2]}))
      ble-decode-char/csi/.modify-key "$param2"
      csistat=$key
      return 0
    fi
  fi
  csistat=$_ble_decode_KCODE_ERROR
}
function ble-decode-char/csi/consume {
  csistat=
  ((_ble_decode_csi_mode==0&&$1!=27&&$1!=155)) && return 1
  local char=$1
  case "$_ble_decode_csi_mode" in
  (0)
    ((_ble_decode_csi_mode=$1==155?2:1))
    _ble_decode_csi_args=
    csistat=_ ;;
  (1)
    if ((char!=91)); then
      _ble_decode_csi_mode=0
      return 1
    else
      _ble_decode_csi_mode=2
      _ble_decode_csi_args=
      csistat=_
    fi ;;
  (2)
    if ((32<=char&&char<64)); then
      local ret; ble/util/c2s "$char"
      _ble_decode_csi_args=$_ble_decode_csi_args$ret
      csistat=_
    elif ((64<=char&&char<127)); then
      _ble_decode_csi_mode=0
      ble-decode-char/csi/.decode "$char"
      ((csistat==27)) && csistat=$_ble_decode_IsolatedESC
    else
      _ble_decode_csi_mode=0
    fi ;;
  esac
}
_ble_decode_char_buffer=()
function ble/decode/has-input-for-char {
  ((_ble_decode_input_count)) ||
    ble/util/is-stdin-ready ||
    ble/encoding:"$bleopt_input_encoding"/is-intermediate
}
_ble_decode_char__hook=
_ble_decode_cmap_=()
_ble_decode_char2_seq=
_ble_decode_char2_reach_key=
_ble_decode_char2_reach_seq=
_ble_decode_char2_modifier=
_ble_decode_char2_modkcode=
_ble_decode_char2_modseq=
function ble-decode-char {
  if [[ $ble_decode_char_nest && ! $ble_decode_char_sync ]]; then
    ble/array#push _ble_decode_char_buffer "$@"
    return 148
  fi
  local ble_decode_char_nest=1
  local iloop=0
  local ble_decode_char_total=$#
  local ble_decode_char_rest=$#
  local ble_decode_char_char=
  local chars ichar char ent
  chars=("$@") ichar=0
  while
    if ((iloop++%50==0)); then
      ((iloop>=200)) && builtin eval -- "$_ble_decode_show_progress_hook"
      if [[ ! $ble_decode_char_sync ]] && ble/decode/has-input-for-char; then
        ble/array#push _ble_decode_char_buffer "${chars[@]:ichar}"
        return 148
      fi
    fi
    if ((${#_ble_decode_char_buffer[@]})); then
      ((ble_decode_char_total+=${#_ble_decode_char_buffer[@]}))
      ((ble_decode_char_rest+=${#_ble_decode_char_buffer[@]}))
      ble/array#set chars "${_ble_decode_char_buffer[@]}" "${chars[@]:ichar}"
      ichar=0
      _ble_decode_char_buffer=()
    fi
    ((ble_decode_char_rest))
  do
    char=${chars[ichar]}
    ble_decode_char_char=$char # 補正前 char (_ble_decode_Macr 判定の為)
    ((ble_decode_char_rest--,ichar++))
    ((_ble_debug_keylog_enabled)) && ble/array#push _ble_debug_keylog_chars "$char"
    if [[ $_ble_decode_keylog_chars_enabled ]]; then
      if ! ((char&_ble_decode_Macr)); then
        ble/array#push _ble_decode_keylog_chars "$char"
        ((_ble_decode_keylog_chars_count++))
      fi
    fi
    ((char&=~_ble_decode_Macr))
    if ((char&_ble_decode_Erro)); then
      ((char&=~_ble_decode_Erro))
      if [[ $bleopt_decode_error_char_vbell ]]; then
        local name; ble/util/sprintf name 'U+%04x' "$char"
        ble/term/visible-bell "received a misencoded char $name"
      fi
      [[ $bleopt_decode_error_char_abell ]] && ble/term/audible-bell
      [[ $bleopt_decode_error_char_discard ]] && continue
    fi
    if [[ $_ble_decode_char__hook ]]; then
      ((char==_ble_decode_IsolatedESC)) && char=27 # isolated ESC -> ESC
      local hook=$_ble_decode_char__hook
      _ble_decode_char__hook=
      ble-decode/widget/.call-async-read "$hook $char" "$char"
      continue
    fi
    ble-decode-char/.getent # -> ent
    if [[ ! $ent ]]; then
      if [[ $_ble_decode_char2_reach_key ]]; then
        local key=$_ble_decode_char2_reach_key
        local seq=$_ble_decode_char2_reach_seq
        local rest=${_ble_decode_char2_seq:${#seq}}
        ble/string#split-words rest "${rest//_/ } $ble_decode_char_char"
        _ble_decode_char2_seq=
        _ble_decode_char2_reach_key=
        _ble_decode_char2_reach_seq=
        ble-decode-char/csi/clear
        ble-decode-char/.send-modified-key "$key" "$seq"
        ((ble_decode_char_total+=${#rest[@]}))
        ((ble_decode_char_rest+=${#rest[@]}))
        chars=("${rest[@]}" "${chars[@]:ichar}") ichar=0
      else
        ble-decode-char/.send-modified-key "$char" "_$char"
      fi
    elif [[ $ent == *_ ]]; then
      _ble_decode_char2_seq=${_ble_decode_char2_seq}_$char
      if [[ ${ent%_} ]]; then
        _ble_decode_char2_reach_key=${ent%_}
        _ble_decode_char2_reach_seq=$_ble_decode_char2_seq
      elif [[ ! $_ble_decode_char2_reach_key ]]; then
        _ble_decode_char2_reach_key=$char
        _ble_decode_char2_reach_seq=$_ble_decode_char2_seq
      fi
    else
      local seq=${_ble_decode_char2_seq}_$char
      _ble_decode_char2_seq=
      _ble_decode_char2_reach_key=
      _ble_decode_char2_reach_seq=
      ble-decode-char/csi/clear
      ble-decode-char/.send-modified-key "$ent" "$seq"
    fi
  done
  return 0
}
function ble/decode/char-hook/next-char {
  ((ble_decode_char_rest)) || return 1
  ((char=chars[ichar]&~_ble_decode_Macr))
  ((char&_ble_decode_Erro)) && return 1
  ((iloop%1000==0)) && return 1
  ((char==_ble_decode_IsolatedESC)) && char=27
  ((ble_decode_char_rest--,ichar++,iloop++))
  return 0
}
function ble-decode-char/.getent {
  builtin eval "ent=\${_ble_decode_cmap_$_ble_decode_char2_seq[char]-}"
  local csistat=
  ble-decode-char/csi/consume "$char"
  if [[ $csistat && ! ${ent%_} ]]; then
    if ((csistat==_ble_decode_KCODE_ERROR)); then
      if [[ $bleopt_decode_error_cseq_vbell ]]; then
        local ret; ble-decode-unkbd ${_ble_decode_char2_seq//_/ } $char
        ble/term/visible-bell "unrecognized CSI sequence: $ret"
      fi
      [[ $bleopt_decode_error_cseq_abell ]] && ble/term/audible-bell
      if [[ $bleopt_decode_error_cseq_discard ]]; then
        csistat=$_ble_decode_KCODE_IGNORE
      else
        csistat=
      fi
    fi
    if [[ ! $ent ]]; then
      ent=$csistat
    else
      ent=${csistat%_}_
    fi
  fi
}
function ble-decode-char/.process-modifier {
  local mflag1=$1 mflag=$_ble_decode_char2_modifier
  if ((mflag1&mflag)); then
    return 1
  else
    ((_ble_decode_char2_modkcode=key|mflag,
      _ble_decode_char2_modifier=mflag1|mflag))
    _ble_decode_char2_modseq=${_ble_decode_char2_modseq}$2
    return 0
  fi
}
function ble-decode-char/.send-modified-key {
  local key=$1 seq=$2
  ((key==_ble_decode_KCODE_IGNORE)) && return 0
  if ((0<=key&&key<32)); then
    ((key|=(key==0||key>26?64:96)|_ble_decode_Ctrl))
  elif ((key==127)); then # C-?
    ((key=63|_ble_decode_Ctrl))
  fi
  if (($1==27)); then
    ble-decode-char/.process-modifier "$_ble_decode_Meta" "$seq" && return 0
  elif (($1==_ble_decode_IsolatedESC)); then
    ((key=(_ble_decode_Ctrl|91)))
    if ! ble/decode/uses-isolated-esc; then
      ble-decode-char/.process-modifier "$_ble_decode_Meta" "$seq" && return 0
    fi
  elif ((_ble_decode_KCODE_SHIFT<=$1&&$1<=_ble_decode_KCODE_HYPER)); then
    case "$1" in
    ($_ble_decode_KCODE_SHIFT)
      ble-decode-char/.process-modifier "$_ble_decode_Shft" "$seq" && return 0 ;;
    ($_ble_decode_KCODE_CONTROL)
      ble-decode-char/.process-modifier "$_ble_decode_Ctrl" "$seq" && return 0 ;;
    ($_ble_decode_KCODE_ALTER)
      ble-decode-char/.process-modifier "$_ble_decode_Altr" "$seq" && return 0 ;;
    ($_ble_decode_KCODE_META)
      ble-decode-char/.process-modifier "$_ble_decode_Meta" "$seq" && return 0 ;;
    ($_ble_decode_KCODE_SUPER)
      ble-decode-char/.process-modifier "$_ble_decode_Supr" "$seq" && return 0 ;;
    ($_ble_decode_KCODE_HYPER)
      ble-decode-char/.process-modifier "$_ble_decode_Hypr" "$seq" && return 0 ;;
    esac
  fi
  if [[ $_ble_decode_char2_modifier ]]; then
    local mflag=$_ble_decode_char2_modifier
    local mcode=$_ble_decode_char2_modkcode
    local mseq=$_ble_decode_char2_modseq
    _ble_decode_char2_modifier=
    _ble_decode_char2_modkcode=
    _ble_decode_char2_modseq=
    if ((key&mflag)); then
      local CHARS
      ble/string#split-words CHARS "${mseq//_/ }"
      ble-decode-key "$mcode"
    else
      seq=$mseq$seq
      ((key|=mflag))
    fi
  fi
  local CHARS
  ble/string#split-words CHARS "${seq//_/ }"
  ble-decode-key "$key"
}
function ble-decode-char/is-intermediate { [[ $_ble_decode_char2_seq ]]; }
function ble-decode-char/bind {
  local -a seq; ble/string#split-words seq "$1"
  local kc=$2
  local i iN=${#seq[@]} char tseq=
  for ((i=0;i<iN;i++)); do
    local char=${seq[i]}
    builtin eval "local okc=\${_ble_decode_cmap_$tseq[char]-}"
    if ((i+1==iN)); then
      if [[ ${okc//[0-9]} == _ ]]; then
        builtin eval "_ble_decode_cmap_$tseq[char]=\${kc}_"
      else
        builtin eval "_ble_decode_cmap_$tseq[char]=\${kc}"
      fi
    else
      if [[ ! $okc ]]; then
        builtin eval "_ble_decode_cmap_$tseq[char]=_"
      else
        builtin eval "_ble_decode_cmap_$tseq[char]=\${okc%_}_"
      fi
      tseq=${tseq}_$char
    fi
  done
}
function ble-decode-char/unbind {
  local -a seq; ble/string#split-words seq "$1"
  local tseq=
  local i iN=${#seq}
  for ((i=0;i<iN-1;i++)); do
    tseq=${tseq}_${seq[i]}
  done
  local char=${seq[iN-1]}
  local isfirst=1 ent=
  while
    builtin eval "ent=\${_ble_decode_cmap_$tseq[char]-}"
    if [[ $isfirst ]]; then
      isfirst=
      if [[ $ent == *_ ]]; then
        builtin eval "_ble_decode_cmap_$tseq[char]=_"
        break
      fi
    else
      if [[ $ent != _ ]]; then
        builtin eval "_ble_decode_cmap_$tseq[char]=${ent%_}"
        break
      fi
    fi
    builtin unset -v "_ble_decode_cmap_$tseq[char]"
    builtin eval "((\${#_ble_decode_cmap_$tseq[@]}!=0))" && break
    [[ $tseq ]]
  do
    char=${tseq##*_}
    tseq=${tseq%_*}
  done
}
function ble-decode-char/print {
  [[ $ble_bind_print ]] || local sgr0= sgrf= sgrq= sgrc= sgro=
  local IFS=$_ble_term_IFS q=\' Q="'\''"
  local tseq=$1 nseq ccode
  nseq=("${@:2}")
  builtin eval "local -a ccodes; ccodes=(\${!_ble_decode_cmap_$tseq[@]})"
  for ccode in "${ccodes[@]}"; do
    local ret; ble-decode-unkbd "$ccode"
    local cnames
    cnames=("${nseq[@]}" "$ret")
    builtin eval "local ent=\${_ble_decode_cmap_$tseq[ccode]}"
    if [[ ${ent%_} ]]; then
      local key=${ent%_} ret
      local qkspec qcnames
      if [[ $sgrq ]]; then
        ble-decode-unkbd "$key"
        ble/string#quote-word "$ret" quote-empty:sgrq="$sgrq":sgr0="$sgr0"; qkspec=$ret
        ble/string#quote-word "${cnames[*]}" quote-empty:sgrq="$sgrq":sgr0="$sgr0"; qcnames=$ret
      else
        ble-decode-unkbd "$key"
        qkspec="'${ret//$q/$Q}'"
        qcnames="'${cnames[*]//$q/$Q}'" # WA #D1570 checked
      fi
      ble/util/print "${sgrf}ble-bind$sgr0 $sgro-k$sgr0 $qcnames $qkspec"
    fi
    if [[ ${ent//[0-9]} == _ ]]; then
      ble-decode-char/print "${tseq}_$ccode" "${cnames[@]}"
    fi
  done
}
_ble_decode_keymap_list=
function ble/decode/keymap#registered {
  [[ :$_ble_decode_keymap_list: == *:"$1":* ]]
}
function ble/decode/keymap#.register {
  local kmap=$1
  if [[ $kmap && :$_ble_decode_keymap_list: != *:"$kmap":* ]]; then
    _ble_decode_keymap_list=$_ble_decode_keymap_list:$kmap
  fi
}
function ble/decode/keymap#.unregister {
  _ble_decode_keymap_list=$_ble_decode_keymap_list:
  _ble_decode_keymap_list=${_ble_decode_keymap_list//:"$1":/:}
  _ble_decode_keymap_list=${_ble_decode_keymap_list%:}
}
function ble/decode/is-keymap {
  ble/decode/keymap#registered "$1" || ble/is-function "ble-decode/keymap:$1/define"
}
function ble/decode/keymap#is-empty {
  ! ble/is-array "_ble_decode_${1}_kmap_" ||
    builtin eval -- "((\${#_ble_decode_${1}_kmap_[*]}==0))"
}
function ble/decode/keymap#.onload {
  local kmap=$1
  local delay=$_ble_base_run/$$.bind.delay.$kmap
  if [[ -s $delay ]]; then
    source "$delay"
    : >| "$delay"
  fi
}
function ble/decode/keymap#load {
  local opts=:$2:
  ble/decode/keymap#registered "$1" && return 0
  local init=ble-decode/keymap:$1/define
  ble/is-function "$init" || return 1
  ble/decode/keymap#.register "$1"
  local ble_bind_keymap=$1
  if ! "$init" || ble/decode/keymap#is-empty "$1"; then
    ble/decode/keymap#.unregister "$1"
    return 1
  fi
  [[ $opts == *:dump:* ]] &&
    ble/decode/keymap#dump "$1" >&3
  ble/decode/keymap#.onload "$1"
  return 0
}
function ble/decode/keymap#unload {
  if (($#==0)); then
    local list; ble/string#split-words list "${_ble_decode_keymap_list//:/ }"
    set -- "${list[@]}"
  fi
  while (($#)); do
    local array_names array_name
    builtin eval -- "array_names=(\"\${!_ble_decode_${1}_kmap_@}\")"
    for array_name in "${array_names[@]}"; do
      builtin unset -v "$array_name"
    done
    ble/decode/keymap#.unregister "$1"
    shift
  done
}
if [[ ${_ble_decode_kmaps-} ]]; then
  function ble/decode/keymap/cleanup-old-keymaps {
    local -a list=()
    local var
    for var in "${!_ble_decode_@}"; do
      [[ $var == _ble_decode_*_kmap_ ]] || continue
      var=${var#_ble_decode_}
      var=${var%_kmap_}
      ble/array#push list "$var"
    done
    local keymap_name
    for keymap_name in "${list[@]}"; do
      ble/decode/keymap#unload "$keymap_name"
    done
    builtin unset -v _ble_decode_kmaps
  }
  ble/decode/keymap/cleanup-old-keymaps
fi
function ble/decode/keymap#dump {
  if (($#)); then
    local kmap=$1 arrays
    builtin eval "arrays=(\"\${!_ble_decode_${kmap}_kmap_@}\")"
    ble/util/print "ble/decode/keymap#.register $kmap"
    ble/util/declare-print-definitions "${arrays[@]}"
    ble/util/print "ble/decode/keymap#.onload $kmap"
  else
    local list; ble/string#split-words list "${_ble_decode_keymap_list//:/ }"
    local keymap_name
    for keymap_name in "${list[@]}"; do
      ble/decode/keymap#dump "$keymap_name"
    done
  fi
}
function ble-decode/GET_BASEMAP {
  [[ $1 == -v ]] || return 1
  local ret; bleopt/get:default_keymap
  [[ $ret == vi ]] && ret=vi_imap
  builtin eval "$2=\$ret"
}
function ble-decode/INITIALIZE_DEFMAP {
  ble-decode/GET_BASEMAP "$@" &&
    ble/decode/keymap#load "${!2}" &&
    return 0
  ble/decode/keymap#load safe &&
    builtin eval -- "$2=safe" &&
    bleopt_default_keymap=safe
}
function ble/widget/.SHELL_COMMAND { local IFS=$_ble_term_IFS; builtin eval -- "$*"; }
function ble/widget/.EDIT_COMMAND { local IFS=$_ble_term_IFS; builtin eval -- "$*"; }
function ble-decode-key/bind {
  if ! ble/decode/keymap#registered "$1"; then
    ble/util/print-quoted-command "$FUNCNAME" "$@" >> "$_ble_base_run/$$.bind.delay.$1"
    return 0
  fi
  local kmap=$1 keys=$2 cmd=$3
  if local widget=${cmd%%[$_ble_term_IFS]*}; ! ble/is-function "$widget"; then
    local message="ble-bind: Unknown widget \`${widget#'ble/widget/'}'."
    [[ $command == ble/widget/ble/widget/* ]] &&
      message="$message Note: The prefix 'ble/widget/' is redundant."
    ble/util/print "$message" 1>&2
    return 1
  fi
  local dicthead=_ble_decode_${kmap}_kmap_
  local -a seq; ble/string#split-words seq "$keys"
  local i iN=${#seq[@]} tseq=
  for ((i=0;i<iN;i++)); do
    local key=${seq[i]}
    builtin eval "local ocmd=\${$dicthead$tseq[key]}"
    if ((i+1==iN)); then
      if [[ ${ocmd::1} == _ ]]; then
        builtin eval "$dicthead$tseq[key]=${ocmd%%:*}:\$cmd"
      else
        builtin eval "$dicthead$tseq[key]=1:\$cmd"
      fi
    else
      if [[ ! $ocmd ]]; then
        builtin eval "$dicthead$tseq[key]=_"
      elif [[ ${ocmd::1} == 1 ]]; then
        builtin eval "$dicthead$tseq[key]=_:\${ocmd#*:}"
      fi
      tseq=${tseq}_$key
    fi
  done
}
function ble-decode-key/set-timeout {
  if ! ble/decode/keymap#registered "$1"; then
    ble/util/print-quoted-command "$FUNCNAME" "$@" >> "$_ble_base_run/$$.bind.delay.$1"
    return 0
  fi
  local kmap=$1 keys=$2 timeout=$3
  local dicthead=_ble_decode_${kmap}_kmap_
  local -a seq; ble/string#split-words seq "$keys"
  [[ $timeout == - ]] && timeout=
  local i iN=${#seq[@]}
  local key=${seq[iN-1]}
  local tseq=
  for ((i=0;i<iN-1;i++)); do
    tseq=${tseq}_${seq[i]}
  done
  builtin eval "local ent=\${$dicthead$tseq[key]}"
  if [[ $ent == _* ]]; then
    local cmd=; [[ $ent == *:* ]] && cmd=${ent#*:}
    builtin eval "$dicthead$tseq[key]=_$timeout${cmd:+:}\$cmd"
  else
    ble/util/print "ble-bind -T: specified partial keyspec not found." >&2
    return 1
  fi
}
function ble-decode-key/unbind {
  if ! ble/decode/keymap#registered "$1"; then
    ble/util/print-quoted-command "$FUNCNAME" "$@" >> "$_ble_base_run/$$.bind.delay.$1"
    return 0
  fi
  local kmap=$1 keys=$2
  local dicthead=_ble_decode_${kmap}_kmap_
  local -a seq; ble/string#split-words seq "$keys"
  local i iN=${#seq[@]}
  local key=${seq[iN-1]}
  local tseq=
  for ((i=0;i<iN-1;i++)); do
    tseq=${tseq}_${seq[i]}
  done
  local isfirst=1 ent=
  while
    builtin eval "ent=\${$dicthead$tseq[key]}"
    if [[ $isfirst ]]; then
      isfirst=
      if [[ ${ent::1} == _ ]]; then
        builtin eval "$dicthead$tseq[key]=\${ent%%:*}"
        break
      fi
    else
      if [[ $ent == *:* ]]; then
        builtin eval "$dicthead$tseq[key]=1:\${ent#*:}"
        break
      fi
    fi
    builtin unset -v "$dicthead$tseq[key]"
    builtin eval "((\${#$dicthead$tseq[@]}!=0))" && break
    [[ $tseq ]]
  do
    key=${tseq##*_}
    tseq=${tseq%_*}
  done
}
function ble/decode/keymap#get-cursor {
  cursor=_ble_decode_${1}_kmap_cursor
  cursor=${!cursor-}
}
function ble/decode/keymap#set-cursor {
  local keymap=$1 cursor=$2
  if ! ble/decode/keymap#registered "$keymap"; then
    ble/util/print-quoted-command "$FUNCNAME" "$@" >> "$_ble_base_run/$$.bind.delay.$keymap"
    return 0
  fi
  builtin eval "_ble_decode_${keymap}_kmap_cursor=\$cursor"
}
function ble/decode/keymap#print {
  local kmap
  if (($#==0)); then
    for kmap in ${_ble_decode_keymap_list//:/ }; do
      ble/util/print "$sgrc# keymap $kmap$sgr0"
      ble/decode/keymap#print "$kmap"
    done
    return 0
  fi
  [[ $ble_bind_print ]] || local sgr0= sgrf= sgrq= sgrc= sgro=
  local kmap=$1 tseq=$2 nseq=$3
  local dicthead=_ble_decode_${kmap}_kmap_
  local kmapopt=
  [[ $kmap ]] && kmapopt=" $sgro-m$sgr0 $sgrq'$kmap'$sgr0"
  local q=\' Q="'\''"
  local key keys
  builtin eval "keys=(\${!$dicthead$tseq[@]})"
  for key in "${keys[@]}"; do
    local ret; ble-decode-unkbd "$key"
    local knames=$nseq${nseq:+ }$ret
    builtin eval "local ent=\${$dicthead$tseq[key]}"
    local qknames
    if [[ $sgrq ]]; then
      ble/string#quote-word "$knames" quote-empty:sgrq="$sgrq":sgr0="$sgr0"; qknames=$ret
    else
      qknames="'${knames//$q/$Q}'"
    fi
    if [[ $ent == *:* ]]; then
      local cmd=${ent#*:}
      local o v
      case "$cmd" in
      ('ble/widget/.SHELL_COMMAND '*) o=c v=${cmd#'ble/widget/.SHELL_COMMAND '} ;;
      ('ble/widget/.EDIT_COMMAND '*)  o=x v=${cmd#'ble/widget/.EDIT_COMMAND '} ;;
      ('ble/widget/.MACRO '*)         o=s; ble/util/chars2keyseq ${cmd#*' '}; v=$ret ;;
      ('ble/widget/'*)                o=f v=${cmd#ble/widget/} ;;
      (*)                             o=@ v=$cmd  ;;
      esac
      local qv
      if [[ $sgrq ]]; then
        ble/string#quote-word "$v" quote-empty:sgrq="$sgrq":sgr0="$sgr0"; qv=$ret
      else
        qv="'${v//$q/$Q}'"
      fi
      ble/util/print "${sgrf}ble-bind$sgr0$kmapopt $sgro-$o$sgr0 $qknames $qv"
    fi
    if [[ ${ent::1} == _ ]]; then
      ble/decode/keymap#print "$kmap" "${tseq}_$key" "$knames"
      if [[ $ent == _[0-9]* ]]; then
        local timeout=${ent%%:*}; timeout=${timeout:1}
        ble/util/print "${sgrf}ble-bind$sgr0$kmapopt $sgro-T$sgr0 $qknames $timeout"
      fi
    fi
  done
}
_ble_decode_keymap=
_ble_decode_keymap_stack=()
function ble/decode/keymap/push {
  if ble/decode/keymap#registered "$1"; then
    ble/array#push _ble_decode_keymap_stack "$_ble_decode_keymap"
    _ble_decode_keymap=$1
    local cursor; ble/decode/keymap#get-cursor "$1"
    [[ $cursor ]] && ble/term/cursor-state/set-internal $((cursor))
    return 0
  elif ble/decode/keymap#load "$1" && ble/decode/keymap#registered "$1"; then
    ble/decode/keymap/push "$1" # 再実行
  else
    ble/util/print "[ble: keymap '$1' not found]" >&2
    return 1
  fi
}
function ble/decode/keymap/pop {
  local count=${#_ble_decode_keymap_stack[@]}
  local last=$((count-1))
  ble/util/assert '((last>=0))' || return 1
  local cursor
  ble/decode/keymap#get-cursor "$_ble_decode_keymap"
  if [[ $cursor ]]; then
    local i
    for ((i=last;i>=0;i--)); do
      ble/decode/keymap#get-cursor "${_ble_decode_keymap_stack[i]}"
      [[ $cursor ]] && break
    done
    ble/term/cursor-state/set-internal $((${cursor:-0}))
  fi
  local old_keymap=_ble_decode_keymap
  _ble_decode_keymap=${_ble_decode_keymap_stack[last]}
  builtin unset -v '_ble_decode_keymap_stack[last]'
}
function ble/decode/keymap/get-parent {
  local len=${#_ble_decode_keymap_stack[@]}
  if ((len)); then
    ret=${_ble_decode_keymap_stack[len-1]}
  else
    ret=
  fi
}
_ble_decode_key__seq=
_ble_decode_key__hook=
function ble-decode-key/is-intermediate { [[ $_ble_decode_key__seq ]]; }
_ble_decode_key_batch=()
function ble-decode-key/batch/flush {
  ((${#_ble_decode_key_batch[@]})) || return 1
  local dicthead=_ble_decode_${_ble_decode_keymap}_kmap_
  builtin eval "local command=\${${dicthead}[_ble_decode_KCODE_BATCH_CHAR]-}"
  command=${command:2}
  if [[ $command ]]; then
    local chars; chars=("${_ble_decode_key_batch[@]}")
    _ble_decode_key_batch=()
    ble/decode/widget/call-interactively "$command" "${chars[@]}"; local ext=$?
    ((ext!=125)) && return 0
  fi
  ble/decode/widget/call-interactively ble/widget/__batch_char__.default "${chars[@]}"; local ext=$?
  return "$ext"
}
function ble/widget/__batch_char__.default {
  builtin eval "local widget_defchar=\${${dicthead}[_ble_decode_KCODE_DEFCHAR]-}"
  widget_defchar=${widget_defchar:2}
  builtin eval "local widget_default=\${${dicthead}[_ble_decode_KCODE_DEFAULT]-}"
  widget_default=${widget_default:2}
  local -a unprocessed_chars=()
  local key command
  for key in "${KEYS[@]}"; do
    if [[ $widget_defchar ]]; then
      ble/decode/widget/call-interactively "$widget_defchar" "$key"; local ext=$?
      ((ext!=125)) && continue
    fi
    if [[ $widget_default ]]; then
      ble/decode/widget/call-interactively "$widget_default" "$key"; local ext=$?
      ((ext!=125)) && continue
    fi
    ble/array#push unprocessed_chars "$key"
  done
  if ((${#unprocessed_chars[@]})); then
    local ret; ble-decode-unkbd "${unprocessed_chars[@]}"
    [[ $bleopt_decode_error_kseq_vbell ]] && ble/term/visible-bell "unprocessed chars: $ret"
    [[ $bleopt_decode_error_kseq_abell ]] && ble/term/audible-bell
  fi
  return 0
}
function ble-decode-key {
  local key
  while (($#)); do
    key=$1; shift
    ((_ble_debug_keylog_enabled)) && ble/array#push _ble_debug_keylog_keys "$key"
    if [[ $_ble_decode_keylog_keys_enabled && $_ble_decode_keylog_depth == 0 ]]; then
      ble/array#push _ble_decode_keylog_keys "$key"
      ((_ble_decode_keylog_keys_count++))
    fi
    local dicthead=_ble_decode_${_ble_decode_keymap}_kmap_
    if (((key&_ble_decode_MaskChar)==_ble_decode_KCODE_MOUSE_MOVE)); then
      builtin eval "local command=\${${dicthead}[key]-}"
      command=${command:2}
      ble-decode/widget/.call-keyseq
      continue
    fi
    if [[ $_ble_decode_key__hook ]]; then
      local hook=$_ble_decode_key__hook
      _ble_decode_key__hook=
      ble-decode/widget/.call-async-read "$hook $key" "$key"
      continue
    fi
    builtin eval "local ent=\${$dicthead$_ble_decode_key__seq[key]-}"
    if [[ $ent == _[0-9]* ]]; then
      local node_type=_
      if (($#==0)) && ! ble/decode/has-input; then
        local timeout=${ent%%:*}; timeout=${timeout:1}
        ble/decode/wait-input "$timeout" || node_type=1
      fi
      if [[ $ent == *:* ]]; then
        ent=$node_type:${ent#*:}
      else
        ent=$node_type
      fi
    fi
    if [[ $ent == 1:* ]]; then
      local command=${ent:2}
      if [[ $command ]]; then
        ble-decode/widget/.call-keyseq
      else
        _ble_decode_key__seq=
      fi
    elif [[ $ent == _ || $ent == _:* ]]; then
      _ble_decode_key__seq=${_ble_decode_key__seq}_$key
    else
      ble-decode-key/.invoke-partial-match "$key" && continue
      local kseq=${_ble_decode_key__seq}_$key ret
      ble-decode-unkbd "${kseq//_/ }"
      local kspecs=$ret
      [[ $bleopt_decode_error_kseq_vbell ]] && ble/term/visible-bell "unbound keyseq: $kspecs"
      [[ $bleopt_decode_error_kseq_abell ]] && ble/term/audible-bell
      if [[ $_ble_decode_key__seq ]]; then
        if [[ $bleopt_decode_error_kseq_discard ]]; then
          _ble_decode_key__seq=
        else
          local -a keys
          ble/string#split-words keys "${_ble_decode_key__seq//_/ } $key"
          _ble_decode_key__seq=
          ble-decode-key "${keys[@]:1}"
        fi
      fi
    fi
  done
  if ((${#_ble_decode_key_batch[@]})); then
    if ! ble/decode/has-input || ((${#_ble_decode_key_batch[@]}>=50)); then
      ble-decode-key/batch/flush
    fi
  fi
  return 0
}
function ble-decode-key/.invoke-partial-match {
  local dicthead=_ble_decode_${_ble_decode_keymap}_kmap_
  local next=$1
  if [[ $_ble_decode_key__seq ]]; then
    local last=${_ble_decode_key__seq##*_}
    _ble_decode_key__seq=${_ble_decode_key__seq%_*}
    builtin eval "local ent=\${$dicthead$_ble_decode_key__seq[last]-}"
    if [[ $ent == _*:* ]]; then
      local command=${ent#*:}
      if [[ $command ]]; then
        ble-decode/widget/.call-keyseq
      else
        _ble_decode_key__seq=
      fi
      ble-decode-key "$next"
      return 0
    else # ent = _
      if ble-decode-key/.invoke-partial-match "$last"; then
        ble-decode-key "$next"
        return 0
      else
        _ble_decode_key__seq=${_ble_decode_key__seq}_$last
        return 1
      fi
    fi
  else
    local key=$1
    if ble-decode-key/ischar "$key"; then
      if ble/decode/has-input && builtin eval "[[ \${${dicthead}[_ble_decode_KCODE_BATCH_CHAR]-} ]]"; then
        ble/array#push _ble_decode_key_batch "$key"
        return 0
      fi
      builtin eval "local command=\${${dicthead}[_ble_decode_KCODE_DEFCHAR]-}"
      command=${command:2}
      if [[ $command ]]; then
        local seq_save=$_ble_decode_key__seq
        ble-decode/widget/.call-keyseq; local ext=$?
        ((ext!=125)) && return 0
        _ble_decode_key__seq=$seq_save # 125 の時はまた元に戻して次の試行を行う
      fi
    fi
    builtin eval "local command=\${${dicthead}[_ble_decode_KCODE_DEFAULT]-}"
    command=${command:2}
    ble-decode/widget/.call-keyseq; local ext=$?
    ((ext!=125)) && return 0
    return 1
  fi
}
function ble-decode-key/ischar {
  local key=$1
  (((key&_ble_decode_MaskFlag)==0&&32<=key&&key<_ble_decode_FunctionKeyBase))
}
_ble_decode_widget_last=
function ble-decode/widget/.invoke-hook {
  local key=$1
  local dicthead=_ble_decode_${_ble_decode_keymap}_kmap_
  builtin eval "local hook=\${$dicthead[key]-}"
  hook=${hook:2}
  [[ $hook ]] && builtin eval -- "$hook"
}
function ble-decode/widget/.call-keyseq {
  ble-decode-key/batch/flush
  [[ $command ]] || return 125
  local _ble_decode_keylog_depth=$((_ble_decode_keylog_depth+1))
  local WIDGET=$command KEYMAP=$_ble_decode_keymap LASTWIDGET=$_ble_decode_widget_last
  local -a KEYS; ble/string#split-words KEYS "${_ble_decode_key__seq//_/ } $key"
  _ble_decode_widget_last=$WIDGET
  _ble_decode_key__seq=
  ble-decode/widget/.invoke-hook "$_ble_decode_KCODE_BEFORE_WIDGET"
  builtin eval -- "$WIDGET"; local ext=$?
  ble-decode/widget/.invoke-hook "$_ble_decode_KCODE_AFTER_WIDGET"
  ((_ble_decode_keylog_depth==1)) &&
    _ble_decode_keylog_chars_count=0 _ble_decode_keylog_keys_count=0
  return "$ext"
}
function ble-decode/widget/.call-async-read {
  local _ble_decode_keylog_depth=$((_ble_decode_keylog_depth+1))
  local WIDGET=$1 KEYMAP=$_ble_decode_keymap LASTWIDGET=$_ble_decode_widget_last
  local -a KEYS; ble/string#split-words KEYS "$2"
  builtin eval -- "$WIDGET"; local ext=$?
  ((_ble_decode_keylog_depth==1)) &&
    _ble_decode_keylog_chars_count=0 _ble_decode_keylog_keys_count=0
  return "$ext"
}
function ble/decode/widget/call-interactively {
  local WIDGET=$1 KEYMAP=$_ble_decode_keymap LASTWIDGET=$_ble_decode_widget_last
  local -a KEYS; KEYS=("${@:2}")
  _ble_decode_widget_last=$WIDGET
  ble-decode/widget/.invoke-hook "$_ble_decode_KCODE_BEFORE_WIDGET"
  builtin eval -- "$WIDGET"; local ext=$?
  ble-decode/widget/.invoke-hook "$_ble_decode_KCODE_AFTER_WIDGET"
  return "$ext"
}
function ble/decode/widget/call {
  local WIDGET=$1 KEYMAP=$_ble_decode_keymap LASTWIDGET=$_ble_decode_widget_last
  local -a KEYS; KEYS=("${@:2}")
  _ble_decode_widget_last=$WIDGET
  builtin eval -- "$WIDGET"
}
function ble/decode/widget/dispatch {
  local ret; ble/string#quote-command "ble/widget/$@"
  local WIDGET=$ret
  _ble_decode_widget_last=$WIDGET
  builtin eval -- "$WIDGET"
}
function ble/decode/widget/suppress-widget {
  WIDGET=
}
function ble/decode/widget/redispatch-by-keys {
  if ((_ble_decode_keylog_depth==1)); then
    ble/decode/keylog#pop
    _ble_decode_keylog_depth=0
  fi
  ble-decode-key "$@"
}
function ble/decode/widget/skip-lastwidget {
  _ble_decode_widget_last=$LASTWIDGET
}
function ble/decode/widget/keymap-dispatch {
  local name=${FUNCNAME[1]#ble/widget/}
  local widget=ble/widget/$_ble_decode_keymap/$name
  ble/is-function "$widget" || widget=ble/widget/default/$name
  "$widget" "$@"
}
function ble/decode/has-input {
  ((_ble_decode_input_count||ble_decode_char_rest)) ||
    ble/util/is-stdin-ready ||
    ble/encoding:"$bleopt_input_encoding"/is-intermediate ||
    ble-decode-char/is-intermediate
}
function ble/decode/wait-input {
  local timeout=$1
  while ((timeout>0)); do
    ble/decode/has-input && return 0
    local w=$((timeout<20?timeout:20))
    ble/util/msleep "$w"
    ((timeout-=w))
  done
  return 1
}
function ble/util/idle/IS_IDLE {
  ! ble/decode/has-input
}
_ble_debug_keylog_enabled=0
_ble_debug_keylog_bytes=()
_ble_debug_keylog_chars=()
_ble_debug_keylog_keys=()
function ble/debug/keylog#start {
  _ble_debug_keylog_enabled=1
}
function ble/debug/keylog#end {
  {
    local IFS=$_ble_term_IFS
    ble/util/print '===== bytes ====='
    ble/util/print "${_ble_debug_keylog_bytes[*]}"
    ble/util/print
    ble/util/print '===== chars ====='
    local ret; ble-decode-unkbd "${_ble_debug_keylog_chars[@]}"
    ble/string#split ret ' ' "$ret"
    ble/util/print "${ret[*]}"
    ble/util/print
    ble/util/print '===== keys ====='
    local ret; ble-decode-unkbd "${_ble_debug_keylog_keys[@]}"
    ble/string#split ret ' ' "$ret"
    ble/util/print "${ret[*]}"
    ble/util/print
  } | fold -w 40
  _ble_debug_keylog_enabled=0
  _ble_debug_keylog_bytes=()
  _ble_debug_keylog_chars=()
  _ble_debug_keylog_keys=()
}
_ble_decode_keylog_depth=0
_ble_decode_keylog_keys_enabled=
_ble_decode_keylog_keys_count=0
_ble_decode_keylog_keys=()
_ble_decode_keylog_chars_enabled=
_ble_decode_keylog_chars_count=0
_ble_decode_keylog_chars=()
function ble/decode/keylog#start {
  [[ $_ble_decode_keylog_keys_enabled ]] && return 1
  _ble_decode_keylog_keys_enabled=${1:-1}
  _ble_decode_keylog_keys=()
}
function ble/decode/keylog#end {
  ret=("${_ble_decode_keylog_keys[@]}")
  _ble_decode_keylog_keys_enabled=
  _ble_decode_keylog_keys=()
}
function ble/decode/keylog#pop {
  [[ $_ble_decode_keylog_keys_enabled && $_ble_decode_keylog_depth == 1 ]] || return 1
  local new_size=$((${#_ble_decode_keylog_keys[@]}-_ble_decode_keylog_keys_count))
  ((new_size<0)) && new_size=0
  _ble_decode_keylog_keys=("${_ble_decode_keylog_keys[@]::new_size}")
  _ble_decode_keylog_keys_count=0
}
function ble/decode/charlog#start {
  [[ $_ble_decode_keylog_chars_enabled ]] && return 1
  _ble_decode_keylog_chars_enabled=${1:-1}
  _ble_decode_keylog_chars=()
}
function ble/decode/charlog#end {
  [[ $_ble_decode_keylog_chars_enabled ]] || { ret=(); return 1; }
  ret=("${_ble_decode_keylog_chars[@]}")
  _ble_decode_keylog_chars_enabled=
  _ble_decode_keylog_chars=()
}
function ble/decode/charlog#end-exclusive {
  ret=()
  [[ $_ble_decode_keylog_chars_enabled ]] || return 1
  local size=$((${#_ble_decode_keylog_chars[@]}-_ble_decode_keylog_chars_count))
  ((size>0)) && ret=("${_ble_decode_keylog_chars[@]::size}")
  _ble_decode_keylog_chars_enabled=
  _ble_decode_keylog_chars=()
}
function ble/decode/charlog#end-exclusive-depth1 {
  if ((_ble_decode_keylog_depth==1)); then
    ble/decode/charlog#end-exclusive
  else
    ble/decode/charlog#end
  fi
}
function ble/decode/charlog#encode {
  local -a buff=()
  for char; do
    ((char==0)) && char=$_ble_decode_EscapedNUL
    ble/util/c2s "$char"
    ble/array#push buff "$ret"
  done
  IFS= builtin eval 'ret="${buff[*]}"'
}
function ble/decode/charlog#decode {
  local text=$1 n=${#1} i chars
  chars=()
  for ((i=0;i<n;i++)); do
    ble/util/s2c "${text:i:1}"
    ((ret==_ble_decode_EscapedNUL)) && ret=0
    ble/array#push chars "$ret"
  done
  ret=("${chars[@]}")
}
function ble/decode/keylog#encode {
  ret=
  ble/util/c2s 155; local csi=$ret
  local key
  local -a buff=()
  for key; do
    if ble-decode-key/ischar "$key"; then
      ble/util/c2s "$key"
      if ((${#ret}==1)); then
        ble/array#push buff "$ret"
        continue
      fi
    fi
    local c=$((key&_ble_decode_MaskChar))
    if (((key&_ble_decode_MaskFlag)==_ble_decode_Ctrl&&(c==64||91<=c&&c<=95||97<=c&&c<=122))); then
      if ((c!=64)); then
        ble/util/c2s $((c&0x1F))
        ble/array#push buff "$ret"
        continue
      fi
    fi
    local mod=1
    (((key&_ble_decode_Shft)&&(mod+=0x01),
      (key&_ble_decode_Altr)&&(mod+=0x02),
      (key&_ble_decode_Ctrl)&&(mod+=0x04),
      (key&_ble_decode_Supr)&&(mod+=0x08),
      (key&_ble_decode_Hypr)&&(mod+=0x10),
      (key&_ble_decode_Meta)&&(mod+=0x20)))
    ble/array#push buff "${csi}27;$mod;$c~"
  done
  IFS= builtin eval 'ret="${buff[*]-}"'
}
function ble/decode/keylog#decode-chars {
  local text=$1 n=${#1} i
  local -a chars=()
  for ((i=0;i<n;i++)); do
    ble/util/s2c "${text:i:1}"
    ((ret==27)) && ret=$_ble_decode_IsolatedESC
    ble/array#push chars "$ret"
  done
  ret=("${chars[@]}")
}
_ble_decode_macro_count=0
function ble/widget/.MACRO {
  if ((ble_decode_char_char&_ble_decode_Macr)); then
    if ((_ble_decode_macro_count++>=bleopt_decode_macro_limit)); then
      ((_ble_decode_macro_count==bleopt_decode_macro_limit+1)) &&
        ble/term/visible-bell "Macro invocation is cancelled by decode_macro_limit"
      return 1
    fi
  else
    _ble_decode_macro_count=0
  fi
  local -a chars=()
  local char
  for char; do
    ble/array#push chars $((char|_ble_decode_Macr))
  done
  ble-decode-char "${chars[@]}"
}
function ble/widget/.CHARS {
  ble-decode-char "$@"
}
function ble/decode/c2dqs {
  local i=$1
  if ((0<=i&&i<32)); then
    if ((1<=i&&i<=26)); then
      ble/util/c2s $((i+96))
      ret="\\C-$ret"
    elif ((i==27)); then
      ret="\\e"
    elif ((i==28)); then
      ret="\\x1c"
    else
      ble/decode/c2dqs $((i+64))
      ret="\\C-$ret"
    fi
  elif ((32<=i&&i<127)); then
    ble/util/c2s "$i"
    if ((i==34||i==92)); then
      ret='\'"$ret"
    fi
  elif ((128<=i&&i<160)); then
    ble/util/sprintf ret '\\%03o' "$i"
  else
    ble/util/sprintf ret '\\%03o' "$i"
  fi
}
function ble/decode/cmap/.generate-binder-template {
  local tseq=$1 qseq=$2 nseq=$3 depth=${4:-1} ccode
  local apos="'" escapos="'\\''"
  builtin eval "local -a ccodes; ccodes=(\${!_ble_decode_cmap_$tseq[@]})"
  for ccode in "${ccodes[@]}"; do
    local ret
    ble/decode/c2dqs "$ccode"
    qseq1=$qseq$ret
    nseq1="$nseq $ccode"
    builtin eval "local ent=\${_ble_decode_cmap_$tseq[ccode]}"
    if [[ ${ent%_} ]]; then
      if ((depth>=3)); then
        ble/util/print "\$binder \"$qseq1\" \"${nseq1# }\""
      fi
    fi
    if [[ ${ent//[0-9]} == _ ]]; then
      ble/decode/cmap/.generate-binder-template "${tseq}_$ccode" "$qseq1" "$nseq1" $((depth+1))
    fi
  done
}
function ble/decode/cmap/.emit-bindx {
  local q="'" Q="'\''"
  ble/util/print "builtin bind -x '\"${1//$q/$Q}\":ble-decode/.hook $2; builtin eval -- \"\$_ble_decode_bind_hook\"'"
}
function ble/decode/cmap/.emit-bindr {
  ble/util/print "builtin bind -r \"$1\""
}
_ble_decode_cmap_initialized=
function ble/decode/cmap/initialize {
  [[ $_ble_decode_cmap_initialized ]] && return 0
  _ble_decode_cmap_initialized=1
  local init=$_ble_base/lib/init-cmap.sh
  local dump=$_ble_base_cache/decode.cmap.$_ble_decode_kbd_ver.$TERM.dump
  if [[ -s $dump && $dump -nt $init ]]; then
    source "$dump"
  else
    ble/edit/info/immediate-show text 'ble.sh: generating "'"$dump"'"...'
    source "$init"
    ble-bind -D | ble/bin/awk '
      {
        sub(/^declare +(-[aAilucnrtxfFgGI]+ +)?/, "");
        sub(/^-- +/, "");
      }
      /^_ble_decode_(cmap|csimap|kbd)/ {
        if (!($0 ~ /^_ble_decode_csimap_kitty_u/))
          gsub(/["'\'']/, "");
        print
      }
    ' >| "$dump"
  fi
  if ((_ble_bash>=40300)); then
    local fbinder=$_ble_base_cache/decode.cmap.allseq
    _ble_decode_bind_fbinder=$fbinder
    if ! [[ -s $_ble_decode_bind_fbinder.bind && $_ble_decode_bind_fbinder.bind -nt $init &&
              -s $_ble_decode_bind_fbinder.unbind && $_ble_decode_bind_fbinder.unbind -nt $init ]]; then
      ble/edit/info/immediate-show text  'ble.sh: initializing multichar sequence binders... '
      ble/decode/cmap/.generate-binder-template >| "$fbinder"
      binder=ble/decode/cmap/.emit-bindx source "$fbinder" >| "$fbinder.bind"
      binder=ble/decode/cmap/.emit-bindr source "$fbinder" >| "$fbinder.unbind"
      ble/edit/info/immediate-show text  'ble.sh: initializing multichar sequence binders... done'
    fi
  fi
}
function ble/decode/cmap/decode-chars.hook {
  ble/array#push ble_decode_bind_keys "$1"
  _ble_decode_key__hook=ble/decode/cmap/decode-chars.hook
}
function ble/decode/cmap/decode-chars {
  ble/decode/cmap/initialize
  local _ble_decode_csi_mode=0
  local _ble_decode_csi_args=
  local _ble_decode_char2_seq=
  local _ble_decode_char2_reach_key=
  local _ble_decode_char2_reach_seq=
  local _ble_decode_char2_modifier=
  local _ble_decode_char2_modkcode=
  local _ble_decode_char__hook=
  local _ble_debug_keylog_enabled=
  local _ble_decode_keylog_keys_enabled=
  local _ble_decode_keylog_chars_enabled=
  local _ble_decode_show_progress_hook=
  local _ble_decode_erase_progress_hook=
  local bleopt_decode_error_cseq_abell=
  local bleopt_decode_error_cseq_vbell=
  local bleopt_decode_error_cseq_discard=
  local -a ble_decode_bind_keys=()
  local _ble_decode_key__hook=ble/decode/cmap/decode-chars.hook
  local ble_decode_char_sync=1 # ユーザ入力があっても中断しない
  ble-decode-char "$@"
  keys=("${ble_decode_bind_keys[@]}")
}
_ble_decode_bind_hook=
_ble_decode_bind__uvwflag=
function ble/decode/bind/adjust-uvw {
  [[ $_ble_decode_bind__uvwflag ]] && return 0
  _ble_decode_bind__uvwflag=1
  builtin bind -x '"":ble-decode/.hook 21; builtin eval -- "$_ble_decode_bind_hook"'
  builtin bind -x '"":ble-decode/.hook 22; builtin eval -- "$_ble_decode_bind_hook"'
  builtin bind -x '"":ble-decode/.hook 23; builtin eval -- "$_ble_decode_bind_hook"'
  builtin bind -x '"":ble-decode/.hook 127; builtin eval -- "$_ble_decode_bind_hook"'
}
function ble/base/workaround-POSIXLY_CORRECT {
  [[ $_ble_decode_bind_state == none ]] && return 0
  builtin bind -x '"\C-i":ble-decode/.hook 9; builtin eval -- "$_ble_decode_bind_hook"'
}
function ble/decode/bind/.generate-source-to-unbind-default {
  {
    if ((_ble_bash>=40300)); then
      ble/util/print '__BINDX__'
      builtin bind -X
    fi
    ble/util/print '__BINDP__'
    builtin bind -sp
  } | ble/decode/bind/.generate-source-to-unbind-default/.process
} 2>/dev/null
function ble/decode/bind/.generate-source-to-unbind-default/.process {
  local q=\' Q="'\''"
  LC_ALL=C ble/bin/awk -v q="$q" '
    BEGIN {
      IS_XPG4 = AWKTYPE == "xpg4";
      rep_Q         = str2rep(q "\\" q q);
      rep_bslash    = str2rep("\\");
      rep_kseq_1c5c = str2rep("\"\\x1c\\x5c\"");
      rep_kseq_1c   = str2rep("\"\\x1c\"");
      mode = 1;
    }
    function str2rep(str) {
      if (IS_XPG4) sub(/\\/, "\\\\\\\\", str);
      return str;
    }
    function quote(text) {
      gsub(q, rep_Q, text);
      return q text q;
    }
    function unescape_control_modifier(str, _, i, esc, chr) {
      for (i = 0; i < 32; i++) {
        if (i == 0 || i == 31)
          esc = sprintf("\\\\C-%c", i + 64);
        else if (27 <= i && i <= 30)
          esc = sprintf("\\\\C-\\%c", i + 64);
        else
          esc = sprintf("\\\\C-%c", i + 96);
        chr = sprintf("%c", i);
        gsub(esc, chr, str);
      }
      gsub(/\\C-\?/, sprintf("%c", 127), str);
      return str;
    }
    function unescape(str) {
      if (str ~ /\\C-/)
        str = unescape_control_modifier(str);
      gsub(/\\e/, sprintf("%c", 27), str);
      gsub(/\\"/, "\"", str);
      gsub(/\\\\/, rep_bslash, str);
      return str;
    }
    function output_bindr(line0, _seq) {
      if (match(line0, /^"(([^"\\]|\\.)+)"/) > 0) {
        _seq = substr(line0, 2, RLENGTH - 2);
        gsub(/\\M-/, "\\e", _seq);
        print "builtin bind -r " quote(_seq);
      }
    }
    /^__BINDP__$/ { mode = 1; next; }
    /^__BINDX__$/ { mode = 2; next; }
    mode == 1 && $0 ~ /^"/ {
      sub(/^"\\C-\\\\\\"/, rep_kseq_1c5c);
      sub(/^"\\C-\\\\?"/, rep_kseq_1c);
      output_bindr($0);
      print "builtin bind " quote($0) > "/dev/stderr";
    }
    mode == 2 && $0 ~ /^"/ {
      output_bindr($0);
      line = $0;
      if (line ~ /(^|[^[:alnum:]])ble-decode\/.hook($|[^[:alnum:]])/) next;
      if (match(line, /^("([^"\\]|\\.)*":) "(([^"\\]|\\.)*)"/) > 0) {
        rlen = RLENGTH;
        match(line, /^"([^"\\]|\\.)*":/);
        rlen1 = RLENGTH;
        rlen2 = rlen - rlen1 - 3;
        sequence = substr(line, 1        , rlen1);
        command  = substr(line, rlen1 + 3, rlen2);
        if (command ~ /\\/)
          command = unescape(command);
        line = sequence command;
      }
      print "builtin bind -x " quote(line) > "/dev/stderr";
    }
  ' 2>| "$_ble_base_run/$$.bind.save"
}
_ble_decode_bind_state=none
_ble_decode_bind_bindp=
_ble_decode_bind_encoding=
function ble/decode/bind/bind {
  _ble_decode_bind_encoding=$bleopt_input_encoding
  local file=$_ble_base_cache/decode.bind.$_ble_bash.$_ble_decode_bind_encoding.bind
  [[ -s $file && $file -nt $_ble_base/lib/init-bind.sh ]] || source "$_ble_base/lib/init-bind.sh"
  ble/term/rl-convert-meta/enter
  source "$file"
  _ble_decode_bind__uvwflag=
  ble/util/assign _ble_decode_bind_bindp 'builtin bind -p' # TERM 変更検出用
}
function ble/decode/bind/unbind {
  ble/function#try ble/encoding:"$bleopt_input_encoding"/clear
  source "$_ble_base_cache/decode.bind.$_ble_bash.$_ble_decode_bind_encoding.unbind"
}
function ble/decode/rebind {
  [[ $_ble_decode_bind_state == none ]] && return 0
  ble/decode/bind/unbind
  ble/decode/bind/bind
}
function ble-bind/.initialize-kmap {
  [[ $kmap ]] && return 0
  ble-decode/GET_BASEMAP -v kmap
  if ! ble/decode/is-keymap "$kmap"; then
    ble/util/print "ble-bind: the default keymap '$kmap' is unknown." >&2
    flags=R$flags
    return 1
  fi
  return 0
}
function ble-bind/option:help {
  ble/util/cat <<EOF
ble-bind --help
ble-bind -k [TYPE:]cspecs [[TYPE:]kspec]
ble-bind --csi PsFt [TYPE:]kspec
ble-bind [-m keymap] -fxc@s [TYPE:]kspecs command
ble-bind [-m keymap] -T [TYPE:]kspecs timeout
ble-bind [-m keymap] --cursor cursor_code
ble-bind [-m keymap]... (-PD|--print|--dump)
ble-bind (-L|--list-widgets)

TYPE:SPEC
  TYPE specifies the format of SPEC. The default is  "kspecs".

  kspecs  ble.sh keyboard spec
  keys    List of key codes
  chars   List of character codes in Unicode
  keyseq  Key sequence in the Readline format
  raw     Raw byte sequence

TIMEOUT
  specifies the timeout duration in milliseconds.

CURSOR_CODE
  specifies the cursor shape by the DECSCUSR code.

EOF
}
function ble-bind/check-argument {
  if (($3<$2)); then
    flags=E$flags
    if (($2==1)); then
      ble/util/print "ble-bind: the option \`$1' requires an argument." >&2
    else
      ble/util/print "ble-bind: the option \`$1' requires $2 arguments." >&2
    fi
    return 2
  fi
}
function ble-bind/option:csi {
  local ret key=
  if [[ $2 ]]; then
    ble-decode-kbd "$2"
    ble/string#split-words key "$ret"
    if ((${#key[@]}!=1)); then
      ble/util/print "ble-bind --csi: the second argument is not a single key!" >&2
      return 1
    elif ((key&~_ble_decode_MaskChar)); then
      ble/util/print "ble-bind --csi: the second argument should not have modifiers!" >&2
      return 1
    fi
  fi
  local rex
  if rex='^([1-9][0-9]*)~$' && [[ $1 =~ $rex ]]; then
    _ble_decode_csimap_tilde[BASH_REMATCH[1]]=$key
    local -a cseq
    cseq=(27 91)
    local ret i iN num="${BASH_REMATCH[1]}\$"
    for ((i=0,iN=${#num};i<iN;i++)); do
      ble/util/s2c "${num:i:1}"
      ble/array#push cseq "$ret"
    done
    local IFS=$_ble_term_IFS
    if [[ $key ]]; then
      ble-decode-char/bind "${cseq[*]}" $((key|_ble_decode_Shft))
    else
      ble-decode-char/unbind "${cseq[*]}"
    fi
  elif [[ $1 == [a-zA-Z] ]]; then
    local ret; ble/util/s2c "$1"
    _ble_decode_csimap_alpha[ret]=$key
  else
    ble/util/print "ble-bind --csi: not supported type of csi sequences: CSI \`$1'." >&2
    return 1
  fi
}
function ble-bind/option:list-widgets {
  declare -f | ble/bin/sed -n 's/^ble\/widget\/\([a-zA-Z][^.[:space:]();&|]\{1,\}\)[[:space:]]*()[[:space:]]*$/\1/p'
}
function ble-bind/option:dump {
  if (($#)); then
    local keymap
    for keymap; do
      ble/decode/keymap#dump "$keymap"
    done
  else
    ble/util/declare-print-definitions "${!_ble_decode_kbd__@}" "${!_ble_decode_cmap_@}" "${!_ble_decode_csimap_@}"
    ble/decode/keymap#dump
  fi
}
function ble-bind/option:print {
  local ble_bind_print=1
  local sgr0= sgrf= sgrq= sgrc= sgro=
  if [[ $flags == *c* || $flags != *n* && -t 1 ]]; then
    local ret
    ble/color/face2sgr command_function; sgrf=$ret
    ble/color/face2sgr syntax_quoted; sgrq=$ret
    ble/color/face2sgr syntax_comment; sgrc=$ret
    ble/color/face2sgr argument_option; sgro=$ret
    sgr0=$_ble_term_sgr0
  fi
  local keymap
  ble-decode/INITIALIZE_DEFMAP -v keymap # 初期化を強制する
  if (($#)); then
    for keymap; do
      ble/decode/keymap#print "$keymap"
    done
  else
    ble-decode-char/csi/print
    ble-decode-char/print
    ble/decode/keymap#print
  fi
}
function ble-bind {
  local flags= kmap=${ble_bind_keymap-} ret
  local -a keymaps; keymaps=()
  ble/decode/initialize
  local IFS=$_ble_term_IFS q=\' Q="''\'"
  local arg c
  while (($#)); do
    local arg=$1; shift
    if [[ $arg == --?* ]]; then
      case "${arg:2}" in
      (color|color=always)
        flags=c${flags//[cn]} ;;
      (color=never)
        flags=n${flags//[cn]} ;;
      (color=auto)
        flags=${flags//[cn]} ;;
      (help)
        ble-bind/option:help
        flags=D$flags ;;
      (csi)
        flags=D$flags
        ble-bind/check-argument --csi 2 $# || break
        ble-bind/option:csi "$1" "$2"
        shift 2 ;;
      (cursor)
        flags=D$flags
        ble-bind/check-argument --cursor 1 $# || break
        ble-bind/.initialize-kmap &&
          ble/decode/keymap#set-cursor "$kmap" "$1"
        shift 1 ;;
      (list-widgets|list-functions)
        flags=D$flags
        ble-bind/option:list-widgets ;;
      (dump)
        flags=D$flags
        ble-bind/option:dump "${keymaps[@]}" ;;
      (print)
        flags=D$flags
        ble-bind/option:print "${keymaps[@]}" ;;
      (*)
        flags=E$flags
        ble/util/print "ble-bind: unrecognized long option $arg" >&2 ;;
      esac
    elif [[ $arg == -?* ]]; then
      arg=${arg:1}
      while ((${#arg})); do
        c=${arg::1} arg=${arg:1}
        case $c in
        (k)
          flags=D$flags
          if (($#<2)); then
            ble/util/print "ble-bind: the option \`-k' requires two arguments." >&2
            flags=E$flags
            break
          fi
          ble-decode-kbd "$1"; local cseq=$ret
          if [[ $2 && $2 != - ]]; then
            ble-decode-kbd "$2"; local kc=$ret
            ble-decode-char/bind "$cseq" "$kc"
          else
            ble-decode-char/unbind "$cseq"
          fi
          shift 2 ;;
        (m)
          ble-bind/check-argument -m 1 $# || break
          if ! ble/decode/is-keymap "$1"; then
            ble/util/print "ble-bind: the keymap '$1' is unknown." >&2
            flags=E$flags
            shift
            continue
          fi
          kmap=$1
          ble/array#push keymaps "$1"
          shift ;;
        (D)
          flags=D$flags
          ble-bind/option:dump "${keymaps[@]}" ;;
        ([Pd])
          flags=D$flags
          ble-bind/option:print "${keymaps[@]}" ;;
        (['fxc@s'])
          flags=D$flags
          [[ $c != f && $arg == f* ]] && arg=${arg:1}
          ble-bind/check-argument "-$c" 2 $# || break
          ble-decode-kbd "$1"; local kbd=$ret
          if [[ $2 && $2 != - ]]; then
            local command=$2
            case $c in
            (f) command=ble/widget/$command ;; # ble/widget/ 関数
            (x) command="ble/widget/.EDIT_COMMAND '${command//$q/$Q}'" ;; # 編集用の関数
            (c) command="ble/widget/.SHELL_COMMAND '${command//$q/$Q}'" ;; # コマンド実行
            (s) local ret; ble/util/keyseq2chars "$command"; command="ble/widget/.MACRO ${ret[*]}" ;;
            ('@') ;; # 直接実行
            (*)
              ble/util/print "error: unsupported binding type \`-$c'." 1>&2
              continue ;;
            esac
            ble-bind/.initialize-kmap &&
              ble-decode-key/bind "$kmap" "$kbd" "$command"
          else
            ble-bind/.initialize-kmap &&
              ble-decode-key/unbind "$kmap" "$kbd"
          fi
          shift 2 ;;
        (T)
          flags=D$flags
          ble-decode-kbd "$1"; local kbd=$ret
          ble-bind/check-argument -T 2 $# || break
          ble-bind/.initialize-kmap &&
            ble-decode-key/set-timeout "$kmap" "$kbd" "$2"
          shift 2 ;;
        (L)
          flags=D$flags
          ble-bind/option:list-widgets ;;
        (*)
          ble/util/print "ble-bind: unrecognized short option \`-$c'." >&2
          flags=E$flags ;;
        esac
      done
    else
      ble/util/print "ble-bind: unrecognized argument \`$arg'." >&2
      flags=E$flags
    fi
  done
  [[ $flags == *E* ]] && return 2
  [[ $flags == *R* ]] && return 1
  [[ $flags == *D* ]] || ble-bind/option:print "${keymaps[@]}"
  return 0
}
function ble/decode/read-inputrc/test {
  local text=$1
  if [[ ! $text ]]; then
    ble/util/print "ble.sh (bind):\$if: test condition is not supplied." >&2
    return 1
  elif local rex=$'[ \t]*([<>]=?|[=!]?=)[ \t]*(.*)$'; [[ $text =~ $rex ]]; then
    local op=${BASH_REMATCH[1]}
    local rhs=${BASH_REMATCH[2]}
    local lhs=${text::${#text}-${#BASH_REMATCH}}
  else
    local lhs=application
    local rhs=$text
  fi
  case $lhs in
  (application)
    local ret; ble/string#tolower "$rhs"
    [[ $ret == bash || $ret == blesh ]]
    return "$?" ;;
  (mode)
    if [[ -o emacs ]]; then
      test emacs "$op" "$rhs"
    elif [[ -o vi ]]; then
      test vi "$op" "$rhs"
    else
      false
    fi
    return "$?" ;;
  (term)
    if [[ $op == '!=' ]]; then
      test "$TERM" "$op" "$rhs" && test "${TERM%%-*}" "$op" "$rhs"
    else
      test "$TERM" "$op" "$rhs" || test "${TERM%%-*}" "$op" "$rhs"
    fi
    return "$?" ;;
  (version)
    local lhs_major lhs_minor
    if ((_ble_bash<40400)); then
      ((lhs_major=2+_ble_bash/10000,
        lhs_minor=_ble_bash/100%100))
    elif ((_ble_bash<50000)); then
      ((lhs_major=7,lhs_minor=0))
    else
      ((lhs_major=3+_ble_bash/10000,
        lhs_minor=_ble_bash/100%100))
    fi
    local rhs_major rhs_minor
    if [[ $rhs == *.* ]]; then
      local version
      ble/string#split version . "$rhs"
      rhs_major=${version[0]}
      rhs_minor=${version[1]}
    else
      ((rhs_major=rhs,rhs_minor=0))
    fi
    local lhs_ver=$((lhs_major*10000+lhs_minor))
    local rhs_ver=$((rhs_major*10000+rhs_minor))
    [[ $op == '=' ]] && op='=='
    let "$lhs_ver$op$rhs_ver"
    return "$?" ;;
  (*)
    if local ret; ble/util/read-rl-variable "$lhs"; then
      test "$ret" "$op" "$rhs"
      return "$?"
    else
      ble/util/print "ble.sh (bind):\$if: unknown readline variable '${lhs//$q/$Q}'." >&2
      return 1
    fi ;;
  esac
}
function ble/decode/read-inputrc {
  local file=$1 ref=$2 q=\' Q="''\'"
  if [[ -f $ref && $ref == */* && $file != /* ]]; then
    local relative_file=${ref%/*}/$file
    [[ -f $relative_file ]] && file=$relative_file
  fi
  if [[ ! -f $file ]]; then
    ble/util/print "ble.sh (bind):\$include: the file '${1//$q/$Q}' not found." >&2
    return 1
  fi
  local -a script=()
  local ret line= iline=0 TMOUT= 2>/dev/null # #D1630 WA readonly TMOUT
  while builtin read "${_ble_bash_tmout_wa[@]}" -r line || [[ $line ]]; do
    ((++iline))
    ble/string#trim "$line"; line=$ret
    [[ ! $line || $line == '#'* ]] && continue
    if [[ $line == '$'* ]]; then
      local directive=${line%%[$IFS]*}
      case $directive in
      ('$if')
        local args=${line#'$if'}
        ble/string#trim "$args"; args=$ret
        ble/array#push script "if ble/decode/read-inputrc/test '${args//$q/$Q}'; then :" ;;
      ('$else')  ble/array#push script 'else :' ;;
      ('$endif') ble/array#push script 'fi' ;;
      ('$include')
        local args=${line#'$include'}
        ble/string#trim "$args"; args=$ret
        ble/array#push script "ble/decode/read-inputrc '${args//$q/$Q}' '${file//$q/$Q}'" ;;
      (*)
        ble/util/print "ble.sh (bind):$file:$iline: unrecognized directive '$directive'." >&2 ;;
      esac
    else
      ble/array#push script "ble/builtin/bind/.process -- '${line//$q/$Q}'"
    fi
  done < "$file"
  IFS=$'\n' builtin eval 'script="${script[*]}"'
  builtin eval -- "$script"
}
_ble_builtin_bind_keymap=
function ble/builtin/bind/set-keymap {
  local opt_keymap= flags=
  ble/builtin/bind/option:m "$1" &&
    _ble_builtin_bind_keymap=$opt_keymap
  return 0
}
function ble/builtin/bind/option:m {
  local name=$1
  local ret; ble/string#tolower "$name"; local keymap=$ret
  case $keymap in
  (emacs|emacs-standard|emacs-meta|emacs-ctlx) ;;
  (vi|vi-command|vi-move|vi-insert) ;;
  (*) keymap= ;;
  esac
  if [[ ! $keymap ]]; then
    ble/util/print "ble.sh (bind): unrecognized keymap name '$name'" >&2
    flags=e$flags
    return 1
  else
    opt_keymap=$keymap
    return 0
  fi
}
function ble/builtin/bind/.decompose-pair {
  local LC_ALL= LC_CTYPE=C
  local ret; ble/string#trim "$1"
  local spec=$ret ifs=$_ble_term_IFS q=\' Q="'\''"
  keyseq= value=
  [[ ! $spec || $spec == 'set'["$ifs"]* ]] && return 3
  local rex='^(("([^\"]|\\.)*"|[^":'$ifs'])*("([^\"]|\\.)*)?)['$ifs']*(:['$ifs']*)?'
  [[ $spec =~ $rex ]]
  keyseq=${BASH_REMATCH[1]} value=${spec:${#BASH_REMATCH}}
  if [[ $keyseq == '$'* ]]; then
    return 3
  elif [[ ! $keyseq ]]; then
    ble/util/print "ble.sh (bind): empty keyseq in spec:'${spec//$q/$Q}'" >&2
    flags=e$flags
    return 1
  elif rex='^"([^\"]|\\.)*$'; [[ $keyseq =~ $rex ]]; then
    ble/util/print "ble.sh (bind): no closing '\"' in keyseq:'${keyseq//$q/$Q}'" >&2
    flags=e$flags
    return 1
  elif rex='^"([^\"]|\\.)*"'; [[ $keyseq =~ $rex ]]; then
    local rematch=${BASH_REMATCH[0]}
    if ((${#rematch}<${#keyseq})); then
      local fragment=${keyseq:${#rematch}}
      ble/util/print "ble.sh (bind): warning: unprocessed fragments in keyseq '${fragment//$q/$Q}'" >&2
    fi
    keyseq=$rematch
    return 0
  else
    return 0
  fi
}
ble/function#suppress-stderr ble/builtin/bind/.decompose-pair
function ble/builtin/bind/.parse-keyname {
  local ret mflags=
  ble/string#tolower "$1"; local lower=$ret
  if [[ $1 == *-* ]]; then
    ble/string#split ret - "$lower"
    local mod
    for mod in "${ret[@]::${#ret[@]}-1}"; do
      case $mod in
      (*m|*meta) mflags=m$mflags ;;
      (*c|*ctrl|*control) mflags=c$mflags ;;
      esac
    done
  fi
  local name=${lower##*-} ch=
  case $name in
  (rubout|del) ch=$'\177' ;;
  (escape|esc) ch=$'\033' ;;
  (newline|lfd) ch=$'\n' ;;
  (return|ret) ch=$'\r' ;;
  (space|spc) ch=' ' ;;
  (tab) ch=$'\t' ;;
  (*) ble/util/substr "${1##*-}" 0 1; ch=$ret ;;
  esac
  ble/util/s2c "$ch"; local key=$ret
  [[ $mflags == *c* ]] && ((key&=0x1F))
  [[ $mflags == *m* ]] && ((key|=0x80))
  chars=("$key")
}
function ble/builtin/bind/.initialize-kmap {
  local keymap=$1
  kmap=
  case $keymap in
  (emacs|emacs-standard) kmap=emacs ;;
  (emacs-ctlx) kmap=emacs; keys=(24 "${keys[@]}") ;;
  (emacs-meta) kmap=emacs; keys=(27 "${keys[@]}") ;;
  (vi-insert) kmap=vi_imap ;;
  (vi|vi-command|vi-move) kmap=vi_nmap ;;
  (*) ble-decode/GET_BASEMAP -v kmap ;;
  esac
  if ! ble/decode/is-keymap "$kmap"; then
    ble/util/print "ble/builtin/bind: the keymap '$kmap' is unknown." >&2
    return 1
  fi
  return 0
}
function ble/builtin/bind/.initialize-keys-and-value {
  local spec=$1 opts=$2
  keys= value=
  local keyseq
  ble/builtin/bind/.decompose-pair "$spec" || return "$?"
  local chars
  if [[ $keyseq == \"*\" ]]; then
    local ret; ble/util/keyseq2chars "${keyseq:1:${#keyseq}-2}"
    chars=("${ret[@]}")
    ((${#chars[@]})) || ble/util/print "ble.sh (bind): warning: empty keyseq" >&2
  else
    [[ :$opts: == *:nokeyname:* ]] &&
      ble/util/print "ble.sh (bind): warning: readline \"bind -x\" does not support \"keyname\" spec" >&2
    ble/builtin/bind/.parse-keyname "$keyseq"
  fi
  ble/decode/cmap/decode-chars "${chars[@]}"
}
function ble/builtin/bind/option:x {
  local q=\' Q="''\'"
  local keys value kmap
  if ! ble/builtin/bind/.initialize-keys-and-value "$1" nokeyname; then
    ble/util/print "ble.sh (bind): unrecognized readline command '${1//$q/$Q}'." >&2
    flags=e$flags
    return 1
  elif ! ble/builtin/bind/.initialize-kmap "$opt_keymap"; then
    ble/util/print "ble.sh (bind): sorry, failed to initialize keymap:'$opt_keymap'." >&2
    flags=e$flags
    return 1
  fi
  if [[ $value == \"* ]]; then
    local ifs=$_ble_term_IFS
    local rex='^"(([^\"]|\\.)*)"'
    if ! [[ $value =~ $rex ]]; then
      ble/util/print "ble.sh (bind): no closing '\"' in spec:'${1//$q/$Q}'" >&2
      flags=e$flags
      return 1
    fi
    if ((${#BASH_REMATCH}<${#value})); then
      local fragment=${value:${#BASH_REMATCH}}
      ble/util/print "ble.sh (bind): warning: unprocessed fragments:'${fragment//$q/$Q}' in spec:'${1//$q/$Q}'" >&2
    fi
    value=${BASH_REMATCH[1]}
  fi
  [[ $value == \"*\" ]] && value=${value:1:${#value}-2}
  local command="ble/widget/.EDIT_COMMAND '${value//$q/$Q}'"
  ble-decode-key/bind "$kmap" "${keys[*]}" "$command"
}
function ble/builtin/bind/option:r {
  local keyseq=$1
  local ret chars keys
  ble/util/keyseq2chars "$keyseq"; chars=("${ret[@]}")
  ble/decode/cmap/decode-chars "${chars[@]}"
  local kmap
  ble/builtin/bind/.initialize-kmap "$opt_keymap" || return 1
  ble-decode-key/unbind "$kmap" "${keys[*]}"
}
_ble_decode_rlfunc2widget_emacs=()
_ble_decode_rlfunc2widget_vi_imap=()
_ble_decode_rlfunc2widget_vi_nmap=()
function ble/builtin/bind/rlfunc2widget {
  local kmap=$1 rlfunc=$2
  local IFS=$_ble_term_IFS
  local rlfunc_file= rlfunc_dict=
  case $kmap in
  (emacs)   rlfunc_file=$_ble_base/lib/core-decode.emacs-rlfunc.txt
            rlfunc_dict=_ble_decode_rlfunc2widget_emacs ;;
  (vi_imap) rlfunc_file=$_ble_base/lib/core-decode.vi_imap-rlfunc.txt
            rlfunc_dict=_ble_decode_rlfunc2widget_vi_imap ;;
  (vi_nmap) rlfunc_file=$_ble_base/lib/core-decode.vi_nmap-rlfunc.txt
            rlfunc_dict=_ble_decode_rlfunc2widget_vi_nmap ;;
  esac
  if [[ $rlfunc_file ]]; then
    local dict script='
    ((${#DICT[@]})) ||
      ble/util/mapfile DICT < "$rlfunc_file"
    dict=("${DICT[@]}")'
    builtin eval -- "${script//DICT/$rlfunc_dict}"
    local line TMOUT= 2>/dev/null # #D1630 WA readonly TMOUT
    for line in "${dict[@]}"; do
      [[ $line == "$rlfunc "* ]] || continue
      local rl widget; builtin read "${_ble_bash_tmout_wa[@]}" -r rl widget <<< "$line"
      if [[ $widget == - ]]; then
        ble/util/print "ble.sh (bind): unsupported readline function '${rlfunc//$q/$Q}' for keymap '$kmap'." >&2
        return 1
      elif [[ $widget == '<IGNORE>' ]]; then
        return 2
      fi
      ret=ble/widget/$widget
      return 0
    done
  fi
  if ble/is-function ble/widget/"${rlfunc%%[$IFS]*}"; then
    ret=ble/widget/$rlfunc
    return 0
  fi
  ble/util/print "ble.sh (bind): unsupported readline function '${rlfunc//$q/$Q}'." >&2
  return 1
}
function ble/builtin/bind/option:u {
  local rlfunc=$1
  local kmap
  if ! ble/builtin/bind/.initialize-kmap "$opt_keymap" || ! ble/decode/keymap#load "$kmap"; then
    ble/util/print "ble.sh (bind): sorry, failed to initialize keymap:'$opt_keymap'." >&2
    flags=e$flags
    return 1
  fi
  local ret
  ble/builtin/bind/rlfunc2widget "$kmap" "$rlfunc" || return 0
  local command=$ret
  local -a unbind_keys_list=()
  ble/builtin/bind/option:u/search-recursive "$kmap"
  local keys
  for keys in "${unbind_keys_list[@]}"; do
    ble-decode-key/unbind "$kmap" "$keys"
  done
}
function ble/builtin/bind/option:u/search-recursive {
  local kmap=$1 tseq=$2
  local dicthead=_ble_decode_${kmap}_kmap_
  local key keys
  builtin eval "keys=(\${!$dicthead$tseq[@]})"
  for key in "${keys[@]}"; do
    builtin eval "local ent=\${$dicthead$tseq[key]}"
    if [[ ${ent:2} == "$command" ]]; then
      ble/array#push unbind_keys_list "${tseq//_/ } $key"
    fi
    if [[ ${ent::1} == _ ]]; then
      ble/builtin/bind/option:u/search-recursive "$kmap" "${tseq}_$key"
    fi
  done
}
function ble/builtin/bind/option:- {
  local ret; ble/string#trim "$1"; local arg=$ret
  local q=\' ifs=$_ble_term_IFS
  local rex='^(([^\"'$q$ifs']|"([^\"]|\\.)*"|'$q'([^\'$q']|\\.)*'$q'|\\.|['$ifs']+[^#'$_ifs'])*)['$ifs']+#'
  [[ $arg =~ $rex ]] && arg=${BASH_REMATCH[1]}
  local ifs=$_ble_term_IFS
  if [[ $arg == 'set'["$ifs"]* ]]; then
    if [[ $_ble_decode_bind_state != none ]]; then
      local variable= value= rex=$'^set[ \t]+([^ \t]+)[ \t]+([^ \t].*)$'
      [[ $arg =~ $rex ]] && variable=${BASH_REMATCH[1]} value=${BASH_REMATCH[2]}
      case $variable in
      (keymap)
        ble/builtin/bind/set-keymap "$value"
        return 0 ;;
      (editing-mode)
        _ble_builtin_bind_keymap= ;;
      esac
      builtin bind "$arg"
    fi
    return 0
  fi
  local keys value kmap
  if ! ble/builtin/bind/.initialize-keys-and-value "$arg"; then
    local q=\' Q="''\'"
    ble/util/print "ble.sh (bind): unrecognized readline command '${arg//$q/$Q}'." >&2
    flags=e$flags
    return 1
  elif ! ble/builtin/bind/.initialize-kmap "$opt_keymap"; then
    ble/util/print "ble.sh (bind): sorry, failed to initialize keymap:'$opt_keymap'." >&2
    flags=e$flags
    return 1
  fi
  if [[ $value == \"* ]]; then
    local bind_keys="${keys[*]}"
    value=${value#\"} value=${value%\"}
    local ret chars; ble/util/keyseq2chars "$value"; chars=("${ret[@]}")
    local command="ble/widget/.MACRO ${chars[*]}"
    ble/decode/cmap/decode-chars "${chars[@]}"
    [[ ${keys[*]} != "$bind_keys" ]] &&
      ble-decode-key/bind "$kmap" "$bind_keys" "$command"
  elif [[ $value ]]; then
    local ret; ble/builtin/bind/rlfunc2widget "$kmap" "$value"; local ext=$?
    if ((ext==0)); then
      local command=$ret
      ble-decode-key/bind "$kmap" "${keys[*]}" "$command"
      return 0
    elif ((ext==2)); then
      return 0
    else
      flags=e$flags
      return 1
    fi
  else
    ble/util/print "ble.sh (bind): readline function name is not specified ($arg)." >&2
    return 1
  fi
}
function ble/builtin/bind/.process {
  flags=
  local IFS=$_ble_term_IFS
  local opt_literal= opt_keymap=$_ble_builtin_bind_keymap opt_print=
  local -a opt_queries=()
  while (($#)); do
    local arg=$1; shift
    if [[ ! $opt_literal ]]; then
      case $arg in
      (--) opt_literal=1
           continue ;;
      (--help)
        if ((_ble_bash<40400)); then
          ble/util/print "ble.sh (bind): unrecognized option $arg" >&2
          flags=e$flags
        else
          [[ $_ble_decode_bind_state != none ]] &&
            (builtin bind --help)
          flags=h$flags
        fi
        continue ;;
      (--*)
        ble/util/print "ble.sh (bind): unrecognized option $arg" >&2
        flags=e$flags
        continue ;;
      (-*)
        local i n=${#arg} c
        for ((i=1;i<n;i++)); do
          c=${arg:i:1}
          case $c in
          ([lpPsSvVX])
            opt_print=$opt_print$c ;;
          ([mqurfx])
            if ((!$#)); then
              ble/util/print "ble.sh (bind): missing option argument for -$c" >&2
              flags=e$flags
            else
              local optarg=$1; shift
              case $c in
              (m) ble/builtin/bind/option:m "$optarg" ;;
              (x) ble/builtin/bind/option:x "$optarg" ;;
              (r) ble/builtin/bind/option:r "$optarg" ;;
              (u) ble/builtin/bind/option:u "$optarg" ;;
              (q) ble/array#push opt_queries "$optarg" ;;
              (f) ble/decode/read-inputrc "$optarg" ;;
              (*)
                ble/util/print "ble.sh (bind): unsupported option -$c $optarg" >&2
                flags=e$flags ;;
              esac
            fi ;;
          (*)
            ble/util/print "ble.sh (bind): unrecognized option -$c" >&2
            flags=e$flags ;;
          esac
        done
        continue ;;
      esac
    fi
    ble/builtin/bind/option:- "$arg"
    opt_literal=1
  done
  if [[ $_ble_decode_bind_state != none ]]; then
    if [[ $opt_print == *[pPsSX]* ]] || ((${#opt_queries[@]})); then
      ( ble/decode/bind/unbind
        [[ -s "$_ble_base_run/$$.bind.save" ]] &&
          source "$_ble_base_run/$$.bind.save"
        [[ $opt_print ]] &&
          builtin bind ${opt_keymap:+-m $opt_keymap} -$opt_print
        declare rlfunc
        for rlfunc in "${opt_queries[@]}"; do
          builtin bind ${opt_keymap:+-m $opt_keymap} -q "$rlfunc"
        done )
    elif [[ $opt_print ]]; then
      builtin bind ${opt_keymap:+-m $opt_keymap} -$opt_print
    fi
  fi
  return 0
}
_ble_builtin_bind_inputrc_done=
function ble/builtin/bind/initialize-inputrc {
  [[ $_ble_builtin_bind_inputrc_done ]] && return 0
  _ble_builtin_bind_inputrc_done=1
  local inputrc=${INPUTRC:-$HOME/.inputrc}
  [[ -e $inputrc ]] && ble/decode/read-inputrc "$inputrc"
}
_ble_builtin_bind_user_settings_loaded=
function ble/builtin/bind/read-user-settings/.collect {
  local map
  for map in vi-insert vi-command emacs; do
    local cache=$_ble_base_cache/decode.readline.$_ble_bash.$map.txt
    if ! [[ -s $cache && $cache -nt $_ble_base/ble.sh ]]; then
      INPUTRC=/dev/null "$BASH" --noprofile --norc -i -c "builtin bind -m $map -p" |
        LC_ALL= LC_CTYPE=C ble/bin/sed '/^#/d;s/"\\M-/"\\e/' >| "$cache.part" &&
        ble/bin/mv "$cache.part" "$cache" || continue
    fi
    local cache_content
    ble/util/readfile cache_content "$cache"
    ble/util/print __CLEAR__
    ble/util/print KEYMAP="$map"
    ble/util/print __BIND0__
    ble/util/print "${cache_content%$_ble_term_nl}"
    if ((_ble_bash>=40300)); then
      ble/util/print __BINDX__
      builtin bind -m "$map" -X
    fi
    ble/util/print __BINDS__
    builtin bind -m "$map" -s
    ble/util/print __BINDP__
    builtin bind -m "$map" -p
    ble/util/print __PRINT__
  done
}
function ble/builtin/bind/read-user-settings/.reconstruct {
  local collect q=\'
  ble/util/assign collect ble/builtin/bind/read-user-settings/.collect
  <<< "$collect" LC_ALL= LC_CTYPE=C ble/bin/awk -v q="$q" -v _ble_bash="$_ble_bash" '
    function keymap_register(key, val, type) {
      if (!haskey[key]) {
        keys[nkey++] = key;
        haskey[key] = 1;
      }
      keymap[key] = val;
      keymap_type[key] = type;
    }
    function keymap_clear(_, i, key) {
      for(i = 0; i < nkey; i++) {
        key = keys[i];
        delete keymap[key];
        delete keymap_type[key];
        delete keymap0[key];
        haskey[key] = 0;
      }
      nkey = 0;
    }
    function keymap_print(_, i, key, type, value, text, line) {
      for (i = 0; i < nkey; i++) {
        key = keys[i];
        type = keymap_type[key];
        value = keymap[key];
        if (type == "" && value == keymap0[key]) continue;
        text = key ": " value;
        gsub(/'$q'/, q "\\" q q, text);
        line = "bind";
        if (KEYMAP != "") line = line " -m " KEYMAP;
        if (type == "x") line = line " -x";
        line = line " " q text q;
        print line;
      }
    }
    /^__BIND0__$/ { mode = 0; next; }
    /^__BINDX__$/ { mode = 1; next; }
    /^__BINDS__$/ { mode = 2; next; }
    /^__BINDP__$/ { mode = 3; next; }
    /^__CLEAR__$/ { keymap_clear(); next; }
    /^__PRINT__$/ { keymap_print(); next; }
    sub(/^KEYMAP=/, "") { KEYMAP = $0; }
    /ble-decode\/.hook / { next; }
    function workaround_bashbug(keyseq, _, rex, out, unit) {
      out = "";
      while (keyseq != "") {
        if (mode == 0 || mode == 3) {
          match(keyseq, /^\\C-\\(\\"$)?|^\\M-|^\\.|^./);
        } else {
          match(keyseq, /^\\[CM]-|^\\.|^./);
        }
        unit = substr(keyseq, 1, RLENGTH);
        keyseq = substr(keyseq, 1 + RLENGTH);
        if (unit == "\\C-\\") {
          unit = unit "\\";
        } else if (unit == "\\M-") {
          unit = "\\e";
        }
        out = out unit;
      }
      return out;
    }
    match($0, /^"(\\.|[^"])+": /) {
      key = substr($0, 1, RLENGTH - 2);
      val = substr($0, 1 + RLENGTH);
      if (_ble_bash < 50100)
        key = workaround_bashbug(key);
      if (mode) {
        type = mode == 1 ? "x" : mode == 2 ? "s" : "";
        keymap_register(key, val, type);
      } else {
        keymap0[key] = val;
      }
    }
  ' 2>/dev/null # suppress LC_ALL error messages
}
function ble/builtin/bind/read-user-settings/.cache-enabled {
  local keymap use_cache=1
  for keymap in emacs vi_imap vi_nmap; do
    ble/decode/keymap#registered "$keymap" && return 1
    [[ -s $delay_prefix.$keymap ]] && return 1
  done
  return 0
}
function ble/builtin/bind/read-user-settings/.cache-alive {
  [[ -e $cache_prefix.settings ]] || return 1
  [[ $cache_prefix.settings -nt $_ble_base/lib/init-cmap.sh  ]] || return 1
  local keymap
  for keymap in emacs vi_imap vi_nmap; do
    [[ $cache_prefix.settings -nt $_ble_base/core-decode.$cache-rlfunc.txt ]] || return 1
    [[ -e $cache_prefix.$keymap ]] || return 1
  done
  local content
  ble/util/readfile content "$cache_prefix.settings"
  [[ ${content%$'\n'} == "$settings" ]]
}
function ble/builtin/bind/read-user-settings/.cache-save {
  local keymap content fail=
  for keymap in emacs vi_imap vi_nmap; do
    if [[ -s $delay_prefix.$keymap ]]; then
      ble/util/copyfile "$delay_prefix.$keymap" "$cache_prefix.$keymap"
    else
      : >| "$cache_prefix.$keymap"
    fi || fail=1
  done
  [[ $fail ]] && return 1
  ble/util/print "$settings" >| "$cache_prefix.settings"
}
function ble/builtin/bind/read-user-settings/.cache-load {
  local keymap
  for keymap in emacs vi_imap vi_nmap; do
    ble/util/copyfile "$cache_prefix.$keymap" "$delay_prefix.$keymap"
  done
}
function ble/builtin/bind/read-user-settings {
  if [[ $_ble_decode_bind_state == none ]]; then
    [[ $_ble_builtin_bind_user_settings_loaded ]] && return 0
    _ble_builtin_bind_user_settings_loaded=1
    builtin bind # inputrc を読ませる
    local settings
    ble/util/assign settings ble/builtin/bind/read-user-settings/.reconstruct
    [[ $settings ]] || return 0
    local cache_prefix=$_ble_base_cache/decode.inputrc.$_ble_decode_kbd_ver.$TERM
    local delay_prefix=$_ble_base_run/$$.bind.delay
    if ble/builtin/bind/read-user-settings/.cache-enabled; then
      if ble/builtin/bind/read-user-settings/.cache-alive; then
        ble/builtin/bind/read-user-settings/.cache-load
      else
        builtin eval -- "$settings"
        ble/builtin/bind/read-user-settings/.cache-save
      fi
    else
      builtin eval -- "$settings"
    fi
  fi
}
function ble/builtin/bind {
  local set shopt; ble/base/.adjust-bash-options set shopt
  [[ ! $_ble_attached || $_ble_edit_exec_inside_userspace ]] &&
    ble/base/adjust-BASH_REMATCH
  ble/decode/initialize
  local flags= ext=0
  ble/builtin/bind/.process "$@"
  if [[ $_ble_decode_bind_state == none ]]; then
    builtin bind "$@"; ext=$?
  elif [[ $flags == *[eh]* ]]; then
    [[ $flags == *e* ]] &&
      builtin bind --usage 2>&1 1>/dev/null | ble/bin/grep ^bind >&2
    ext=2
  fi
  [[ ! $_ble_attached || $_ble_edit_exec_inside_userspace ]] &&
    ble/base/restore-BASH_REMATCH
  ble/base/.restore-bash-options set shopt
  return "$ext"
}
function bind { ble/builtin/bind "$@"; }
function ble/decode/initialize/.has-broken-suse-inputrc {
  ((_ble_bash<50000)) || return 1 # Bash 5.0+ are not suffered
  [[ -s /etc/inputrc.keys ]] || return 1
  local content
  ble/util/readfile content /etc/inputrc.keys
  [[ $content == *'"\M-[2~":'* ]]
}
_ble_decode_initialized=
function ble/decode/initialize {
  [[ $_ble_decode_initialized ]] && return 0
  _ble_decode_initialized=1
  ble/decode/cmap/initialize
  if ble/decode/initialize/.has-broken-suse-inputrc; then
    [[ ${INPUTRC-} == /etc/inputrc || ${INPUTRC-} == /etc/inputrc.keys ]] &&
      local INPUTRC=~/.inputrc
    ble/builtin/bind/initialize-inputrc
  else
    ble/builtin/bind/read-user-settings
  fi
}
function ble/decode/reset-default-keymap {
  local old_base_keymap=${_ble_decode_keymap_stack[0]:-$_ble_decode_keymap}
  ble-decode/INITIALIZE_DEFMAP -v _ble_decode_keymap # 0ms
  _ble_decode_keymap_stack=()
  if [[ $_ble_decode_keymap != "$old_base_keymap" ]]; then
    [[ $old_base_keymap ]] &&
      _ble_decode_keymap=$old_base_keymap ble-decode/widget/.invoke-hook "$_ble_decode_KCODE_DETACH"
    ble-decode/widget/.invoke-hook "$_ble_decode_KCODE_ATTACH" # 7ms for vi-mode
  fi
}
function ble/decode/attach {
  if ble/decode/keymap#is-empty "$_ble_decode_keymap"; then
    ble/util/print "ble.sh: The keymap '$_ble_decode_keymap' is empty." >&2
    return 1
  fi
  [[ $_ble_decode_bind_state != none ]] && return 0
  ble/util/save-editing-mode _ble_decode_bind_state
  [[ $_ble_decode_bind_state == none ]] && return 1
  ble/term/initialize # 3ms
  ble/util/reset-keymap-of-editing-mode
  builtin eval -- "$(ble/decode/bind/.generate-source-to-unbind-default)" # 21ms
  ble/decode/bind/bind # 20ms
  case $TERM in
  (linux)
    _ble_term_TERM=linux:- ;;
  (st|st-*)
    _ble_term_TERM=st:- ;;
  (*)
    ble/util/buffer $'\e[>c' # DA2 要求 (ble-decode-char/csi/.decode で受信)
  esac
  return 0
}
function ble/decode/detach {
  [[ $_ble_decode_bind_state != none ]] || return 1
  local current_editing_mode=
  ble/util/save-editing-mode current_editing_mode
  [[ $_ble_decode_bind_state == "$current_editing_mode" ]] || ble/util/restore-editing-mode _ble_decode_bind_state
  ble/term/finalize
  ble/decode/bind/unbind
  if [[ -s "$_ble_base_run/$$.bind.save" ]]; then
    source "$_ble_base_run/$$.bind.save"
    : >| "$_ble_base_run/$$.bind.save"
  fi
  [[ $_ble_decode_bind_state == "$current_editing_mode" ]] || ble/util/restore-editing-mode current_editing_mode
  _ble_decode_bind_state=none
}
function ble/encoding:UTF-8/generate-binder { :; }
_ble_encoding_utf8_decode_mode=0
_ble_encoding_utf8_decode_code=0
_ble_encoding_utf8_decode_table=(
  'M&&E,A[i++]='{0..127}
  'C=C<<6|'{0..63}',--M==0&&(A[i++]=C)'
  'M&&E,C='{0..31}',M=1'
  'M&&E,C='{0..15}',M=2'
  'M&&E,C='{0..7}',M=3'
  'M&&E,C='{0..3}',M=4'
  'M&&E,C='{0..1}',M=5'
  'M&&E,A[i++]=_ble_decode_Erro|'{254,255}
)
function ble/encoding:UTF-8/clear {
  _ble_encoding_utf8_decode_mode=0
  _ble_encoding_utf8_decode_code=0
}
function ble/encoding:UTF-8/is-intermediate {
  ((_ble_encoding_utf8_decode_mode))
}
function ble/encoding:UTF-8/decode {
  local C=$_ble_encoding_utf8_decode_code
  local M=$_ble_encoding_utf8_decode_mode
  local E='M=0,A[i++]=_ble_decode_Erro|C'
  local -a A=()
  local i=0 b
  for b; do
    ((_ble_encoding_utf8_decode_table[b&255]))
  done
  _ble_encoding_utf8_decode_code=$C
  _ble_encoding_utf8_decode_mode=$M
  ((i)) && ble-decode-char "${A[@]}"
}
function ble/encoding:UTF-8/c2bc {
  local code=$1
  ((ret=code<0x80?1:
    (code<0x800?2:
    (code<0x10000?3:
    (code<0x200000?4:5)))))
}
function ble/encoding:C/generate-binder {
  ble/init:bind/bind-s '"\C-@":"\x9B\x80"'
  ble/init:bind/bind-s '"\e":"\x9B\x8B"' # isolated ESC (U+07FF)
  local i ret
  for i in {0..255}; do
    ble/decode/c2dqs "$i"
    ble/init:bind/bind-s "\"\e$ret\": \"\x9B\x9B$ret\""
  done
}
_ble_encoding_c_csi=
function ble/encoding:C/clear {
  _ble_encoding_c_csi=
}
function ble/encoding:C/is-intermediate {
  [[ $_ble_encoding_c_csi ]]
}
function ble/encoding:C/decode {
  local -a A=()
  local i=0 b
  for b; do
    if [[ $_ble_encoding_c_csi ]]; then
      _ble_encoding_c_csi=
      case $b in
      (155) A[i++]=27 # ESC
            continue ;;
      (139) A[i++]=2047 # isolated ESC
            continue ;;
      (128) A[i++]=0 # C-@
            continue ;;
      esac
      A[i++]=155
    fi
    if ((b==155)); then
      _ble_encoding_c_csi=1
    else
      A[i++]=$b
    fi
  done
  ((i)) && ble-decode-char "${A[@]}"
}
function ble/encoding:C/c2bc {
  ret=1
}
_ble_color_gflags_Bold=0x01
_ble_color_gflags_Italic=0x02
_ble_color_gflags_Underline=0x04
_ble_color_gflags_Revert=0x08
_ble_color_gflags_Invisible=0x10
_ble_color_gflags_Strike=0x20
_ble_color_gflags_Blink=0x40
_ble_color_gflags_DecorationMask=0x77
_ble_color_gflags_FgMask=0x00000000FFFFFF00
_ble_color_gflags_BgMask=0x00FFFFFF00000000
_ble_color_gflags_FgIndexed=0x0100000000000000
_ble_color_gflags_BgIndexed=0x0200000000000000
function ble/color/define-options {
  local ncolor=0
  if [[ $TERM == xterm* || $TERM == *-256color || $TERM == kterm* ]]; then
    ncolor=256
  elif [[ $TERM == *-88color ]]; then
    ncolor=88
  fi
  bleopt/declare -v term_true_colors semicolon
  bleopt/declare -v term_index_colors "$ncolor"
}
ble/color/define-options
function bleopt/check:term_true_colors {
  ble/color/g2sgr/.clear-cache
  return 0
}
function bleopt/check:term_index_colors {
  ble/color/g2sgr/.clear-cache
  return 0
}
function ble/color/initialize-term-colors {
  local fields
  ble/string#split fields \; "$_ble_term_DA2R"
  if [[ $bleopt_term_true_colors == auto ]]; then
    local value=
    if [[ $TERM == *-24bit || $TERM == *-direct ]]; then
      value=colon
    elif [[ $TERM == *-24bits || $TERM == *-truecolor || $COLORTERM == *24bit* || $COLORTERM == *truecolor* ]]; then
      value=semicolon
    else
      case ${fields[0]} in
      (83) # screen (truecolor on にしている必要がある。判定方法は不明)
        if ((fields[1]>=49900)); then
          value=semicolon
        fi ;;
      (67)
        if ((fields[1]>=100000)); then
          : # cygwin terminal
        else
          value=colon
        fi ;;
      esac
    fi
    [[ $value ]] &&
      bleopt term_true_colors="$value"
  fi
}
blehook DA2R+=ble/color/initialize-term-colors
function ble-color-show {
  if (($#)); then
    ble/base/print-usage-for-no-argument-command 'Update and reload ble.sh.' "$@"
    return "$?"
  fi
  local cols=16
  local bg bg0 bgN ret gflags=$((_ble_color_gflags_BgIndexed|_ble_color_gflags_FgIndexed))
  for ((bg0=0;bg0<256;bg0+=cols)); do
    ((bgN=bg0+cols,bgN<256||(bgN=256)))
    for ((bg=bg0;bg<bgN;bg++)); do
      ble/color/g2sgr $((gflags|bg<<32))
      printf '%s%03d ' "$ret" "$bg"
    done
    printf '%s\n' "$_ble_term_sgr0"
    for ((bg=bg0;bg<bgN;bg++)); do
      ble/color/g2sgr $((gflags|bg<<32|15<<8))
      printf '%s%03d ' "$ret" "$bg"
    done
    printf '%s\n' "$_ble_term_sgr0"
  done
}
_ble_color_g2sgr=()
_ble_color_g2sgr_ansi=()
function ble/color/g2sgr/.impl {
  local g=$(($1))
  local sgr=0
  ((g&_ble_color_gflags_Bold))      && sgr="$sgr;${_ble_term_sgr_bold:-1}"
  ((g&_ble_color_gflags_Italic))    && sgr="$sgr;${_ble_term_sgr_sitm:-3}"
  ((g&_ble_color_gflags_Underline)) && sgr="$sgr;${_ble_term_sgr_smul:-4}"
  ((g&_ble_color_gflags_Blink))     && sgr="$sgr;${_ble_term_sgr_blink:-5}"
  ((g&_ble_color_gflags_Revert))    && sgr="$sgr;${_ble_term_sgr_rev:-7}"
  ((g&_ble_color_gflags_Invisible)) && sgr="$sgr;${_ble_term_sgr_invis:-8}"
  ((g&_ble_color_gflags_Strike))    && sgr="$sgr;${_ble_term_sgr_strike:-9}"
  if ((g&_ble_color_gflags_FgIndexed)); then
    local fg=$((g>>8&0xFF))
    ble/color/.color2sgrfg "$fg"
    sgr="$sgr;$ret"
  elif ((g&_ble_color_gflags_FgMask)); then
    local rgb=$((1<<24|g>>8&0xFFFFFF))
    ble/color/.color2sgrfg "$rgb"
    sgr="$sgr;$ret"
  fi
  if ((g&_ble_color_gflags_BgIndexed)); then
    local bg=$((g>>32&0xFF))
    ble/color/.color2sgrbg "$bg"
    sgr="$sgr;$ret"
  elif ((g&_ble_color_gflags_BgMask)); then
    local rgb=$((1<<24|g>>32&0xFFFFFF))
    ble/color/.color2sgrbg "$rgb"
    sgr="$sgr;$ret"
  fi
  ret=$'\e['$sgr'm'
  _ble_color_g2sgr[$1]=$ret
}
function ble/color/g2sgr/.clear-cache {
  _ble_color_g2sgr=()
}
function ble/color/g2sgr {
  ret=${_ble_color_g2sgr[$1]}
  [[ $ret ]] || ble/color/g2sgr/.impl "$1"
}
function ble/color/g2sgr-ansi/.impl {
  local g=$(($1))
  local sgr=0
  ((g&_ble_color_gflags_Bold))      && sgr="$sgr;1"
  ((g&_ble_color_gflags_Italic))    && sgr="$sgr;3"
  ((g&_ble_color_gflags_Underline)) && sgr="$sgr;4"
  ((g&_ble_color_gflags_Blink))     && sgr="$sgr;5"
  ((g&_ble_color_gflags_Revert))    && sgr="$sgr;7"
  ((g&_ble_color_gflags_Invisible)) && sgr="$sgr;8"
  ((g&_ble_color_gflags_Strike))    && sgr="$sgr;9"
  if ((g&_ble_color_gflags_FgIndexed)); then
    local fg=$((g>>8&0xFF))
    sgr="$sgr;38:5:$fg"
  elif ((g&_ble_color_gflags_FgMask)); then
    local rgb=$((1<<24|g>>8&0xFFFFFF))
    local R=$((rgb>>16&0xFF)) G=$((rgb>>8&0xFF)) B=$((rgb&0xFF))
    sgr="$sgr;38:2::$r:$g:$b"
  fi
  if ((g&_ble_color_gflags_BgIndexed)); then
    local bg=$((g>>32&0xFF))
    sgr="$sgr;48:5:$bg"
  elif ((g&_ble_color_gflags_BgMask)); then
    local rgb=$((1<<24|g>>32&0xFFFFFF))
    local R=$((rgb>>16&0xFF)) G=$((rgb>>8&0xFF)) B=$((rgb&0xFF))
    sgr="$sgr;48:2::$r:$g:$b"
  fi
  ret=$'\e['$sgr'm'
  _ble_color_g2sgr_ansi[$1]=$ret
}
function ble/color/g2sgr-ansi {
  ret=${_ble_color_g2sgr_ansi[$1]}
  [[ $ret ]] || ble/color/g2sgr-ansi/.impl "$1"
}
function ble/color/g#setfg-clear {
  (($1&=~(_ble_color_gflags_FgIndexed|_ble_color_gflags_FgMask)))
}
function ble/color/g#setbg-clear {
  (($1&=~(_ble_color_gflags_BgIndexed|_ble_color_gflags_BgMask)))
}
function ble/color/g#setfg-index {
  local __color=$2
  (($1=$1&~_ble_color_gflags_FgMask|_ble_color_gflags_FgIndexed|(__color&0xFF)<<8)) # index color
}
function ble/color/g#setbg-index {
  local __color=$2
  (($1=$1&~_ble_color_gflags_BgMask|_ble_color_gflags_BgIndexed|(__color&0xFF)<<32)) # index color
}
function ble/color/g#setfg-rgb {
  local __R=$2 __G=$3 __B=$4
  ((__R&=0xFF,__G&=0xFF,__B&=0xFF))
  if ((__R==0&&__G==0&&__B==0)); then
    ble/color/g#setfg-index "$1" 16
  else
    (($1=$1&~(_ble_color_gflags_FgIndexed|_ble_color_gflags_FgMask)|__R<<24|__G<<16|__B<<8)) # true color
  fi
}
function ble/color/g#setbg-rgb {
  local __R=$2 __G=$3 __B=$4
  ((__R&=0xFF,__G&=0xFF,__B&=0xFF))
  if ((__R==0&&__G==0&&__B==0)); then
    ble/color/g#setbg-index "$1" 16
  else
    (($1=$1&~(_ble_color_gflags_BgIndexed|_ble_color_gflags_BgMask)|__R<<48|__G<<40|__B<<32)) # true color
  fi
}
function ble/color/g#setfg-cmyk {
  local __C=$2 __M=$3 __Y=$4 __K=${5:-0}
  ((__K=~__K&0xFF,
    __C=(~__C&0xFF)*__K/255,
    __M=(~__M&0xFF)*__K/255,
    __Y=(~__Y&0xFF)*__K/255))
  ble/color/g#setfg-rgb "$__C" "$__M" "$__Y"
}
function ble/color/g#setbg-cmyk {
  local __C=$2 __M=$3 __Y=$4 __K=${5:-0}
  ((__K=~__K&0xFF,
    __C=(~__C&0xFF)*__K/255,
    __M=(~__M&0xFF)*__K/255,
    __Y=(~__Y&0xFF)*__K/255))
  ble/color/g#setbg-rgb "$1" "$__C" "$__M" "$__Y"
}
function ble/color/g#setfg {
  local __color=$2
  if ((__color<0)); then
    ble/color/g#setfg-clear "$1"
  elif ((__color>=0x1000000)); then
    if ((__color==0x1000000)); then
      ble/color/g#setfg-index "$1" 16
    else
      (($1=$1&~(_ble_color_gflags_FgIndexed|_ble_color_gflags_FgMask)|(__color&0xFFFFFF)<<8)) # true color
    fi
  else
    ble/color/g#setfg-index "$1" "$__color"
  fi
}
function ble/color/g#setbg {
  local __color=$2
  if ((__color<0)); then
    ble/color/g#setbg-clear "$1"
  elif ((__color>=0x1000000)); then
    if ((__color==0x1000000)); then
      ble/color/g#setbg-index "$1" 16
    else
      (($1=$1&~(_ble_color_gflags_BgIndexed|_ble_color_gflags_BgMask)|(__color&0xFFFFFF)<<32)) # true color
    fi
  else
    ble/color/g#setbg-index "$1" "$__color"
  fi
}
function ble/color/g#append {
  local __g2=$2
  ((__g2&(_ble_color_gflags_FgMask|_ble_color_gflags_FgIndexed))) &&
    (($1&=~(_ble_color_gflags_FgMask|_ble_color_gflags_FgIndexed)))
  ((__g2&(_ble_color_gflags_BgMask|_ble_color_gflags_BgIndexed))) &&
    (($1&=~(_ble_color_gflags_BgMask|_ble_color_gflags_BgIndexed)))
  (($1|=__g2))
}
function ble/color/g#compose {
  (($1=($2)))
  local __g2
  for __g2 in "${@:3}"; do
    ble/color/g#append "$1" "$__g2"
  done
}
function ble/color/g.setfg { ble/color/g#setfg g "$@"; }
function ble/color/g.setbg { ble/color/g#setbg g "$@"; }
function ble/color/g.setfg-clear { ble/color/g#setfg-clear g "$@"; }
function ble/color/g.setbg-clear { ble/color/g#setbg-clear g "$@"; }
function ble/color/g.setfg-index { ble/color/g#setfg-index g "$@"; }
function ble/color/g.setbg-index { ble/color/g#setbg-index g "$@"; }
function ble/color/g.setfg-rgb { ble/color/g#setfg-rgb g "$@"; }
function ble/color/g.setbg-rgb { ble/color/g#setbg-rgb g "$@"; }
function ble/color/g.setfg-cmyk { ble/color/g#setfg-cmyk g "$@"; }
function ble/color/g.setbg-cmyk { ble/color/g#setbg-cmyk g "$@"; }
function ble/color/g.append { ble/color/g#append g "$@"; }
function ble/color/g.compose { ble/color/g#compose g "$@"; }
function ble/color/g#getfg {
  local g=$1
  if ((g&_ble_color_gflags_FgIndexed)); then
    ((ret=g>>8&0xFF))
  elif ((g&_ble_color_gflags_FgMask)); then
    ((ret=0x1000000|(g>>8&0xFFFFFF)))
  else
    ((ret=-1))
  fi
}
function ble/color/g#getbg {
  local g=$1
  if ((g&_ble_color_gflags_BgIndexed)); then
    ((ret=g>>32&0xFF))
  elif ((g&_ble_color_gflags_BgMask)); then
    ((ret=0x1000000|(g>>32&0xFFFFFF)))
  else
    ((ret=-1))
  fi
}
function ble/color/g#compute-fg {
  local g=$1
  if ((g&_ble_color_gflags_Invisible)); then
    ble/color/g#compute-bg "$g"
  elif ((g&_ble_color_gflags_Revert)); then
    ble/color/g#getbg "$g"
  else
    ble/color/g#getfg "$g"
  fi
}
function ble/color/g#compute-bg {
  local g=$1
  if ((g&_ble_color_gflags_Revert)); then
    ble/color/g#getfg "$g"
  else
    ble/color/g#getbg "$g"
  fi
}
function ble/color/gspec2g {
  local g=0 entry
  for entry in ${1//,/ }; do
    case "$entry" in
    (bold)      ((g|=_ble_color_gflags_Bold)) ;;
    (underline) ((g|=_ble_color_gflags_Underline)) ;;
    (blink)     ((g|=_ble_color_gflags_Blink)) ;;
    (invis)     ((g|=_ble_color_gflags_Invisible)) ;;
    (reverse)   ((g|=_ble_color_gflags_Revert)) ;;
    (strike)    ((g|=_ble_color_gflags_Strike)) ;;
    (italic)    ((g|=_ble_color_gflags_Italic)) ;;
    (standout)  ((g|=_ble_color_gflags_Revert|_ble_color_gflags_Bold)) ;;
    (fg=*)
      ble/color/.name2color "${entry:3}"
      ble/color/g.setfg "$ret" ;;
    (bg=*)
      ble/color/.name2color "${entry:3}"
      ble/color/g.setbg "$ret" ;;
    (none)
      g=0 ;;
    esac
  done
  ret=$g
}
function ble/color/g2gspec {
  local g=$1 gspec=
  if ((g&_ble_color_gflags_FgIndexed)); then
    local fg=$((g>>8&0xFF))
    ble/color/.color2name "$fg"
    gspec=$gspec,fg=$ret
  elif ((g&_ble_color_gflags_FgMask)); then
    local rgb=$((1<<24|g>>8&0xFFFFFF))
    ble/color/.color2name "$rgb"
    gspec=$gspec,fg=$ret
  fi
  if ((g&_ble_color_gflags_BgIndexed)); then
    local bg=$((g>>32&0xFF))
    ble/color/.color2name "$bg"
    gspec=$gspec,bg=$ret
  elif ((g&_ble_color_gflags_BgMask)); then
    local rgb=$((1<<24|g>>32&0xFFFFFF))
    ble/color/.color2name "$rgb"
    gspec=$gspec,bg=$ret
  fi
  ((g&_ble_color_gflags_Bold))      && gspec=$gspec,bold
  ((g&_ble_color_gflags_Underline)) && gspec=$gspec,underline
  ((g&_ble_color_gflags_Blink))     && gspec=$gspec,blink
  ((g&_ble_color_gflags_Invisible)) && gspec=$gspec,invis
  ((g&_ble_color_gflags_Revert))    && gspec=$gspec,reverse
  ((g&_ble_color_gflags_Strike))    && gspec=$gspec,strike
  ((g&_ble_color_gflags_Italic))    && gspec=$gspec,italic
  gspec=${gspec#,}
  ret=${gspec:-none}
}
function ble/color/gspec2sgr {
  local sgr=0 entry
  for entry in ${1//,/ }; do
    case "$entry" in
    (bold)      sgr="$sgr;${_ble_term_sgr_bold:-1}" ;;
    (underline) sgr="$sgr;${_ble_term_sgr_smul:-4}" ;;
    (blink)     sgr="$sgr;${_ble_term_sgr_blink:-5}" ;;
    (invis)     sgr="$sgr;${_ble_term_sgr_invis:-8}" ;;
    (reverse)   sgr="$sgr;${_ble_term_sgr_rev:-7}" ;;
    (strike)    sgr="$sgr;${_ble_term_sgr_strike:-9}" ;;
    (italic)    sgr="$sgr;${_ble_term_sgr_sitm:-3}" ;;
    (standout)  sgr="$sgr;${_ble_term_sgr_bold:-1};${_ble_term_sgr_rev:-7}" ;;
    (fg=*)
      ble/color/.name2color "${entry:3}"
      ble/color/.color2sgrfg "$ret"
      sgr="$sgr;$ret" ;;
    (bg=*)
      ble/color/.name2color "${entry:3}"
      ble/color/.color2sgrbg "$ret"
      sgr="$sgr;$ret" ;;
    (none)
      sgr=0 ;;
    esac
  done
  ret="[${sgr}m"
}
function ble/color/.name2color/.clamp {
  local text=$1 max=$2
  if [[ $text == *% ]]; then
    ((ret=10#0${text%'%'}*max/100))
  else
    ((ret=10#0$text))
  fi
  ((ret>max)) && ret=max
}
function ble/color/.name2color/.wrap {
  local text=$1 max=$2
  if [[ $text == *% ]]; then
    ((ret=10#0${text%'%'}*max/100))
  else
    ((ret=10#0$text))
  fi
  ((ret%=max))
}
function ble/color/.hxx2color {
  local H=$1 Min=$2 Range=$3 Unit=$4
  local h1 h2 x=$Min y=$Min z=$Min
  ((h1=H%120,h2=120-h1,
    x+=Range*(h2<60?h2:60)/60,
    y+=Range*(h1<60?h1:60)/60))
  ((x=x*255/Unit,
    y=y*255/Unit,
    z=z*255/Unit))
  case $((H/120)) in
  (0) local R=$x G=$y B=$z ;;
  (1) local R=$z G=$x B=$y ;;
  (2) local R=$y G=$z B=$x ;;
  esac
  ((ret=1<<24|R<<16|G<<8|B))
}
function ble/color/.hsl2color {
  local H=$1 S=$2 L=$3 Unit=$4
  local Range=$((2*(L<=Unit/2?L:Unit-L)*S/Unit))
  local Min=$((L-Range/2))
  ble/color/.hxx2color "$H" "$Min" "$Range" "$Unit"
}
function ble/color/.hsb2color {
  local H=$1 S=$2 B=$3 Unit=$4
  local Range=$((B*S/Unit))
  local Min=$((B-Range))
  ble/color/.hxx2color "$H" "$Min" "$Range" "$Unit"
}
function ble/color/.name2color {
  local colorName=$1
  if [[ ! ${colorName//[0-9]} ]]; then
    ((ret=10#0$colorName&255))
  elif [[ $colorName == '#'* ]]; then
    if local rex='^#[0-9a-fA-F]{3}$'; [[ $colorName =~ $rex ]]; then
      let "ret=1<<24|16#${colorName:1:1}*0x11<<16|16#${colorName:2:1}*0x11<<8|16#${colorName:3:1}*0x11"
    elif rex='^#[0-9a-fA-F]{6}$'; [[ $colorName =~ $rex ]]; then
      let "ret=1<<24|16#${colorName:1:2}<<16|16#${colorName:3:2}<<8|16#${colorName:5:2}"
    else
      ret=-1
    fi
  elif [[ $colorName == *:* ]]; then
    if local rex='^rgb:([0-9]+%?)/([0-9]+%?)/([0-9]+%?)$'; [[ $colorName =~ $rex ]]; then
      ble/color/.name2color/.clamp "${BASH_REMATCH[1]}" 255; local R=$ret
      ble/color/.name2color/.clamp "${BASH_REMATCH[2]}" 255; local G=$ret
      ble/color/.name2color/.clamp "${BASH_REMATCH[3]}" 255; local B=$ret
      ((ret=1<<24|R<<16|G<<8|B))
    elif
      local rex1='^cmy:([0-9]+%?)/([0-9]+%?)/([0-9]+%?)$'
      local rex2='^cmyk:([0-9]+%?)/([0-9]+%?)/([0-9]+%?)/([0-9]+%?)$'
      [[ $colorName =~ $rex1 || $colorName =~ $rex2 ]]
    then
      ble/color/.name2color/.clamp "${BASH_REMATCH[1]}" 255; local C=$ret
      ble/color/.name2color/.clamp "${BASH_REMATCH[2]}" 255; local M=$ret
      ble/color/.name2color/.clamp "${BASH_REMATCH[3]}" 255; local Y=$ret
      ble/color/.name2color/.clamp "${BASH_REMATCH[4]:-0}" 255; local K=$ret
      local K=$((~K&0xFF))
      local R=$(((~C&0xFF)*K/255))
      local G=$(((~M&0xFF)*K/255))
      local B=$(((~Y&0xFF)*K/255))
      ((ret=1<<24|R<<16|G<<8|B))
    elif rex='^hs[lvb]:([0-9]+)/([0-9]+%)/([0-9]+%)$'; [[ $colorName =~ $rex ]]; then
      ble/color/.name2color/.wrap  "${BASH_REMATCH[1]}" 360; local H=$ret
      ble/color/.name2color/.clamp "${BASH_REMATCH[2]}" 1000; local S=$ret
      ble/color/.name2color/.clamp "${BASH_REMATCH[3]}" 1000; local X=$ret
      if [[ $colorName == hsl:* ]]; then
        ble/color/.hsl2color "$H" "$S" "$X" 1000
      else
        ble/color/.hsb2color "$H" "$S" "$X" 1000
      fi
    else
      ret=-1
    fi
  else
    case "$colorName" in
    (black)   ret=0 ;;
    (brown)   ret=1 ;;
    (green)   ret=2 ;;
    (olive)   ret=3 ;;
    (navy)    ret=4 ;;
    (purple)  ret=5 ;;
    (teal)    ret=6 ;;
    (silver)  ret=7 ;;
    (gr[ae]y) ret=8 ;;
    (red)     ret=9 ;;
    (lime)    ret=10 ;;
    (yellow)  ret=11 ;;
    (blue)    ret=12 ;;
    (magenta) ret=13 ;;
    (cyan)    ret=14 ;;
    (white)   ret=15 ;;
    (orange)  ret=202 ;;
    (transparent|default) ret=-1 ;;
    (*)       ret=-1 ;;
    esac
  fi
}
function ble/color/.color2name {
  if (($1>=0x1000000)); then
    ble/util/sprintf ret '#%06x' $(($1&0xFFFFFF))
    return 0
  fi
  ((ret=(10#0$1&255)))
  case $ret in
  (0)  ret=black   ;;
  (1)  ret=brown   ;;
  (2)  ret=green   ;;
  (3)  ret=olive   ;;
  (4)  ret=navy    ;;
  (5)  ret=purple  ;;
  (6)  ret=teal    ;;
  (7)  ret=silver  ;;
  (8)  ret=gray    ;;
  (9)  ret=red     ;;
  (10) ret=lime    ;;
  (11) ret=yellow  ;;
  (12) ret=blue    ;;
  (13) ret=magenta ;;
  (14) ret=cyan    ;;
  (15) ret=white   ;;
  (202) ret=orange ;;
  esac
}
function ble/color/convert-color88-to-color256 {
  local color=$1
  if ((color>=16)); then
    if ((color>=80)); then
      local L=$((((color-80+1)*25+4)/9))
      ((color=L==0?16:(L==25?231:232+(L-1))))
    else
      ((color-=16))
      local R=$((color/16)) G=$((color/4%4)) B=$((color%4))
      ((R=(R*5+1)/3,G=(G*5+1)/3,B=(B*5+1)/3,
        color=16+R*36+G*6+B))
    fi
  fi
  ret=$color
}
function ble/color/convert-color256-to-color88 {
  local color=$1
  if ((color>=16)); then
    if ((color>=232)); then
      local L=$((((color-232+1)*9+12)/25))
      ((color=L==0?16:(L==9?79:80+(L-1))))
    else
      ((color-=16))
      local R=$((color/36)) G=$((color/6%6)) B=$((color%6))
      ((R=(R*3+2)/5,G=(G*3+2)/5,B=(B*3+2)/5,
        color=16+R*16+G*4+B))
    fi
  fi
  ret=$color
}
function ble/color/convert-rgb24-to-color256 {
  local R=$1 G=$2 B=$3
  if ((R==G&&G==B)); then
    if ((R<=3)); then
      ret=16
    elif ((R>=247)); then
      ret=231
    elif ((R>=92&&(R-92)%40<5)); then
      ((ret=59+43*(R-92)/40))
    else
      local level=$(((R-3)/10))
      ((ret=232+(level<=23?level:23)))
    fi
  else
    ((R=R<=47?0:(R<=95?1:(R-35)/40)))
    ((G=G<=47?0:(G<=95?1:(G-35)/40)))
    ((B=B<=47?0:(B<=95?1:(B-35)/40)))
    ((ret=16+36*R+6*G+B))
  fi
}
function ble/color/convert-rgb24-to-color88 {
  local R=$1 G=$2 B=$3
  if ((R==G&&G==B)); then
    if ((R<=22)); then
      ret=16 # 4x4x4 cube (0,0,0)=0:0:0
    elif ((R>=239)); then
      ret=79 # 4x4x4 cube (3,3,3)=255:255:255
    elif ((131<=R&&R<=142)); then
      ret=37 # 4x4x4 cube (1,1,1)=139:139:139
    elif ((197<=R&&R<=208)); then
      ret=58 # 4x4x4 cube (2,2,2)=197:197:197
    else
      local level=$(((R-34)/25))
      ((ret=80+(level<=7?level:7)))
    fi
  else
    ((R=R<=69?0:(R<=168?1:(R-52)/58)))
    ((G=G<=69?0:(G<=168?1:(G-52)/58)))
    ((B=B<=69?0:(B<=168?1:(B-52)/58)))
    ((ret=16+16*R+4*G+B))
  fi
}
function ble/color/.color2sgr-impl {
  local ccode=$1 prefix=$2 # 3 for fg, 4 for bg
  if ((ccode<0)); then
    ret=${prefix}9
  elif ((ccode<16&&ccode<_ble_term_colors)); then
    if ((prefix==4)); then
      ret=${_ble_term_sgr_ab[ccode]}
    else
      ret=${_ble_term_sgr_af[ccode]}
    fi
  elif ((ccode<256)); then
    if ((_ble_term_colors>=256||bleopt_term_index_colors==256)); then
      ret="${prefix}8;5;$ccode"
    elif ((_ble_term_colors>=88||bleopt_term_index_colors==88)); then
      ble/color/convert-color256-to-color88 "$ccode"
      ret="${prefix}8;5;$ret"
    elif ((ccode<_ble_term_colors||ccode<bleopt_term_index_colors)); then
      ret="${prefix}8;5;$ccode"
    elif ((_ble_term_colors>=16||_ble_term_colors==8)); then
      if ((ccode>=16)); then
        if ((ccode>=232)); then
          local L=$((((ccode-232+1)*3+12)/25))
          ((ccode=L==0?0:(L==1?8:(L==2?7:15))))
        else
          ((ccode-=16))
          local R=$((ccode/36)) G=$((ccode/6%6)) B=$((ccode%6))
          if ((R==G&&G==B)); then
            local L=$(((R*3+2)/5))
            ((ccode=L==0?0:(L==1?8:(L==2?7:15))))
          else
            local min max
            ((R<G?(min=R,max=G):(min=G,max=R),
              B<min?(min=B):(B>max&&(max=B))))
            local Range=$((max-min))
            ((R=(R-min+Range/2)/Range,
              G=(G-min+Range/2)/Range,
              B=(B-min+Range/2)/Range,
              ccode=R+G*2+B*4+(min+max>=5?8:0)))
          fi
        fi
      fi
      ((_ble_term_colors==8&&ccode>=8&&(ccode-=8)))
      if ((prefix==4)); then
        ret=${_ble_term_sgr_ab[ccode]}
      else
        ret=${_ble_term_sgr_af[ccode]}
      fi
    else
      ret=${prefix}9
    fi
  elif ((0x1000000<=ccode&&ccode<0x2000000)); then
    local R=$((ccode>>16&0xFF)) G=$((ccode>>8&0xFF)) B=$((ccode&0xFF))
    if [[ $bleopt_term_true_colors == semicolon ]]; then
      ret="${prefix}8;2;$R;$G;$B"
    elif [[ $bleopt_term_true_colors == colon ]]; then
      ret="${prefix}8:2:$R:$G:$B"
    elif ((_ble_term_colors>=256||bleopt_term_index_colors==256)); then
      ble/color/convert-rgb24-to-color256 "$R" "$G" "$B"
      ret="${prefix}8;5;$ret"
    elif ((_ble_term_colors>=88||bleopt_term_index_colors==88)); then
      ble/color/convert-rgb24-to-color88 "$R" "$G" "$B"
      ret="${prefix}8;5;$ret"
    else
      ble/color/convert-rgb24-to-color256 "$R" "$G" "$B"
      ble/color/.color2sgr-impl "$ret" "$prefix"
    fi
  else
    ret=${prefix}9
  fi
}
function ble/color/.color2sgrfg {
  ble/color/.color2sgr-impl "$1" 3
}
function ble/color/.color2sgrbg {
  ble/color/.color2sgr-impl "$1" 4
}
function ble/color/read-sgrspec/.arg-next {
  local _var=arg _ret
  if [[ $1 == -v ]]; then
    _var=$2
    shift 2
  fi
  if ((j<${#fields[*]})); then
    ((_ret=10#0${fields[j++]}))
  else
    ((i++))
    ((_ret=10#0${specs[i]%%:*}))
  fi
  (($_var=_ret))
}
function ble/color/read-sgrspec {
  local specs i iN
  ble/string#split specs \; "$1"
  for ((i=0,iN=${#specs[@]};i<iN;i++)); do
    local spec=${specs[i]} fields
    ble/string#split fields : "$spec"
    local arg=$((10#0${fields[0]}))
    if ((arg==0)); then
      g=0
      continue
    elif [[ :$opts: != *:ansi:* ]]; then
      [[ ${_ble_term_sgr_term2ansi[arg]} ]] &&
        arg=${_ble_term_sgr_term2ansi[arg]}
    fi
    if ((30<=arg&&arg<50)); then
      if ((30<=arg&&arg<38)); then
        local color=$((arg-30))
        ble/color/g.setfg-index "$color"
      elif ((40<=arg&&arg<48)); then
        local color=$((arg-40))
        ble/color/g.setbg-index "$color"
      elif ((arg==38)); then
        local j=1 color cspace
        ble/color/read-sgrspec/.arg-next -v cspace
        if ((cspace==5)); then
          ble/color/read-sgrspec/.arg-next -v color
          if [[ :$opts: != *:ansi:* ]] && ((bleopt_term_index_colors==88)); then
            local ret; ble/color/convert-color88-to-color256 "$color"; color=$ret
          fi
          ble/color/g.setfg-index "$color"
        elif ((cspace==2)); then
          local S R G B
          ((${#fields[@]}>5)) &&
            ble/color/read-sgrspec/.arg-next -v S
          ble/color/read-sgrspec/.arg-next -v R
          ble/color/read-sgrspec/.arg-next -v G
          ble/color/read-sgrspec/.arg-next -v B
          ble/color/g.setfg-rgb "$R" "$G" "$B"
        elif ((cspace==3||cspace==4)); then
          local S C M Y K=0
          ((${#fields[@]}>2+cspace)) &&
            ble/color/read-sgrspec/.arg-next -v S
          ble/color/read-sgrspec/.arg-next -v C
          ble/color/read-sgrspec/.arg-next -v M
          ble/color/read-sgrspec/.arg-next -v Y
          ((cspace==4)) &&
            ble/color/read-sgrspec/.arg-next -v K
          ble/color/g.setfg-cmyk "$C" "$M" "$Y" "$K"
        else
          ble/color/g.setfg-clear
        fi
      elif ((arg==48)); then
        local j=1 color cspace
        ble/color/read-sgrspec/.arg-next -v cspace
        if ((cspace==5)); then
          ble/color/read-sgrspec/.arg-next -v color
          if [[ :$opts: != *:ansi:* ]] && ((bleopt_term_index_colors==88)); then
            local ret; ble/color/convert-color88-to-color256 "$color"; color=$ret
          fi
          ble/color/g.setbg-index "$color"
        elif ((cspace==2)); then
          local S R G B
          ((${#fields[@]}>5)) &&
            ble/color/read-sgrspec/.arg-next -v S
          ble/color/read-sgrspec/.arg-next -v R
          ble/color/read-sgrspec/.arg-next -v G
          ble/color/read-sgrspec/.arg-next -v B
          ble/color/g.setbg-rgb "$R" "$G" "$B"
        elif ((cspace==3||cspace==4)); then
          local S C M Y K=0
          ((${#fields[@]}>2+cspace)) &&
            ble/color/read-sgrspec/.arg-next -v S
          ble/color/read-sgrspec/.arg-next -v C
          ble/color/read-sgrspec/.arg-next -v M
          ble/color/read-sgrspec/.arg-next -v Y
          ((cspace==4)) &&
            ble/color/read-sgrspec/.arg-next -v K
          ble/color/g.setbg-cmyk "$C" "$M" "$Y" "$K"
        else
          ble/color/g.setbg-clear
        fi
      elif ((arg==39)); then
        ble/color/g.setfg-clear
      elif ((arg==49)); then
        ble/color/g.setbg-clear
      fi
    elif ((90<=arg&&arg<98)); then
      local color=$((arg-90+8))
      ble/color/g.setfg-index "$color"
    elif ((100<=arg&&arg<108)); then
      local color=$((arg-100+8))
      ble/color/g.setbg-index "$color"
    else
      case $arg in
      (1)    ((g|=_ble_color_gflags_Bold))       ;;
      (22)   ((g&=~_ble_color_gflags_Bold))      ;;
      (4)    ((g|=_ble_color_gflags_Underline))  ;;
      (24)   ((g&=~_ble_color_gflags_Underline)) ;;
      (7)    ((g|=_ble_color_gflags_Revert))     ;;
      (27)   ((g&=~_ble_color_gflags_Revert))    ;;
      (9807) ((g^=_ble_color_gflags_Revert))     ;; # toggle (for internal use)
      (3)    ((g|=_ble_color_gflags_Italic))     ;;
      (23)   ((g&=~_ble_color_gflags_Italic))    ;;
      (5)    ((g|=_ble_color_gflags_Blink))      ;;
      (25)   ((g&=~_ble_color_gflags_Blink))     ;;
      (8)    ((g|=_ble_color_gflags_Invisible))  ;;
      (28)   ((g&=~_ble_color_gflags_Invisible)) ;;
      (9)    ((g|=_ble_color_gflags_Strike))     ;;
      (29)   ((g&=~_ble_color_gflags_Strike))    ;;
      esac
    fi
  done
}
function ble/color/sgrspec2g {
  local g=0
  ble/color/read-sgrspec "$1"
  ret=$g
}
function ble/color/ansi2g {
  local x=0 y=0 g=0
  ble/function#try ble/canvas/trace "$1" # -> ret
  ret=$g
}
if [[ ! ${_ble_faces_count-} ]]; then # reload #D0875
  _ble_faces_count=0
  _ble_faces=()
fi
function ble/color/setface/.check-argument {
  local rex='^[a-zA-Z0-9_]+$'
  [[ $# == 2 && $1 =~ $rex && $2 ]] && return 0
  local flags=a
  while (($#)); do
    local arg=$1; shift
    case $arg in
    (--help) flags=H$flags ;;
    (--color|--color=always) flags=c${flags//[ac]} ;;
    (--color=auto) flags=a${flags//[ac]} ;;
    (--color=never) flags=${flags//[ac]} ;;
    (-*)
      ble/util/print "${FUNCNAME[1]}: unrecognized option '$arg'." >&2
      flags=E$flags ;;
    (*)
      ble/util/print "${FUNCNAME[1]}: unrecognized argument '$arg'." >&2
      flags=E$flags ;;
    esac
  done
  if [[ $flags == *E* ]]; then
    ext=2; return 1
  elif [[ $flags == *H* ]]; then
    ble/util/print-lines \
      "usage: $name FACE_NAME [TYPE:]SPEC" \
      '    Set face.' \
      '' \
      '  TYPE      Specifies the format of SPEC. The following values are available.' \
      '    gspec   Comma separated graphic attribute list' \
      '    g       Integer value' \
      '    ref     Face name or id (reference)' \
      '    copy    Face name or id (copy value)' \
      '    sgrspec Parameters to the control function SGR' \
      '    ansi    ANSI Sequences' >&2
    ext=0; return 1
  fi
  local opts=
  [[ $flags == *c* || $flags == *a* && -t 1 ]] && opts=$opts:color
  ble/color/list-faces "$opts"; ext=$?; return 1
}
function ble-color-defface {
  local ext; ble/color/setface/.check-argument "$@" || return "$ext"
  ble/color/defface "$@"
}
function ble-color-setface {
  local ext; ble/color/setface/.check-argument "$@" || return "$ext"
  ble/color/setface "$@"
}
function ble/color/defface   { local q=\' Q="'\''"; blehook color_defface_load+="ble/color/defface '${1//$q/$Q}' '${2//$q/$Q}'"; }
function ble/color/setface   { local q=\' Q="'\''"; blehook color_setface_load+="ble/color/setface '${1//$q/$Q}' '${2//$q/$Q}'"; }
function ble/color/face2g    { ble/color/initialize-faces && ble/color/face2g    "$@"; }
function ble/color/face2sgr  { ble/color/initialize-faces && ble/color/face2sgr  "$@"; }
function ble/color/iface2g   { ble/color/initialize-faces && ble/color/iface2g   "$@"; }
function ble/color/iface2sgr { ble/color/initialize-faces && ble/color/iface2sgr "$@"; }
function ble/color/face2sgr-ansi { ble/color/initialize-faces && ble/color/face2sgr  "$@"; }
_ble_color_faces_initialized=
function ble/color/initialize-faces {
  local _ble_color_faces_initializing=1
  local -a _ble_color_faces_errors=()
  function ble/color/face2g {
    ((ret=_ble_faces[_ble_faces__$1]))
  }
  function ble/color/face2sgr { ble/color/g2sgr $((_ble_faces[_ble_faces__$1])); }
  function ble/color/face2sgr-ansi { ble/color/g2sgr-ansi $((_ble_faces[_ble_faces__$1])); }
  function ble/color/iface2g {
    ((ret=_ble_faces[$1]))
  }
  function ble/color/iface2sgr {
    ble/color/g2sgr $((_ble_faces[$1]))
  }
  function ble/color/setface/.spec2g {
    local spec=$1 value=${spec#*:}
    case $spec in
    (gspec:*)   ble/color/gspec2g "$value" ;;
    (g:*)       ret=$(($value)) ;;
    (ref:*)
      if [[ ! ${value//[0-9]} ]]; then
        ret=_ble_faces[$((value))]
      else
        ret=_ble_faces[_ble_faces__$value]
      fi ;;
    (copy:*|face:*|iface:*)
      [[ $spec == copy:* ]] ||
        ble/util/print "ble-face: \"${spec%%:*}:*\" is obsoleted. Use \"copy:*\" instead." >&2
      if [[ ! ${value//[0-9]} ]]; then
        ble/color/iface2g "$value"
      else
        ble/color/face2g "$value"
      fi ;;
    (sgrspec:*) ble/color/sgrspec2g "$value" ;;
    (ansi:*)    ble/color/ansi2g "$value" ;;
    (*)         ble/color/gspec2g "$spec" ;;
    esac
  }
  function ble/color/defface {
    local name=_ble_faces__$1 spec=$2 ret
    (($name)) && return 0
    (($name=++_ble_faces_count))
    ble/color/setface/.spec2g "$spec"
    _ble_faces[$name]=$ret
    _ble_faces_def[$name]=$ret
  }
  function ble/color/setface {
    local name=_ble_faces__$1 spec=$2 ret
    if [[ ${!name} ]]; then
      ble/color/setface/.spec2g "$spec"; _ble_faces[$name]=$ret
    else
      local message="ble.sh: the specified face \`$1' is not defined."
      if [[ $_ble_color_faces_initializing ]]; then
        ble/array#push _ble_color_faces_errors "$message"
      else
        ble/util/print "$message" >&2
      fi
      return 1
    fi
  }
  _ble_color_faces_initialized=1
  blehook/invoke color_defface_load
  blehook/invoke color_setface_load
  blehook color_defface_load=
  blehook color_setface_load=
  if ((${#_ble_color_faces_errors[@]})); then
    if ((_ble_edit_attached)) && [[ ! $_ble_textarea_invalidated && $_ble_term_state == internal ]]; then
      IFS=$'\n' builtin eval 'local message="${_ble_color_faces_errors[*]}"'
      ble/widget/print "$message"
    else
      printf '%s\n' "${_ble_color_faces_errors[@]}" >&2
    fi
    return 1
  else
    return 0
  fi
}
ble/function#try ble/util/idle.push ble/color/initialize-faces
function ble/color/list-faces {
  local flags=
  [[ :$1: == *:color:* ]] && flags=c
  local ret sgr0= sgr1= sgr2=
  if [[ $flags == *c* ]]; then
    sgr0=$_ble_term_sgr0
    ble/color/face2sgr command_function; sgr1=$ret
    ble/color/face2sgr syntax_varname; sgr2=$ret
  fi
  local key
  for key in "${!_ble_faces__@}"; do
    ble-face/.print-face "$key"
  done
}
function ble-face/.read-arguments/process-set {
  local o=$1 face=$2 value=$3
  if local rex='^[_a-zA-Z0-9@][_a-zA-Z0-9@]*$'; ! [[ $face =~ $rex ]]; then
    ble/util/print "ble-face: invalid face name '$face'." >&2
    flags=E$flags
    return 1
  elif [[ $o == '-d' && $face == *@* ]]; then
    ble/util/print "ble-face: wildcards cannot be used in the face name '$face' for definition." >&2
    flags=E$flags
    return 1
  fi
  local assign='='
  [[ $o == -d ]] && assign=':='
  ble/array#push setface "$face$assign$value"
}
function ble-face/.read-arguments {
  flags= setface=() print=()
  local opt_color=auto
  local args iarg narg=$#; args=("$@")
  for ((iarg=0;iarg<narg;)); do
    local arg=${args[iarg++]}
    if [[ $arg == -* ]]; then
      if [[ $flags == *L* ]]; then
        ble/util/print "ble-face: unrecognized argument '$arg'." >&2
        flags=E$flags
      else
        case $arg in
        (--help) flags=H$flags ;;
        (--color)
          opt_color=always ;;
        (--color=always|--color=auto|--color=never)
          opt_color=${arg#*=} ;;
        (--color=*)
          ble/util/print "ble-face: '${arg#*=}': unrecognized option argument for '--color'." >&2
          flags=E$flags ;;
        (--reset) flags=r$flags ;;
        (--changed) flags=u$flags ;;
        (--) flags=L$flags ;;
        (--*)
          ble/util/print "ble-face: unrecognized long option '$arg'." >&2
          flags=E$flags ;;
        (-?*)
          local i c
          for ((i=1;i<${#arg};i++)); do
            c=${arg:i:1}
            case $c in
            ([ru]) flags=$c$flags ;;
            ([sd])
              if ((i+1<${#arg})); then
                local lhs=${arg:i+1}
              else
                local lhs=${args[iarg++]}
              fi
              local rhs=${args[iarg++]}
              if ((iarg>narg)); then
                ble/util/print "ble-face: missing option argument for '-$c FACE SPEC'." >&2
                flags=E$flags
                continue
              fi
              ble-face/.read-arguments/process-set "${arg::2}" "$lhs" "$rhs"
              break ;;
            (*)
              ble/util/print "ble-face: unrecognized option '-$c'." >&2
              flags=E$flags ;;
            esac
          done ;;
        (-)
          ble/util/print "ble-face: unrecognized argument '$arg'." >&2
          flags=E$flags ;;
        esac
      fi
    elif [[ $arg == *=* ]]; then
      if local rex='^[_a-zA-Z@][_a-zA-Z0-9@]*:?='; [[ $arg =~ $rex ]]; then
        ble/array#push setface "$arg"
      else
        local lhs=${arg%%=*}; lhs=${lhs%:}
        ble/util/print "ble-face: invalid left-hand side '$lhs' ($arg)." >&2
        flags=E$flags
      fi
    else
      if local rex='^[_a-zA-Z@][_a-zA-Z0-9@]*$'; [[ $arg =~ $rex ]]; then
        ble/array#push print "$arg"
      else
        ble/util/print "ble-face: unrecognized form of argument '$arg'." >&2
        flags=E$flags
      fi
    fi
  done
  [[ $opt_color == auto && -t 1 || $opt_color == always ]] && flags=c$flags
  [[ $flags != *E* ]]
}
function ble-face/.print-help {
  ble/util/print-lines >&2 \
    'ble-face --help' \
    'ble-face [FACEPAT[:=|=][TYPE:]SPEC | -[sd] FACEPAT [TYPE:]SPEC]]...' \
    'ble-face [-ur|--color[=WHEN]] [FACE...]' \
    '' \
    '  OPTIONS/ARGUMENTS' \
    '' \
    '    FACEPAT=[TYPE:]SPEC' \
    '    -s FACEPAT [TYPE:]SPEC' \
    '            Set a face.  FACEPAT can include a wildcard @ which matches one or' \
    '            more characters.' \
    '' \
    '    FACE:=[TYPE:]SPEC' \
    '    -d FACE [TYPE:]SPEC' \
    '            Define a face' \
    '' \
    '    [-u | --color[=always|never|auto]]... FACEPAT...' \
    '            Print faces.  If faces are not specified, all faces are selected.' \
    '            If -u is specified, only the faces with different values from their' \
    '            default will be printed.  The option "--color" controls the output' \
    '            color settings.  The default is "auto".' \
    '' \
    '    -r FACEPAT...' \
    '            Reset faces.  If faces are not specified, all faces are selected.' \
    '' \
    '  FACEPAT   Specifies a face name.  The character @ in the face name is treated' \
    '            as a wildcard.' \
    '' \
    '  FACE      Specifies a face name.  Wildcard @ cannot be used.' \
    '' \
    '  TYPE      Specifies the format of SPEC. The following values are available.' \
    '    gspec   Comma separated graphic attribute list' \
    '    g       Integer value' \
    '    ref     Face name or id (reference)' \
    '    copy    Face name or id (copy value)' \
    '    sgrspec Parameters to the control function SGR' \
    '    ansi    ANSI Sequences' \
    ''
  return 0
}
function ble-face/.print-face {
  local key=$1 ret
  local name=${key#_ble_faces__}
  local cur=${_ble_faces[key]}
  if [[ $flags == *u* ]]; then
    local def=_ble_faces_def[key]
    [[ ${!def+set} && $cur == "${!def}" ]] && return 0
  fi
  local def=${_ble_faces[key]}
  if [[ $cur == '_ble_faces['*']' ]]; then
    cur=${cur#'_ble_faces['}
    cur=${cur%']'}
    cur=ref:${cur#_ble_faces__}
  else
    ble/color/g2gspec $((cur)); cur=$ret
  fi
  if [[ $flags == *c* ]]; then
    ble/color/iface2sgr $((key))
    cur=$ret$cur$_ble_term_sgr0
  fi
  printf '%s %s=%s\n' "${sgr1}ble-face$sgr0" "$sgr2$name$sgr0" "$cur"
}
function ble-face/.reset-face {
  local key=$1 ret
  [[ ${_ble_faces_def[key]+set} ]] &&
    _ble_faces[key]=${_ble_faces_def[key]}
}
function ble-face {
  local flags setface print
  ble-face/.read-arguments "$@"
  if [[ $flags == *H* ]]; then
    ble-face/.print-help
    return 2
  elif [[ $flags == *E* ]]; then
    return 2
  fi
  if ((!${#print[@]}&&!${#setface[@]})); then
    print=(@)
  fi
  ((${#print[@]})) && ble/color/initialize-faces
  if [[ ! $_ble_color_faces_initialized ]]; then
    local ret
    ble/string#quote-command ble-face "${setface[@]}"
    blehook color_setface_load+="$ret"
    return 0
  fi
  local spec
  for spec in "${setface[@]}"; do
    if local rex='^([_a-zA-Z@][_a-zA-Z0-9@]*)(:?=)(.*)$'; ! [[ $spec =~ $rex ]]; then
      ble/util/print "ble-face: unrecognized setting '$spec'" >&2
      flags=E$flags
      continue
    fi
    local var=${BASH_REMATCH[1]}
    local type=${BASH_REMATCH[2]}
    local value=${BASH_REMATCH[3]}
    if [[ $type == ':=' ]]; then
      if [[ $var == *@* ]]; then
        ble/util/print "ble-face: wild card @ cannot be used for face definition ($spec)." >&2
        flags=E$flags
      else
        ble/color/defface "$var" "$value"
      fi
    else
      local ret face
      if bleopt/expand-variable-pattern "_ble_faces__$var"; then
        for face in "${ret[@]}"; do
          ble/color/setface "${face#_ble_faces__}" "$value"
        done
      else
        ble/util/print "ble-face: face '$var' not found" >&2
        flags=E$flags
      fi
    fi
  done
  if ((${#print[@]})); then
    local ret sgr0= sgr1= sgr2=
    if [[ $flags == *c* ]]; then
      sgr0=$_ble_term_sgr0
      ble/color/face2sgr command_function; sgr1=$ret
      ble/color/face2sgr syntax_varname; sgr2=$ret
    fi
    local spec
    for spec in "${print[@]}"; do
      local ret face
      if bleopt/expand-variable-pattern "_ble_faces__$spec"; then
        if [[ $flags == *r* ]]; then
          for face in "${ret[@]}"; do
            ble-face/.reset-face "$face"
          done
        else
          for face in "${ret[@]}"; do
            ble-face/.print-face "$face"
          done
        fi
      else
        ble/util/print "ble-face: face '$spec' not found" >&2
        flags=E$flags
      fi
    done
  fi
  [[ $flags != *E* ]]
}
_ble_highlight_layer__list=(plain)
function ble/highlight/layer/update {
  local text=$1 iN=${#1} opts=$2
  local DMIN=${3:-0} DMAX=${4:-$iN} DMAX0=${5:-0}
  local PREV_BUFF=_ble_highlight_layer_plain_buff
  local PREV_UMIN=-1
  local PREV_UMAX=-1
  local layer player=plain LEVEL
  local nlevel=${#_ble_highlight_layer__list[@]}
  for ((LEVEL=0;LEVEL<nlevel;LEVEL++)); do
    layer=${_ble_highlight_layer__list[LEVEL]}
    "ble/highlight/layer:$layer/update" "$text" "$player"
    player=$layer
  done
  HIGHLIGHT_BUFF=$PREV_BUFF
  HIGHLIGHT_UMIN=$PREV_UMIN
  HIGHLIGHT_UMAX=$PREV_UMAX
}
function ble/highlight/layer/update/add-urange {
  local umin=$1 umax=$2
  (((PREV_UMIN<0||PREV_UMIN>umin)&&(PREV_UMIN=umin),
    (PREV_UMAX<0||PREV_UMAX<umax)&&(PREV_UMAX=umax)))
}
function ble/highlight/layer/update/shift {
  local __dstArray=$1
  local __srcArray=${2:-$__dstArray}
  if ((DMIN>=0)); then
    ble/array#reserve-prototype $((DMAX-DMIN))
    builtin eval "
    $__dstArray=(
      \"\${$__srcArray[@]::DMIN}\"
      \"\${_ble_array_prototype[@]::DMAX-DMIN}\"
      \"\${$__srcArray[@]:DMAX0}\")"
  else
    [[ $__dstArray != "$__srcArray" ]] && builtin eval "$__dstArray=(\"\${$__srcArray[@]}\")"
  fi
}
function ble/highlight/layer/update/getg {
  g=
  local LEVEL=$LEVEL
  while ((--LEVEL>=0)); do
    "ble/highlight/layer:${_ble_highlight_layer__list[LEVEL]}/getg" "$1"
    [[ $g ]] && return 0
  done
  g=0
}
function ble/highlight/layer/getg {
  LEVEL=${#_ble_highlight_layer__list[*]} ble/highlight/layer/update/getg "$1"
}
_ble_highlight_layer_plain_VARNAMES=(
  _ble_highlight_layer_plain_buff)
function ble/highlight/layer:plain/initialize-vars {
  _ble_highlight_layer_plain_buff=()
}
ble/highlight/layer:plain/initialize-vars
function ble/highlight/layer:plain/update/.getch {
  [[ $ch == [' '-'~'] ]] && return 0
  if [[ $ch == [$'\t\n\177'] ]]; then
    if [[ $ch == $'\t' ]]; then
      ch=${_ble_string_prototype::it}
    elif [[ $ch == $'\n' ]]; then
      ch=$_ble_term_el$_ble_term_nl
    elif [[ $ch == $'\177' ]]; then
      ch='^?'
    fi
  else
    local ret; ble/util/s2c "$ch"
    local cs=${_ble_unicode_GraphemeCluster_ControlRepresentation[ret]}
    if [[ $cs ]]; then
      ch=$cs
    elif ((ret<0x20)); then
      ble/util/c2s $((ret+64))
      ch="^$ret"
    elif ((0x80<=ret&&ret<=0x9F)); then
      ble/util/c2s $((ret-64))
      ch="M-^$ret"
    fi
  fi
}
function ble/highlight/layer:plain/update {
  if ((DMIN>=0)); then
    ble/highlight/layer/update/shift _ble_highlight_layer_plain_buff
    local i text=$1 ch
    local it=$_ble_term_it
    for ((i=DMIN;i<DMAX;i++)); do
      ch=${text:i:1}
      local LC_ALL= LC_COLLATE=C
      ble/highlight/layer:plain/update/.getch
      _ble_highlight_layer_plain_buff[i]=$ch
    done
  fi
  PREV_BUFF=_ble_highlight_layer_plain_buff
  ((PREV_UMIN=DMIN,PREV_UMAX=DMAX))
}
ble/function#suppress-stderr ble/highlight/layer:plain/update
function ble/highlight/layer:plain/getg {
  g=0
}
function ble/color/defface.onload {
  ble/color/defface region         bg=60,fg=white
  ble/color/defface region_target  bg=153,fg=black
  ble/color/defface region_match   bg=55,fg=white
  ble/color/defface region_insert  fg=12,bg=252
  ble/color/defface disabled       fg=242
  ble/color/defface overwrite_mode fg=black,bg=51
}
blehook color_defface_load+=ble/color/defface.onload
_ble_highlight_layer_region_VARNAMES=(
  _ble_highlight_layer_region_buff
  _ble_highlight_layer_region_osel
  _ble_highlight_layer_region_osgr)
function ble/highlight/layer:region/initialize-vars {
  _ble_highlight_layer_region_buff=()
  _ble_highlight_layer_region_osel=()
  _ble_highlight_layer_region_osgr=
}
ble/highlight/layer:region/initialize-vars
function ble/highlight/layer:region/.update-dirty-range {
  local a=$1 b=$2 p q
  ((a==b)) && return 0
  (((a<b?(p=a,q=b):(p=b,q=a)),
    (umin<0||umin>p)&&(umin=p),
    (umax<0||umax<q)&&(umax=q)))
}
function ble/highlight/layer:region/update {
  local IFS=$_ble_term_IFS
  local omin=-1 omax=-1 osgr= olen=${#_ble_highlight_layer_region_osel[@]}
  if ((olen)); then
    omin=${_ble_highlight_layer_region_osel[0]}
    omax=${_ble_highlight_layer_region_osel[olen-1]}
    osgr=$_ble_highlight_layer_region_osgr
  fi
  if ((DMIN>=0)); then
    ((DMAX0<=omin?(omin+=DMAX-DMAX0):(DMIN<omin&&(omin=DMIN)),
      DMAX0<=omax?(omax+=DMAX-DMAX0):(DMIN<omax&&(omax=DMIN))))
  fi
  local sgr=
  local -a selection=()
  if [[ $_ble_edit_mark_active ]]; then
    if ! ble/function#try ble/highlight/layer:region/mark:"$_ble_edit_mark_active"/get-selection; then
      if ((_ble_edit_mark>_ble_edit_ind)); then
        selection=("$_ble_edit_ind" "$_ble_edit_mark")
      elif ((_ble_edit_mark<_ble_edit_ind)); then
        selection=("$_ble_edit_mark" "$_ble_edit_ind")
      fi
    fi
    local face=region
    ble/function#try ble/highlight/layer:region/mark:"$_ble_edit_mark_active"/get-face
    local ret; ble/color/face2sgr "$face"; sgr=$ret
  fi
  local rlen=${#selection[@]}
  if ((DMIN<0&&(PREV_UMIN<0||${#selection[*]}>=2&&selection[0]<=PREV_UMIN&&PREV_UMAX<=selection[1]))); then
    if [[ $sgr == "$osgr" && ${selection[*]} == "${_ble_highlight_layer_region_osel[*]}" ]]; then
      [[ ${selection[*]} ]] && PREV_BUFF=_ble_highlight_layer_region_buff
      return 0
    fi
  else
    [[ ! ${selection[*]} && ! ${_ble_highlight_layer_region_osel[*]} ]] && return 0
  fi
  local umin=-1 umax=-1
  if ((rlen)); then
    local rmin=${selection[0]}
    local rmax=${selection[rlen-1]}
    local -a buff=()
    local g ret
    local k=0 inext iprev=0
    for inext in "${selection[@]}"; do
      if ((inext>iprev)); then
        if ((k==0)); then
          ble/array#push buff "\"\${$PREV_BUFF[@]::$inext}\""
        elif ((k%2)); then
          ble/array#push buff "\"$sgr\${_ble_highlight_layer_plain_buff[@]:$iprev:$((inext-iprev))}\""
        else
          ble/highlight/layer/update/getg "$iprev"
          ble/color/g2sgr "$g"
          ble/array#push buff "\"$ret\${$PREV_BUFF[@]:$iprev:$((inext-iprev))}\""
        fi
      fi
      ((iprev=inext,k++))
    done
    ble/highlight/layer/update/getg "$iprev"
    ble/color/g2sgr "$g"
    ble/array#push buff "\"$ret\${$PREV_BUFF[@]:$iprev}\""
    builtin eval "_ble_highlight_layer_region_buff=(${buff[*]})"
    PREV_BUFF=_ble_highlight_layer_region_buff
    if ((DMIN>=0)); then
      ble/highlight/layer:region/.update-dirty-range "$DMIN" "$DMAX"
    fi
    if ((omin>=0)); then
      if [[ $osgr != "$sgr" ]]; then
        ble/highlight/layer:region/.update-dirty-range "$omin" "$omax"
        ble/highlight/layer:region/.update-dirty-range "$rmin" "$rmax"
      else
        ble/highlight/layer:region/.update-dirty-range "$omin" "$rmin"
        ble/highlight/layer:region/.update-dirty-range "$omax" "$rmax"
        if ((olen>1||rlen>1)); then
          ble/highlight/layer:region/.update-dirty-range "$rmin" "$rmax"
        fi
      fi
    else
      ble/highlight/layer:region/.update-dirty-range "$rmin" "$rmax"
    fi
    local pmin=$PREV_UMIN pmax=$PREV_UMAX
    if ((rlen==2)); then
      ((rmin<=pmin&&pmin<rmax&&(pmin=rmax),
        rmin<pmax&&pmax<=rmax&&(pmax=rmin)))
    fi
    ble/highlight/layer:region/.update-dirty-range "$pmin" "$pmax"
  else
    umin=$PREV_UMIN umax=$PREV_UMAX
    ble/highlight/layer:region/.update-dirty-range "$omin" "$omax"
  fi
  _ble_highlight_layer_region_osel=("${selection[@]}")
  _ble_highlight_layer_region_osgr=$sgr
  ((PREV_UMIN=umin,
    PREV_UMAX=umax))
}
function ble/highlight/layer:region/getg {
  if [[ $_ble_edit_mark_active ]]; then
    local index=$1 olen=${#_ble_highlight_layer_region_osel[@]}
    ((olen)) || return 1
    ((_ble_highlight_layer_region_osel[0]<=index&&index<_ble_highlight_layer_region_osel[olen-1])) || return 1
    local flag_region=
    if ((olen>=4)); then
      local l=0 u=$((olen-1)) m
      while ((l+1<u)); do
        ((_ble_highlight_layer_region_osel[m=(l+u)/2]<=index?(l=m):(u=m)))
      done
      ((l%2==0)) && flag_region=1
    else
      flag_region=1
    fi
    if [[ $flag_region ]]; then
      local face=region
      ble/function#try ble/highlight/layer:region/mark:"$_ble_edit_mark_active"/get-face
      local ret; ble/color/face2g "$face"; g=$ret
    fi
  fi
}
_ble_highlight_layer_disabled_VARNAMES=(
  _ble_highlight_layer_disabled_prev
  _ble_highlight_layer_disabled_buff)
function ble/highlight/layer:disabled/initialize-vars {
  _ble_highlight_layer_disabled_prev=
  _ble_highlight_layer_disabled_buff=()
}
ble/highlight/layer:disabled/initialize-vars
function ble/highlight/layer:disabled/update {
  if [[ $_ble_edit_line_disabled ]]; then
    if ((DMIN>=0)) || [[ ! $_ble_highlight_layer_disabled_prev ]]; then
      local ret; ble/color/face2sgr disabled; local sgr=$ret
      _ble_highlight_layer_disabled_buff=("$sgr""${_ble_highlight_layer_plain_buff[@]}")
    fi
    PREV_BUFF=_ble_highlight_layer_disabled_buff
    if [[ $_ble_highlight_layer_disabled_prev ]]; then
      PREV_UMIN=$DMIN PREV_UMAX=$DMAX
    else
      PREV_UMIN=0 PREV_UMAX=${#1}
    fi
  else
    if [[ $_ble_highlight_layer_disabled_prev ]]; then
      PREV_UMIN=0 PREV_UMAX=${#1}
    fi
  fi
  _ble_highlight_layer_disabled_prev=$_ble_edit_line_disabled
}
function ble/highlight/layer:disabled/getg {
  if [[ $_ble_highlight_layer_disabled_prev ]]; then
    local ret; ble/color/face2g disabled; g=$ret
  fi
}
_ble_highlight_layer_overwrite_mode_VARNAMES=(
  _ble_highlight_layer_overwrite_mode_index
  _ble_highlight_layer_overwrite_mode_buff)
function ble/highlight/layer:overwrite_mode/initialize-vars {
  _ble_highlight_layer_overwrite_mode_index=-1
  _ble_highlight_layer_overwrite_mode_buff=()
}
ble/highlight/layer:overwrite_mode/initialize-vars
function ble/highlight/layer:overwrite_mode/update {
  local oindex=$_ble_highlight_layer_overwrite_mode_index
  if ((DMIN>=0)); then
    if ((oindex>=DMAX0)); then
      ((oindex+=DMAX-DMAX0))
    elif ((oindex>=DMIN)); then
      oindex=-1
    fi
  fi
  local index=-1
  if [[ $_ble_edit_overwrite_mode && ! $_ble_edit_mark_active ]]; then
    local next=${_ble_edit_str:_ble_edit_ind:1}
    if [[ $next && $next != [$'\n\t'] ]]; then
      index=$_ble_edit_ind
      local g ret
      if ((PREV_UMIN<0&&oindex>=0)); then
        ble/highlight/layer/update/getg "$oindex"
        ble/color/g2sgr "$g"
        _ble_highlight_layer_overwrite_mode_buff[oindex]=$ret${_ble_highlight_layer_plain_buff[oindex]}
      else
        builtin eval "_ble_highlight_layer_overwrite_mode_buff=(\"\${$PREV_BUFF[@]}\")"
      fi
      PREV_BUFF=_ble_highlight_layer_overwrite_mode_buff
      ble/color/face2g overwrite_mode
      ble/color/g2sgr "$ret"
      _ble_highlight_layer_overwrite_mode_buff[index]=$ret${_ble_highlight_layer_plain_buff[index]}
      if ((index+1<${#1})); then
        ble/highlight/layer/update/getg $((index+1))
        ble/color/g2sgr "$g"
        _ble_highlight_layer_overwrite_mode_buff[index+1]=$ret${_ble_highlight_layer_plain_buff[index+1]}
      fi
    fi
  fi
  if ((index>=0)); then
    ble/term/cursor-state/hide
  else
    ble/term/cursor-state/reveal
  fi
  if ((index!=oindex)); then
    ((oindex>=0)) && ble/highlight/layer/update/add-urange "$oindex" $((oindex+1))
    ((index>=0)) && ble/highlight/layer/update/add-urange "$index" $((index+1))
  fi
  _ble_highlight_layer_overwrite_mode_index=$index
}
function ble/highlight/layer:overwrite_mode/getg {
  local index=$_ble_highlight_layer_overwrite_mode_index
  if ((index>=0&&index==$1)); then
    local ret; ble/color/face2g overwrite_mode; g=$ret
  fi
}
_ble_highlight_layer_RandomColor_VARNAMES=(
  _ble_highlight_layer_RandomColor_buff)
function ble/highlight/layer:RandomColor/initialize-vars {
  _ble_highlight_layer_RandomColor_buff=()
}
ble/highlight/layer:RandomColor/initialize-vars
function ble/highlight/layer:RandomColor/update {
  local text=$1 ret i
  _ble_highlight_layer_RandomColor_buff=()
  for ((i=0;i<${#text};i++)); do
    ble/color/gspec2sgr "fg=$((RANDOM%256))"
    _ble_highlight_layer_RandomColor_buff[i]=$ret${_ble_highlight_layer_plain_buff[i]}
  done
  PREV_BUFF=_ble_highlight_layer_RandomColor_buff
  ((PREV_UMIN=0,PREV_UMAX=${#text}))
}
function ble/highlight/layer:RandomColor/getg {
  local ret; ble/color/gspec2g "fg=$((RANDOM%256))"; g=$ret
}
_ble_highlight_layer_RandomColor2_buff=()
function ble/highlight/layer:RandomColor2/update {
  local text=$1 ret i x
  ble/highlight/layer/update/shift _ble_highlight_layer_RandomColor2_buff
  for ((i=DMIN;i<DMAX;i++)); do
    ble/color/gspec2sgr "fg=$((16+(x=RANDOM%27)*4-x%9*2-x%3))"
    _ble_highlight_layer_RandomColor2_buff[i]=$ret${_ble_highlight_layer_plain_buff[i]}
  done
  PREV_BUFF=_ble_highlight_layer_RandomColor2_buff
  ((PREV_UMIN=0,PREV_UMAX=${#text}))
}
function ble/highlight/layer:RandomColor2/getg {
  local x ret
  ble/color/gspec2g "fg=$((16+(x=RANDOM%27)*4-x%9*2-x%3))"; g=$ret
}
_ble_highlight_layer__list=(plain syntax region overwrite_mode disabled)
bleopt/declare -v tab_width ''
function bleopt/check:tab_width {
  if [[ $value ]] && (((value=value)<=0)); then
    ble/util/print "bleopt: an empty string or a positive value is required for tab_width." >&2
    return 1
  fi
}
function ble/arithmetic/sum {
  IFS=+ builtin eval 'let "ret=$*+0"'
}
_ble_util_c2w=()
_ble_util_c2w_cache=()
function ble/util/c2w/clear-cache {
  _ble_util_c2w_cache=()
}
bleopt/declare -n char_width_mode auto
function bleopt/check:char_width_mode {
  if ! ble/is-function "ble/util/c2w:$value"; then
    ble/util/print "bleopt: Invalid value char_width_mode='$value'. A function 'ble/util/c2w:$value' is not defined." >&2
    return 1
  fi
  case $value in
  (auto)
    _ble_unicode_c2w_ambiguous=1
    ble && ble/util/c2w:auto/test.buff first-line ;;
  (west) _ble_unicode_c2w_ambiguous=1 ;;
  (east) _ble_unicode_c2w_ambiguous=2 ;;
  esac
  ((_ble_prompt_version++))
  ble/util/c2w/clear-cache
}
function ble/util/c2w {
  ret=${_ble_util_c2w_cache[$1]:-${_ble_util_c2w[$1]}}
  if [[ ! $ret ]]; then
    "ble/util/c2w:$bleopt_char_width_mode" "$1"
    _ble_util_c2w_cache[$1]=$ret
  fi
}
function ble/util/c2w-edit {
  local cs=${_ble_unicode_GraphemeCluster_ControlRepresentation[$1]}
  if [[ $cs ]]; then
    ret=${#cs}
  elif (($1<32||127<=$1&&$1<160)); then
    ret=2
    ((128<=$1&&(ret=4)))
  else
    ble/util/c2w "$1"
  fi
}
function ble/util/s2w-edit {
  local text=$1 iN=${#1} flags=$2 i
  ret=0
  for ((i=0;i<iN;i++)); do
    local c w cs cb extend
    ble/unicode/GraphemeCluster/match "$text" "$i" "$flags"
    ((ret+=w,i+=extend))
  done
}
function ble/util/s2w {
  ble/util/s2w-edit "$1" R
}
_ble_unicode_c2w_UnicodeVersionCount=16
_ble_unicode_c2w_UnicodeVersionMapping=(
  1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1 -1
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
  3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
  3 3 3 3 3 3 3 0 0 0 0 0 0 0 0 0
  -1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
  -1 -1 -1 -1 -1 -1 -1 1 1 1 1 1 1 1 1 1
  1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0
  -1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0
  -1 -1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
  -1 -1 -1 1 1 1 1 1 1 1 1 1 1 1 1 1
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 1 1 1 1 1
  -1 -1 -1 -1 1 1 1 1 1 1 1 1 1 1 1 1
  -1 -1 -1 -1 1 1 1 0 0 0 0 0 0 0 0 0
  -1 -1 -1 -1 -1 -1 -1 0 0 0 0 0 0 0 0 0
  -1 -1 -1 -1 -1 -1 1 0 0 0 0 0 0 0 0 0
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 1
  -1 -1 -1 1 1 1 1 0 0 0 0 0 0 0 0 0
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 0 0 0 0 0
  -1 -1 1 1 1 1 1 0 0 0 0 0 0 0 0 0
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 1 1 1 1 1 1
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 0
  -1 -1 -1 -1 -1 -1 -1 -1 1 1 1 1 1 1 1 1
  -1 -1 -1 -1 -1 -1 -1 -1 -1 1 1 1 1 1 1 1
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 1 1
  -1 -1 -1 -1 -1 -1 -1 -1 -1 0 0 0 0 0 0 0
  -1 -1 -1 -1 -1 -1 -1 -1 0 0 0 0 0 0 0 0
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 0 0 0 0 0 0
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 0 0
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 1 1 1 1
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 0 0 0 0
  2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
  -1 -1 2 2 2 2 2 2 2 2 2 2 2 2 2 2
  -1 -1 2 2 2 1 1 1 1 1 1 1 1 1 1 1
  1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 1
  1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0
  -1 -1 -1 -1 -1 1 1 1 1 1 1 1 1 1 1 1
  -1 -1 3 3 3 3 3 3 3 3 3 3 3 3 3 3
  1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2
  -1 -1 -1 1 1 1 1 1 1 2 2 2 2 2 2 2
  3 3 3 3 3 3 3 3 3 2 2 2 2 2 2 2
  -1 -1 1 1 1 1 1 1 1 2 2 2 2 2 2 2
  -1 -1 3 3 3 3 3 3 3 2 2 2 2 2 2 2
  -1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2
  2 2 2 2 2 2 2 0 0 0 0 0 0 0 0 0
  -1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 2 2 2 2 2 2
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 2 2 2 2 2
  -1 -1 -1 2 2 2 2 2 2 2 2 2 2 2 2 2
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 2 2
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 2 2 2
  -1 -1 2 2 2 2 2 -2 -2 -2 -2 -2 -2 -2 2 2
  -1 -1 2 2 2 2 2 -2 2 2 2 2 2 2 2 2
  -1 -1 2 2 2 2 2 -2 -2 -2 2 2 2 2 2 2
  -1 -1 2 2 2 2 2 -2 -2 -2 -2 2 2 2 2 2
  -1 -1 2 2 2 2 2 -2 -2 -2 -2 -2 -2 -2 -2 2
  -1 -1 1 1 1 1 1 1 1 1 1 1 0 0 0 0
  -1 -1 2 2 2 2 2 -2 -2 -2 -2 -2 -2 -2 -2 -2
  -1 -1 -1 -1 -1 -1 -1 -1 1 1 1 0 0 0 0 0
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 1 0 0 0 0 0
  -1 -1 -1 -1 -1 -1 -1 -1 -1 2 2 2 2 2 2 2
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 2 2 2 2
  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 2
  -1 -1 -1 3 3 3 3 3 3 3 3 3 3 3 3 3
  -1 -1 -1 3 3 3 3 3 3 2 2 2 2 2 2 2
  -1 -1 -1 -1 -1 -1 -1 -1 -1 3 3 3 3 3 3 3
  -1 -1 -1 -1 -1 -1 -1 -1 1 2 2 2 2 2 2 2
  -1 -1 -1 -1 -1 -1 -1 1 1 2 2 2 2 2 2 2
  -1 -1 -1 -1 1 1 1 1 1 2 2 2 2 2 2 2
  -1 -1 -1 -1 -1 -1 -1 -1 -1 2 2 2 2 2 1 1
  2 2 2 2 2 2 2 -2 -2 -2 -2 -2 -2 -2 2 2
  2 2 2 2 2 2 2 -2 -2 -2 -2 -2 -2 -2 -2 2
  2 2 2 2 2 2 2 -2 -2 -2 -2 -2 -2 -2 -2 -2
  2 2 2 2 2 2 2 -2 2 2 2 2 2 2 2 2
  2 2 2 2 2 2 2 -2 -2 -2 2 2 2 2 2 2
)
_ble_unicode_c2w=([0]=0 [32]=1 [127]=0 [160]=1 [161]=2 [162]=1 [164]=2 [165]=1 [167]=2 [169]=1 [170]=2 [171]=1 [173]=3 [174]=2
  [175]=1 [176]=2 [181]=1 [182]=2 [187]=1 [188]=2 [192]=1 [198]=2 [199]=1 [208]=2 [209]=1 [215]=2 [217]=1 [222]=2 [226]=1 [230]=2
  [231]=1 [232]=2 [235]=1 [236]=2 [238]=1 [240]=2 [241]=1 [242]=2 [244]=1 [247]=2 [251]=1 [252]=2 [253]=1 [254]=2 [255]=1 [257]=2
  [258]=1 [273]=2 [274]=1 [275]=2 [276]=1 [283]=2 [284]=1 [294]=2 [296]=1 [299]=2 [300]=1 [305]=2 [308]=1 [312]=2 [313]=1 [319]=2
  [323]=1 [324]=2 [325]=1 [328]=2 [332]=1 [333]=2 [334]=1 [338]=2 [340]=1 [358]=2 [360]=1 [363]=2 [364]=1 [462]=2 [463]=1 [464]=2
  [465]=1 [466]=2 [467]=1 [468]=2 [469]=1 [470]=2 [471]=1 [472]=2 [473]=1 [474]=2 [475]=1 [476]=2 [477]=1 [578]=4 [592]=1 [593]=2
  [594]=1 [609]=2 [610]=1 [708]=2 [709]=1 [711]=2 [712]=1 [713]=2 [716]=1 [717]=2 [718]=1 [720]=2 [721]=1 [728]=2 [732]=1 [733]=2
  [734]=1 [735]=2 [736]=1 [768]=3 [880]=4 [884]=1 [886]=4 [888]=5 [890]=1 [891]=4 [894]=1 [895]=6 [896]=5 [900]=1 [907]=5 [908]=1
  [909]=5 [910]=1 [913]=2 [930]=5 [931]=2 [938]=1 [945]=2 [962]=1 [963]=2 [970]=1 [975]=4 [976]=1 [1025]=2 [1026]=1 [1040]=2
  [1104]=1 [1105]=2 [1106]=1 [1155]=7 [1159]=8 [1160]=7 [1162]=1 [1231]=4 [1232]=1 [1274]=4 [1280]=1 [1296]=4 [1316]=9 [1318]=10
  [1320]=6 [1328]=5 [1329]=1 [1367]=5 [1369]=1 [1376]=11 [1377]=1 [1416]=11 [1417]=1 [1419]=5 [1421]=6 [1423]=12 [1424]=5 [1425]=7
  [1466]=8 [1467]=7 [1470]=1 [1471]=7 [1472]=1 [1473]=7 [1475]=1 [1476]=7 [1478]=1 [1479]=7 [1480]=5 [1488]=1 [1515]=5 [1519]=11
  [1520]=1 [1525]=5 [1536]=7 [1540]=13 [1541]=14 [1542]=4 [1547]=1 [1552]=7 [1558]=8 [1563]=1 [1564]=15 [1565]=16 [1566]=1
  [1568]=10 [1569]=1 [1595]=4 [1600]=1 [1611]=7 [1631]=17 [1632]=1 [1648]=7 [1649]=1 [1750]=7 [1758]=1 [1759]=7 [1765]=1 [1767]=7
  [1769]=1 [1770]=7 [1774]=1 [1806]=5 [1807]=7 [1808]=1 [1809]=7 [1810]=1 [1840]=7 [1867]=5 [1869]=1 [1902]=4 [1920]=1 [1958]=7
  [1969]=1 [1970]=5 [1984]=4 [2027]=8 [2036]=4 [2043]=5 [2045]=18 [2046]=11 [2048]=9 [2070]=19 [2074]=9 [2075]=19 [2084]=9
  [2085]=19 [2088]=9 [2089]=19 [2094]=5 [2096]=9 [2111]=5 [2112]=10 [2137]=17 [2140]=5 [2142]=10 [2143]=5 [2144]=20 [2155]=5
  [2160]=16 [2191]=5 [2192]=21 [2194]=5 [2200]=21 [2208]=12 [2209]=6 [2210]=12 [2221]=6 [2227]=22 [2229]=16 [2230]=23 [2238]=24
  [2248]=16 [2250]=21 [2259]=18 [2260]=25 [2275]=26 [2276]=13 [2303]=14 [2304]=19 [2305]=7 [2307]=1 [2362]=17 [2363]=10 [2364]=7
  [2365]=1 [2369]=7 [2377]=1 [2381]=7 [2382]=9 [2383]=10 [2384]=1 [2385]=7 [2389]=19 [2390]=17 [2392]=1 [2402]=7 [2404]=1 [2417]=4
  [2419]=10 [2424]=6 [2425]=9 [2427]=4 [2429]=1 [2430]=4 [2432]=6 [2433]=7 [2434]=1 [2436]=5 [2437]=1 [2445]=5 [2447]=1 [2449]=5
  [2451]=1 [2473]=5 [2474]=1 [2481]=5 [2482]=1 [2483]=5 [2486]=1 [2490]=5 [2492]=7 [2493]=1 [2497]=7 [2501]=5 [2503]=1 [2505]=5
  [2507]=1 [2509]=7 [2510]=1 [2511]=5 [2519]=1 [2520]=5 [2524]=1 [2526]=5 [2527]=1 [2530]=7 [2532]=5 [2534]=1 [2555]=9 [2556]=20
  [2558]=18 [2559]=5 [2561]=7 [2563]=1 [2564]=5 [2565]=1 [2571]=5 [2575]=1 [2577]=5 [2579]=1 [2601]=5 [2602]=1 [2609]=5 [2610]=1
  [2612]=5 [2613]=1 [2615]=5 [2616]=1 [2618]=5 [2620]=7 [2621]=5 [2622]=1 [2625]=7 [2627]=5 [2631]=7 [2633]=5 [2635]=7 [2638]=5
  [2641]=8 [2642]=5 [2649]=1 [2653]=5 [2654]=1 [2655]=5 [2662]=1 [2672]=7 [2674]=1 [2677]=8 [2678]=11 [2679]=5 [2689]=7 [2691]=1
  [2692]=5 [2693]=1 [2702]=5 [2703]=1 [2706]=5 [2707]=1 [2729]=5 [2730]=1 [2737]=5 [2738]=1 [2740]=5 [2741]=1 [2746]=5 [2748]=7
  [2749]=1 [2753]=7 [2758]=5 [2759]=7 [2761]=1 [2762]=5 [2763]=1 [2765]=7 [2766]=5 [2768]=1 [2769]=5 [2784]=1 [2786]=7 [2788]=5
  [2790]=1 [2800]=12 [2801]=1 [2802]=5 [2809]=22 [2810]=27 [2816]=5 [2817]=7 [2818]=1 [2820]=5 [2821]=1 [2829]=5 [2831]=1 [2833]=5
  [2835]=1 [2857]=5 [2858]=1 [2865]=5 [2866]=1 [2868]=5 [2869]=1 [2874]=5 [2876]=7 [2877]=1 [2879]=7 [2880]=1 [2881]=7 [2884]=8
  [2885]=5 [2887]=1 [2889]=5 [2891]=1 [2893]=7 [2894]=5 [2901]=28 [2902]=7 [2903]=1 [2904]=5 [2908]=1 [2910]=5 [2911]=1 [2914]=8
  [2916]=5 [2918]=1 [2930]=10 [2936]=5 [2946]=7 [2947]=1 [2948]=5 [2949]=1 [2955]=5 [2958]=1 [2961]=5 [2962]=1 [2966]=5 [2969]=1
  [2971]=5 [2972]=1 [2973]=5 [2974]=1 [2976]=5 [2979]=1 [2981]=5 [2984]=1 [2987]=5 [2990]=1 [3002]=5 [3006]=1 [3008]=7 [3009]=1
  [3011]=5 [3014]=1 [3017]=5 [3018]=1 [3021]=7 [3022]=5 [3024]=4 [3025]=5 [3031]=1 [3032]=5 [3046]=1 [3067]=5 [3072]=14 [3073]=1
  [3076]=18 [3077]=1 [3085]=5 [3086]=1 [3089]=5 [3090]=1 [3113]=5 [3114]=1 [3124]=6 [3125]=1 [3130]=5 [3132]=21 [3133]=4 [3134]=7
  [3137]=1 [3141]=5 [3142]=7 [3145]=5 [3146]=7 [3150]=5 [3157]=7 [3159]=5 [3160]=4 [3162]=22 [3163]=5 [3165]=16 [3166]=5 [3168]=1
  [3170]=8 [3172]=5 [3174]=1 [3184]=5 [3191]=29 [3192]=4 [3200]=23 [3201]=14 [3202]=1 [3204]=11 [3205]=1 [3213]=5 [3214]=1
  [3217]=5 [3218]=1 [3241]=5 [3242]=1 [3252]=5 [3253]=1 [3258]=5 [3260]=7 [3261]=1 [3263]=7 [3264]=1 [3269]=5 [3270]=7 [3271]=1
  [3273]=5 [3274]=1 [3276]=7 [3278]=5 [3285]=1 [3287]=5 [3293]=16 [3294]=1 [3295]=5 [3296]=1 [3298]=8 [3300]=5 [3302]=1 [3312]=5
  [3313]=4 [3315]=5 [3328]=27 [3329]=14 [3330]=1 [3332]=24 [3333]=1 [3341]=5 [3342]=1 [3345]=5 [3346]=1 [3369]=10 [3370]=1
  [3386]=10 [3387]=27 [3389]=4 [3390]=1 [3393]=7 [3396]=8 [3397]=5 [3398]=1 [3401]=5 [3402]=1 [3405]=7 [3406]=10 [3407]=23
  [3408]=5 [3412]=23 [3415]=1 [3416]=23 [3423]=22 [3424]=1 [3426]=8 [3428]=5 [3430]=1 [3440]=4 [3446]=23 [3449]=4 [3456]=5
  [3457]=28 [3458]=1 [3460]=5 [3461]=1 [3479]=5 [3482]=1 [3506]=5 [3507]=1 [3516]=5 [3517]=1 [3518]=5 [3520]=1 [3527]=5 [3530]=7
  [3531]=5 [3535]=1 [3538]=7 [3541]=5 [3542]=7 [3543]=5 [3544]=1 [3552]=5 [3558]=6 [3568]=5 [3570]=1 [3573]=5 [3585]=1 [3633]=7
  [3634]=1 [3636]=7 [3643]=5 [3647]=1 [3655]=7 [3663]=1 [3676]=5 [3713]=1 [3715]=5 [3716]=1 [3717]=5 [3718]=29 [3719]=1 [3721]=29
  [3722]=1 [3723]=5 [3724]=29 [3725]=1 [3726]=29 [3732]=1 [3736]=29 [3737]=1 [3744]=29 [3745]=1 [3748]=5 [3749]=1 [3750]=5
  [3751]=1 [3752]=29 [3754]=1 [3756]=29 [3757]=1 [3761]=7 [3762]=1 [3764]=7 [3770]=30 [3771]=7 [3773]=1 [3774]=5 [3776]=1 [3781]=5
  [3782]=1 [3783]=5 [3784]=7 [3790]=5 [3792]=1 [3802]=5 [3804]=1 [3806]=12 [3808]=5 [3840]=1 [3864]=7 [3866]=1 [3893]=7 [3894]=1
  [3895]=7 [3896]=1 [3897]=7 [3898]=1 [3912]=5 [3913]=1 [3947]=4 [3949]=5 [3953]=7 [3967]=1 [3968]=7 [3973]=1 [3974]=7 [3976]=1
  [3980]=10 [3981]=17 [3984]=7 [3992]=5 [3993]=7 [4029]=5 [4030]=1 [4038]=7 [4039]=1 [4045]=5 [4046]=4 [4047]=1 [4050]=4 [4053]=9
  [4057]=10 [4059]=5 [4096]=1 [4130]=4 [4131]=1 [4136]=4 [4137]=1 [4139]=4 [4140]=1 [4141]=7 [4145]=1 [4146]=7 [4147]=8 [4150]=7
  [4152]=1 [4153]=7 [4154]=8 [4155]=4 [4157]=8 [4159]=4 [4160]=1 [4184]=7 [4186]=4 [4190]=8 [4193]=4 [4209]=8 [4213]=4 [4226]=8
  [4227]=4 [4229]=8 [4231]=4 [4237]=8 [4238]=4 [4250]=9 [4253]=19 [4254]=4 [4256]=1 [4294]=5 [4295]=12 [4296]=5 [4301]=12 [4302]=5
  [4304]=1 [4349]=12 [4352]=31 [4442]=32 [4447]=31 [4448]=1 [4515]=33 [4520]=1 [4602]=33 [4608]=1 [4681]=5 [4682]=1 [4686]=5
  [4688]=1 [4695]=5 [4696]=1 [4697]=5 [4698]=1 [4702]=5 [4704]=1 [4745]=5 [4746]=1 [4750]=5 [4752]=1 [4785]=5 [4786]=1 [4790]=5
  [4792]=1 [4799]=5 [4800]=1 [4801]=5 [4802]=1 [4806]=5 [4808]=1 [4823]=5 [4824]=1 [4881]=5 [4882]=1 [4886]=5 [4888]=1 [4955]=5
  [4957]=17 [4959]=7 [4960]=1 [4989]=5 [4992]=1 [5018]=5 [5024]=1 [5109]=22 [5110]=5 [5112]=22 [5118]=5 [5120]=9 [5121]=1 [5751]=9
  [5760]=1 [5789]=5 [5792]=1 [5873]=6 [5881]=5 [5888]=1 [5901]=16 [5902]=1 [5906]=7 [5909]=16 [5910]=5 [5919]=16 [5920]=1 [5938]=7
  [5940]=34 [5941]=1 [5943]=5 [5952]=1 [5970]=7 [5972]=5 [5984]=1 [5997]=5 [5998]=1 [6001]=5 [6002]=7 [6004]=5 [6016]=1 [6068]=7
  [6070]=1 [6071]=7 [6078]=1 [6086]=7 [6087]=1 [6089]=7 [6100]=1 [6109]=7 [6110]=5 [6112]=1 [6122]=5 [6128]=1 [6138]=5 [6144]=1
  [6155]=7 [6159]=21 [6160]=1 [6170]=5 [6176]=1 [6264]=11 [6265]=5 [6272]=1 [6277]=35 [6279]=1 [6313]=7 [6314]=4 [6315]=5 [6320]=9
  [6390]=5 [6400]=1 [6429]=6 [6431]=5 [6432]=7 [6435]=1 [6439]=7 [6441]=1 [6444]=5 [6448]=1 [6450]=7 [6451]=1 [6457]=7 [6460]=5
  [6464]=1 [6465]=5 [6468]=1 [6510]=5 [6512]=1 [6517]=5 [6528]=1 [6570]=9 [6572]=5 [6576]=1 [6602]=5 [6608]=1 [6618]=9 [6619]=5
  [6622]=1 [6679]=7 [6681]=1 [6683]=7 [6684]=5 [6686]=1 [6688]=9 [6742]=19 [6743]=9 [6744]=19 [6751]=5 [6752]=19 [6753]=9
  [6754]=19 [6755]=9 [6757]=19 [6765]=9 [6771]=19 [6781]=5 [6783]=19 [6784]=9 [6794]=5 [6800]=9 [6810]=5 [6816]=9 [6830]=5
  [6832]=14 [6847]=28 [6849]=21 [6863]=5 [6912]=8 [6916]=4 [6964]=8 [6965]=4 [6966]=8 [6971]=4 [6972]=8 [6973]=4 [6978]=8 [6979]=4
  [6988]=16 [6989]=5 [6992]=4 [7019]=8 [7028]=4 [7037]=16 [7039]=5 [7040]=8 [7042]=4 [7074]=8 [7078]=4 [7080]=8 [7082]=4 [7083]=13
  [7086]=4 [7098]=12 [7104]=10 [7142]=17 [7143]=10 [7144]=17 [7146]=10 [7149]=17 [7150]=10 [7151]=17 [7154]=10 [7156]=5 [7164]=10
  [7168]=4 [7212]=8 [7220]=4 [7222]=8 [7224]=5 [7227]=4 [7242]=5 [7245]=4 [7296]=23 [7305]=5 [7312]=11 [7355]=5 [7357]=11
  [7360]=12 [7368]=5 [7376]=19 [7379]=9 [7380]=19 [7393]=9 [7394]=19 [7401]=9 [7405]=19 [7406]=9 [7411]=12 [7412]=13 [7413]=12
  [7415]=20 [7416]=14 [7418]=29 [7419]=5 [7424]=1 [7616]=7 [7620]=8 [7655]=14 [7670]=27 [7674]=21 [7675]=25 [7676]=17 [7677]=19
  [7678]=8 [7680]=1 [7836]=4 [7840]=1 [7930]=4 [7936]=1 [7958]=5 [7960]=1 [7966]=5 [7968]=1 [8006]=5 [8008]=1 [8014]=5 [8016]=1
  [8024]=5 [8025]=1 [8026]=5 [8027]=1 [8028]=5 [8029]=1 [8030]=5 [8031]=1 [8062]=5 [8064]=1 [8117]=5 [8118]=1 [8133]=5 [8134]=1
  [8148]=5 [8150]=1 [8156]=5 [8157]=1 [8176]=5 [8178]=1 [8181]=5 [8182]=1 [8191]=5 [8192]=1 [8203]=7 [8208]=2 [8209]=1 [8211]=2
  [8215]=1 [8216]=2 [8218]=1 [8220]=2 [8222]=1 [8224]=2 [8227]=1 [8228]=2 [8232]=0 [8234]=7 [8239]=1 [8240]=2 [8241]=1 [8242]=2
  [8244]=1 [8245]=2 [8246]=1 [8251]=2 [8252]=1 [8254]=2 [8255]=1 [8288]=7 [8292]=8 [8293]=5 [8294]=15 [8298]=7 [8304]=1 [8306]=5
  [8308]=2 [8309]=1 [8319]=2 [8320]=1 [8321]=2 [8325]=1 [8335]=5 [8336]=1 [8341]=10 [8349]=5 [8352]=1 [8364]=2 [8365]=1 [8374]=9
  [8377]=10 [8378]=36 [8379]=6 [8382]=22 [8383]=20 [8384]=16 [8385]=5 [8400]=7 [8428]=8 [8433]=5 [8448]=1 [8451]=2 [8452]=1
  [8453]=2 [8454]=1 [8457]=2 [8458]=1 [8467]=2 [8468]=1 [8470]=2 [8471]=1 [8481]=2 [8483]=1 [8486]=2 [8487]=1 [8491]=2 [8492]=1
  [8525]=4 [8528]=9 [8531]=2 [8533]=1 [8539]=2 [8543]=1 [8544]=2 [8556]=1 [8560]=2 [8570]=1 [8580]=4 [8585]=37 [8586]=22 [8588]=5
  [8592]=2 [8602]=1 [8632]=2 [8634]=1 [8658]=2 [8659]=1 [8660]=2 [8661]=1 [8679]=2 [8680]=1 [8704]=2 [8705]=1 [8706]=2 [8708]=1
  [8711]=2 [8713]=1 [8715]=2 [8716]=1 [8719]=2 [8720]=1 [8721]=2 [8722]=1 [8725]=2 [8726]=1 [8730]=2 [8731]=1 [8733]=2 [8737]=1
  [8739]=2 [8740]=1 [8741]=2 [8742]=1 [8743]=2 [8749]=1 [8750]=2 [8751]=1 [8756]=2 [8760]=1 [8764]=2 [8766]=1 [8776]=2 [8777]=1
  [8780]=2 [8781]=1 [8786]=2 [8787]=1 [8800]=2 [8802]=1 [8804]=2 [8808]=1 [8810]=2 [8812]=1 [8814]=2 [8816]=1 [8834]=2 [8836]=1
  [8838]=2 [8840]=1 [8853]=2 [8854]=1 [8857]=2 [8858]=1 [8869]=2 [8870]=1 [8895]=2 [8896]=1 [8978]=2 [8979]=1 [8986]=38 [8988]=1
  [9001]=31 [9003]=1 [9180]=4 [9192]=9 [9193]=39 [9197]=10 [9200]=39 [9201]=10 [9203]=39 [9204]=6 [9211]=23 [9215]=20 [9216]=1
  [9255]=5 [9280]=1 [9291]=5 [9312]=2 [9450]=1 [9451]=2 [9548]=1 [9552]=2 [9588]=1 [9600]=2 [9616]=1 [9618]=2 [9622]=1 [9632]=2
  [9634]=1 [9635]=2 [9642]=1 [9650]=2 [9652]=1 [9654]=2 [9656]=1 [9660]=2 [9662]=1 [9664]=2 [9666]=1 [9670]=2 [9673]=1 [9675]=2
  [9676]=1 [9678]=2 [9682]=1 [9698]=2 [9702]=1 [9711]=2 [9712]=1 [9725]=38 [9727]=1 [9733]=2 [9735]=1 [9737]=2 [9738]=1 [9742]=2
  [9744]=1 [9748]=40 [9750]=1 [9756]=2 [9757]=1 [9758]=2 [9759]=1 [9792]=2 [9793]=1 [9794]=2 [9795]=1 [9800]=38 [9812]=1 [9824]=2
  [9826]=1 [9827]=2 [9830]=1 [9831]=2 [9835]=1 [9836]=2 [9838]=1 [9839]=2 [9840]=1 [9855]=38 [9856]=1 [9875]=38 [9876]=1 [9885]=4
  [9886]=37 [9888]=1 [9889]=38 [9890]=1 [9898]=38 [9900]=1 [9906]=4 [9917]=41 [9918]=42 [9919]=37 [9920]=4 [9924]=42 [9926]=37
  [9934]=39 [9935]=37 [9940]=42 [9941]=37 [9954]=10 [9955]=37 [9956]=10 [9960]=37 [9962]=42 [9963]=37 [9970]=42 [9972]=37
  [9973]=42 [9974]=37 [9978]=42 [9979]=37 [9981]=42 [9982]=37 [9984]=6 [9985]=1 [9989]=39 [9990]=1 [9994]=39 [9996]=1 [10024]=39
  [10025]=1 [10045]=2 [10046]=1 [10060]=39 [10061]=1 [10062]=39 [10063]=1 [10067]=39 [10070]=1 [10071]=42 [10072]=1 [10079]=10
  [10081]=1 [10102]=2 [10112]=1 [10133]=39 [10136]=1 [10160]=39 [10161]=1 [10175]=39 [10176]=1 [10183]=4 [10187]=12 [10188]=4
  [10189]=12 [10190]=10 [10192]=1 [10220]=4 [10224]=1 [11028]=4 [11035]=43 [11037]=4 [11085]=6 [11088]=43 [11089]=4 [11093]=42
  [11094]=37 [11098]=6 [11124]=5 [11126]=6 [11158]=5 [11159]=24 [11160]=6 [11194]=11 [11197]=6 [11209]=29 [11210]=6 [11218]=20
  [11219]=11 [11244]=22 [11248]=11 [11263]=29 [11264]=1 [11311]=16 [11312]=1 [11359]=16 [11360]=4 [11376]=9 [11377]=4 [11390]=9
  [11392]=1 [11499]=9 [11503]=19 [11506]=12 [11508]=5 [11513]=1 [11558]=5 [11559]=12 [11560]=5 [11565]=12 [11566]=5 [11568]=1
  [11622]=12 [11624]=5 [11631]=1 [11632]=10 [11633]=5 [11647]=17 [11648]=1 [11671]=5 [11680]=1 [11687]=5 [11688]=1 [11695]=5
  [11696]=1 [11703]=5 [11704]=1 [11711]=5 [11712]=1 [11719]=5 [11720]=1 [11727]=5 [11728]=1 [11735]=5 [11736]=1 [11743]=5
  [11744]=8 [11776]=1 [11800]=4 [11804]=1 [11806]=4 [11825]=9 [11826]=12 [11836]=6 [11843]=23 [11845]=20 [11850]=11 [11855]=29
  [11856]=24 [11859]=16 [11870]=5 [11904]=31 [11930]=5 [11931]=31 [12020]=5 [12032]=31 [12246]=5 [12272]=31 [12284]=5 [12288]=31
  [12330]=44 [12334]=31 [12351]=1 [12352]=5 [12353]=31 [12439]=5 [12441]=44 [12443]=31 [12544]=5 [12549]=31 [12589]=45 [12590]=46
  [12591]=47 [12592]=5 [12593]=31 [12687]=5 [12688]=31 [12728]=48 [12731]=49 [12736]=31 [12752]=45 [12772]=5 [12784]=31 [12831]=5
  [12832]=31 [12868]=32 [12872]=37 [12880]=31 [13055]=50 [13056]=31 [19894]=51 [19904]=1 [19968]=31 [40892]=45 [40900]=32
  [40909]=52 [40918]=53 [40939]=54 [40944]=51 [40957]=55 [40960]=31 [42125]=5 [42128]=31 [42183]=5 [42192]=9 [42240]=4 [42540]=5
  [42560]=4 [42592]=10 [42594]=4 [42607]=8 [42611]=4 [42612]=13 [42620]=8 [42622]=4 [42648]=6 [42654]=26 [42655]=13 [42656]=9
  [42736]=19 [42738]=9 [42744]=5 [42752]=1 [42775]=4 [42893]=10 [42895]=22 [42896]=10 [42898]=12 [42900]=6 [42912]=10 [42922]=12
  [42923]=6 [42926]=23 [42927]=11 [42928]=6 [42930]=22 [42936]=11 [42938]=29 [42944]=16 [42946]=29 [42951]=24 [42955]=5 [42960]=16
  [42962]=5 [42963]=16 [42964]=5 [42965]=16 [42970]=5 [42994]=16 [42997]=24 [42999]=6 [43000]=12 [43002]=10 [43003]=4 [43008]=1
  [43010]=7 [43011]=1 [43014]=7 [43015]=1 [43019]=7 [43020]=1 [43045]=7 [43047]=1 [43052]=28 [43053]=5 [43056]=9 [43066]=5
  [43072]=4 [43128]=5 [43136]=4 [43204]=8 [43205]=25 [43206]=5 [43214]=4 [43226]=5 [43232]=19 [43250]=9 [43260]=22 [43262]=11
  [43263]=18 [43264]=4 [43302]=8 [43310]=4 [43335]=8 [43346]=4 [43348]=5 [43359]=4 [43360]=32 [43389]=5 [43392]=19 [43395]=9
  [43443]=19 [43444]=9 [43446]=19 [43450]=9 [43452]=19 [43453]=56 [43454]=9 [43470]=5 [43471]=9 [43482]=5 [43486]=9 [43488]=6
  [43493]=14 [43494]=6 [43519]=5 [43520]=4 [43561]=8 [43567]=4 [43569]=8 [43571]=4 [43573]=8 [43575]=5 [43584]=4 [43587]=8
  [43588]=4 [43596]=8 [43597]=4 [43598]=5 [43600]=4 [43610]=5 [43612]=4 [43616]=9 [43644]=14 [43645]=6 [43648]=9 [43696]=19
  [43697]=9 [43698]=19 [43701]=9 [43703]=19 [43705]=9 [43710]=19 [43712]=9 [43713]=19 [43714]=9 [43715]=5 [43739]=9 [43744]=12
  [43756]=13 [43758]=12 [43766]=13 [43767]=5 [43777]=10 [43783]=5 [43785]=10 [43791]=5 [43793]=10 [43799]=5 [43808]=10 [43815]=5
  [43816]=10 [43823]=5 [43824]=6 [43872]=22 [43876]=6 [43878]=29 [43880]=24 [43884]=5 [43888]=22 [43968]=9 [44005]=19 [44006]=9
  [44008]=19 [44009]=9 [44013]=19 [44014]=5 [44016]=9 [44026]=5 [44032]=31 [55204]=5 [55216]=33 [55239]=5 [55243]=33 [55292]=5
  [55296]=0 [57344]=2 [63744]=31 [64046]=32 [64048]=31 [64107]=32 [64110]=57 [64112]=31 [64218]=57 [64256]=1 [64263]=5 [64275]=1
  [64280]=5 [64285]=1 [64286]=7 [64287]=1 [64311]=5 [64312]=1 [64317]=5 [64318]=1 [64319]=5 [64320]=1 [64322]=5 [64323]=1
  [64325]=5 [64326]=1 [64434]=10 [64450]=16 [64451]=5 [64467]=1 [64832]=16 [64848]=1 [64912]=5 [64914]=1 [64968]=5 [64975]=16
  [64976]=5 [65008]=1 [65022]=16 [65024]=3 [65040]=31 [65050]=5 [65056]=7 [65060]=8 [65063]=14 [65070]=26 [65072]=31 [65107]=5
  [65108]=31 [65127]=5 [65128]=31 [65132]=5 [65136]=1 [65141]=5 [65142]=1 [65277]=5 [65279]=7 [65280]=5 [65281]=31 [65377]=1
  [65471]=5 [65474]=1 [65480]=5 [65482]=1 [65488]=5 [65490]=1 [65496]=5 [65498]=1 [65501]=5 [65504]=31 [65511]=5 [65512]=1
  [65519]=5 [65529]=7 [65532]=1 [65533]=2 [65534]=5 [65536]=1 [65548]=5 [65549]=1 [65575]=5 [65576]=1 [65595]=5 [65596]=1
  [65598]=5 [65599]=1 [65614]=5 [65616]=1 [65630]=5 [65664]=1 [65787]=5 [65792]=1 [65795]=5 [65799]=1 [65844]=5 [65847]=1
  [65931]=6 [65933]=23 [65935]=5 [65936]=4 [65948]=24 [65949]=5 [65952]=6 [65953]=5 [66000]=4 [66045]=8 [66046]=5 [66176]=4
  [66205]=5 [66208]=4 [66257]=5 [66272]=14 [66273]=6 [66300]=5 [66304]=1 [66335]=6 [66336]=1 [66340]=5 [66349]=20 [66352]=1
  [66379]=5 [66384]=6 [66422]=14 [66427]=5 [66432]=1 [66462]=5 [66463]=1 [66500]=5 [66504]=1 [66518]=5 [66560]=1 [66718]=5
  [66720]=1 [66730]=5 [66736]=23 [66772]=5 [66776]=23 [66812]=5 [66816]=6 [66856]=5 [66864]=6 [66916]=5 [66927]=6 [66928]=16
  [66939]=5 [66940]=16 [66955]=5 [66956]=16 [66963]=5 [66964]=16 [66966]=5 [66967]=16 [66978]=5 [66979]=16 [66994]=5 [66995]=16
  [67002]=5 [67003]=16 [67005]=5 [67072]=6 [67383]=5 [67392]=6 [67414]=5 [67424]=6 [67432]=5 [67456]=16 [67462]=5 [67463]=16
  [67505]=5 [67506]=16 [67515]=5 [67584]=1 [67590]=5 [67592]=1 [67593]=5 [67594]=1 [67638]=5 [67639]=1 [67641]=5 [67644]=1
  [67645]=5 [67647]=1 [67648]=9 [67670]=5 [67671]=9 [67680]=6 [67743]=5 [67751]=6 [67760]=5 [67808]=22 [67827]=5 [67828]=22
  [67830]=5 [67835]=22 [67840]=4 [67866]=9 [67868]=5 [67871]=4 [67898]=5 [67903]=4 [67904]=5 [67968]=12 [68024]=5 [68028]=22
  [68030]=12 [68032]=22 [68048]=5 [68050]=22 [68096]=1 [68097]=7 [68100]=5 [68101]=7 [68103]=5 [68108]=7 [68112]=1 [68116]=5
  [68117]=1 [68120]=5 [68121]=1 [68148]=11 [68150]=5 [68152]=7 [68155]=5 [68159]=7 [68160]=1 [68168]=11 [68169]=5 [68176]=1
  [68185]=5 [68192]=9 [68224]=6 [68256]=5 [68288]=6 [68325]=14 [68327]=5 [68331]=6 [68343]=5 [68352]=9 [68406]=5 [68409]=9
  [68438]=5 [68440]=9 [68467]=5 [68472]=9 [68480]=6 [68498]=5 [68505]=6 [68509]=5 [68521]=6 [68528]=5 [68608]=9 [68681]=5
  [68736]=22 [68787]=5 [68800]=22 [68851]=5 [68858]=22 [68864]=11 [68900]=18 [68904]=5 [68912]=11 [68922]=5 [69216]=9 [69247]=5
  [69248]=24 [69290]=5 [69291]=28 [69293]=24 [69294]=5 [69296]=24 [69298]=5 [69376]=11 [69416]=5 [69424]=11 [69446]=18 [69457]=11
  [69466]=5 [69488]=16 [69506]=21 [69510]=16 [69514]=5 [69552]=24 [69580]=5 [69600]=29 [69623]=5 [69632]=10 [69633]=17 [69634]=10
  [69688]=17 [69703]=10 [69710]=5 [69714]=10 [69744]=21 [69745]=16 [69747]=21 [69749]=16 [69750]=5 [69759]=14 [69760]=19 [69762]=9
  [69811]=19 [69815]=9 [69817]=19 [69819]=9 [69821]=19 [69822]=9 [69826]=21 [69827]=5 [69837]=18 [69838]=5 [69840]=12 [69865]=5
  [69872]=12 [69882]=5 [69888]=13 [69891]=12 [69927]=13 [69932]=12 [69933]=13 [69941]=5 [69942]=12 [69956]=11 [69959]=24 [69960]=5
  [69968]=6 [70003]=14 [70004]=6 [70007]=5 [70016]=13 [70018]=12 [70070]=13 [70079]=12 [70089]=58 [70090]=26 [70093]=6 [70094]=24
  [70095]=28 [70096]=12 [70106]=6 [70107]=22 [70112]=5 [70113]=6 [70133]=5 [70144]=6 [70162]=5 [70163]=6 [70191]=14 [70194]=6
  [70196]=14 [70197]=6 [70198]=14 [70200]=6 [70206]=25 [70207]=5 [70272]=22 [70279]=5 [70280]=22 [70281]=5 [70282]=22 [70286]=5
  [70287]=22 [70302]=5 [70303]=22 [70314]=5 [70320]=6 [70367]=14 [70368]=6 [70371]=14 [70379]=5 [70384]=6 [70394]=5 [70400]=26
  [70401]=14 [70402]=6 [70404]=5 [70405]=6 [70413]=5 [70415]=6 [70417]=5 [70419]=6 [70441]=5 [70442]=6 [70449]=5 [70450]=6
  [70452]=5 [70453]=6 [70458]=5 [70459]=18 [70460]=14 [70461]=6 [70464]=14 [70465]=6 [70469]=5 [70471]=6 [70473]=5 [70475]=6
  [70478]=5 [70480]=22 [70481]=5 [70487]=6 [70488]=5 [70493]=6 [70500]=5 [70502]=14 [70509]=5 [70512]=14 [70517]=5 [70656]=23
  [70712]=25 [70720]=23 [70722]=25 [70725]=23 [70726]=25 [70727]=23 [70746]=24 [70747]=23 [70748]=5 [70749]=23 [70750]=18
  [70751]=29 [70752]=24 [70754]=5 [70784]=6 [70835]=14 [70841]=6 [70842]=14 [70843]=6 [70847]=14 [70849]=6 [70850]=14 [70852]=6
  [70856]=5 [70864]=6 [70874]=5 [71040]=6 [71090]=14 [71094]=5 [71096]=6 [71100]=14 [71102]=6 [71103]=14 [71105]=6 [71114]=22
  [71132]=26 [71134]=5 [71168]=6 [71219]=14 [71227]=6 [71229]=14 [71230]=6 [71231]=14 [71233]=6 [71237]=5 [71248]=6 [71258]=5
  [71264]=23 [71277]=5 [71296]=12 [71339]=13 [71340]=12 [71341]=13 [71342]=12 [71344]=13 [71350]=12 [71351]=13 [71352]=29
  [71353]=16 [71354]=5 [71360]=12 [71370]=5 [71424]=22 [71450]=11 [71451]=5 [71453]=26 [71456]=22 [71458]=26 [71462]=22 [71463]=26
  [71468]=5 [71472]=22 [71488]=16 [71495]=5 [71680]=11 [71727]=18 [71736]=11 [71737]=18 [71739]=11 [71740]=5 [71840]=6 [71923]=5
  [71935]=6 [71936]=24 [71943]=5 [71945]=24 [71946]=5 [71948]=24 [71956]=5 [71957]=24 [71959]=5 [71960]=24 [71990]=5 [71991]=24
  [71993]=5 [71995]=28 [71997]=24 [71998]=28 [71999]=24 [72003]=28 [72004]=24 [72007]=5 [72016]=24 [72026]=5 [72096]=29 [72104]=5
  [72106]=29 [72148]=30 [72152]=5 [72154]=30 [72156]=29 [72160]=30 [72161]=29 [72165]=5 [72192]=20 [72193]=27 [72199]=59
  [72201]=27 [72203]=20 [72243]=27 [72249]=20 [72251]=27 [72255]=20 [72263]=27 [72264]=5 [72272]=20 [72273]=27 [72279]=20
  [72281]=27 [72284]=20 [72324]=29 [72326]=20 [72330]=27 [72343]=20 [72344]=27 [72346]=20 [72349]=11 [72350]=20 [72355]=5
  [72368]=16 [72384]=6 [72441]=5 [72704]=23 [72713]=5 [72714]=23 [72752]=25 [72759]=5 [72760]=25 [72766]=23 [72767]=25 [72768]=23
  [72774]=5 [72784]=23 [72813]=5 [72816]=23 [72848]=5 [72850]=25 [72872]=5 [72873]=23 [72874]=25 [72881]=23 [72882]=25 [72884]=23
  [72885]=25 [72887]=5 [72960]=20 [72967]=5 [72968]=20 [72970]=5 [72971]=20 [73009]=27 [73015]=5 [73018]=27 [73019]=5 [73020]=27
  [73022]=5 [73023]=27 [73030]=20 [73031]=27 [73032]=5 [73040]=20 [73050]=5 [73056]=11 [73062]=5 [73063]=11 [73065]=5 [73066]=11
  [73103]=5 [73104]=18 [73106]=5 [73107]=11 [73109]=18 [73110]=11 [73111]=18 [73112]=11 [73113]=5 [73120]=11 [73130]=5 [73440]=11
  [73459]=18 [73461]=11 [73465]=5 [73648]=24 [73649]=5 [73664]=29 [73714]=5 [73727]=29 [73728]=4 [74607]=6 [74649]=22 [74650]=5
  [74752]=4 [74851]=6 [74863]=5 [74864]=4 [74868]=6 [74869]=5 [74880]=22 [75076]=5 [77712]=16 [77811]=5 [77824]=9 [78895]=5
  [78896]=30 [78905]=5 [82944]=22 [83527]=5 [92160]=10 [92729]=5 [92736]=6 [92767]=5 [92768]=6 [92778]=5 [92782]=6 [92784]=16
  [92863]=5 [92864]=16 [92874]=5 [92880]=6 [92910]=5 [92912]=14 [92917]=6 [92918]=5 [92928]=6 [92976]=14 [92983]=6 [92998]=5
  [93008]=6 [93018]=5 [93019]=6 [93026]=5 [93027]=6 [93048]=5 [93053]=6 [93072]=5 [93760]=11 [93851]=5 [93952]=12 [94021]=29
  [94027]=5 [94031]=30 [94032]=12 [94079]=29 [94088]=5 [94095]=13 [94099]=12 [94112]=5 [94176]=60 [94177]=46 [94178]=61 [94180]=28
  [94181]=5 [94192]=49 [94194]=5 [94208]=60 [100333]=47 [100338]=61 [100344]=5 [100352]=60 [101107]=49 [101590]=5 [101632]=49
  [101641]=5 [110576]=62 [110580]=5 [110581]=62 [110588]=5 [110589]=62 [110591]=5 [110592]=48 [110594]=46 [110879]=62 [110883]=5
  [110928]=61 [110931]=5 [110948]=61 [110952]=5 [110960]=46 [111356]=5 [113664]=6 [113771]=5 [113776]=6 [113789]=5 [113792]=6
  [113801]=5 [113808]=6 [113818]=5 [113820]=6 [113821]=14 [113823]=6 [113824]=14 [113828]=5 [118528]=21 [118574]=5 [118576]=21
  [118599]=5 [118608]=16 [118724]=5 [118784]=1 [119030]=5 [119040]=1 [119079]=5 [119081]=4 [119082]=1 [119143]=7 [119146]=1
  [119155]=7 [119171]=1 [119173]=7 [119180]=1 [119210]=7 [119214]=1 [119262]=22 [119273]=16 [119275]=5 [119296]=1 [119362]=7
  [119365]=1 [119366]=5 [119520]=11 [119540]=5 [119552]=1 [119639]=5 [119648]=4 [119666]=11 [119673]=5 [119808]=1 [119893]=5
  [119894]=1 [119965]=5 [119966]=1 [119968]=5 [119970]=1 [119971]=5 [119973]=1 [119975]=5 [119977]=1 [119981]=5 [119982]=1
  [119994]=5 [119995]=1 [119996]=5 [119997]=1 [120004]=5 [120005]=1 [120070]=5 [120071]=1 [120075]=5 [120077]=1 [120085]=5
  [120086]=1 [120093]=5 [120094]=1 [120122]=5 [120123]=1 [120127]=5 [120128]=1 [120133]=5 [120134]=1 [120135]=5 [120138]=1
  [120145]=5 [120146]=1 [120486]=5 [120488]=1 [120778]=4 [120780]=5 [120782]=1 [120832]=22 [121344]=26 [121399]=22 [121403]=26
  [121453]=22 [121461]=26 [121462]=22 [121476]=26 [121477]=22 [121484]=5 [121499]=26 [121504]=5 [121505]=26 [121520]=5 [122624]=16
  [122655]=5 [122880]=25 [122887]=5 [122888]=25 [122905]=5 [122907]=25 [122914]=5 [122915]=25 [122917]=5 [122918]=25 [122923]=5
  [123136]=29 [123181]=5 [123184]=30 [123191]=29 [123198]=5 [123200]=29 [123210]=5 [123214]=29 [123216]=5 [123536]=16 [123566]=21
  [123567]=5 [123584]=29 [123628]=30 [123632]=29 [123642]=5 [123647]=29 [123648]=5 [124896]=16 [124903]=5 [124904]=16 [124908]=5
  [124909]=16 [124911]=5 [124912]=16 [124927]=5 [124928]=6 [125125]=5 [125127]=6 [125136]=14 [125143]=5 [125184]=23 [125252]=25
  [125259]=29 [125260]=5 [125264]=23 [125274]=5 [125278]=23 [125280]=5 [126065]=11 [126133]=5 [126209]=29 [126270]=5 [126464]=12
  [126468]=5 [126469]=12 [126496]=5 [126497]=12 [126499]=5 [126500]=12 [126501]=5 [126503]=12 [126504]=5 [126505]=12 [126515]=5
  [126516]=12 [126520]=5 [126521]=12 [126522]=5 [126523]=12 [126524]=5 [126530]=12 [126531]=5 [126535]=12 [126536]=5 [126537]=12
  [126538]=5 [126539]=12 [126540]=5 [126541]=12 [126544]=5 [126545]=12 [126547]=5 [126548]=12 [126549]=5 [126551]=12 [126552]=5
  [126553]=12 [126554]=5 [126555]=12 [126556]=5 [126557]=12 [126558]=5 [126559]=12 [126560]=5 [126561]=12 [126563]=5 [126564]=12
  [126565]=5 [126567]=12 [126571]=5 [126572]=12 [126579]=5 [126580]=12 [126584]=5 [126585]=12 [126589]=5 [126590]=12 [126591]=5
  [126592]=12 [126602]=5 [126603]=12 [126620]=5 [126625]=12 [126628]=5 [126629]=12 [126634]=5 [126635]=12 [126652]=5 [126704]=12
  [126706]=5 [126976]=4 [126980]=43 [126981]=4 [127020]=5 [127024]=4 [127124]=5 [127136]=10 [127151]=5 [127153]=10 [127167]=6
  [127168]=5 [127169]=10 [127183]=39 [127184]=5 [127185]=10 [127200]=6 [127222]=5 [127232]=37 [127243]=6 [127245]=24 [127248]=37
  [127278]=9 [127279]=11 [127280]=63 [127281]=37 [127282]=63 [127293]=37 [127294]=63 [127295]=37 [127296]=63 [127298]=37
  [127299]=63 [127302]=37 [127303]=63 [127306]=37 [127311]=63 [127319]=37 [127320]=63 [127327]=37 [127328]=63 [127338]=12
  [127340]=29 [127341]=24 [127344]=63 [127353]=37 [127354]=63 [127355]=37 [127357]=63 [127359]=37 [127360]=63 [127370]=37
  [127374]=64 [127375]=63 [127376]=37 [127377]=64 [127387]=65 [127405]=24 [127406]=5 [127462]=10 [127488]=32 [127489]=48
  [127491]=5 [127504]=32 [127538]=48 [127547]=60 [127548]=5 [127552]=32 [127561]=5 [127568]=48 [127570]=5 [127584]=46 [127590]=5
  [127744]=39 [127777]=6 [127789]=66 [127792]=39 [127798]=6 [127799]=39 [127869]=6 [127870]=66 [127872]=39 [127892]=6 [127904]=39
  [127941]=67 [127942]=39 [127947]=6 [127951]=66 [127956]=6 [127968]=39 [127985]=6 [127988]=67 [127989]=6 [127992]=66 [128000]=39
  [128063]=6 [128064]=39 [128065]=6 [128066]=39 [128248]=67 [128249]=39 [128253]=6 [128255]=66 [128256]=39 [128318]=6 [128320]=12
  [128324]=6 [128331]=66 [128335]=22 [128336]=39 [128360]=6 [128378]=60 [128379]=6 [128405]=67 [128407]=6 [128420]=60 [128421]=6
  [128507]=39 [128512]=68 [128513]=39 [128529]=68 [128530]=39 [128533]=68 [128534]=39 [128535]=68 [128536]=39 [128537]=68
  [128538]=39 [128539]=68 [128540]=39 [128543]=68 [128544]=39 [128550]=68 [128552]=39 [128556]=68 [128557]=39 [128558]=68
  [128560]=39 [128564]=68 [128565]=39 [128577]=67 [128579]=66 [128581]=39 [128592]=6 [128640]=39 [128710]=6 [128716]=67 [128717]=6
  [128720]=66 [128721]=60 [128723]=20 [128725]=61 [128726]=49 [128728]=5 [128733]=62 [128736]=6 [128747]=67 [128749]=5 [128752]=6
  [128756]=60 [128759]=46 [128761]=47 [128762]=61 [128763]=49 [128765]=5 [128768]=10 [128884]=5 [128896]=6 [128981]=11 [128985]=5
  [128992]=61 [129004]=5 [129008]=62 [129009]=5 [129024]=6 [129036]=5 [129040]=6 [129096]=5 [129104]=6 [129114]=5 [129120]=6
  [129160]=5 [129168]=6 [129198]=5 [129200]=24 [129202]=5 [129280]=20 [129292]=49 [129293]=61 [129296]=66 [129305]=60 [129311]=46
  [129312]=60 [129320]=46 [129328]=60 [129329]=46 [129331]=60 [129339]=69 [129340]=60 [129343]=61 [129344]=60 [129350]=69
  [129351]=60 [129356]=46 [129357]=47 [129360]=60 [129375]=46 [129388]=47 [129393]=61 [129394]=49 [129395]=47 [129399]=49
  [129401]=62 [129402]=47 [129403]=61 [129404]=47 [129408]=66 [129413]=60 [129426]=46 [129432]=47 [129443]=49 [129445]=61
  [129451]=49 [129454]=61 [129456]=47 [129466]=61 [129472]=66 [129473]=47 [129475]=61 [129483]=49 [129484]=62 [129485]=61
  [129488]=46 [129511]=47 [129536]=29 [129620]=5 [129632]=11 [129646]=5 [129648]=61 [129652]=49 [129653]=5 [129656]=61 [129659]=62
  [129661]=5 [129664]=61 [129667]=49 [129671]=5 [129680]=61 [129686]=49 [129705]=62 [129709]=5 [129712]=49 [129719]=62 [129723]=5
  [129728]=49 [129731]=62 [129734]=5 [129744]=49 [129751]=62 [129754]=5 [129760]=62 [129768]=5 [129776]=62 [129783]=5 [129792]=24
  [129939]=5 [129940]=24 [129995]=5 [130032]=24 [130042]=5 [131072]=31 [173783]=70 [173790]=71 [173792]=72 [173824]=31 [177973]=71
  [177977]=72 [177984]=31 [178206]=72 [178208]=73 [183970]=72 [183984]=74 [191457]=72 [194560]=31 [195102]=72 [196606]=5
  [196608]=70 [201547]=72 [262142]=5 [917505]=7 [917506]=5 [917536]=7 [917632]=5 [917760]=3 [918000]=5 [983040]=2 [1048574]=5
  [1048576]=2 [1114110]=5)
_ble_unicode_c2w_ranges=(0 32 127 162 165 167 171 176 182 188 192 199 209 215 217 222 226 232 236 238 242 244 247 255 258 276 284
  294 296 300 305 308 313 319 325 328 334 338 340 358 360 364 477 578 594 610 709 713 718 721 728 736 768 880 884 886 888 891 896
  900 910 913 931 938 945 963 970 976 1026 1040 1106 1155 1160 1162 1232 1274 1280 1296 1316 1318 1320 1329 1367 1369 1377 1417
  1419 1421 1425 1467 1473 1476 1480 1488 1515 1520 1525 1536 1542 1547 1552 1558 1566 1569 1595 1600 1611 1632 1649 1750 1759
  1765 1767 1770 1774 1810 1840 1867 1869 1902 1920 1958 1970 1984 2027 2036 2043 2046 2048 2070 2075 2085 2089 2094 2096 2112
  2137 2140 2144 2155 2160 2192 2194 2200 2210 2221 2227 2230 2238 2248 2250 2260 2276 2305 2307 2365 2369 2377 2385 2390 2392
  2402 2404 2417 2419 2425 2427 2430 2434 2437 2445 2447 2449 2451 2474 2483 2486 2490 2493 2497 2501 2503 2505 2507 2511 2520
  2524 2527 2530 2532 2534 2556 2559 2561 2565 2571 2575 2577 2579 2602 2610 2613 2616 2618 2622 2625 2627 2631 2633 2635 2638
  2642 2649 2655 2662 2672 2674 2679 2689 2693 2703 2707 2730 2738 2741 2746 2749 2753 2759 2763 2766 2769 2784 2786 2788 2790
  2802 2810 2818 2821 2829 2831 2833 2835 2858 2866 2869 2874 2877 2881 2885 2887 2889 2891 2894 2904 2908 2911 2914 2916 2918
  2930 2936 2949 2955 2958 2962 2966 2969 2974 2976 2979 2981 2984 2987 2990 3002 3006 3009 3011 3014 3018 3022 3025 3032 3046
  3067 3073 3077 3086 3090 3114 3125 3130 3134 3137 3142 3146 3150 3157 3160 3163 3166 3168 3170 3172 3174 3184 3192 3202 3205
  3214 3218 3242 3253 3258 3261 3264 3271 3274 3276 3278 3285 3287 3296 3298 3300 3302 3313 3315 3330 3333 3342 3346 3370 3387
  3390 3393 3398 3402 3408 3412 3416 3424 3426 3428 3430 3440 3446 3449 3458 3461 3479 3482 3507 3518 3520 3527 3531 3535 3538
  3544 3552 3558 3568 3570 3573 3585 3634 3636 3643 3647 3655 3663 3676 3713 3719 3726 3732 3737 3745 3752 3754 3757 3762 3764
  3771 3774 3776 3784 3790 3792 3802 3804 3806 3808 3840 3864 3866 3898 3913 3947 3949 3953 3968 3974 3976 3981 3984 3993 4030
  4039 4047 4050 4053 4057 4059 4096 4131 4137 4141 4147 4150 4155 4157 4160 4184 4186 4190 4193 4209 4213 4227 4229 4231 4238
  4250 4254 4256 4296 4302 4304 4349 4352 4442 4448 4515 4520 4602 4608 4682 4686 4688 4698 4702 4704 4746 4750 4752 4786 4790
  4792 4802 4806 4808 4824 4882 4886 4888 4955 4957 4960 4989 4992 5018 5024 5110 5112 5118 5121 5751 5760 5789 5792 5873 5881
  5888 5902 5906 5910 5920 5938 5941 5943 5952 5970 5972 5984 5998 6002 6004 6016 6068 6071 6078 6087 6089 6100 6110 6112 6122
  6128 6138 6144 6155 6160 6170 6176 6265 6272 6277 6279 6315 6320 6390 6400 6429 6432 6435 6439 6441 6444 6448 6451 6457 6460
  6465 6468 6510 6512 6517 6528 6570 6572 6576 6602 6608 6619 6622 6679 6681 6684 6686 6688 6744 6755 6757 6765 6771 6781 6784
  6794 6800 6810 6816 6830 6832 6847 6849 6863 6912 6916 6966 6973 6979 6989 6992 7019 7028 7037 7040 7042 7074 7078 7080 7083
  7086 7098 7104 7144 7146 7151 7154 7156 7164 7168 7212 7220 7222 7224 7227 7242 7245 7296 7305 7312 7355 7357 7360 7368 7376
  7380 7394 7401 7406 7413 7416 7419 7424 7616 7620 7655 7670 7678 7680 7836 7840 7930 7936 7958 7960 7966 7968 8006 8008 8014
  8016 8031 8062 8064 8118 8134 8148 8150 8157 8176 8178 8182 8192 8203 8209 8211 8216 8218 8220 8222 8224 8228 8232 8234 8242
  8246 8252 8255 8288 8294 8298 8304 8306 8309 8321 8325 8336 8341 8349 8352 8365 8374 8379 8385 8400 8428 8433 8448 8454 8458
  8468 8471 8481 8483 8487 8492 8525 8528 8531 8533 8539 8544 8556 8560 8570 8580 8586 8588 8592 8602 8632 8634 8661 8680 8706
  8708 8711 8713 8716 8722 8726 8731 8733 8737 8743 8751 8756 8760 8764 8766 8777 8781 8787 8800 8802 8804 8808 8810 8812 8814
  8816 8834 8836 8838 8840 8854 8858 8870 8896 8979 8986 8988 9001 9003 9180 9193 9197 9201 9204 9211 9216 9255 9280 9291 9312
  9451 9548 9552 9588 9600 9616 9618 9622 9632 9635 9642 9650 9652 9654 9656 9660 9662 9664 9666 9670 9673 9676 9678 9682 9698
  9702 9712 9725 9727 9733 9735 9738 9742 9744 9748 9750 9759 9795 9800 9812 9824 9827 9831 9836 9840 9856 9876 9886 9890 9898
  9900 9906 9920 9924 9926 9935 9941 9956 9960 9963 9970 9974 9979 9982 9985 9990 9994 9996 10025 10046 10063 10067 10072 10079
  10081 10102 10112 10133 10136 10161 10176 10183 10190 10192 10220 10224 11028 11035 11037 11085 11089 11094 11098 11124 11126
  11160 11194 11197 11210 11219 11244 11248 11264 11312 11360 11377 11390 11392 11499 11503 11506 11508 11513 11560 11566 11568
  11622 11624 11633 11648 11671 11680 11688 11696 11704 11712 11720 11728 11736 11744 11776 11800 11804 11806 11826 11836 11843
  11845 11850 11856 11859 11870 11904 11931 12020 12032 12246 12272 12284 12288 12330 12334 12353 12439 12441 12443 12544 12549
  12593 12688 12728 12731 12736 12752 12772 12784 12832 12868 12872 12880 13056 19894 19904 19968 40892 40900 40909 40918 40939
  40944 40957 40960 42125 42128 42183 42192 42240 42540 42560 42592 42594 42607 42612 42620 42622 42648 42656 42736 42738 42744
  42752 42775 42893 42896 42898 42900 42912 42923 42928 42930 42936 42938 42944 42946 42951 42955 42960 42965 42970 42994 42997
  43000 43003 43008 43011 43015 43020 43045 43047 43053 43056 43066 43072 43128 43136 43206 43214 43226 43232 43250 43260 43264
  43302 43310 43335 43346 43348 43360 43389 43392 43395 43444 43446 43450 43454 43471 43482 43486 43488 43494 43520 43561 43567
  43569 43571 43573 43575 43584 43588 43598 43600 43610 43612 43616 43645 43648 43698 43701 43703 43705 43710 43715 43739 43744
  43756 43758 43767 43777 43783 43785 43791 43793 43799 43808 43816 43824 43872 43876 43878 43880 43884 43888 43968 44006 44009
  44014 44016 44026 44032 55204 55216 55239 55243 55292 55296 57344 63744 64046 64048 64107 64110 64112 64218 64256 64263 64275
  64280 64287 64312 64320 64323 64326 64434 64451 64467 64832 64848 64912 64914 64968 64976 65008 65022 65024 65040 65050 65056
  65060 65063 65070 65072 65108 65128 65132 65136 65142 65277 65281 65377 65471 65474 65480 65482 65488 65490 65496 65498 65501
  65504 65512 65519 65529 65534 65536 65549 65576 65596 65599 65614 65616 65630 65664 65787 65792 65795 65799 65844 65847 65931
  65933 65936 65949 65953 66000 66046 66176 66205 66208 66257 66273 66300 66304 66336 66340 66349 66352 66379 66384 66422 66427
  66432 66463 66500 66504 66518 66560 66718 66720 66730 66736 66772 66776 66812 66816 66856 66864 66916 66928 66940 66956 66964
  66967 66979 66995 67003 67005 67072 67383 67392 67414 67424 67432 67456 67463 67506 67515 67584 67590 67594 67639 67641 67645
  67648 67671 67680 67743 67751 67760 67808 67828 67830 67835 67840 67866 67868 67871 67898 67904 67968 68024 68028 68030 68032
  68048 68050 68097 68101 68103 68108 68112 68117 68121 68148 68150 68152 68155 68160 68169 68176 68185 68192 68224 68256 68288
  68325 68327 68331 68343 68352 68406 68409 68438 68440 68467 68472 68480 68498 68505 68509 68521 68528 68608 68681 68736 68787
  68800 68851 68858 68864 68900 68904 68912 68922 69216 69248 69291 69294 69296 69298 69376 69416 69424 69446 69457 69466 69488
  69506 69510 69514 69552 69580 69600 69623 69634 69688 69703 69710 69714 69745 69747 69750 69760 69762 69811 69815 69817 69819
  69822 69827 69838 69840 69865 69872 69882 69888 69891 69927 69933 69942 69956 69960 69968 70004 70007 70016 70018 70070 70079
  70090 70096 70107 70113 70133 70144 70163 70191 70194 70198 70200 70207 70272 70282 70287 70303 70314 70320 70368 70371 70379
  70384 70394 70402 70405 70413 70415 70417 70419 70442 70450 70453 70461 70465 70469 70471 70473 70475 70478 70481 70488 70493
  70500 70502 70509 70512 70517 70656 70712 70720 70722 70727 70752 70754 70784 70835 70843 70847 70850 70852 70856 70864 70874
  71040 71090 71094 71096 71100 71103 71105 71114 71132 71134 71168 71219 71227 71231 71233 71237 71248 71258 71264 71277 71296
  71342 71344 71354 71360 71370 71424 71451 71453 71456 71458 71463 71468 71472 71488 71495 71680 71727 71737 71740 71840 71923
  71936 71943 71946 71948 71957 71960 71991 71993 71995 71999 72004 72007 72016 72026 72096 72104 72106 72148 72152 72154 72156
  72161 72165 72193 72199 72201 72203 72243 72249 72251 72255 72264 72273 72279 72281 72284 72324 72326 72330 72344 72346 72350
  72355 72368 72384 72441 72704 72714 72752 72760 72768 72774 72784 72813 72816 72848 72850 72874 72882 72885 72887 72960 72968
  72971 73009 73015 73020 73023 73032 73040 73050 73056 73063 73066 73104 73107 73113 73120 73130 73440 73459 73461 73465 73649
  73664 73714 73728 74607 74650 74752 74851 74864 74869 74880 75076 77712 77811 77824 78896 78905 82944 83527 92160 92729 92736
  92768 92778 92782 92784 92864 92874 92880 92910 92912 92918 92928 92976 92983 92998 93008 93019 93027 93048 93053 93072 93760
  93851 93952 94021 94027 94032 94079 94088 94095 94099 94112 94178 94181 94192 94194 94208 100333 100338 100344 100352 101107
  101590 101632 101641 110576 110581 110589 110592 110594 110879 110883 110928 110931 110948 110952 110960 111356 113664 113771
  113776 113789 113792 113801 113808 113818 113821 113824 113828 118528 118574 118576 118599 118608 118724 118784 119030 119040
  119079 119082 119143 119146 119155 119171 119173 119180 119210 119214 119262 119273 119275 119296 119362 119366 119520 119540
  119552 119639 119648 119666 119673 119808 119894 119966 119968 119971 119973 119975 119977 119982 119997 120005 120071 120075
  120077 120086 120094 120123 120128 120135 120138 120146 120486 120488 120778 120780 120782 120832 121344 121399 121403 121453
  121462 121477 121484 121499 121505 121520 122624 122655 122880 122888 122905 122907 122915 122918 122923 123136 123181 123184
  123191 123198 123200 123210 123214 123216 123536 123567 123584 123628 123632 123642 123648 124896 124904 124909 124912 124928
  125125 125127 125136 125143 125184 125252 125260 125264 125274 125278 125280 126065 126133 126209 126270 126464 126469 126497
  126501 126505 126516 126524 126531 126541 126545 126549 126561 126565 126567 126572 126580 126585 126592 126603 126620 126625
  126629 126635 126652 126704 126706 126976 126981 127020 127024 127124 127136 127151 127153 127169 127185 127200 127222 127232
  127243 127245 127248 127282 127296 127299 127303 127306 127311 127320 127328 127338 127341 127344 127355 127357 127360 127370
  127377 127387 127406 127462 127489 127491 127504 127538 127548 127552 127561 127568 127570 127584 127590 127744 127777 127789
  127792 127799 127870 127872 127892 127904 127942 127947 127951 127956 127968 127985 127989 127992 128000 128066 128249 128253
  128256 128318 128320 128324 128331 128336 128360 128379 128405 128407 128421 128507 128513 128530 128540 128544 128550 128552
  128558 128560 128565 128577 128579 128581 128592 128640 128710 128717 128721 128723 128726 128728 128733 128736 128747 128749
  128752 128756 128759 128763 128765 128768 128884 128896 128981 128985 128992 129004 129009 129024 129036 129040 129096 129104
  129114 129120 129160 129168 129198 129200 129202 129280 129293 129296 129305 129312 129320 129329 129331 129340 129344 129351
  129357 129360 129375 129388 129395 129399 129404 129408 129413 129426 129432 129443 129445 129451 129454 129456 129466 129473
  129475 129485 129488 129511 129536 129620 129632 129646 129648 129653 129656 129659 129661 129664 129667 129671 129680 129686
  129705 129709 129712 129719 129723 129728 129731 129734 129744 129751 129754 129760 129768 129776 129783 129792 129940 129995
  130032 130042 131072 173783 173790 173792 173824 177973 177977 177984 178206 178208 183970 183984 191457 194560 195102 196606
  196608 201547 262142 917506 917536 917632 917760 918000 983040 1048574 1048576 1114110 1114112)
_ble_unicode_c2w_index=(0:24 23:43 42:53 52:68 67:77 76:98 97:115 114:129 128:153 152:193 192:238 237:287 286:330 329:367 366:397
  396:418 417:444 443:450 449:466 465:479 478:480 1 479:487 486:514 513:526 525:549 548:571 570:596 595:619 618:625 624:629
  628:649 648:684 683:710 709:745 744:757 756:762 761:790 789:825 824:847 1 1 1 846:864 863:874 873:892 891:907 906:911 910:918
  917:927 926:932 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 931:935 31 31 31 31 31 31 31 31 31
  31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31
  31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 934:943 31 31 31 31 942:948 4 947:962
  961:985 984:1003 1002:1022 1021:1048 1047:1070 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31
  31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 1069:1076 0 0 0 0 0 0 0 1075:1077 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
  2 1076:1078 31 1077:1085 1084:1096 1 1095:1105 1104:1118 1117:1135 1134:1145 1144:1156 1155:1163 1162:1177 1176:1185 1184:1198 6
  1197:1208 1207:1224 1223:1236 1235:1260 1259:1273 1272:1280 1279:1284 1283:1291 1290:1304 1303:1326 1325:1345 1344:1362
  1361:1387 1386:1402 1401:1413 1412:1429 1428:1439 1438:1445 1444:1467 1466:1490 1489:1491 1490:1506 1505:1523 1522:1527
  1526:1531 4 4 4 1530:1534 1533:1538 1537:1539 5 5 5 5 5 5 5 5 5 1538:1542 9 9 9 9 1541:1544 5 5 5 5 5 5 5 5 5 5 5 5 5 5
  1543:1545 22 22 1544:1546 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 1545:1547 10 10 1546:1560 1559:1569 5
  5 1568:1572 1571:1585 60 60 60 60 60 60 60 60 60 60 60 60 60 60 60 60 60 60 60 60 60 60 60 1584:1589 60 60 1588:1590 49
  1589:1592 1591:1593 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 1592:1597 1596:1598 1597:1605 1604:1606 5
  5 5 5 5 5 5 5 1605:1607 1606:1617 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 1616:1618 1617:1624 1623:1626 1625:1640 1639:1645 1644:1650
  1649:1660 1659:1670 1669:1672 1671:1676 22 1675:1677 1676:1686 5 5 5 1685:1687 1686:1689 1688:1696 1695:1704 1703:1711 5 5 5 5
  1710:1716 1715:1721 1720:1727 5 5 1726:1729 1728:1732 1731:1757 1756:1758 1757:1770 1769:1792 1791:1804 1803:1821 1820:1825
  1824:1836 1835:1866 1865:1874 1873:1886 1885:1919 1918:1948 1947:1952 5 5 5 1951:1953 31 31 31 31 31 31 31 31 31 31 1952:1957
  1956:1962 1961:1964 74 1963:1965 1964:1969 70 1968:1970 72 72 72 72 72 72 72 72 72 72 72 72 72 1969:1971 5 5 5 5 5 5 5 5 5 5 5 5
  5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
  5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
  5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 1970:1976 5 5 5 5 5 5 5 5 5 5 5 5 5 5 1975:1977 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1976:1979
  2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1978:1980)
function ble/unicode/c2w/version2index {
  case $1 in
  (4.1) ret=0 ;;
  (5.0) ret=1 ;;
  (5.2) ret=2 ;;
  (6.0) ret=3 ;;
  (6.1) ret=4 ;;
  (6.2) ret=5 ;;
  (6.3) ret=6 ;;
  (7.0) ret=7 ;;
  (8.0) ret=8 ;;
  (9.0) ret=9 ;;
  (10.0) ret=10 ;;
  (11.0) ret=11 ;;
  (12.0) ret=12 ;;
  (12.1) ret=13 ;;
  (13.0) ret=14 ;;
  (14.0) ret=15 ;;
  (*) return 1 ;;
  esac
}
_ble_unicode_c2w_version=15
_ble_unicode_c2w_version=14
_ble_unicode_c2w_ambiguous=1
_ble_unicode_c2w_invalid=1
_ble_unicode_c2w_custom=()
bleopt/declare -n char_width_version auto
function bleopt/check:char_width_version {
  if [[ $value == auto ]]; then
    ble && ble/util/c2w:auto/test.buff first-line
    ((_ble_prompt_version++))
    ble/util/c2w/clear-cache
    return 0
  elif local ret; ble/unicode/c2w/version2index "$value"; then
    _ble_unicode_c2w_version=$ret
    ((_ble_prompt_version++))
    ble/util/c2w/clear-cache
    return 0
  else
    ble/util/print "bleopt: char_width_version: invalid value '$value'." >&2
    return 1
  fi
}
_ble_unicode_c2w_custom[173]=1                    # U+00ad       Cf A SHY(soft-hyphen)
let '_ble_unicode_c2w_custom['{1536..1541}']=1'   # U+0600..0605 Cf 1 アラブの数字?
_ble_unicode_c2w_custom[1757]=1                   # U+06dd       Cf 1 ARABIC END OF AYAH
_ble_unicode_c2w_custom[1807]=1                   # U+070f       Cf 1 SYRIAC ABBREVIATION MARK
_ble_unicode_c2w_custom[2274]=1                   # U+08e2       Cf 1 ARABIC DISPUTED END OF AYAH
_ble_unicode_c2w_custom[69821]=1                  # U+110bd      Cf 1 KAITHI NUMBER SIGN
_ble_unicode_c2w_custom[69837]=1                  # U+110cd      Cf 1 KAITHI NUMBER SIGN ABOVE
let '_ble_unicode_c2w_custom['{12872..12879}']=2' # U+3248..324f No A 囲み文字10-80 (8字)
let '_ble_unicode_c2w_custom['{19904..19967}']=2' # U+4dc0..4dff So 1 易経記号 (6字)
let '_ble_unicode_c2w_custom['{4448..4607}']=0'   # U+1160..11ff Lo 1 HANGUL JAMO (160字)
let '_ble_unicode_c2w_custom['{55216..55238}']=0' # U+d7b0..d7c6 Lo 1 HANGUL JAMO EXTENDED-B (1) (23字)
let '_ble_unicode_c2w_custom['{55243..55291}']=0' # U+d7cb..d7fb Lo 1 HANGUL JAMO EXTENDED-B (2) (49字)
function ble/unicode/c2w {
  local c=$1
  ret=${_ble_unicode_c2w_custom[c]}
  [[ $ret ]] && return 0
  ret=${_ble_unicode_c2w[c]}
  if [[ ! $ret ]]; then
    ret=${_ble_unicode_c2w_index[c<0x20000?c>>8:((c>>12)-32+512)]}
    if [[ $ret == *:* ]]; then
      local l=${ret%:*} u=${ret#*:} m
      while ((l+1<u)); do
        ((m=(l+u)/2))
        if ((_ble_unicode_c2w_ranges[m]<=c)); then
          l=$m
        else
          u=$m
        fi
      done
      ret=${_ble_unicode_c2w[_ble_unicode_c2w_ranges[l]]}
    fi
  fi
  ret=${_ble_unicode_c2w_UnicodeVersionMapping[ret*_ble_unicode_c2w_UnicodeVersionCount+_ble_unicode_c2w_version]}
  ((ret<0)) && ret=${_ble_unicode_c2w_invalid:-$((-ret))}
  ((ret==3)) &&
    ret=${_ble_unicode_c2w_ambiguous:-1}
  return 0
}
_ble_unicode_EmojiStatus_None=0
_ble_unicode_EmojiStatus_FullyQualified=1
_ble_unicode_EmojiStatus_MinimallyQualified=2
_ble_unicode_EmojiStatus_Unqualified=3
_ble_unicode_EmojiStatus_Component=4
_ble_unicode_EmojiStatus_xmaybe='8596<=code&&code<=11036||127344<=code&&code<=129782'
_ble_unicode_EmojiStatus=([169]=3 [174]=3 [8252]=3 [8265]=3 [8482]=3 [8505]=3 [8596]=3 [8602]=0 [8617]=3 [8619]=0 [8986]=1
  [8988]=0 [9000]='V>=2?3:0' [9167]='V>=2?3:0' [9193]=1 [9197]='V>=1?3:0' [9199]='V>=2?3:0' [9200]=1 [9201]='V>=2?3:0' [9203]=1
  [9204]=0 [9208]='V>=1?3:0' [9211]=0 [9410]=3 [9642]=3 [9644]=0 [9654]=3 [9664]=3 [9723]=3 [9725]=1 [9727]=0 [9728]=3
  [9730]='V>=1?3:0' [9732]='V>=2?3:0' [9733]=0 [9742]=3 [9745]=3 [9748]=1 [9750]=0 [9752]='V>=2?3:0' [9757]=3 [9760]='V>=2?3:0'
  [9761]=0 [9762]='V>=2?3:0' [9764]=0 [9766]='V>=2?3:0' [9770]='V>=1?3:0' [9774]='V>=2?3:0' [9775]='V>=1?3:0' [9784]='V>=1?3:0'
  [9786]=3 [9787]=0 [9792]='V>=5?3:0' [9793]=0 [9794]='V>=5?3:0' [9800]=1 [9812]=0 [9823]='V>=7?3:0' [9824]=3 [9827]=3 [9828]=0
  [9829]=3 [9831]=0 [9832]=3 [9833]=0 [9851]=3 [9854]='V>=7?3:0' [9855]=1 [9874]='V>=2?3:0' [9875]=1 [9876]='V>=2?3:0'
  [9877]='V>=5?3:0' [9878]='V>=2?3:0' [9880]=0 [9881]='V>=2?3:0' [9882]=0 [9885]=0 [9888]=3 [9889]=1 [9895]='V>=10?3:0' [9898]=1
  [9900]=0 [9904]='V>=2?3:0' [9906]=0 [9917]=1 [9919]=0 [9924]=1 [9926]=0 [9928]='V>=1?3:0' [9934]=1 [9935]='V>=1?3:0' [9936]=0
  [9937]='V>=1?3:0' [9938]=0 [9939]='V>=1?3:0' [9940]=1 [9961]='V>=1?3:0' [9962]=1 [9968]='V>=1?3:0' [9970]=1 [9972]='V>=1?3:0'
  [9973]=1 [9974]=0 [9975]='V>=1?3:0' [9978]=1 [9979]=0 [9981]=1 [9986]=3 [9989]=1 [9992]=3 [9994]=1 [9996]=3 [9997]='V>=1?3:0'
  [9998]=0 [9999]=3 [10000]=0 [10002]=3 [10003]=0 [10004]=3 [10005]=0 [10006]=3 [10013]='V>=1?3:0' [10017]='V>=1?3:0' [10024]=1
  [10035]=3 [10037]=0 [10052]=3 [10055]=3 [10060]=1 [10061]=0 [10062]=1 [10067]=1 [10070]=0 [10071]=1 [10072]=0 [10083]='V>=2?3:0'
  [10084]=3 [10133]=1 [10136]=0 [10145]=3 [10160]=1 [10175]='V>=2?1:0' [10548]=3 [10550]=0 [11013]=3 [11016]=0 [11035]=1 [11037]=0
  [11088]=1 [11093]=1 [12336]=3 [12349]=3 [12951]=3 [12952]=0 [12953]=3 [126980]=1 [127183]=1 [127344]=3 [127346]=0 [127358]=3
  [127360]=0 [127374]=1 [127377]=1 [127387]=0 [127462]=1 [127488]=0 [127489]=1 [127490]=3 [127491]=0 [127514]=1 [127535]=1
  [127538]=1 [127543]=3 [127547]=0 [127568]=1 [127570]=0 [127744]=1 [127757]='V>=1?1:0' [127759]=1 [127760]='V>=2?1:0' [127761]=1
  [127762]='V>=2?1:0' [127763]=1 [127766]='V>=2?1:0' [127769]=1 [127770]='V>=2?1:0' [127771]=1 [127772]='V>=1?1:0' [127775]=1
  [127777]='V>=1?3:0' [127778]=0 [127780]='V>=1?3:0' [127789]='V>=2?1:0' [127792]=1 [127794]='V>=2?1:0' [127796]=1
  [127798]='V>=1?3:0' [127819]='V>=2?1:0' [127824]='V>=2?1:0' [127868]='V>=2?1:0' [127869]='V>=1?3:0' [127870]='V>=2?1:0'
  [127872]=1 [127892]=0 [127894]='V>=1?3:0' [127896]=0 [127900]=0 [127902]='V>=1?3:0' [127904]=1 [127941]='V>=2?1:0' [127942]=1
  [127943]='V>=2?1:0' [127944]=1 [127945]='V>=2?1:0' [127946]=1 [127947]='V>=1?3:0' [127951]='V>=2?1:0' [127956]='V>=1?3:0'
  [127968]=1 [127972]='V>=2?1:0' [127985]=0 [127987]='V>=1?3:0' [127988]='V>=2?1:0' [127989]='V>=1?3:0' [127990]=0
  [127991]='V>=1?3:0' [127992]='V>=2?1:0' [127995]='V>=2?4:0' [128000]='V>=2?1:0' [128008]='V>=1?1:0' [128012]=1
  [128015]='V>=2?1:0' [128017]=1 [128019]='V>=2?1:0' [128020]=1 [128021]='V>=1?1:0' [128022]='V>=2?1:0' [128042]='V>=2?1:0'
  [128063]='V>=1?3:0' [128064]=1 [128065]='V>=1?3:0' [128101]='V>=2?1:0' [128108]='V>=2?1:0' [128110]=1 [128173]='V>=2?1:0'
  [128182]='V>=2?1:0' [128184]=1 [128236]='V>=1?1:0' [128238]=1 [128239]='V>=2?1:0' [128240]=1 [128245]='V>=2?1:0'
  [128248]='V>=2?1:0' [128253]='V>=1?3:0' [128254]=0 [128255]='V>=2?1:0' [128259]=1 [128264]='V>=1?1:0' [128265]='V>=2?1:0'
  [128266]=1 [128277]='V>=2?1:0' [128300]='V>=2?1:0' [128302]=1 [128318]=0 [128329]='V>=1?3:0' [128331]='V>=2?1:0' [128335]=0
  [128336]=1 [128348]='V>=1?1:0' [128360]=0 [128367]='V>=1?3:0' [128369]=0 [128371]='V>=1?3:0' [128378]='V>=4?1:0' [128379]=0
  [128391]='V>=1?3:0' [128394]='V>=1?3:0' [128398]=0 [128400]='V>=1?3:0' [128405]='V>=2?1:0' [128407]=0 [128420]='V>=4?1:0'
  [128421]='V>=1?3:0' [128424]='V>=1?3:0' [128433]='V>=1?3:0' [128435]=0 [128444]='V>=1?3:0' [128450]='V>=1?3:0' [128453]=0
  [128465]='V>=1?3:0' [128468]=0 [128476]='V>=1?3:0' [128479]=0 [128481]='V>=1?3:0' [128482]=0 [128483]='V>=1?3:0'
  [128488]='V>=3?3:0' [128495]='V>=1?3:0' [128499]='V>=1?3:0' [128506]='V>=1?3:0' [128507]=1 [128512]='V>=2?1:0'
  [128519]='V>=2?1:0' [128521]=1 [128526]='V>=2?1:0' [128527]=1 [128528]='V>=1?1:0' [128529]='V>=2?1:0' [128533]='V>=2?1:0'
  [128534]=1 [128535]='V>=2?1:0' [128536]=1 [128537]='V>=2?1:0' [128538]=1 [128539]='V>=2?1:0' [128543]='V>=2?1:0'
  [128550]='V>=2?1:0' [128552]=1 [128556]='V>=2?1:0' [128557]=1 [128558]='V>=2?1:0' [128560]=1 [128564]='V>=2?1:0' [128565]=1
  [128566]='V>=2?1:0' [128577]='V>=2?1:0' [128581]=1 [128592]=0 [128640]=1 [128641]='V>=2?1:0' [128643]=1 [128646]='V>=2?1:0'
  [128647]=1 [128648]='V>=2?1:0' [128649]=1 [128650]='V>=2?1:0' [128652]=1 [128653]='V>=1?1:0' [128654]='V>=2?1:0' [128655]=1
  [128656]='V>=2?1:0' [128657]=1 [128660]='V>=1?1:0' [128661]=1 [128662]='V>=2?1:0' [128663]=1 [128664]='V>=1?1:0'
  [128667]='V>=2?1:0' [128674]=1 [128675]='V>=2?1:0' [128676]=1 [128678]='V>=2?1:0' [128686]='V>=2?1:0' [128690]=1 [128694]=1
  [128697]=1 [128703]='V>=2?1:0' [128704]=1 [128705]='V>=2?1:0' [128710]=0 [128715]='V>=1?3:0' [128716]='V>=2?1:0'
  [128717]='V>=1?3:0' [128720]='V>=2?1:0' [128721]='V>=4?1:0' [128723]=0 [128725]='V>=8?1:0' [128726]='V>=10?1:0' [128728]=0
  [128733]='V>=12?1:0' [128736]='V>=1?3:0' [128742]=0 [128745]='V>=1?3:0' [128746]=0 [128747]='V>=2?1:0' [128749]=0
  [128752]='V>=1?3:0' [128755]='V>=1?3:0' [128756]='V>=4?1:0' [128759]='V>=6?1:0' [128761]='V>=7?1:0' [128762]='V>=8?1:0'
  [128763]='V>=10?1:0' [128765]=0 [128992]='V>=8?1:0' [129004]=0 [129008]='V>=12?1:0' [129292]='V>=10?1:0' [129293]='V>=8?1:0'
  [129296]='V>=2?1:0' [129305]='V>=4?1:0' [129311]='V>=6?1:0' [129320]='V>=6?1:0' [129328]='V>=4?1:0' [129331]='V>=4?1:0'
  [129339]=0 [129343]='V>=8?1:0' [129350]=0 [129356]='V>=6?1:0' [129357]='V>=7?1:0' [129360]='V>=4?1:0' [129375]='V>=6?1:0'
  [129388]='V>=7?1:0' [129393]='V>=8?1:0' [129394]='V>=10?1:0' [129399]='V>=10?1:0' [129401]='V>=12?1:0' [129402]='V>=7?1:0'
  [129403]='V>=8?1:0' [129404]='V>=7?1:0' [129408]='V>=2?1:0' [129413]='V>=4?1:0' [129426]='V>=6?1:0' [129432]='V>=7?1:0'
  [129443]='V>=10?1:0' [129445]='V>=8?1:0' [129451]='V>=10?1:0' [129454]='V>=8?1:0' [129456]='V>=7?4:0' [129460]='V>=7?1:0'
  [129466]='V>=8?1:0' [129472]='V>=2?1:0' [129473]='V>=7?1:0' [129475]='V>=8?1:0' [129483]='V>=10?1:0' [129484]='V>=12?1:0'
  [129488]='V>=6?1:0' [129511]='V>=7?1:0' [129536]=0 [129648]='V>=8?1:0' [129652]='V>=10?1:0' [129653]=0 [129656]='V>=8?1:0'
  [129659]='V>=12?1:0' [129661]=0 [129664]='V>=8?1:0' [129667]='V>=10?1:0' [129671]=0 [129680]='V>=8?1:0' [129686]='V>=10?1:0'
  [129705]='V>=12?1:0' [129709]=0 [129712]='V>=10?1:0' [129719]='V>=12?1:0' [129723]=0 [129728]='V>=10?1:0' [129731]='V>=12?1:0'
  [129734]=0 [129744]='V>=10?1:0' [129751]='V>=12?1:0' [129754]=0 [129760]='V>=12?1:0' [129768]=0 [129776]='V>=12?1:0' [129783]=0)
_ble_unicode_EmojiStatus_ranges=(8596 8602 8617 8619 8986 8988 9193 9197 9201 9204 9208 9211 9642 9644 9723 9725 9728 9730 9733
  9748 9750 9762 9764 9784 9787 9800 9812 9829 9833 9878 9885 9898 9900 9904 9906 9917 9919 9924 9926 9968 9970 9975 9979 9992
  9994 10000 10035 10037 10067 10072 10133 10136 10548 10550 11013 11016 11035 11037 127344 127346 127358 127360 127377 127387
  127462 127491 127538 127547 127568 127570 127744 127757 127763 127766 127775 127778 127780 127789 127792 127794 127796 127870
  127872 127892 127894 127900 127902 127904 127947 127951 127956 127968 127985 127992 127995 128000 128012 128015 128017 128108
  128110 128182 128184 128236 128240 128255 128266 128300 128302 128318 128329 128331 128336 128348 128360 128367 128369 128371
  128379 128394 128398 128405 128407 128433 128435 128450 128453 128465 128468 128476 128479 128507 128519 128521 128550 128552
  128558 128560 128577 128581 128592 128641 128643 128650 128657 128667 128676 128686 128697 128705 128710 128717 128721 128723
  128726 128728 128733 128736 128742 128747 128749 128756 128759 128763 128765 128992 129004 129293 129296 129305 129320 129331
  129357 129360 129375 129388 129399 129404 129408 129413 129426 129432 129443 129445 129451 129454 129456 129460 129466 129473
  129475 129488 129511 129536 129648 129653 129656 129659 129661 129664 129667 129671 129680 129686 129705 129709 129712 129719
  129723 129728 129731 129734 129744 129751 129754 129760 129768 129776 129783)
function ble/unicode/EmojiStatus/version2index {
  case $1 in
  (0.6) ret=0 ;;
  (0.7) ret=1 ;;
  (1.0) ret=2 ;;
  (2.0) ret=3 ;;
  (3.0) ret=4 ;;
  (4.0) ret=5 ;;
  (5.0) ret=6 ;;
  (11.0) ret=7 ;;
  (12.0) ret=8 ;;
  (12.1) ret=9 ;;
  (13.0) ret=10 ;;
  (13.1) ret=11 ;;
  (14.0) ret=12 ;;
  (*) return 1 ;;
  esac
}
_ble_unicode_EmojiStatus_version=12
bleopt/declare -n emoji_version 14.0
bleopt/declare -v emoji_width 2
bleopt/declare -v emoji_opts ri
function bleopt/check:emoji_version {
  local ret
  if ! ble/unicode/EmojiStatus/version2index "$value"; then
    local rex='^0*([0-9]+)\.0*([0-9]+)$'
    if ! [[ $value =~ $rex ]]; then
      ble/util/print "bleopt: Invalid format for emoji_version: '$value'." >&2
      return 1
    else
      ble/util/print "bleopt: Unsupported emoji_version: '$value'." >&2
      return 1
    fi
  fi
  _ble_unicode_EmojiStatus_version=$ret
  ((_ble_prompt_version++))
  ble/util/c2w/clear-cache
  return 0
}
function bleopt/check:emoji_width { ble/util/c2w/clear-cache; }
_ble_unicode_EmojiStatus_xIsEmoji='ret&&ret!=_ble_unicode_EmojiStatus_Unqualified'
function bleopt/check:emoji_opts {
  _ble_unicode_EmojiStatus_xIsEmoji='ret'
  [[ :$value: != *:unqualified:* ]] &&
    _ble_unicode_EmojiStatus_xIsEmoji=$_ble_unicode_EmojiStatus_xIsEmoji'&&ret!=_ble_unicode_EmojiStatus_Unqualified'
  local rex=':min=U\+([0-9a-fA-F]+):'
  [[ :$value: =~ $rex ]] &&
    _ble_unicode_EmojiStatus_xIsEmoji=$_ble_unicode_EmojiStatus_xIsEmoji'&&code>=0x'${BASH_REMATCH[1]}
  ((_ble_prompt_version++))
  ble/util/c2w/clear-cache
  return 0
}
function ble/unicode/EmojiStatus {
  local code=$1 V=$_ble_unicode_EmojiStatus_version
  ret=${_ble_unicode_EmojiStatus[code]}
  if [[ ! $ret ]]; then
    ret=$_ble_unicode_EmojiStatus_None
    if ((_ble_unicode_EmojiStatus_xmaybe)); then
      local l=0 u=${#_ble_unicode_EmojiStatus_ranges[@]} m
      while ((l+1<u)); do
        ((_ble_unicode_EmojiStatus_ranges[m=(l+u)/2]<=code?(l=m):(u=m)))
      done
      ret=${_ble_unicode_EmojiStatus[_ble_unicode_EmojiStatus_ranges[l]]:-0}
    fi
    _ble_unicode_EmojiStatus[code]=$ret
  fi
  ((ret=ret))
  return 0
}
function ble/util/c2w/is-emoji {
  local code=$1 ret
  ble/unicode/EmojiStatus "$code"
  ((_ble_unicode_EmojiStatus_xIsEmoji))
}
function ble/util/c2w:west {
  if [[ $bleopt_emoji_width ]] && ble/util/c2w/is-emoji "$1"; then
    ((ret=bleopt_emoji_width))
  else
    ble/unicode/c2w "$1"
  fi
}
function ble/util/c2w:east {
  if [[ $bleopt_emoji_width ]] && ble/util/c2w/is-emoji "$1"; then
    ((ret=bleopt_emoji_width))
  else
    ble/unicode/c2w "$1"
  fi
}
_ble_util_c2w_emacs_wranges=(
 162 164 167 169 172 173 176 178 180 181 182 183 215 216 247 248 272 273 276 279
 280 282 284 286 288 290 293 295 304 305 306 308 315 316 515 516 534 535 545 546
 555 556 608 618 656 660 722 723 724 725 768 769 770 772 775 777 779 780 785 787
 794 795 797 801 805 806 807 813 814 815 820 822 829 830 850 851 864 866 870 872
 874 876 898 900 902 904 933 934 959 960 1042 1043 1065 1067 1376 1396 1536 1540 1548 1549
 1551 1553 1555 1557 1559 1561 1563 1566 1568 1569 1571 1574 1576 1577 1579 1581 1583 1585 1587 1589
 1591 1593 1595 1597 1599 1600 1602 1603 1611 1612 1696 1698 1714 1716 1724 1726 1734 1736 1739 1740
 1742 1744 1775 1776 1797 1799 1856 1857 1858 1859 1898 1899 1901 1902 1903 1904)
function ble/util/c2w:emacs {
  local code=$1
  ret=1
  ((code<0xA0)) && return 0
  if [[ $bleopt_emoji_width ]] && ble/util/c2w/is-emoji "$code"; then
    ((ret=bleopt_emoji_width))
    return 0
  fi
  local al=0 ah=0 tIndex=
  ((
    0x3100<=code&&code<0xA4D0||0xAC00<=code&&code<0xD7A4?(
      ret=2
    ):(0x2000<=code&&code<0x2700?(
      tIndex=0x0100+code-0x2000
    ):(
      al=code&0xFF,
      ah=code/256,
      ah==0x00?(
        tIndex=al
      ):(ah==0x03?(
        ret=0xFF&((al-0x91)&~0x20),
        ret=ret<25&&ret!=17?2:1
      ):(ah==0x04?(
        ret=al==1||0x10<=al&&al<=0x50||al==0x51?2:1
      ):(ah==0x11?(
        ret=al<0x60?2:1
      ):(ah==0x2e?(
        ret=al>=0x80?2:1
      ):(ah==0x2f?(
        ret=2
      ):(ah==0x30?(
        ret=al!=0x3f?2:1
      ):(ah==0xf9||ah==0xfa?(
        ret=2
      ):(ah==0xfe?(
        ret=0x30<=al&&al<0x70?2:1
      ):(ah==0xff?(
        ret=0x01<=al&&al<0x61||0xE0<=al&&al<=0xE7?2:1
      ):(ret=1))))))))))
    ))
  ))
  [[ $tIndex ]] || return 0
  if ((tIndex<_ble_util_c2w_emacs_wranges[0])); then
    ret=1
    return 0
  fi
  local l=0 u=${#_ble_util_c2w_emacs_wranges[@]} m
  while ((l+1<u)); do
    ((_ble_util_c2w_emacs_wranges[m=(l+u)/2]<=tIndex?(l=m):(u=m)))
  done
  ((ret=((l&1)==0)?2:1))
  return 0
}
_ble_util_c2w_musl=([0]=0 [1]=1 [768]=0 [880]=1 [1155]=0 [1162]=1 [1425]=0 [1470]=1 [1471]=0 [1472]=1 [1473]=0 [1475]=1 [1476]=0
  [1478]=1 [1479]=0 [1480]=1 [1536]=0 [1541]=1 [1552]=0 [1563]=1 [1611]=0 [1632]=1 [1648]=0 [1649]=1 [1750]=0 [1758]=1 [1759]=0
  [1765]=1 [1767]=0 [1769]=1 [1770]=0 [1774]=1 [1807]=0 [1808]=1 [1809]=0 [1810]=1 [1840]=0 [1867]=1 [1958]=0 [1969]=1 [2027]=0
  [2036]=1 [2070]=0 [2074]=1 [2075]=0 [2084]=1 [2085]=0 [2088]=1 [2089]=0 [2094]=1 [2137]=0 [2140]=1 [2276]=0 [2303]=1 [2304]=0
  [2307]=1 [2362]=0 [2363]=1 [2364]=0 [2365]=1 [2369]=0 [2377]=1 [2381]=0 [2382]=1 [2385]=0 [2392]=1 [2402]=0 [2404]=1 [2433]=0
  [2434]=1 [2492]=0 [2493]=1 [2497]=0 [2501]=1 [2509]=0 [2510]=1 [2530]=0 [2532]=1 [2561]=0 [2563]=1 [2620]=0 [2621]=1 [2625]=0
  [2627]=1 [2631]=0 [2633]=1 [2635]=0 [2638]=1 [2641]=0 [2642]=1 [2672]=0 [2674]=1 [2677]=0 [2678]=1 [2689]=0 [2691]=1 [2748]=0
  [2749]=1 [2753]=0 [2758]=1 [2759]=0 [2761]=1 [2765]=0 [2766]=1 [2786]=0 [2788]=1 [2817]=0 [2818]=1 [2876]=0 [2877]=1 [2879]=0
  [2880]=1 [2881]=0 [2885]=1 [2893]=0 [2894]=1 [2902]=0 [2903]=1 [2914]=0 [2916]=1 [2946]=0 [2947]=1 [3008]=0 [3009]=1 [3021]=0
  [3022]=1 [3134]=0 [3137]=1 [3142]=0 [3145]=1 [3146]=0 [3150]=1 [3157]=0 [3159]=1 [3170]=0 [3172]=1 [3260]=0 [3261]=1 [3263]=0
  [3264]=1 [3270]=0 [3271]=1 [3276]=0 [3278]=1 [3298]=0 [3300]=1 [3393]=0 [3397]=1 [3405]=0 [3406]=1 [3426]=0 [3428]=1 [3530]=0
  [3531]=1 [3538]=0 [3541]=1 [3542]=0 [3543]=1 [3633]=0 [3634]=1 [3636]=0 [3643]=1 [3655]=0 [3663]=1 [3761]=0 [3762]=1 [3764]=0
  [3770]=1 [3771]=0 [3773]=1 [3784]=0 [3790]=1 [3864]=0 [3866]=1 [3893]=0 [3894]=1 [3895]=0 [3896]=1 [3897]=0 [3898]=1 [3953]=0
  [3967]=1 [3968]=0 [3973]=1 [3974]=0 [3976]=1 [3981]=0 [3992]=1 [3993]=0 [4029]=1 [4038]=0 [4039]=1 [4141]=0 [4145]=1 [4146]=0
  [4152]=1 [4153]=0 [4155]=1 [4157]=0 [4159]=1 [4184]=0 [4186]=1 [4190]=0 [4193]=1 [4209]=0 [4213]=1 [4226]=0 [4227]=1 [4229]=0
  [4231]=1 [4237]=0 [4238]=1 [4253]=0 [4254]=1 [4352]=2 [4448]=1 [4515]=2 [4520]=1 [4602]=2 [4608]=1 [4957]=0 [4960]=1 [5906]=0
  [5909]=1 [5938]=0 [5941]=1 [5970]=0 [5972]=1 [6002]=0 [6004]=1 [6068]=0 [6070]=1 [6071]=0 [6078]=1 [6086]=0 [6087]=1 [6089]=0
  [6100]=1 [6109]=0 [6110]=1 [6155]=0 [6158]=1 [6313]=0 [6314]=1 [6432]=0 [6435]=1 [6439]=0 [6441]=1 [6450]=0 [6451]=1 [6457]=0
  [6460]=1 [6679]=0 [6681]=1 [6742]=0 [6743]=1 [6744]=0 [6751]=1 [6752]=0 [6753]=1 [6754]=0 [6755]=1 [6757]=0 [6765]=1 [6771]=0
  [6781]=1 [6783]=0 [6784]=1 [6912]=0 [6916]=1 [6964]=0 [6965]=1 [6966]=0 [6971]=1 [6972]=0 [6973]=1 [6978]=0 [6979]=1 [7019]=0
  [7028]=1 [7040]=0 [7042]=1 [7074]=0 [7078]=1 [7080]=0 [7082]=1 [7083]=0 [7084]=1 [7142]=0 [7143]=1 [7144]=0 [7146]=1 [7149]=0
  [7150]=1 [7151]=0 [7154]=1 [7212]=0 [7220]=1 [7222]=0 [7224]=1 [7376]=0 [7379]=1 [7380]=0 [7393]=1 [7394]=0 [7401]=1 [7405]=0
  [7406]=1 [7412]=0 [7413]=1 [7616]=0 [7655]=1 [7676]=0 [7680]=1 [8203]=0 [8208]=1 [8234]=0 [8239]=1 [8288]=0 [8293]=1 [8298]=0
  [8304]=1 [8400]=0 [8433]=1 [9001]=2 [9003]=1 [11503]=0 [11506]=1 [11647]=0 [11648]=1 [11744]=0 [11776]=1 [11904]=2 [11930]=1
  [11931]=2 [12020]=1 [12032]=2 [12246]=1 [12272]=2 [12284]=1 [12288]=2 [12330]=0 [12334]=2 [12351]=1 [12353]=2 [12439]=1
  [12441]=0 [12443]=2 [12544]=1 [12549]=2 [12590]=1 [12593]=2 [12687]=1 [12688]=2 [12731]=1 [12736]=2 [12772]=1 [12784]=2
  [12831]=1 [12832]=2 [12872]=1 [12880]=2 [13055]=1 [13056]=2 [19904]=1 [19968]=2 [42125]=1 [42128]=2 [42183]=1 [42607]=0
  [42611]=1 [42612]=0 [42622]=1 [42655]=0 [42656]=1 [42736]=0 [42738]=1 [43010]=0 [43011]=1 [43014]=0 [43015]=1 [43019]=0
  [43020]=1 [43045]=0 [43047]=1 [43204]=0 [43205]=1 [43232]=0 [43250]=1 [43302]=0 [43310]=1 [43335]=0 [43346]=1 [43360]=2
  [43389]=1 [43392]=0 [43395]=1 [43443]=0 [43444]=1 [43446]=0 [43450]=1 [43452]=0 [43453]=1 [43561]=0 [43567]=1 [43569]=0
  [43571]=1 [43573]=0 [43575]=1 [43587]=0 [43588]=1 [43596]=0 [43597]=1 [43696]=0 [43697]=1 [43698]=0 [43701]=1 [43703]=0
  [43705]=1 [43710]=0 [43712]=1 [43713]=0 [43714]=1 [43756]=0 [43758]=1 [43766]=0 [43767]=1 [44005]=0 [44006]=1 [44008]=0
  [44009]=1 [44013]=0 [44014]=1 [44032]=2 [55204]=1 [55216]=2 [55239]=1 [55243]=2 [55292]=1 [63744]=2 [64256]=1 [64286]=0
  [64287]=1 [65024]=0 [65040]=2 [65050]=1 [65056]=0 [65063]=1 [65072]=2 [65107]=1 [65108]=2 [65127]=1 [65128]=2 [65132]=1
  [65279]=0 [65280]=1 [65281]=2 [65377]=1 [65504]=2 [65511]=1 [65529]=0 [65532]=1 [66045]=0 [66046]=1 [68097]=0 [68100]=1
  [68101]=0 [68103]=1 [68108]=0 [68112]=1 [68152]=0 [68155]=1 [68159]=0 [68160]=1 [69633]=0 [69634]=1 [69688]=0 [69703]=1
  [69760]=0 [69762]=1 [69811]=0 [69815]=1 [69817]=0 [69819]=1 [69821]=0 [69822]=1 [69888]=0 [69891]=1 [69927]=0 [69932]=1
  [69933]=0 [69941]=1 [70016]=0 [70018]=1 [70070]=0 [70079]=1 [71339]=0 [71340]=1 [71341]=0 [71342]=1 [71344]=0 [71350]=1
  [71351]=0 [71352]=1 [94095]=0 [94099]=1 [110592]=2 [110594]=1 [119143]=0 [119146]=1 [119155]=0 [119171]=1 [119173]=0 [119180]=1
  [119210]=0 [119214]=1 [119362]=0 [119365]=1 [127488]=2 [127491]=1 [127504]=2 [127547]=1 [127552]=2 [127561]=1 [127568]=2
  [127570]=1 [131072]=2 [196606]=1 [196608]=2 [262142]=1 [262144]=0 [327678]=1 [327680]=0 [393214]=1 [393216]=0 [458750]=1
  [458752]=0 [524286]=1 [524288]=0 [589822]=1 [589824]=0 [655358]=1 [655360]=0 [720894]=1 [720896]=0 [786430]=1 [786432]=0
  [851966]=1 [851968]=0 [917502]=1 [917504]=0 [917999]=1)
_ble_util_c2w_musl_ranges=(0 1 768 880 1155 1162 1425 1470 1471 1472 1473 1475 1476 1478 1479 1480 1536 1541 1552 1563 1611 1632
  1648 1649 1750 1758 1759 1765 1767 1769 1770 1774 1807 1808 1809 1810 1840 1867 1958 1969 2027 2036 2070 2074 2075 2084 2085
  2088 2089 2094 2137 2140 2276 2303 2304 2307 2362 2363 2364 2365 2369 2377 2381 2382 2385 2392 2402 2404 2433 2434 2492 2493
  2497 2501 2509 2510 2530 2532 2561 2563 2620 2621 2625 2627 2631 2633 2635 2638 2641 2642 2672 2674 2677 2678 2689 2691 2748
  2749 2753 2758 2759 2761 2765 2766 2786 2788 2817 2818 2876 2877 2879 2880 2881 2885 2893 2894 2902 2903 2914 2916 2946 2947
  3008 3009 3021 3022 3134 3137 3142 3145 3146 3150 3157 3159 3170 3172 3260 3261 3263 3264 3270 3271 3276 3278 3298 3300 3393
  3397 3405 3406 3426 3428 3530 3531 3538 3541 3542 3543 3633 3634 3636 3643 3655 3663 3761 3762 3764 3770 3771 3773 3784 3790
  3864 3866 3893 3894 3895 3896 3897 3898 3953 3967 3968 3973 3974 3976 3981 3992 3993 4029 4038 4039 4141 4145 4146 4152 4153
  4155 4157 4159 4184 4186 4190 4193 4209 4213 4226 4227 4229 4231 4237 4238 4253 4254 4352 4448 4515 4520 4602 4608 4957 4960
  5906 5909 5938 5941 5970 5972 6002 6004 6068 6070 6071 6078 6086 6087 6089 6100 6109 6110 6155 6158 6313 6314 6432 6435 6439
  6441 6450 6451 6457 6460 6679 6681 6742 6743 6744 6751 6752 6753 6754 6755 6757 6765 6771 6781 6783 6784 6912 6916 6964 6965
  6966 6971 6972 6973 6978 6979 7019 7028 7040 7042 7074 7078 7080 7082 7083 7084 7142 7143 7144 7146 7149 7150 7151 7154 7212
  7220 7222 7224 7376 7379 7380 7393 7394 7401 7405 7406 7412 7413 7616 7655 7676 7680 8203 8208 8234 8239 8288 8293 8298 8304
  8400 8433 9001 9003 11503 11506 11647 11648 11744 11776 11904 11930 11931 12020 12032 12246 12272 12284 12288 12330 12334 12351
  12353 12439 12441 12443 12544 12549 12590 12593 12687 12688 12731 12736 12772 12784 12831 12832 12872 12880 13055 13056 19904
  19968 42125 42128 42183 42607 42611 42612 42622 42655 42656 42736 42738 43010 43011 43014 43015 43019 43020 43045 43047 43204
  43205 43232 43250 43302 43310 43335 43346 43360 43389 43392 43395 43443 43444 43446 43450 43452 43453 43561 43567 43569 43571
  43573 43575 43587 43588 43596 43597 43696 43697 43698 43701 43703 43705 43710 43712 43713 43714 43756 43758 43766 43767 44005
  44006 44008 44009 44013 44014 44032 55204 55216 55239 55243 55292 63744 64256 64286 64287 65024 65040 65050 65056 65063 65072
  65107 65108 65127 65128 65132 65279 65280 65281 65377 65504 65511 65529 65532 66045 66046 68097 68100 68101 68103 68108 68112
  68152 68155 68159 68160 69633 69634 69688 69703 69760 69762 69811 69815 69817 69819 69821 69822 69888 69891 69927 69932 69933
  69941 70016 70018 70070 70079 71339 71340 71341 71342 71344 71350 71351 71352 94095 94099 110592 110594 119143 119146 119155
  119171 119173 119180 119210 119214 119362 119365 127488 127491 127504 127547 127552 127561 127568 127570 131072 196606 196608
  262142 262144 327678 327680 393214 393216 458750 458752 524286 524288 589822 589824 655358 655360 720894 720896 786430 786432
  851966 851968 917502 917504 917999)
function ble/util/c2w:musl {
  local code=$1
  ret=1
  ((code&&code<0x300)) && return 0
  if [[ $bleopt_emoji_width ]] && ble/util/c2w/is-emoji "$code"; then
    ((ret=bleopt_emoji_width))
    return 0
  fi
  local l=0 u=${#_ble_util_c2w_musl_ranges[@]} m
  while ((l+1<u)); do
    ((_ble_util_c2w_musl_ranges[m=(l+u)/2]<=code?(l=m):(u=m)))
  done
  ret=${_ble_util_c2w_musl[_ble_util_c2w_musl_ranges[l]]}
}
_ble_util_c2w_auto_update_x0=0
_ble_util_c2w_auto_update_result=()
_ble_util_c2w_auto_update_processing=0
function ble/util/c2w:auto {
  if [[ $bleopt_emoji_width ]] && ble/util/c2w/is-emoji "$1"; then
    ((ret=bleopt_emoji_width))
  else
    ble/unicode/c2w "$1"
  fi
}
function ble/util/c2w:auto/check {
  [[ $bleopt_char_width_mode == auto || $bleopt_char_width_version == auto ]] &&
    ble/util/c2w:auto/test.buff
  return 0
}
function ble/util/c2w:auto/test.buff {
  local opts=$1
  local -a DRAW_BUFF=()
  local ret saved_pos=
  ((_ble_util_c2w_auto_update_processing)) && return 0
  [[ $_ble_attached ]] && { ble/canvas/panel/save-position goto-top-dock; saved_pos=$ret; }
  ble/canvas/put.draw "$_ble_term_sc"
  if ble/util/is-unicode-output; then
    local -a codes=(
      0x25bd 0x25b6
      0x9FBC 0x9FC4 0x31B8 0xD7B0 0x3099
      0x9FCD 0x1F93B 0x312E 0x312F 0x16FE2
      0x32FF 0x31BB 0x9FFD)
    _ble_util_c2w_auto_update_processing=${#codes[@]}
    _ble_util_c2w_auto_update_result=()
    if [[ :$opts: == *:first-line:* ]]; then
      local cols=${COLUMNS:-80}
      local x0=$((cols-4)); ((x0<0)) && x0=0
      _ble_util_c2w_auto_update_x0=$x0
      local code index=0
      for code in "${codes[@]}"; do
        ble/canvas/put-cup.draw 1 $((x0+1))
        ble/canvas/put.draw "$_ble_term_el"
        ble/util/c2s $((code))
        ble/canvas/put.draw "$ret"
        ble/term/CPR/request.draw "ble/util/c2w/test.hook $((index++))"
      done
      ble/canvas/put-cup.draw 1 $((x0+1))
      ble/canvas/put.draw "$_ble_term_el"
    else
      _ble_util_c2w_auto_update_x0=2
      local code index=0
      for code in "${codes[@]}"; do
        ble/util/c2s $((code))
        ble/canvas/put.draw "$_ble_term_cr$_ble_term_el[$ret]"
        ble/term/CPR/request.draw "ble/util/c2w/test.hook $((index++))"
      done
      ble/canvas/put.draw "$_ble_term_cr$_ble_term_el"
    fi
  fi
  ble/canvas/put.draw "$_ble_term_rc"
  [[ $_ble_attached ]] && ble/canvas/panel/load-position.draw "$saved_pos"
  ble/canvas/bflush.draw
}
function ble/util/c2w/test.hook {
  local index=$1 l=$2 c=$3
  local w=$((c-1-_ble_util_c2w_auto_update_x0))
  _ble_util_c2w_auto_update_result[index]=$w
  ((index==_ble_util_c2w_auto_update_processing-1)) || return 0
  _ble_util_c2w_auto_update_processing=0
  local ws
  if [[ $bleopt_char_width_mode == auto ]]; then
    IFS=: builtin eval 'ws="${_ble_util_c2w_auto_update_result[*]::2}:${_ble_util_c2w_auto_update_result[*]:5:2}"'
    case $ws in
    (2:2:*:*) bleopt char_width_mode=east ;;
    (2:1:*:*) bleopt char_width_mode=emacs ;;
    (1:1:2:0) bleopt char_width_mode=musl ;;
    (*)       bleopt char_width_mode=west ;;
    esac
  fi
  if [[ $bleopt_char_width_version == auto ]]; then
    ws=("${_ble_util_c2w_auto_update_result[@]:2}")
    if ((ws[11]==2)); then
      if ((ws[12]==2)); then
        bleopt char_width_version=14.0
      else
        bleopt char_width_version=13.0
      fi
    elif ((ws[10]==2)); then
      bleopt char_width_version=12.1
    elif ((ws[9]==2)); then
      bleopt char_width_version=12.0
    elif ((ws[8]==2)); then
      bleopt char_width_version=11.0
    elif ((ws[7]==2)); then
      bleopt char_width_version=10.0
    elif ((ws[6]==2)); then
      bleopt char_width_version=9.0
    elif ((ws[4]==0)); then
      if ((ws[5]==2)); then
        bleopt char_width_version=8.0
      else
        bleopt char_width_version=7.0
      fi
    elif ((ws[3]==1&&ws[1]==2)); then
      bleopt char_width_version=6.3 # or 6.2
    elif ((ws[2]==2)); then
      bleopt char_width_version=6.1 # or 6.0
    elif ((ws[1]==2)); then
      bleopt char_width_version=5.2
    elif ((ws[0]==2)); then
      bleopt char_width_version=5.0
    else
      bleopt char_width_version=4.1
    fi
  fi
  return 0
}
bleopt/declare -v grapheme_cluster extended
function bleopt/check:grapheme_cluster {
  case $value in
  (extended|legacy|'') return 0 ;;
  (*)
    ble/util/print "bleopt: invalid value for grapheme_cluster: '$value'." >&2
    return 1 ;;
  esac
}
_ble_unicode_GraphemeClusterBreak_Count=13
_ble_unicode_GraphemeClusterBreak_ZWJ=2
_ble_unicode_GraphemeClusterBreak_Regional_Indicator=6
_ble_unicode_GraphemeClusterBreak_Prepend=3
_ble_unicode_GraphemeClusterBreak_SpacingMark=5
_ble_unicode_GraphemeClusterBreak_LVT=11
_ble_unicode_GraphemeClusterBreak_Pictographic=12
_ble_unicode_GraphemeClusterBreak_LV=10
_ble_unicode_GraphemeClusterBreak_T=9
_ble_unicode_GraphemeClusterBreak_V=8
_ble_unicode_GraphemeClusterBreak_Control=1
_ble_unicode_GraphemeClusterBreak_Extend=4
_ble_unicode_GraphemeClusterBreak_Other=0
_ble_unicode_GraphemeClusterBreak_L=7
_ble_unicode_GraphemeClusterBreak_MaxCode=921600
_ble_unicode_GraphemeClusterBreak=(
  [169]=12 [173]=1 [174]=12 [1470]=0 [1471]=4 [1472]=0 [1473]=4 [1474]=4 [1475]=0 [1476]=4 [1477]=4 [1478]=0 [1479]=4 [1563]=0 [1564]=1 [1648]=4 
  [1757]=3 [1758]=0 [1765]=0 [1766]=0 [1767]=4 [1768]=4 [1769]=0 [1807]=3 [1808]=0 [1809]=4 [2045]=4 [2074]=0 [2084]=0 [2088]=0 [2274]=3 [2307]=5 
  [2362]=4 [2363]=5 [2364]=4 [2365]=0 [2381]=4 [2382]=5 [2383]=5 [2384]=0 [2402]=4 [2403]=4 [2433]=4 [2434]=5 [2435]=5 [2492]=4 [2493]=0 [2494]=4 
  [2495]=5 [2496]=5 [2501]=0 [2502]=0 [2503]=5 [2504]=5 [2505]=0 [2506]=0 [2507]=5 [2508]=5 [2509]=4 [2519]=4 [2530]=4 [2531]=4 [2558]=4 [2559]=0 
  [2560]=0 [2561]=4 [2562]=4 [2563]=5 [2620]=4 [2621]=0 [2625]=4 [2626]=4 [2631]=4 [2632]=4 [2633]=0 [2634]=0 [2641]=4 [2672]=4 [2673]=4 [2677]=4 
  [2689]=4 [2690]=4 [2691]=5 [2748]=4 [2749]=0 [2758]=0 [2759]=4 [2760]=4 [2761]=5 [2762]=0 [2763]=5 [2764]=5 [2765]=4 [2786]=4 [2787]=4 [2816]=0 
  [2817]=4 [2818]=5 [2819]=5 [2876]=4 [2877]=0 [2878]=4 [2879]=4 [2880]=5 [2885]=0 [2886]=0 [2887]=5 [2888]=5 [2889]=0 [2890]=0 [2891]=5 [2892]=5 
  [2893]=4 [2914]=4 [2915]=4 [2946]=4 [3006]=4 [3007]=5 [3008]=4 [3009]=5 [3010]=5 [3017]=0 [3021]=4 [3031]=4 [3072]=4 [3076]=4 [3141]=0 [3145]=0 
  [3157]=4 [3158]=4 [3170]=4 [3171]=4 [3201]=4 [3202]=5 [3203]=5 [3260]=4 [3261]=0 [3262]=5 [3263]=4 [3264]=5 [3265]=5 [3266]=4 [3267]=5 [3268]=5 
  [3269]=0 [3270]=4 [3271]=5 [3272]=5 [3273]=0 [3274]=5 [3275]=5 [3276]=4 [3277]=4 [3285]=4 [3286]=4 [3298]=4 [3299]=4 [3328]=4 [3329]=4 [3330]=5 
  [3331]=5 [3387]=4 [3388]=4 [3389]=0 [3390]=4 [3391]=5 [3392]=5 [3397]=0 [3401]=0 [3405]=4 [3406]=3 [3415]=4 [3426]=4 [3427]=4 [3457]=4 [3458]=5 
  [3459]=5 [3530]=4 [3535]=4 [3536]=5 [3537]=5 [3541]=0 [3542]=4 [3543]=0 [3551]=4 [3570]=5 [3571]=5 [3633]=4 [3634]=0 [3635]=5 [3761]=4 [3762]=0 
  [3763]=5 [3864]=4 [3865]=4 [3893]=4 [3894]=0 [3895]=4 [3896]=0 [3897]=4 [3902]=5 [3903]=5 [3967]=5 [3973]=0 [3974]=4 [3975]=4 [3992]=0 [4038]=4 
  [4145]=5 [4152]=0 [4153]=4 [4154]=4 [4155]=5 [4156]=5 [4157]=4 [4158]=4 [4182]=5 [4183]=5 [4184]=4 [4185]=4 [4226]=4 [4227]=0 [4228]=5 [4229]=4 
  [4230]=4 [4237]=4 [4253]=4 [5970]=4 [5971]=4 [6002]=4 [6003]=4 [6068]=4 [6069]=4 [6070]=5 [6086]=4 [6087]=5 [6088]=5 [6109]=4 [6158]=1 [6277]=4 
  [6278]=4 [6313]=4 [6439]=4 [6440]=4 [6448]=5 [6449]=5 [6450]=4 [6679]=4 [6680]=4 [6681]=5 [6682]=5 [6683]=4 [6741]=5 [6742]=4 [6743]=5 [6751]=0 
  [6752]=4 [6753]=0 [6754]=4 [6755]=0 [6756]=0 [6781]=0 [6782]=0 [6783]=4 [6916]=5 [6971]=5 [6972]=4 [6978]=4 [6979]=5 [6980]=5 [7040]=4 [7041]=4 
  [7042]=5 [7073]=5 [7078]=5 [7079]=5 [7080]=4 [7081]=4 [7082]=5 [7142]=4 [7143]=5 [7144]=4 [7145]=4 [7149]=4 [7150]=5 [7154]=5 [7155]=5 [7220]=5 
  [7221]=5 [7222]=4 [7223]=4 [7379]=0 [7393]=5 [7405]=4 [7412]=4 [7413]=0 [7414]=0 [7415]=5 [7416]=4 [7417]=4 [7674]=0 [8203]=1 [8204]=4 [8205]=2 
  [8206]=1 [8207]=1 [8252]=12 [8265]=12 [8482]=12 [8505]=12 [8617]=12 [8618]=12 [8986]=12 [8987]=12 [9000]=12 [9096]=12 [9167]=12 [9410]=12 [9642]=12 [9643]=12 
  [9654]=12 [9664]=12 [9727]=0 [9734]=0 [9747]=0 [9990]=0 [9991]=0 [10003]=0 [10004]=12 [10005]=0 [10006]=12 [10013]=12 [10017]=12 [10024]=12 [10035]=12 [10036]=12 
  [10052]=12 [10053]=0 [10054]=0 [10055]=12 [10060]=12 [10061]=0 [10062]=12 [10070]=0 [10071]=12 [10145]=12 [10160]=12 [10175]=12 [10548]=12 [10549]=12 [11035]=12 [11036]=12 
  [11088]=12 [11093]=12 [11647]=4 [12336]=12 [12349]=12 [12441]=4 [12442]=4 [12951]=12 [12952]=0 [12953]=12 [42611]=0 [42654]=4 [42655]=4 [42736]=4 [42737]=4 [43010]=4 
  [43014]=4 [43019]=4 [43043]=5 [43044]=5 [43045]=4 [43046]=4 [43047]=5 [43052]=4 [43136]=5 [43137]=5 [43204]=4 [43205]=4 [43263]=4 [43346]=5 [43347]=5 [43395]=5 
  [43443]=4 [43444]=5 [43445]=5 [43450]=5 [43451]=5 [43452]=4 [43453]=4 [43493]=4 [43567]=5 [43568]=5 [43569]=4 [43570]=4 [43571]=5 [43572]=5 [43573]=4 [43574]=4 
  [43587]=4 [43596]=4 [43597]=5 [43644]=4 [43696]=4 [43697]=0 [43701]=0 [43702]=0 [43703]=4 [43704]=4 [43710]=4 [43711]=4 [43712]=0 [43713]=4 [43755]=5 [43756]=4 
  [43757]=4 [43758]=5 [43759]=5 [43765]=5 [43766]=4 [44003]=5 [44004]=5 [44005]=4 [44006]=5 [44007]=5 [44008]=4 [44009]=5 [44010]=5 [44011]=0 [44012]=5 [44013]=4 
  [44032]=10 [44060]=10 [44088]=10 [44116]=10 [44144]=10 [44172]=10 [44200]=10 [44228]=10 [44256]=10 [44284]=10 [44312]=10 [44340]=10 [44368]=10 [44396]=10 [44424]=10 [44452]=10 
  [44480]=10 [44508]=10 [44536]=10 [44564]=10 [44592]=10 [44620]=10 [44648]=10 [44676]=10 [44704]=10 [44732]=10 [44760]=10 [44788]=10 [44816]=10 [44844]=10 [44872]=10 [44900]=10 
  [44928]=10 [44956]=10 [44984]=10 [45012]=10 [45040]=10 [45068]=10 [45096]=10 [45124]=10 [45152]=10 [45180]=10 [45208]=10 [45236]=10 [45264]=10 [45292]=10 [45320]=10 [45348]=10 
  [45376]=10 [45404]=10 [45432]=10 [45460]=10 [45488]=10 [45516]=10 [45544]=10 [45572]=10 [45600]=10 [45628]=10 [45656]=10 [45684]=10 [45712]=10 [45740]=10 [45768]=10 [45796]=10 
  [45824]=10 [45852]=10 [45880]=10 [45908]=10 [45936]=10 [45964]=10 [45992]=10 [46020]=10 [46048]=10 [46076]=10 [46104]=10 [46132]=10 [46160]=10 [46188]=10 [46216]=10 [46244]=10 
  [46272]=10 [46300]=10 [46328]=10 [46356]=10 [46384]=10 [46412]=10 [46440]=10 [46468]=10 [46496]=10 [46524]=10 [46552]=10 [46580]=10 [46608]=10 [46636]=10 [46664]=10 [46692]=10 
  [46720]=10 [46748]=10 [46776]=10 [46804]=10 [46832]=10 [46860]=10 [46888]=10 [46916]=10 [46944]=10 [46972]=10 [47000]=10 [47028]=10 [47056]=10 [47084]=10 [47112]=10 [47140]=10 
  [47168]=10 [47196]=10 [47224]=10 [47252]=10 [47280]=10 [47308]=10 [47336]=10 [47364]=10 [47392]=10 [47420]=10 [47448]=10 [47476]=10 [47504]=10 [47532]=10 [47560]=10 [47588]=10 
  [47616]=10 [47644]=10 [47672]=10 [47700]=10 [47728]=10 [47756]=10 [47784]=10 [47812]=10 [47840]=10 [47868]=10 [47896]=10 [47924]=10 [47952]=10 [47980]=10 [48008]=10 [48036]=10 
  [48064]=10 [48092]=10 [48120]=10 [48148]=10 [48176]=10 [48204]=10 [48232]=10 [48260]=10 [48288]=10 [48316]=10 [48344]=10 [48372]=10 [48400]=10 [48428]=10 [48456]=10 [48484]=10 
  [48512]=10 [48540]=10 [48568]=10 [48596]=10 [48624]=10 [48652]=10 [48680]=10 [48708]=10 [48736]=10 [48764]=10 [48792]=10 [48820]=10 [48848]=10 [48876]=10 [48904]=10 [48932]=10 
  [48960]=10 [48988]=10 [49016]=10 [49044]=10 [49072]=10 [49100]=10 [49128]=10 [49156]=10 [49184]=10 [49212]=10 [49240]=10 [49268]=10 [49296]=10 [49324]=10 [49352]=10 [49380]=10 
  [49408]=10 [49436]=10 [49464]=10 [49492]=10 [49520]=10 [49548]=10 [49576]=10 [49604]=10 [49632]=10 [49660]=10 [49688]=10 [49716]=10 [49744]=10 [49772]=10 [49800]=10 [49828]=10 
  [49856]=10 [49884]=10 [49912]=10 [49940]=10 [49968]=10 [49996]=10 [50024]=10 [50052]=10 [50080]=10 [50108]=10 [50136]=10 [50164]=10 [50192]=10 [50220]=10 [50248]=10 [50276]=10 
  [50304]=10 [50332]=10 [50360]=10 [50388]=10 [50416]=10 [50444]=10 [50472]=10 [50500]=10 [50528]=10 [50556]=10 [50584]=10 [50612]=10 [50640]=10 [50668]=10 [50696]=10 [50724]=10 
  [50752]=10 [50780]=10 [50808]=10 [50836]=10 [50864]=10 [50892]=10 [50920]=10 [50948]=10 [50976]=10 [51004]=10 [51032]=10 [51060]=10 [51088]=10 [51116]=10 [51144]=10 [51172]=10 
  [51200]=10 [51228]=10 [51256]=10 [51284]=10 [51312]=10 [51340]=10 [51368]=10 [51396]=10 [51424]=10 [51452]=10 [51480]=10 [51508]=10 [51536]=10 [51564]=10 [51592]=10 [51620]=10 
  [51648]=10 [51676]=10 [51704]=10 [51732]=10 [51760]=10 [51788]=10 [51816]=10 [51844]=10 [51872]=10 [51900]=10 [51928]=10 [51956]=10 [51984]=10 [52012]=10 [52040]=10 [52068]=10 
  [52096]=10 [52124]=10 [52152]=10 [52180]=10 [52208]=10 [52236]=10 [52264]=10 [52292]=10 [52320]=10 [52348]=10 [52376]=10 [52404]=10 [52432]=10 [52460]=10 [52488]=10 [52516]=10 
  [52544]=10 [52572]=10 [52600]=10 [52628]=10 [52656]=10 [52684]=10 [52712]=10 [52740]=10 [52768]=10 [52796]=10 [52824]=10 [52852]=10 [52880]=10 [52908]=10 [52936]=10 [52964]=10 
  [52992]=10 [53020]=10 [53048]=10 [53076]=10 [53104]=10 [53132]=10 [53160]=10 [53188]=10 [53216]=10 [53244]=10 [53272]=10 [53300]=10 [53328]=10 [53356]=10 [53384]=10 [53412]=10 
  [53440]=10 [53468]=10 [53496]=10 [53524]=10 [53552]=10 [53580]=10 [53608]=10 [53636]=10 [53664]=10 [53692]=10 [53720]=10 [53748]=10 [53776]=10 [53804]=10 [53832]=10 [53860]=10 
  [53888]=10 [53916]=10 [53944]=10 [53972]=10 [54000]=10 [54028]=10 [54056]=10 [54084]=10 [54112]=10 [54140]=10 [54168]=10 [54196]=10 [54224]=10 [54252]=10 [54280]=10 [54308]=10 
  [54336]=10 [54364]=10 [54392]=10 [54420]=10 [54448]=10 [54476]=10 [54504]=10 [54532]=10 [54560]=10 [54588]=10 [54616]=10 [54644]=10 [54672]=10 [54700]=10 [54728]=10 [54756]=10 
  [54784]=10 [54812]=10 [54840]=10 [54868]=10 [54896]=10 [54924]=10 [54952]=10 [54980]=10 [55008]=10 [55036]=10 [55064]=10 [55092]=10 [55120]=10 [55148]=10 [55176]=10 [64286]=4 
  [65279]=1 [65438]=4 [65439]=4 [66045]=4 [66272]=4 [68100]=0 [68101]=4 [68102]=4 [68159]=4 [68325]=4 [68326]=4 [69291]=4 [69292]=4 [69632]=5 [69633]=4 [69634]=5 
  [69762]=5 [69815]=5 [69816]=5 [69817]=4 [69818]=4 [69819]=0 [69820]=0 [69821]=3 [69837]=3 [69932]=5 [69957]=5 [69958]=5 [70003]=4 [70016]=4 [70017]=4 [70018]=5 
  [70079]=5 [70080]=5 [70081]=0 [70082]=3 [70083]=3 [70093]=0 [70094]=5 [70095]=4 [70194]=5 [70195]=5 [70196]=4 [70197]=5 [70198]=4 [70199]=4 [70206]=4 [70367]=4 
  [70400]=4 [70401]=4 [70402]=5 [70403]=5 [70459]=4 [70460]=4 [70461]=0 [70462]=4 [70463]=5 [70464]=4 [70469]=0 [70470]=0 [70471]=5 [70472]=5 [70473]=0 [70474]=0 
  [70487]=4 [70498]=5 [70499]=5 [70500]=0 [70501]=0 [70720]=5 [70721]=5 [70725]=5 [70726]=4 [70750]=4 [70832]=4 [70833]=5 [70834]=5 [70841]=5 [70842]=4 [70843]=5 
  [70844]=5 [70845]=4 [70846]=5 [70847]=4 [70848]=4 [70849]=5 [70850]=4 [70851]=4 [71087]=4 [71088]=5 [71089]=5 [71094]=0 [71095]=0 [71100]=4 [71101]=4 [71102]=5 
  [71103]=4 [71104]=4 [71132]=4 [71133]=4 [71227]=5 [71228]=5 [71229]=4 [71230]=5 [71231]=4 [71232]=4 [71339]=4 [71340]=5 [71341]=4 [71342]=5 [71343]=5 [71350]=5 
  [71351]=4 [71456]=5 [71457]=5 [71462]=5 [71736]=5 [71737]=4 [71738]=4 [71984]=4 [71990]=0 [71991]=5 [71992]=5 [71993]=0 [71994]=0 [71995]=4 [71996]=4 [71997]=5 
  [71998]=4 [71999]=3 [72000]=5 [72001]=3 [72002]=5 [72003]=4 [72152]=0 [72153]=0 [72154]=4 [72155]=4 [72160]=4 [72164]=5 [72249]=5 [72250]=3 [72263]=4 [72279]=5 
  [72280]=5 [72343]=5 [72344]=4 [72345]=4 [72751]=5 [72759]=0 [72766]=5 [72767]=4 [72872]=0 [72873]=5 [72881]=5 [72882]=4 [72883]=4 [72884]=5 [72885]=4 [72886]=4 
  [73018]=4 [73019]=0 [73020]=4 [73021]=4 [73022]=0 [73030]=3 [73031]=4 [73103]=0 [73104]=4 [73105]=4 [73106]=0 [73107]=5 [73108]=5 [73109]=4 [73110]=5 [73111]=4 
  [73459]=4 [73460]=4 [73461]=5 [73462]=5 [94031]=4 [94032]=0 [94180]=4 [94192]=5 [94193]=5 [113821]=4 [113822]=4 [113823]=0 [119141]=4 [119142]=5 [119149]=5 [119171]=0 
  [119172]=0 [121461]=4 [121476]=4 [121504]=0 [122887]=0 [122905]=0 [122906]=0 [122914]=0 [122915]=4 [122916]=4 [122917]=0 [127279]=12 [127358]=12 [127359]=12 [127374]=12 [127375]=0 
  [127376]=0 [127488]=0 [127514]=12 [127535]=12 [127536]=0 [127537]=0 [127547]=0 [129339]=0 [129350]=0 
  [0]=1 [32]=0 [127]=1 [160]=0 [768]=4 [880]=0 [1155]=4 [1162]=0 [1425]=4 [1480]=0 [1536]=3 [1542]=0 [1552]=4 [1565]=0 [1611]=4 [1632]=0 
  [1750]=4 [1774]=0 [1840]=4 [1867]=0 [1958]=4 [1969]=0 [2027]=4 [2036]=0 [2070]=4 [2094]=0 [2137]=4 [2140]=0 [2259]=4 [2308]=0 [2366]=5 [2369]=4 
  [2377]=5 [2385]=4 [2392]=0 [2497]=4 [2510]=0 [2622]=5 [2627]=0 [2635]=4 [2638]=0 [2750]=5 [2753]=4 [2766]=0 [2810]=4 [2820]=0 [2881]=4 [2894]=0 
  [2901]=4 [2904]=0 [3014]=5 [3022]=0 [3073]=5 [3077]=0 [3134]=4 [3137]=5 [3142]=4 [3150]=0 [3393]=4 [3398]=5 [3407]=0 [3538]=4 [3544]=5 [3552]=0 
  [3636]=4 [3643]=0 [3655]=4 [3663]=0 [3764]=4 [3773]=0 [3784]=4 [3790]=0 [3953]=4 [3976]=0 [3981]=4 [4029]=0 [4141]=4 [4159]=0 [4190]=4 [4193]=0 
  [4209]=4 [4213]=0 [4352]=7 [4448]=8 [4520]=9 [4608]=0 [4957]=4 [4960]=0 [5906]=4 [5909]=0 [5938]=4 [5941]=0 [6071]=4 [6078]=5 [6089]=4 [6100]=0 
  [6155]=4 [6159]=0 [6432]=4 [6435]=5 [6444]=0 [6451]=5 [6457]=4 [6460]=0 [6744]=4 [6765]=5 [6771]=4 [6784]=0 [6832]=4 [6849]=0 [6912]=4 [6917]=0 
  [6964]=4 [6973]=5 [6981]=0 [7019]=4 [7028]=0 [7074]=4 [7086]=0 [7146]=5 [7151]=4 [7156]=0 [7204]=5 [7212]=4 [7224]=0 [7376]=4 [7401]=0 [7616]=4 
  [7680]=0 [8232]=1 [8239]=0 [8288]=1 [8304]=0 [8400]=4 [8433]=0 [8596]=12 [8602]=0 [9193]=12 [9204]=0 [9208]=12 [9211]=0 [9723]=12 [9862]=0 [9872]=12 
  [10007]=0 [10067]=12 [10072]=0 [10083]=12 [10088]=0 [10133]=12 [10136]=0 [11013]=12 [11016]=0 [11503]=4 [11506]=0 [11744]=4 [11776]=0 [12330]=4 [12337]=0 [42607]=4 
  [42622]=0 [43188]=5 [43206]=0 [43232]=4 [43250]=0 [43302]=4 [43310]=0 [43335]=4 [43348]=0 [43360]=7 [43389]=0 [43392]=4 [43396]=0 [43446]=4 [43454]=5 [43457]=0 
  [43561]=4 [43575]=0 [43698]=4 [43705]=0 [44033]=11 [55204]=0 [55216]=8 [55239]=0 [55243]=9 [55292]=0 [65024]=4 [65040]=0 [65056]=4 [65072]=0 [65520]=1 [65532]=0 
  [66422]=4 [66427]=0 [68097]=4 [68103]=0 [68108]=4 [68112]=0 [68152]=4 [68155]=0 [68900]=4 [68904]=0 [69446]=4 [69457]=0 [69688]=4 [69703]=0 [69759]=4 [69763]=0 
  [69808]=5 [69811]=4 [69822]=0 [69888]=4 [69891]=0 [69927]=4 [69941]=0 [70067]=5 [70070]=4 [70084]=0 [70089]=4 [70096]=0 [70188]=5 [70191]=4 [70200]=0 [70368]=5 
  [70371]=4 [70379]=0 [70465]=5 [70478]=0 [70502]=4 [70509]=0 [70512]=4 [70517]=0 [70709]=5 [70712]=4 [70727]=0 [70835]=4 [70852]=0 [71090]=4 [71096]=5 [71105]=0 
  [71216]=5 [71219]=4 [71233]=0 [71344]=4 [71352]=0 [71453]=4 [71468]=0 [71724]=5 [71727]=4 [71739]=0 [71985]=5 [72004]=0 [72145]=5 [72148]=4 [72156]=5 [72161]=0 
  [72193]=4 [72203]=0 [72243]=4 [72255]=0 [72273]=4 [72284]=0 [72324]=3 [72330]=4 [72346]=0 [72752]=4 [72768]=0 [72850]=4 [72887]=0 [73009]=4 [73015]=0 [73023]=4 
  [73032]=0 [73098]=5 [73112]=0 [78896]=1 [78905]=0 [92912]=4 [92917]=0 [92976]=4 [92983]=0 [94033]=5 [94088]=0 [94095]=4 [94099]=0 [113824]=1 [113828]=0 [119143]=4 
  [119146]=0 [119150]=4 [119155]=1 [119163]=4 [119180]=0 [119210]=4 [119214]=0 [119362]=4 [119365]=0 [121344]=4 [121399]=0 [121403]=4 [121453]=0 [121499]=4 [121520]=0 [122880]=4 
  [122923]=0 [123184]=4 [123191]=0 [123628]=4 [123632]=0 [125136]=4 [125143]=0 [125252]=4 [125259]=0 [126976]=12 [127232]=0 [127245]=12 [127248]=0 [127340]=12 [127346]=0 [127377]=12 
  [127387]=0 [127405]=12 [127462]=6 [127489]=12 [127504]=0 [127538]=12 [127552]=0 [127561]=12 [127995]=4 [128000]=12 [128318]=0 [128326]=12 [128592]=0 [128640]=12 [128768]=0 [128884]=12 
  [128896]=0 [128981]=12 [129024]=0 [129036]=12 [129040]=0 [129096]=12 [129104]=0 [129114]=12 [129120]=0 [129160]=12 [129168]=0 [129198]=12 [129280]=0 [129292]=12 [129792]=0 [130048]=12 
  [131070]=0 [917504]=1 [917536]=4 [917632]=1 [917760]=4 [918000]=1 
)
_ble_unicode_GraphemeClusterBreak_ranges=(
  0 32 127 160 768 880 1155 1162 1425 1480 1536 1542 1552 1565 1611 1632 1750 1774 1840 1867 1958 1969 2027 2036 2070 2094 2137 2140 2259 2308 2366 2369 
  2377 2385 2392 2497 2510 2622 2627 2635 2638 2750 2753 2766 2810 2820 2881 2894 2901 2904 3014 3022 3073 3077 3134 3137 3142 3150 3393 3398 3407 3538 3544 3552 
  3636 3643 3655 3663 3764 3773 3784 3790 3953 3976 3981 4029 4141 4159 4190 4193 4209 4213 4352 4448 4520 4608 4957 4960 5906 5909 5938 5941 6071 6078 6089 6100 
  6155 6159 6432 6435 6444 6451 6457 6460 6744 6765 6771 6784 6832 6849 6912 6917 6964 6973 6981 7019 7028 7074 7086 7146 7151 7156 7204 7212 7224 7376 7401 7616 
  7680 8232 8239 8288 8304 8400 8433 8596 8602 9193 9204 9208 9211 9723 9862 9872 10007 10067 10072 10083 10088 10133 10136 11013 11016 11503 11506 11744 11776 12330 12337 42607 
  42622 43188 43206 43232 43250 43302 43310 43335 43348 43360 43389 43392 43396 43446 43454 43457 43561 43575 43698 43705 44033 55204 55216 55239 55243 55292 65024 65040 65056 65072 65520 65532 
  66422 66427 68097 68103 68108 68112 68152 68155 68900 68904 69446 69457 69688 69703 69759 69763 69808 69811 69822 69888 69891 69927 69941 70067 70070 70084 70089 70096 70188 70191 70200 70368 
  70371 70379 70465 70478 70502 70509 70512 70517 70709 70712 70727 70835 70852 71090 71096 71105 71216 71219 71233 71344 71352 71453 71468 71724 71727 71739 71985 72004 72145 72148 72156 72161 
  72193 72203 72243 72255 72273 72284 72324 72330 72346 72752 72768 72850 72887 73009 73015 73023 73032 73098 73112 78896 78905 92912 92917 92976 92983 94033 94088 94095 94099 113824 113828 119143 
  119146 119150 119155 119163 119180 119210 119214 119362 119365 121344 121399 121403 121453 121499 121520 122880 122923 123184 123191 123628 123632 125136 125143 125252 125259 126976 127232 127245 127248 127340 127346 127377 
  127387 127405 127462 127489 127504 127538 127552 127561 127995 128000 128318 128326 128592 128640 128768 128884 128896 128981 129024 129036 129040 129096 129104 129114 129120 129160 129168 129198 129280 129292 129792 130048 
  131070 917504 917536 917632 917760 918000 921600
)
_ble_unicode_GraphemeClusterBreak_rule=(
  0 0 1 0 1 2 0 0 0 0 0 0 0
  0 0 0 0 0 0 0 0 0 0 0 0 0
  0 0 1 0 1 2 0 0 0 0 0 0 3
  2 0 1 2 1 2 2 2 2 2 2 2 2
  0 0 1 0 1 2 0 0 0 0 0 0 0
  0 0 1 0 1 2 0 0 0 0 0 0 0
  0 0 1 0 1 2 4 0 0 0 0 0 0
  0 0 1 0 1 2 0 1 1 0 1 1 0
  0 0 1 0 1 2 0 0 1 1 0 0 0
  0 0 1 0 1 2 0 0 0 1 0 0 0
  0 0 1 0 1 2 0 0 1 1 0 0 0
  0 0 1 0 1 2 0 0 0 1 0 0 0
  0 0 1 0 1 2 0 0 0 0 0 0 0
)
function ble/unicode/GraphemeCluster/c2break {
  local code=$1
  ret=${_ble_unicode_GraphemeClusterBreak[code]}
  [[ $ret ]] && return 0
  ((ret>_ble_unicode_GraphemeClusterBreak_MaxCode)) && { ret=0; return 0; }
  local l=0 u=${#_ble_unicode_GraphemeClusterBreak_ranges[@]} m
  while ((l+1<u)); do
    ((_ble_unicode_GraphemeClusterBreak_ranges[m=(l+u)/2]<=code?(l=m):(u=m)))
  done
  ret=${_ble_unicode_GraphemeClusterBreak[_ble_unicode_GraphemeClusterBreak_ranges[l]]:-0}
  _ble_unicode_GraphemeClusterBreak[code]=$ret
  return 0
}
function ble/unicode/GraphemeCluster/find-previous-boundary/.ZWJ {
  if [[ :$bleopt_emoji_opts: != *:zwj:* ]]; then
    ((ret=i))
    return 0
  fi
  local j=$((i-1))
  for ((j=i-1;j>0;j--)); do
    ble/util/s2c "${text:j-1:1}"
    ble/unicode/GraphemeCluster/c2break "$ret"
    ((ret==_ble_unicode_GraphemeClusterBreak_Extend)) || break
  done
  if ((j==0||ret!=_ble_unicode_GraphemeClusterBreak_Pictographic)); then
    ((ret=i))
    return 0
  else
    ((i=j-1,b1=ret))
    return 1
  fi
}
function ble/unicode/GraphemeCluster/find-previous-boundary/.RI {
  if [[ :$bleopt_emoji_opts: != *:ri:* ]]; then
    ((ret=i))
    return 0
  fi
  local j=$((i-1))
  for ((j=i-1;j>0;j--)); do
    ble/util/s2c "${text:j-1:1}"
    ble/unicode/GraphemeCluster/c2break "$ret"
    ((ret==_ble_unicode_GraphemeClusterBreak_Regional_Indicator)) || break
  done
  if ((i-j==1)); then
    ((i=j,b1=_ble_unicode_GraphemeClusterBreak_Regional_Indicator))
    return 1
  else
    ((ret=(i-j)%2==1?i-1:i))
    return 0
  fi
}
function ble/unicode/GraphemeCluster/find-previous-boundary {
  local text=$1 i=$2
  if [[ $bleopt_grapheme_cluster ]] && ((i&&--i)); then
    ble/util/s2c "${text:i:1}"
    ble/unicode/GraphemeCluster/c2break "$ret"; local b1=$ret
    while ((i>0)); do
      local b2=$b1
      ble/util/s2c "${text:i-1:1}"
      ble/unicode/GraphemeCluster/c2break "$ret"; local b1=$ret
      case ${_ble_unicode_GraphemeClusterBreak_rule[b1*_ble_unicode_GraphemeClusterBreak_Count+b2]} in
      (0) break ;;
      (1) ((i--)) ;;
      (2) [[ $bleopt_grapheme_cluster != extended ]] && break; ((i--)) ;;
      (3) ble/unicode/GraphemeCluster/find-previous-boundary/.ZWJ && return 0 ;;
      (4) ble/unicode/GraphemeCluster/find-previous-boundary/.RI && return 0 ;;
      esac
    done
  fi
  ret=$i
  return 0
}
_ble_unicode_GraphemeClusterBreak_isCore=()
_ble_unicode_GraphemeClusterBreak_isCore[_ble_unicode_GraphemeClusterBreak_Other]=1
_ble_unicode_GraphemeClusterBreak_isCore[_ble_unicode_GraphemeClusterBreak_Control]=1
_ble_unicode_GraphemeClusterBreak_isCore[_ble_unicode_GraphemeClusterBreak_Regional_Indicator]=1
_ble_unicode_GraphemeClusterBreak_isCore[_ble_unicode_GraphemeClusterBreak_L]=1
_ble_unicode_GraphemeClusterBreak_isCore[_ble_unicode_GraphemeClusterBreak_V]=1
_ble_unicode_GraphemeClusterBreak_isCore[_ble_unicode_GraphemeClusterBreak_T]=1
_ble_unicode_GraphemeClusterBreak_isCore[_ble_unicode_GraphemeClusterBreak_LV]=1
_ble_unicode_GraphemeClusterBreak_isCore[_ble_unicode_GraphemeClusterBreak_LVT]=1
_ble_unicode_GraphemeClusterBreak_isCore[_ble_unicode_GraphemeClusterBreak_Pictographic]=1
function ble/unicode/GraphemeCluster/extend-ascii {
  extend=0
  [[ $_ble_util_locale_encoding != UTF-8 || ! $bleopt_grapheme_cluster ]] && return 1
  local text=$1 iN=${#1} i=$2 ret
  for ((;i<iN;i++,extend++)); do
    ble/util/s2c "${text:i:1}"
    ble/unicode/GraphemeCluster/c2break "$ret"
    case $ret in
    ("$_ble_unicode_GraphemeClusterBreak_Extend"|"$_ble_unicode_GraphemeClusterBreak_ZWJ") ;;
    ("$_ble_unicode_GraphemeClusterBreak_SpacingMark")
      [[ $bleopt_grapheme_cluster == extended ]] || break ;;
    (*) break ;;
    esac
  done
  ((extend))
}
_ble_unicode_GraphemeCluster_ControlRepresentation=()
function ble/unicode/GraphemeCluster/.get-ascii-rep {
  local c=$1
  cs=${_ble_unicode_GraphemeCluster_ControlRepresentation[c]}
  if [[ ! $cs ]]; then
    if ((c<32)); then
      ble/util/c2s $((c+64))
      cs=^$ret
    elif ((c==127)); then
      cs=^?
    elif ((128<=c&&c<160)); then
      ble/util/c2s $((c-64))
      cs=M-^$ret
    else
      ble/util/sprintf cs 'U+%X' "$c"
    fi
    _ble_unicode_GraphemeCluster_ControlRepresentation[c]=$cs
  fi
}
function ble/unicode/GraphemeCluster/match {
  local text=$1 iN=${#1} i=$2 j=$2 flags=$3 ret
  if ((i>=iN)); then
    c=0 w=0 cs= cb= extend=0
    return 1
  elif [[ $_ble_util_locale_encoding != UTF-8 || ! $bleopt_grapheme_cluster ]]; then
    cs=${text:i:1}
    ble/util/s2c "$cs"; c=$ret
    if [[ $flags != *R* ]] && {
         ble/unicode/GraphemeCluster/c2break "$c"
         ((ret==_ble_unicode_GraphemeClusterBreak_Control)); };  then
      ble/unicode/GraphemeCluster/.get-ascii-rep "$c"
      w=${#cs}
    else
      ble/util/c2w "$c"; w=$ret
    fi
    extend=0
    return 0
  fi
  local b0 b1 b2 c0 c2
  ble/util/s2c "${text:i:1}"; c0=$ret
  ble/unicode/GraphemeCluster/c2break "$c0"; b0=$ret
  local coreb= corec= npre=0 vs= ri=
  c2=$c0 b2=$b0
  while ((j<iN)); do
    if ((_ble_unicode_GraphemeClusterBreak_isCore[b2])); then
      [[ $coreb ]] || coreb=$b2 corec=$c2
    elif ((b2==_ble_unicode_GraphemeClusterBreak_Prepend)); then
      ((npre++))
    elif ((c2==0xFE0E)); then # Variation selector TPVS
      vs=tpvs
    elif ((c2==0xFE0F)); then # Variation selector EPVS
      vs=epvs
    fi
    ((j++))
    b1=$b2
    ble/util/s2c "${text:j:1}"; c2=$ret
    ble/unicode/GraphemeCluster/c2break "$c2"; b2=$ret
    case ${_ble_unicode_GraphemeClusterBreak_rule[b1*_ble_unicode_GraphemeClusterBreak_Count+b2]} in
    (0) break ;;
    (1) continue ;;
    (2) [[ $bleopt_grapheme_cluster != extended ]] && break ;;
    (3) [[ :$bleopt_emoji_opts: == *:zwj:* ]] &&
          ((coreb==_ble_unicode_GraphemeClusterBreak_Pictographic)) || break ;;
    (4) [[ :$bleopt_emoji_opts: == *:ri:* && ! $ri ]] || break; ri=1 ;;
    esac
  done
  c=$corec cb=$coreb cs=${text:i:j-i}
  ((extend=j-i-1))
  if [[ ! $corec ]]; then
    if [[ $flags != *R* ]]; then
      ((c=c0,cb=0,corec=0x25CC)) # 基底が存在しない時は点線円
      ble/util/c2s "$corec"
      cs=${text:i:npre}$ret${text:i+npre:j-i-npre}
    else
      ble/util/s2c "$cs"; c=$ret corec=$ret
      ble/unicode/GraphemeCluster/c2break "$c"; cb=$ret
    fi
  fi
  if ((cb==_ble_unicode_GraphemeClusterBreak_Control)); then
    if [[ $flags != *R* ]]; then
      ble/unicode/GraphemeCluster/.get-ascii-rep "$c"
      w=${#cs}
    else
      w=0
    fi
  else
    if [[ $vs == tpvs && :$bleopt_emoji_opts: == *:tpvs:* ]]; then
      bleopt_emoji_width= ble/util/c2w "$corec"; w=$ret
    elif [[ $vs == epvs && :$bleopt_emoji_opts: == *:epvs:* ]]; then
      w=${bleopt_emoji_width:-2}
    else
      ble/util/c2w "$corec"; w=$ret
    fi
  fi
  return 0
}
function ble/canvas/attach {
  ble/util/c2w:auto/check
}
function ble/canvas/put.draw {
  DRAW_BUFF[${#DRAW_BUFF[*]}]=$1
}
function ble/canvas/put-ind.draw {
  local count=${1-1} ind=$_ble_term_ind
  [[ :$2: == *:true-ind:* ]] && ind=$'\eD'
  local ret; ble/string#repeat "$ind" "$count"
  DRAW_BUFF[${#DRAW_BUFF[*]}]=$ret
}
function ble/canvas/put-ri.draw {
  local count=${1-1}
  local ret; ble/string#repeat "$_ble_term_ri" "$count"
  DRAW_BUFF[${#DRAW_BUFF[*]}]=$ret
}
function ble/canvas/put-il.draw {
  local value=${1-1}
  ((value>0)) || return 0
  DRAW_BUFF[${#DRAW_BUFF[*]}]=${_ble_term_il//'%d'/$value}
  DRAW_BUFF[${#DRAW_BUFF[*]}]=$_ble_term_el2 # Note #D1214: 最終行対策 cygwin, linux
}
function ble/canvas/put-dl.draw {
  local value=${1-1}
  ((value>0)) || return 0
  DRAW_BUFF[${#DRAW_BUFF[*]}]=$_ble_term_el2 # Note #D1214: 最終行対策 cygwin, linux
  DRAW_BUFF[${#DRAW_BUFF[*]}]=${_ble_term_dl//'%d'/$value}
}
if ((_ble_bash>=40000)) && [[ ( $OSTYPE == cygwin || $OSTYPE == msys ) && $TERM == xterm-256color ]]; then
  function ble/canvas/.is-il-workaround-required {
    local value=$1 opts=$2
    [[ ! $_ble_term_DA2R ]] || return 1
    ((value==1)) || return 1
    [[ :$opts: == *:vfill:* || :$opts: == *:no-lastline:* ]] && return 1
    [[ :$opts: == *:panel:* ]] &&
      ! ble/canvas/panel/is-last-line &&
      return 1
    return 0
  }
  function ble/canvas/put-il.draw {
    local value=${1-1} opts=$2
    ((value>0)) || return 0
    if ble/canvas/.is-il-workaround-required "$value" "$2"; then
      if [[ :$opts: == *:panel:* ]]; then
        DRAW_BUFF[${#DRAW_BUFF[*]}]=$_ble_term_el2
      else
        DRAW_BUFF[${#DRAW_BUFF[*]}]=$'\e[S\e[A\e[L\e[B\e[T'
      fi
    else
      DRAW_BUFF[${#DRAW_BUFF[*]}]=${_ble_term_il//'%d'/$value}
      DRAW_BUFF[${#DRAW_BUFF[*]}]=$_ble_term_el2 # Note #D1214: 最終行対策 cygwin, linux
    fi
  }
  function ble/canvas/put-dl.draw {
    local value=${1-1} opts=$2
    ((value>0)) || return 0
    if ble/canvas/.is-il-workaround-required "$value" "$2"; then
      if [[ :$opts: == *:panel:* ]]; then
        DRAW_BUFF[${#DRAW_BUFF[*]}]=$_ble_term_el2
      else
        DRAW_BUFF[${#DRAW_BUFF[*]}]=$'\e[S\e[A\e[M\e[B\e[T'
      fi
    else
      DRAW_BUFF[${#DRAW_BUFF[*]}]=$_ble_term_el2 # Note #D1214: 最終行対策 cygwin, linux
      DRAW_BUFF[${#DRAW_BUFF[*]}]=${_ble_term_dl//'%d'/$value}
    fi
  }
fi
function ble/canvas/put-cuu.draw {
  local value=${1-1}
  DRAW_BUFF[${#DRAW_BUFF[*]}]=${_ble_term_cuu//'%d'/$value}
}
function ble/canvas/put-cud.draw {
  local value=${1-1}
  DRAW_BUFF[${#DRAW_BUFF[*]}]=${_ble_term_cud//'%d'/$value}
}
function ble/canvas/put-cuf.draw {
  local value=${1-1}
  DRAW_BUFF[${#DRAW_BUFF[*]}]=${_ble_term_cuf//'%d'/$value}
}
function ble/canvas/put-cub.draw {
  local value=${1-1}
  DRAW_BUFF[${#DRAW_BUFF[*]}]=${_ble_term_cub//'%d'/$value}
}
function ble/canvas/put-cup.draw {
  local l=${1-1} c=${2-1}
  local out=$_ble_term_cup
  out=${out//'%l'/$l}
  out=${out//'%c'/$c}
  out=${out//'%y'/$((l-1))}
  out=${out//'%x'/$((c-1))}
  DRAW_BUFF[${#DRAW_BUFF[*]}]=$out
}
function ble/canvas/put-hpa.draw {
  local c=${1-1}
  local out=$_ble_term_hpa
  out=${out//'%c'/$c}
  out=${out//'%x'/$((c-1))}
  DRAW_BUFF[${#DRAW_BUFF[*]}]=$out
}
function ble/canvas/put-vpa.draw {
  local l=${1-1}
  local out=$_ble_term_vpa
  out=${out//'%l'/$l}
  out=${out//'%y'/$((l-1))}
  DRAW_BUFF[${#DRAW_BUFF[*]}]=$out
}
function ble/canvas/put-ech.draw {
  local value=${1:-1} esc
  if [[ $_ble_term_ech ]]; then
    esc=${_ble_term_ech//'%d'/$value}
  else
    ble/string#reserve-prototype "$value"
    esc=${_ble_string_prototype::value}${_ble_term_cub//'%d'/$value}
  fi
  DRAW_BUFF[${#DRAW_BUFF[*]}]=$esc
}
function ble/canvas/put-spaces.draw {
  local value=${1:-1}
  ble/string#reserve-prototype "$value"
  DRAW_BUFF[${#DRAW_BUFF[*]}]=${_ble_string_prototype::value}
}
function ble/canvas/put-move-x.draw {
  local dx=$1
  ((dx)) || return 1
  if ((dx>0)); then
    ble/canvas/put-cuf.draw "$dx"
  else
    ble/canvas/put-cub.draw $((-dx))
  fi
}
function ble/canvas/put-move-y.draw {
  local dy=$1
  ((dy)) || return 1
  if ((dy>0)); then
    if [[ $MC_SID == $$ ]]; then
      ble/canvas/put-ind.draw "$dy" true-ind
    else
      ble/canvas/put-cud.draw "$dy"
    fi
  else
    ble/canvas/put-cuu.draw $((-dy))
  fi
}
function ble/canvas/put-move.draw {
  ble/canvas/put-move-x.draw "$1"
  ble/canvas/put-move-y.draw "$2"
}
function ble/canvas/flush.draw {
  IFS= builtin eval 'ble/util/put "${DRAW_BUFF[*]}"'
  DRAW_BUFF=()
}
function ble/canvas/sflush.draw {
  local _var=ret
  [[ $1 == -v ]] && _var=$2
  IFS= builtin eval "$_var=\"\${DRAW_BUFF[*]}\""
  DRAW_BUFF=()
}
function ble/canvas/bflush.draw {
  IFS= builtin eval 'ble/util/buffer "${DRAW_BUFF[*]}"'
  DRAW_BUFF=()
}
function ble/canvas/put-clear-lines.draw {
  local old=${1:-1}
  local new=${2:-$old}
  if ((old==1&&new==1)); then
    ble/canvas/put.draw "$_ble_term_el2"
  else
    ble/canvas/put-dl.draw "$old" "$3"
    ble/canvas/put-il.draw "$new" "$3"
  fi
}
function ble/canvas/trace/.put-sgr.draw {
  local ret g=$1
  if ((g==0)); then
    ble/canvas/put.draw "$opt_sgr0"
  else
    ble/color/g.compose "$opt_g0" "$g"
    "$trace_g2sgr" "$g"
    ble/canvas/put.draw "$ret"
  fi
}
function ble/canvas/trace/.measure-point {
  if [[ $flag_bbox ]]; then
    ((x<x1?(x1=x):(x2<x&&(x2=x))))
    ((y<y1?(y1=y):(y2<y&&(y2=y))))
  fi
}
function ble/canvas/trace/.goto {
  local dstx=$1 dsty=$2
  if [[ ! $flag_clip ]]; then
    if [[ $trace_flags == *[RJ]* ]]; then
      ble/canvas/put-move.draw $((dstx-x)) $((dsty-y))
    else
      ble/canvas/put-cup.draw $((dsty+1)) $((dstx+1))
    fi
  fi
  ((x=dstx,y=dsty))
  ble/canvas/trace/.measure-point
}
function ble/canvas/trace/.implicit-move {
  local w=$1 type=$2
  ((w>0)) || return 0
  if [[ $flag_gbox ]]; then
    if [[ ! $gx1 ]]; then
      ((gx1=gx2=x,gy1=gy2=y))
    else
      ((x<gx1?(gx1=x):(gx2<x&&(gx2=x))))
      ((y<gy1?(gy1=y):(gy2<y&&(gy2=y))))
    fi
  fi
  ((x+=w))
  if ((x<=cols)); then
    [[ $flag_bbox ]] && ((x>x2)) && x2=$x
    [[ $flag_gbox ]] && ((x>gx2)) && gx2=$x
    if ((x==cols&&!xenl)); then
      ((y++,x=0))
      if [[ $flag_bbox ]]; then
        ((x<x1)) && x1=0
        ((y>y2)) && y2=$y
      fi
    fi
  else
    if [[ $type == atomic ]]; then
      ((y++,x=w<xlimit?w:xlimit))
    else
      ((y+=x/cols,x%=cols,
        xenl&&x==0&&(y--,x=cols)))
    fi
    if [[ $flag_bbox ]]; then
      ((x1>0&&(x1=0)))
      ((x2<cols&&(x2=cols)))
      ((y>y2)) && y2=$y
    fi
    if [[ $flag_gbox ]]; then
      ((gx1>0&&(gx1=0)))
      ((gx2<cols&&(gx2=cols)))
      ((y>gy2)) && gy2=$y
    fi
  fi
  ((x==0&&(lc=32,lg=0)))
  return 0
}
function ble/canvas/trace/.put-atomic.draw {
  local c=$1 w=$2
  if [[ $flag_clip ]]; then
    ((cy1<=y&&y<cy2&&cx1<=x&&x<cx2&&x+w<=cx2)) || return 0
    if [[ $cg != "$g" ]]; then
      ble/canvas/trace/.put-sgr.draw "$g"
      cg=$g
    fi
    ble/canvas/put-move.draw $((x-cx)) $((y-cy))
    ble/canvas/put.draw "$c"
    ((cx+=x+w,cy=y))
  else
    ble/canvas/put.draw "$c"
  fi
  ble/canvas/trace/.implicit-move "$w" atomic
}
function ble/canvas/trace/.put-ascii.draw {
  local value=$1 w=${#1}
  [[ $value ]] || return
  if [[ $flag_clip ]]; then
    local xL=$x xR=$((x+w))
    ((xR<=cx1||cx2<=xL||y+1<=cy1||cy2<=y)) && return 0
    if [[ $cg != "$g" ]]; then
      ble/canvas/trace/.put-sgr.draw "$g"
      cg=$g
    fi
    ((xL<cx1)) && value=${value:cx1-xL} xL=$cx1
    ((xR>cx2)) && value=${value::${#value}-(xR-cx2)} xR=$cx2
    ble/canvas/put-move.draw $((x-cx)) $((y-cy))
    ble/canvas/put.draw "$value"
    ((cx=xR,cy=y))
  else
    ble/canvas/put.draw "$value"
  fi
  ble/canvas/trace/.implicit-move "$w"
}
function ble/canvas/trace/.process-overflow {
  [[ :$opts: == *:truncate:* ]] && i=$iN # stop
  if ((y+1==lines)) && [[ :$opts: == *:ellipsis:* ]]; then
    local ellipsis=... w=3 wmax=$xlimit
    ((w>wmax)) && ellipsis=${ellipsis::wmax} w=$wmax
    if ble/util/is-unicode-output; then
      local symbol='…' ret
      ble/util/s2c "$symbol"
      ble/util/c2w "$ret"
      ((ret<=wmax)) && ellipsis=$symbol w=$ret
    fi
    local ox=$x oy=$y
    ble/canvas/trace/.goto $((wmax-w)) $((lines-1))
    ble/canvas/trace/.put-atomic.draw "$ellipsis" "$w"
    ble/canvas/trace/.goto "$ox" "$oy"
  fi
}
function ble/canvas/trace/.justify/inc-quote {
  [[ $trace_flags == *J* ]] || return 0
  ((trace_sclevel++))
  flag_justify=
}
function ble/canvas/trace/.justify/dec-quote {
  [[ $trace_flags == *J* ]] || return 0
  ((--trace_sclevel)) || flag_justify=1
}
function ble/canvas/trace/.justify/begin-line {
  ((jx0=x1=x2=x,jy0=y1=y2=y))
  gx1= gx2= gy1= gy2=
  [[ $justify_align == *[cr]* ]] &&
    ble/canvas/trace/.justify/next-field
}
function ble/canvas/trace/.justify/next-field {
  local sep=$1 wmin=0
  local esc; ble/canvas/sflush.draw -v esc
  [[ $sep == ' ' ]] && wmin=1
  ble/array#push justify_fields "${sep:-\$}:$wmin:$jx0,$jy0,$x,$y:$x1,$y1,$x2,$y2:$gx1,$gy1,$gx2,$gy2:$esc"
  ((x+=wmin,jx0=x1=x2=x,jy0=y1=y2=y))
}
function ble/canvas/trace/.justify/unpack {
  local data=$1 buff
  sep=${data::1}; data=${data:2}
  wmin=${data%%:*}; data=${data#*:}
  ble/string#split buff , "${data%%:*}"; data=${data#*:}
  xI=${buff[0]} yI=${buff[1]} xF=${buff[2]} yF=${buff[3]}
  ble/string#split buff , "${data%%:*}"; data=${data#*:}
  x1=${buff[0]} y1=${buff[1]} x2=${buff[2]} y2=${buff[3]}
  ble/string#split buff , "${data%%:*}"; data=${data#*:}
  gx1=${buff[0]} gy1=${buff[1]} gx2=${buff[2]} gy2=${buff[3]}
  esc=$data
}
function ble/canvas/trace/.justify/end-line {
  if [[ $trace_flags == *B* ]]; then
    ((y<jy1&&(jy1=y)))
    ((y>jy2&&(jy2=y)))
  fi
  ((${#justify_fields[@]}||${#DRAW_BUFF[@]})) || return 0
  ble/canvas/trace/.justify/next-field
  [[ $justify_align == *c* ]] &&
    ble/canvas/trace/.justify/next-field
  local i width=0 ispan=0 has_content=
  for ((i=0;i<${#justify_fields[@]};i++)); do
    local sep wmin xI yI xF yF x1 y1 x2 y2 gx1 gy1 gx2 gy2 esc
    ble/canvas/trace/.justify/unpack "${justify_fields[i]}"
    ((width+=xF-xI))
    [[ $esc ]] && has_content=1
    ((i+1==${#justify_fields[@]})) && break
    ((width+=wmin))
    ((ispan++))
  done
  [[ $has_content ]] || return 0
  local nspan=$ispan
  local -a DRAW_BUFF=()
  local xlimit=$cols
  [[ $_ble_term_xenl$opt_relative ]] || ((xlimit--))
  local span=$((xlimit-width))
  x= y=
  local ispan=0 vx=0 spanx=0
  for ((i=0;i<${#justify_fields[@]};i++)); do
    local sep wmin xI yI xF yF x1 y1 x2 y2 gx1 gy1 gx2 gy2 esc
    ble/canvas/trace/.justify/unpack "${justify_fields[i]}"
    if [[ ! $x ]]; then
      x=$xI y=$yI
      if [[ $justify_align == right ]]; then
        ble/canvas/put-move-x.draw $((cols-1-x))
        ((x=cols-1))
      fi
    fi
    if [[ $esc ]]; then
      local delta=0
      ((vx+x1-xI<0)) && ((delta=-(vx+x1-xI)))
      ((vx+x2-xI>xlimit)) && ((delta=xlimit-(vx+x2-xI)))
      ble/canvas/put-move-x.draw $((vx+delta-x))
      ((x=vx+delta))
      ble/canvas/put.draw "$esc"
      if [[ $trace_flags == *B* ]]; then
        ((x+x1-xI<jx1&&(jx1=x+x1-xI)))
        ((y+y1-yI<jy1&&(jy1=y+y1-yI)))
        ((x+x2-xI>jx2&&(jx2=x+x2-xI)))
        ((y+y2-yI>jy2&&(jy2=y+y2-yI)))
      fi
      if [[ $flag_gbox && $gx1 ]]; then
        ((gx1+=x-xI,gx2+=x-xI))
        ((gy1+=y-yI,gy2+=y-yI))
        if [[ ! $jgx1 ]]; then
          ((jgx1=gx1,jgy1=gy1,jgx2=gx2,jgy2=gy2))
        else
          ((gx1<jgx1&&(jgx1=gx1)))
          ((gy1<jgy1&&(jgy1=gy1)))
          ((gx2>jgx2&&(jgx2=gx2)))
          ((gy2>jgy2&&(jgy2=gy2)))
        fi
      fi
      ((x+=xF-xI,y+=yF-yI,vx+=xF-xI))
    fi
    ((i+1==${#justify_fields[@]})) && break
    local new_spanx=$((span*++ispan/nspan))
    local wfill=$((wmin+new_spanx-spanx))
    ((vx+=wfill,spanx=new_spanx))
    if [[ $sep == ' ' ]]; then
      ble/string#reserve-prototype "$wfill"
      ble/canvas/put.draw "${_ble_string_prototype::wfill}"
      ((x+=wfill))
    fi
  done
  local ret
  ble/canvas/sflush.draw
  ble/array#push justify_buff "$ret"
  justify_fields=()
}
function ble/canvas/trace/.decsc {
  [[ ${trace_decsc[5]} ]] || ble/canvas/trace/.justify/inc-quote
  trace_decsc=("$x" "$y" "$g" "$lc" "$lg" active)
  if [[ ! $flag_clip ]]; then
    [[ :$opts: == *:noscrc:* ]] ||
      ble/canvas/put.draw "$_ble_term_sc"
  fi
}
function ble/canvas/trace/.decrc {
  [[ ${trace_decsc[5]} ]] && ble/canvas/trace/.justify/dec-quote
  if [[ ! $flag_clip ]]; then
    ble/canvas/trace/.put-sgr.draw "${trace_decsc[2]}" # g を明示的に復元。
    if [[ :$opts: == *:noscrc:* ]]; then
      ble/canvas/put-move.draw $((trace_decsc[0]-x)) $((trace_decsc[1]-y))
    else
      ble/canvas/put.draw "$_ble_term_rc"
    fi
  fi
  x=${trace_decsc[0]}
  y=${trace_decsc[1]}
  g=${trace_decsc[2]}
  lc=${trace_decsc[3]}
  lg=${trace_decsc[4]}
  trace_decsc[5]=
}
function ble/canvas/trace/.scosc {
  [[ ${trace_scosc[5]} ]] || ble/canvas/trace/.justify/inc-quote
  trace_scosc=("$x" "$y" "$g" "$lc" "$lg" active)
  if [[ ! $flag_clip ]]; then
    [[ :$opts: == *:noscrc:* ]] ||
      ble/canvas/put.draw "$_ble_term_sc"
  fi
}
function ble/canvas/trace/.scorc {
  [[ ${trace_scosc[5]} ]] && ble/canvas/trace/.justify/dec-quote
  if [[ ! $flag_clip ]]; then
    ble/canvas/trace/.put-sgr.draw "$g" # g は変わらない様に。
    if [[ :$opts: == *:noscrc:* ]]; then
      ble/canvas/put-move.draw $((trace_scosc[0]-x)) $((trace_scosc[1]-y))
    else
      ble/canvas/put.draw "$_ble_term_rc"
    fi
  fi
  x=${trace_scosc[0]}
  y=${trace_scosc[1]}
  lc=${trace_scosc[3]}
  lg=${trace_scosc[4]}
  trace_scosc[5]=
}
function ble/canvas/trace/.ps1sc {
  ble/canvas/trace/.justify/inc-quote
  trace_brack[${#trace_brack[*]}]="$x $y"
}
function ble/canvas/trace/.ps1rc {
  local lastIndex=$((${#trace_brack[*]}-1))
  if ((lastIndex>=0)); then
    ble/canvas/trace/.justify/dec-quote
    local -a scosc
    ble/string#split-words scosc "${trace_brack[lastIndex]}"
    ((x=scosc[0]))
    ((y=scosc[1]))
    builtin unset -v "trace_brack[$lastIndex]"
  fi
}
function ble/canvas/trace/.NEL {
  if [[ $opt_nooverflow ]] && ((y+1>=lines)); then
    ble/canvas/trace/.process-overflow
    return 1
  fi
  [[ $flag_justify ]] &&
    ble/canvas/trace/.justify/end-line
  if [[ ! $flag_clip ]]; then
    if [[ $opt_relative ]]; then
      ((x)) && ble/canvas/put-cub.draw "$x"
      ble/canvas/put-cud.draw 1
    else
      ble/canvas/put.draw "$_ble_term_cr"
      ble/canvas/put.draw "$_ble_term_nl"
    fi
  fi
  ((y++,x=0,lc=32,lg=0))
  if [[ $flag_bbox ]]; then
    ((x<x1)) && x1=$x
    ((y>y2)) && y2=$y
  fi
  [[ $flag_justify ]] &&
    ble/canvas/trace/.justify/begin-line
  return 0
}
function ble/canvas/trace/.SGR {
  local param=$1 seq=$2 specs i iN
  if [[ ! $param ]]; then
    g=0
    [[ $flag_clip ]] || ble/canvas/put.draw "$opt_sgr0"
    return 0
  fi
  if [[ $opt_terminfo ]]; then
    ble/color/read-sgrspec "$param"
  else
    ble/color/read-sgrspec "$param" ansi
  fi
  [[ $flag_clip ]] || ble/canvas/trace/.put-sgr.draw "$g"
}
function ble/canvas/trace/.process-csi-sequence {
  local seq=$1 seq1=${1:2} rex
  local char=${seq1:${#seq1}-1:1} param=${seq1::${#seq1}-1}
  if [[ ! ${param//[0-9:;]} ]]; then
    case $char in
    (m) # SGR
      ble/canvas/trace/.SGR "$param" "$seq"
      return 0 ;;
    ([ABCDEFGIZ\`ade])
      local arg=0
      [[ $param =~ ^[0-9]+$ ]] && ((arg=10#0$param))
      ((arg==0&&(arg=1)))
      local ox=$x oy=$y
      if [[ $char == A ]]; then
        ((y-=arg,y<0&&(y=0)))
        ((!flag_clip&&y<oy)) && ble/canvas/put-cuu.draw $((oy-y))
      elif [[ $char == [Be] ]]; then
        ((y+=arg,y>=lines&&(y=lines-1)))
        ((!flag_clip&&y>oy)) && ble/canvas/put-cud.draw $((y-oy))
      elif [[ $char == [Ca] ]]; then
        ((x+=arg,x>=cols&&(x=cols-1)))
        ((!flag_clip&&x>ox)) && ble/canvas/put-cuf.draw $((x-ox))
      elif [[ $char == D ]]; then
        ((x-=arg,x<0&&(x=0)))
        ((!flag_clip&&x<ox)) && ble/canvas/put-cub.draw $((ox-x))
      elif [[ $char == E ]]; then
        ((y+=arg,y>=lines&&(y=lines-1),x=0))
        if [[ ! $flag_clip ]]; then
          ((y>oy)) && ble/canvas/put-cud.draw $((y-oy))
          ble/canvas/put.draw "$_ble_term_cr"
        fi
      elif [[ $char == F ]]; then
        ((y-=arg,y<0&&(y=0),x=0))
        if [[ ! $flag_clip ]]; then
          ((y<oy)) && ble/canvas/put-cuu.draw $((oy-y))
          ble/canvas/put.draw "$_ble_term_cr"
        fi
      elif [[ $char == [G\`] ]]; then
        ((x=arg-1,x<0&&(x=0),x>=cols&&(x=cols-1)))
        if [[ ! $flag_clip ]]; then
          if [[ $opt_relative ]]; then
            ble/canvas/put-move-x.draw $((x-ox))
          else
            ble/canvas/put-hpa.draw $((x+1))
          fi
        fi
      elif [[ $char == d ]]; then
        ((y=arg-1,y<0&&(y=0),y>=lines&&(y=lines-1)))
        if [[ ! $flag_clip ]]; then
          if [[ $opt_relative ]]; then
            ble/canvas/put-move-y.draw $((y-oy))
          else
            ble/canvas/put-vpa.draw $((y+1))
          fi
        fi
      elif [[ $char == I ]]; then
        local _x
        ((_x=(x/it+arg)*it,
          _x>=cols&&(_x=cols-1)))
        if ((_x>x)); then
          [[ $flag_clip ]] || ble/canvas/put-cuf.draw $((_x-x))
          ((x=_x))
        fi
      elif [[ $char == Z ]]; then
        local _x
        ((_x=((x+it-1)/it-arg)*it,
          _x<0&&(_x=0)))
        if ((_x<x)); then
          [[ $flag_clip ]] || ble/canvas/put-cub.draw $((x-_x))
          ((x=_x))
        fi
      fi
      ble/canvas/trace/.measure-point
      lc=-1 lg=0
      return 0 ;;
    ([Hf])
      local -a params
      ble/string#split-words params "${param//[^0-9]/ }"
      params=("${params[@]/#/10#0}") # #D1570 is-array OK
      local dstx dsty
      ((dstx=params[1]-1))
      ((dsty=params[0]-1))
      ((dstx<0&&(dstx=0),dstx>=cols&&(dstx=cols-1),
        dsty<0&&(dsty=0),dsty>=lines&&(dsty=lines-1)))
      ble/canvas/trace/.goto "$dstx" "$dsty"
      lc=-1 lg=0
      return 0 ;;
    ([su]) # SCOSC SCORC
      if [[ $char == s ]]; then
        ble/canvas/trace/.scosc
      else
        ble/canvas/trace/.scorc
      fi
      return 0 ;;
    esac
  fi
  ble/canvas/put.draw "$seq"
}
function ble/canvas/trace/.process-esc-sequence {
  local seq=$1 char=${1:1}
  case $char in
  (7) # DECSC
    ble/canvas/trace/.decsc
    return 0 ;;
  (8) # DECRC
    ble/canvas/trace/.decrc
    return 0 ;;
  (D) # IND
    [[ $opt_nooverflow ]] && ((y+1>=lines)) && return 0
    if [[ $flag_clip || $opt_relative || $flag_justify ]]; then
      ((y+1>=lines)) && return 0
      ((y++))
      [[ $flag_clip ]] ||
        ble/canvas/put-cud.draw 1
    else
      ((y++))
      ble/canvas/put.draw "$_ble_term_ind"
      [[ $_ble_term_ind != $'\eD' ]] &&
        ble/canvas/put-hpa.draw $((x+1)) # tput ind が唯の改行の時がある
    fi
    lc=-1 lg=0
    ble/canvas/trace/.measure-point
    return 0 ;;
  (M) # RI
    [[ $opt_nooverflow ]] && ((y==0)) && return 0
    if [[ $flag_clip || $opt_relative || $flag_justify ]]; then
      ((y==0)) && return 0
      ((y--))
      [[ $flag_clip ]] ||
        ble/canvas/put-cuu.draw 1
    else
      ((y--))
      ble/canvas/put.draw "$_ble_term_ri"
    fi
    lc=-1 lg=0
    ble/canvas/trace/.measure-point
    return 0 ;;
  (E) # NEL
    ble/canvas/trace/.NEL
    return 0 ;;
  esac
  ble/canvas/put.draw "$seq"
}
function ble/canvas/trace/.impl {
  local text=$1 opts=$2
  local LC_ALL= LC_COLLATE=C
  local cols=${COLUMNS:-80} lines=${LINES:-25}
  local it=${bleopt_tab_width:-$_ble_term_it} xenl=$_ble_term_xenl
  ble/string#reserve-prototype "$it"
  local ret rex
  ble/util/c2s 156; local st=$ret #  (ST)
  ((${#st}>=2)) && st=
  local xinit=$x yinit=$y ginit=$g
  local trace_flags=
  local opt_nooverflow=; [[ :$opts: == *:truncate:* || :$opts: == *:confine:* ]] && opt_nooverflow=1
  local opt_relative=; [[ :$opts: == *:relative:* ]] && trace_flags=R$trace_flags opt_relative=1
  [[ :$opts: == *:measure-bbox:* ]] && trace_flags=B$trace_flags
  [[ :$opts: == *:measure-gbox:* ]] && trace_flags=G$trace_flags
  [[ :$opts: == *:left-char:* ]] && trace_flags=L$trace_flags
  local opt_terminfo=; [[ :$opts: == *:terminfo:* ]] && opt_terminfo=1
  if local rex=':(justify(=[^:]+)?|center|right):'; [[ :$opts: =~ $rex ]]; then
    trace_flags=J$trace_flags
    local jx0=$x jy0=$y
    local justify_sep= justify_align=
    local -a justify_buff=()
    local -a justify_fields=()
    case ${BASH_REMATCH[1]} in
    (justify*) justify_sep=${BASH_REMATCH[2]:1}${BASH_REMATCH[2]:-' '} ;;
    (center)   justify_align=c ;;
    (right)    justify_align=r ;;
    esac
  fi
  if local rex=':clip=([0-9]*),([0-9]*)([-+])([0-9]*),([0-9]*):'; [[ :$opts: =~ $rex ]]; then
    local cx1 cy1 cx2 cy2 cx cy cg
    trace_flags=C$trace_flags
    cx1=${BASH_REMATCH[1]} cy1=${BASH_REMATCH[2]}
    cx2=${BASH_REMATCH[4]} cy2=${BASH_REMATCH[5]}
    [[ ${BASH_REMATCH[3]} == + ]] && ((cx2+=cx1,cy2+=cy1))
    ((cx1<=cx2)) || local cx1=$cx2 cx2=$cx1
    ((cy1<=cy2)) || local cy1=$cy2 cy2=$cy1
    ((cx1<0)) && cx1=0
    ((cy1<0)) && cy1=0
    ((cols<cx2)) && cx2=$cols
    ((lines<cy2)) && cy2=$lines
    local cx=$cx1 cy=$cy1 cg=
  fi
  local trace_g2sgr=ble/color/g2sgr
  [[ :$opts: == *:ansi:* || $trace_flags == *C*J* ]] &&
    trace_g2sgr=ble/color/g2sgr-ansi
  local opt_g0= opt_sgr0=$_ble_term_sgr0
  if rex=':g0=([^:]+):'; [[ :$opts: =~ $rex ]]; then
    opt_g0=${BASH_REMATCH[1]}
  elif rex=':face0=([^:]+):'; [[ :$opts: =~ $rex ]]; then
    ble/color/face2g "${BASH_REMATCH[1]}"; opt_g0=$ret
  fi
  if [[ $opt_g0 ]]; then
    "$trace_g2sgr" "$opt_g0"; opt_sgr0=$ret
    ble/canvas/put.draw "$opt_sgr0"
    g=$opt_g0
  fi
  local rex_csi='^\[[ -?]*[@-~]'
  local rex_osc='^([]PX^_k])([^'$st']|+[^\'$st'])*(\\|'${st:+'|'}$st'|$)'
  local rex_2022='^[ -/]+[@-~]'
  local rex_esc='^[ -~]'
  local trace_sclevel=0
  local -a trace_brack=()
  local -a trace_scosc=()
  local -a trace_decsc=()
  local flag_lchar=
  if [[ $trace_flags == *L* ]]; then
    flag_lchar=1
  else
    local lc=32 lg=0
  fi
  local flag_bbox= flag_gbox=
  if [[ $trace_flags == *[BJ]* ]]; then
    flag_bbox=1
    [[ $trace_flags != *B* ]] && local x1 x2 y1 y2
    [[ $trace_flags != *G* ]] && local gx1= gx2= gy1= gy2=
    ((x1=x2=x,y1=y2=y))
    [[ $trace_flags == *J*B* ]] &&
      local jx1=$x jy1=$y jx2=$x jy2=$y
  fi
  if [[ $trace_flags == *G* ]]; then
    ((flag_gbox=1))
    gx1= gx2= gy1= gy2=
    [[ $trace_flags == *J* ]] &&
      local jgx1= jgy1= jgx2= jgy2=
  fi
  local flag_clip=
  [[ $trace_flags == *C* && $trace_flags != *J* ]] && flag_clip=1
  local xenl=$_ble_term_xenl
  [[ $opt_relative || $trace_flags == *J* ]] && xenl=1
  local xlimit=$((xenl?cols:cols-1))
  local flag_justify=
  if [[ $trace_flags == *J* ]]; then
    flag_justify=1
    ble/canvas/trace/.justify/begin-line
  fi
  local i=0 iN=${#text}
  while ((i<iN)); do
    local tail=${text:i}
    local is_overflow=
    if [[ $flag_justify && $justify_sep && $tail == ["$justify_sep"]* ]]; then
      ble/canvas/trace/.justify/next-field "${tail::1}"
      ((i++))
    elif [[ $tail == [-]* ]]; then
      local s=${tail::1}
      ((i++))
      case "$s" in
      ($'\e')
        if [[ $tail =~ $rex_osc ]]; then
          s=$BASH_REMATCH
          [[ ${BASH_REMATCH[3]} ]] || s="$s\\" # 終端の追加
          ((i+=${#BASH_REMATCH}-1))
          ble/canvas/trace/.put-atomic.draw "$s" 0
        elif [[ $tail =~ $rex_csi ]]; then
          ((i+=${#BASH_REMATCH}-1))
          ble/canvas/trace/.process-csi-sequence "$BASH_REMATCH"
        elif [[ $tail =~ $rex_2022 ]]; then
          ble/canvas/trace/.put-atomic.draw "$BASH_REMATCH" 0
          ((i+=${#BASH_REMATCH}-1))
        elif [[ $tail =~ $rex_esc ]]; then
          ((i+=${#BASH_REMATCH}-1))
          ble/canvas/trace/.process-esc-sequence "$BASH_REMATCH"
        else
          ble/canvas/trace/.put-atomic.draw "$s" 0
        fi ;;
      ($'\b') # BS
        if ((x>0)); then
          [[ $flag_clip ]] || ble/canvas/put.draw "$s"
          ((x--,lc=32,lg=g))
          ble/canvas/trace/.measure-point
        fi ;;
      ($'\t') # HT
        local _x
        ((_x=(x+it)/it*it,
          _x>=cols&&(_x=cols-1)))
        if ((x<_x)); then
          ((lc=32,lg=g))
          ble/canvas/trace/.put-ascii.draw "${_ble_string_prototype::_x-x}"
        fi ;;
      ($'\n') # LF = CR+LF
        ble/canvas/trace/.NEL ;;
      ($'\v') # VT
        if ((y+1<lines||!opt_nooverflow)); then
          if [[ $flag_clip || $opt_relative || $flag_justify ]]; then
            if ((y+1<lines)); then
              [[ $flag_clip ]] ||
                ble/canvas/put-cud.draw 1
              ((y++,lc=32,lg=0))
            fi
          else
            ble/canvas/put.draw "$_ble_term_cr"
            ble/canvas/put.draw "$_ble_term_nl"
            ((x)) && ble/canvas/put-cuf.draw "$x"
            ((y++,lc=32,lg=0))
          fi
          ble/canvas/trace/.measure-point
        fi ;;
      ($'\r') # CR ^M
        local ox=$x
        ((x=0,lc=-1,lg=0))
        if [[ ! $flag_clip ]]; then
          if [[ $flag_justify ]]; then
            ble/canvas/put-move-x.draw $((jx0-ox))
            ((x=jx0))
          elif [[ $opt_relative ]]; then
            ble/canvas/put-cub.draw "$ox"
          else
            ble/canvas/put.draw "$_ble_term_cr"
          fi
        fi
        ble/canvas/trace/.measure-point ;;
      ($'\001') [[ :$opts: == *:prompt:* ]] && ble/canvas/trace/.ps1sc ;;
      ($'\002') [[ :$opts: == *:prompt:* ]] && ble/canvas/trace/.ps1rc ;;
      (*) ble/canvas/put.draw "$s" ;;
      esac
    elif ble/util/isprint+ "$tail"; then
      local s=$BASH_REMATCH
      [[ $flag_justify && $justify_sep ]] && s=${s%%["$justify_sep"]*}
      local w=${#s}
      if [[ $opt_nooverflow ]]; then
        local wmax=$((lines*cols-(y*cols+x)))
        ((xenl||wmax--,wmax<0&&(wmax=0)))
        ((w>wmax)) && w=$wmax is_overflow=1
      fi
      local t=${s::w}
      if [[ $flag_clip || $opt_relative || $flag_justify ]]; then
        local tlen=$w len=$((cols-x))
        if ((tlen>len)); then
          while ((tlen>len)); do
            ble/canvas/trace/.put-ascii.draw "${t::len}"
            t=${t:len}
            ((x=cols,tlen-=len,len=cols))
            ble/canvas/trace/.NEL
          done
          w=${#t}
        fi
      fi
      if [[ $flag_lchar ]]; then
        local ret
        ble/util/s2c "${s:w-1:1}"
        lc=$ret lg=$g
      fi
      ble/canvas/trace/.put-ascii.draw "$t"
      ((i+=${#s}))
      if local extend; ble/unicode/GraphemeCluster/extend-ascii "$text" "$i"; then
        ble/canvas/trace/.put-atomic.draw "${text:i:extend}" 0
        ((i+=extend))
      fi
    else
      local c w cs cb extend
      ble/unicode/GraphemeCluster/match "$text" "$i" R
      if [[ $opt_nooverflow ]] && ! ((x+w<=xlimit||y+1<lines&&w<=cols)); then
        is_overflow=1
      else
        if ((x+w>cols)); then
          if [[ $flag_clip || $opt_relative || $flag_justify ]]; then
            ble/canvas/trace/.NEL
          else
            ble/canvas/trace/.put-ascii.draw "${_ble_string_prototype::cols-x}"
          fi
        fi
        lc=$c lg=$g
        ble/canvas/trace/.put-atomic.draw "$cs" "$w"
      fi
      ((i+=1+extend))
    fi
    [[ $is_overflow ]] && ble/canvas/trace/.process-overflow
  done
  if [[ $trace_flags == *J* ]]; then
    if [[ ! $flag_justify ]]; then
      [[ ${trace_scosc[5]} ]] && ble/canvas/trace/.scorc
      [[ ${trace_decsc[5]} ]] && ble/canvas/trace/.decrc
      while [[ ${trace_brack[0]} ]]; do ble/canvas/trace/.ps1rc; done
    fi
    ble/canvas/trace/.justify/end-line
    DRAW_BUFF=("${justify_buff[@]}")
    [[ $trace_flags == *B* ]] &&
      ((x1=jx1,y1=jy1,x2=jx2,y2=jy2))
    [[ $trace_flags == *G* ]] &&
      gx1=$jgx1 gy1=$jgy1 gx2=$jgx2 gy2=$jgy2
    if [[ $trace_flags == *C* ]]; then
      ble/canvas/sflush.draw
      x=$xinit y=$yinit g=$ginit
      local trace_opts=clip=$cx1,$cy1-$cx2,$cy2
      [[ :$opts: == *:ansi:* ]] && trace_opts=$trace_opts:ansi
      ble/canvas/trace/.impl "$ret" "$trace_opts"
      cx=$x cy=$y cg=$g
    fi
  fi
  [[ $trace_flags == *B* ]] && ((y2++))
  [[ $trace_flags == *G* ]] && ((gy2++))
  if [[ $trace_flags == *C* ]]; then
    x=$cx y=$cy g=$cg
    if [[ $trace_flags == *B* ]]; then
      ((x1<cx1)) && x1=$cx1
      ((x1>cx2)) && x1=$cx2
      ((x2<cx1)) && x2=$cx1
      ((x2>cx2)) && x2=$cx2
      ((y1<cy1)) && y1=$cy1
      ((y1>cy2)) && y1=$cy2
      ((y2<cy1)) && y2=$cy1
      ((y2>cy2)) && y2=$cy2
    fi
    if [[ $trace_flags == *G* ]]; then
      if ((gx2<=cx1||cx2<=gx1||gy2<=cy1||cy2<=gy1)); then
        gx1= gx2= gy1= gy2=
      else
        ((gx1<cx1)) && gx1=$cx1
        ((gx2>cx2)) && gx2=$cx2
        ((gy1<cy1)) && gy1=$cy1
        ((gy2>cy2)) && gy2=$cy2
      fi
    fi
  fi
}
function ble/canvas/trace.draw {
  ble/canvas/trace/.impl "$@" 2>/dev/null # Note: suppress LC_COLLATE errors #D1205 #D1341 #D1440
}
function ble/canvas/trace {
  local -a DRAW_BUFF=()
  ble/canvas/trace/.impl "$@" 2>/dev/null # Note: suppress LC_COLLATE errors #D1205 #D1341 #D1440
  ble/canvas/sflush.draw # -> ret
}
function ble/canvas/trace-text/.put-simple {
  local nchar=$1
  ((nchar)) || return 0
  local nput=$((cols*lines-!_ble_term_xenl-(y*cols+x)))
  ((nput>0)) || return 1
  ((nput>nchar)) && nput=$nchar
  out=$out${2::nput}
  ((x+=nput,y+=x/cols,x%=cols))
  ((_ble_term_xenl&&x==0&&(y--,x=cols)))
  ((nput==nchar)); return $?
}
function ble/canvas/trace-text/.put-atomic {
  local w=$1 c=$2
  ((y*cols+x+w<=cols*lines-!_ble_term_xenl)) || return 1
  if ((x<cols&&cols<x+w)); then
    if [[ :$opts: == *:nonewline:* ]]; then
      ble/string#reserve-prototype $((cols-x))
      out=$out${_ble_string_prototype::cols-x}
      ((x=cols))
    else
      out=$out$'\n'
      ((y++,x=0))
    fi
  fi
  ((w&&x==cols&&(y++,x=0)))
  local limit=$((cols-(y+1==lines&&!_ble_term_xenl)))
  if ((x+w>limit)); then
    ble/string#reserve-prototype $((limit-x))
    local pad=${_ble_string_prototype::limit-x}
    out=$out$sgr1${pad//?/'#'}$sgr0
    x=$limit
    ((y+1<lines)); return $?
  fi
  out=$out$c
  ((x+=w,!_ble_term_xenl&&x==cols&&(y++,x=0)))
  return 0
}
function ble/canvas/trace-text/.put-nl-if-eol {
  if ((x==cols&&y+1<lines)); then
    [[ :$opts: == *:nonewline:* ]] && return 0
    ((_ble_term_xenl)) && out=$out$'\n'
    ((y++,x=0))
  fi
}
function ble/canvas/trace-text {
  local LC_ALL= LC_COLLATE=C
  local out= glob='*[! -~]*'
  local opts=$2 flag_overflow=
  [[ :$opts: == *:external-sgr:* ]] ||
    local sgr0=$_ble_term_sgr0 sgr1=$_ble_term_rev
  if [[ $1 != $glob ]]; then
    ble/canvas/trace-text/.put-simple "${#1}" "$1"
  else
    local glob='[ -~]*' globx='[! -~]*'
    local i iN=${#1} text=$1
    for ((i=0;i<iN;)); do
      local tail=${text:i}
      if [[ $tail == $glob ]]; then
        local span=${tail%%$globx}; ((i+=${#span}))
        ble/canvas/trace-text/.put-simple "${#span}" "$span"
        if local extend; ble/unicode/GraphemeCluster/extend-ascii "$text" "$i"; then
          out=$out${text:i:extend}
          ((i+=extend))
        fi
      else
        local c w cs cb extend
        ble/unicode/GraphemeCluster/match "$text" "$i"
        ((i+=1+extend))
        ((cb==_ble_unicode_GraphemeClusterBreak_Control)) &&
          cs=$sgr1$cs$sgr0
        ble/canvas/trace-text/.put-atomic "$w" "$cs"
      fi && ((y*cols+x<lines*cols)) ||
        { flag_overflow=1; break; }
    done
  fi
  ble/canvas/trace-text/.put-nl-if-eol
  ret=$out
  [[ ! $flag_overflow ]]
}
ble/function#suppress-stderr ble/canvas/trace-text
_ble_textmap_VARNAMES=(
  _ble_textmap_cols
  _ble_textmap_length
  _ble_textmap_begx
  _ble_textmap_begy
  _ble_textmap_endx
  _ble_textmap_endy
  _ble_textmap_pos
  _ble_textmap_glyph
  _ble_textmap_ichg
  _ble_textmap_dbeg
  _ble_textmap_dend
  _ble_textmap_dend0
  _ble_textmap_umin
  _ble_textmap_umax)
_ble_textmap_cols=80
_ble_textmap_length=
_ble_textmap_begx=0
_ble_textmap_begy=0
_ble_textmap_endx=0
_ble_textmap_endy=0
_ble_textmap_pos=()
_ble_textmap_glyph=()
_ble_textmap_ichg=()
_ble_textmap_dbeg=-1
_ble_textmap_dend=-1
_ble_textmap_dend0=-1
_ble_textmap_umin=-1
_ble_textmap_umax=-1
function ble/textmap#update-dirty-range {
  ble/dirty-range#update --prefix=_ble_textmap_d "$@"
}
function ble/textmap#save {
  local name prefix=$1
  ble/util/save-vars "$prefix" "${_ble_textmap_VARNAMES[@]}"
}
function ble/textmap#restore {
  local name prefix=$1
  ble/util/restore-vars "$prefix" "${_ble_textmap_VARNAMES[@]}"
}
function ble/textmap#update/.wrap {
  if [[ :$opts: == *:relative:* ]]; then
    ((x)) && cs=$cs${_ble_term_cub//'%d'/$x}
    cs=$cs${_ble_term_cud//'%d'/1}
    changed=1
  elif ((xenl)); then
    cs=$cs$_ble_term_cr
    changed=1
  fi
  ((y++,x=0))
}
function ble/textmap#update {
  local IFS=$_ble_term_IFS
  local dbeg dend dend0
  ((dbeg=_ble_textmap_dbeg,
    dend=_ble_textmap_dend,
    dend0=_ble_textmap_dend0))
  ble/dirty-range#clear --prefix=_ble_textmap_d
  local text=$1 opts=$2
  local iN=${#text}
  local _pos="$x $y"
  _ble_textmap_begx=$x
  _ble_textmap_begy=$y
  local cols=${COLUMNS-80} xenl=$_ble_term_xenl
  ((COLUMNS&&cols<COLUMNS&&(xenl=1)))
  ble/string#reserve-prototype "$cols"
  local it=${bleopt_tab_width:-$_ble_term_it}
  ble/string#reserve-prototype "$it"
  if ((cols!=_ble_textmap_cols)); then
    ((dbeg=0,dend0=_ble_textmap_length,dend=iN))
    _ble_textmap_pos[0]=$_pos
  elif [[ ${_ble_textmap_pos[0]} != "$_pos" ]]; then
    ((dbeg<0&&(dend=dend0=0),
      dbeg=0))
    _ble_textmap_pos[0]=$_pos
  else
    if ((dbeg<0)); then
      local pos
      ble/string#split-words pos "${_ble_textmap_pos[iN]}"
      ((x=pos[0]))
      ((y=pos[1]))
      _ble_textmap_endx=$x
      _ble_textmap_endy=$y
      return 0
    elif ((dbeg>0)); then
      local ret
      ble/unicode/GraphemeCluster/find-previous-boundary "$text" "$dbeg"; dbeg=$ret
      local pos
      ble/string#split-words pos "${_ble_textmap_pos[dbeg]}"
      ((x=pos[0]))
      ((y=pos[1]))
    fi
  fi
  _ble_textmap_cols=$cols
  _ble_textmap_length=$iN
  ble/util/assert '((dbeg<0||(dbeg<=dend&&dbeg<=dend0)))' "($dbeg $dend $dend0) <- ($_ble_textmap_dbeg $_ble_textmap_dend $_ble_textmap_dend0)"
  ble/array#reserve-prototype "$iN"
  local -a old_pos old_ichg
  old_pos=("${_ble_textmap_pos[@]:dend0:iN-dend+1}")
  old_ichg=("${_ble_textmap_ichg[@]}")
  _ble_textmap_pos=(
    "${_ble_textmap_pos[@]::dbeg+1}"
    "${_ble_array_prototype[@]::dend-dbeg}"
    "${_ble_textmap_pos[@]:dend0+1:iN-dend}")
  _ble_textmap_glyph=(
    "${_ble_textmap_glyph[@]::dbeg}"
    "${_ble_array_prototype[@]::dend-dbeg}"
    "${_ble_textmap_glyph[@]:dend0:iN-dend}")
  _ble_textmap_ichg=()
  ble/urange#shift --prefix=_ble_textmap_ "$dbeg" "$dend" "$dend0"
  local i extend
  for ((i=dbeg;i<iN;)); do
    if ble/util/isprint+ "${text:i}"; then
      local w=${#BASH_REMATCH}
      local n
      for ((n=i+w;i<n;i++)); do
        local cs=${text:i:1}
        if ((++x==cols)); then
          local changed=0
          ble/textmap#update/.wrap
          ((changed)) && ble/array#push _ble_textmap_ichg "$i"
        fi
        _ble_textmap_glyph[i]=$cs
        _ble_textmap_pos[i+1]="$x $y 0"
      done
      ble/unicode/GraphemeCluster/extend-ascii "$text" "$i"
    else
      local c w cs cb extend changed=0
      ble/unicode/GraphemeCluster/match "$text" "$i"
      if ((c<32)); then
        if ((c==9)); then
          if ((x+1>=cols)); then
            cs=' ' w=0
            ble/textmap#update/.wrap
          else
            local x2
            ((x2=(x/it+1)*it,
              x2>=cols&&(x2=cols-1),
              w=x2-x,
              w!=it&&(changed=1)))
            cs=${_ble_string_prototype::w}
          fi
        elif ((c==10)); then
          w=0
          if [[ :$opts: == *:relative:* ]]; then
            local pad=$((cols-x)) eraser=
            if ((pad)); then
              if [[ $_ble_term_ech ]]; then
                eraser=${_ble_term_ech//'%d'/$pad}
              else
                eraser=${_ble_string_prototype::pad}
                ((x=cols))
              fi
            fi
            local move=${_ble_term_cub//'%d'/$x}${_ble_term_cud//'%d'/1}
            cs=$eraser$move
            changed=1
          else
            cs=$_ble_term_el$_ble_term_nl
          fi
          ((y++,x=0))
        fi
      fi
      local wrapping=0
      if ((w>0)); then
        if ((x<cols&&cols<x+w)); then
          if [[ :$opts: == *:relative:* ]]; then
            cs=${_ble_term_cub//'%d'/$cols}${_ble_term_cud//'%d'/1}$cs
          elif ((xenl)); then
            cs=$_ble_term_cr$cs
          fi
          local pad=$((cols-x))
          if ((pad)); then
            if [[ $_ble_term_ech ]]; then
              cs=${_ble_term_ech//'%d'/$pad}$cs
            else
              cs=${_ble_string_prototype::pad}$cs
            fi
          fi
          ((x=cols,changed=1,wrapping=1))
        fi
        ((x+=w))
        while ((x>cols)); do
          ((y++,x-=cols))
        done
        if ((x==cols)); then
          ble/textmap#update/.wrap
        fi
      fi
      _ble_textmap_glyph[i]=$cs
      ((changed)) && ble/array#push _ble_textmap_ichg "$i"
      _ble_textmap_pos[i+1]="$x $y $wrapping"
      ((i++))
    fi
    while ((extend--)); do
      _ble_textmap_glyph[i]=
      _ble_textmap_pos[++i]="$x $y 0"
    done
    if ((i>=dend)); then
      [[ ${old_pos[i-dend]} == "${_ble_textmap_pos[i]}" ]] && break
      if [[ ${old_pos[i-dend]%%[$IFS]*} == "${_ble_textmap_pos[i]%%[$IFS]*}" ]]; then
        local -a opos npos pos
        opos=(${old_pos[i-dend]})
        npos=(${_ble_textmap_pos[i]})
        local ydelta=$((npos[1]-opos[1]))
        while ((i<iN)); do
          ((i++))
          pos=(${_ble_textmap_pos[i]})
          ((pos[1]+=ydelta))
          _ble_textmap_pos[i]="${pos[*]}"
        done
        pos=(${_ble_textmap_pos[iN]})
        x=${pos[0]} y=${pos[1]}
        break
      fi
    fi
  done
  if ((i<iN)); then
    local -a pos
    pos=(${_ble_textmap_pos[iN]})
    x=${pos[0]} y=${pos[1]}
  fi
  local j jN ichg
  for ((j=0,jN=${#old_ichg[@]};j<jN;j++)); do
    if ((ichg=old_ichg[j],
         (ichg>=dend0)&&(ichg+=dend-dend0),
         (0<=ichg&&ichg<dbeg||dend<=i&&ichg<iN)))
    then
      ble/array#push _ble_textmap_ichg "$ichg"
    fi
  done
  ((dbeg<i)) && ble/urange#update --prefix=_ble_textmap_ "$dbeg" "$i"
  _ble_textmap_endx=$x
  _ble_textmap_endy=$y
}
function ble/textmap#is-up-to-date {
  ((_ble_textmap_dbeg==-1))
}
function ble/textmap#assert-up-to-date {
  ble/util/assert 'ble/textmap#is-up-to-date' 'dirty text positions'
}
function ble/textmap#getxy.out {
  ble/textmap#assert-up-to-date
  local _prefix=
  if [[ $1 == --prefix=* ]]; then
    _prefix=${1#--prefix=}
    shift
  fi
  local -a _pos
  _pos=(${_ble_textmap_pos[$1]})
  ((${_prefix}x=_pos[0]))
  ((${_prefix}y=_pos[1]))
}
function ble/textmap#getxy.cur {
  ble/textmap#assert-up-to-date
  local _prefix=
  if [[ $1 == --prefix=* ]]; then
    _prefix=${1#--prefix=}
    shift
  fi
  local -a _pos
  ble/string#split-words _pos "${_ble_textmap_pos[$1]}"
  if (($1<_ble_textmap_length)); then
    local -a _eoc
    ble/string#split-words _eoc "${_ble_textmap_pos[$1+1]}"
    ((_eoc[2])) && ((_pos[0]=0,_pos[1]++))
  fi
  ((${_prefix}x=_pos[0]))
  ((${_prefix}y=_pos[1]))
}
function ble/textmap#get-index-at {
  ble/textmap#assert-up-to-date
  local _var=index
  if [[ $1 == -v ]]; then
    _var=$2
    shift 2
  fi
  local _x=$1 _y=$2
  if ((_y>_ble_textmap_endy)); then
    (($_var=_ble_textmap_length))
  elif ((_y<_ble_textmap_begy)); then
    (($_var=0))
  else
    local _l=0 _u=$((_ble_textmap_length+1)) _m
    local _mx _my
    while ((_l+1<_u)); do
      ble/textmap#getxy.cur --prefix=_m $((_m=(_l+_u)/2))
      (((_y<_my||_y==_my&&_x<_mx)?(_u=_m):(_l=_m)))
    done
    (($_var=_l))
  fi
}
function ble/textmap#hit/.getxy.out {
  local a
  ble/string#split-words a "${_ble_textmap_pos[$1]}"
  x=${a[0]} y=${a[1]}
}
function ble/textmap#hit/.getxy.cur {
  local index=$1 a
  ble/string#split-words a "${_ble_textmap_pos[index]}"
  x=${a[0]} y=${a[1]}
  if ((index<_ble_textmap_length)); then
    ble/string#split-words a "${_ble_textmap_pos[index+1]}"
    ((a[2])) && ((x=0,y++))
  fi
}
function ble/textmap#hit {
  ble/textmap#assert-up-to-date
  local getxy=ble/textmap#hit/.getxy.$1
  local xh=$2 yh=$3 beg=${4:-0} end=${5:-$_ble_textmap_length}
  local -a pos
  if "$getxy" "$end"; ((yh>y||yh==y&&xh>x)); then
    index=$end
    lx=$x ly=$y
    rx=$x ry=$y
  elif "$getxy" "$beg"; ((yh<y||yh==y&&xh<x)); then
    index=$beg
    lx=$x ly=$y
    rx=$x ry=$y
  else
    local l=0 u=$((end+1)) m
    while ((l+1<u)); do
      "$getxy" $((m=(l+u)/2))
      (((yh<y||yh==y&&xh<x)?(u=m):(l=m)))
    done
    "$getxy" $((index=l))
    lx=$x ly=$y
    (((ly<yh||ly==yh&&lx<xh)&&index<end)) && "$getxy" $((index+1))
    rx=$x ry=$y
  fi
}
_ble_canvas_x=0
_ble_canvas_y=0
_ble_canvas_excursion=
function ble/canvas/goto.draw {
  local x=$1 y=$2 opts=$3
  [[ :$opts: != *:sgr0:* ]] &&
    ((x==_ble_canvas_x&&y==_ble_canvas_y)) && return 0
  ble/canvas/put.draw "$_ble_term_sgr0"
  ble/canvas/put-move-y.draw $((y-_ble_canvas_y))
  local dx=$((x-_ble_canvas_x))
  if ((dx!=0)); then
    if ((x==0)); then
      ble/canvas/put.draw "$_ble_term_cr"
    else
      ble/canvas/put-move-x.draw "$dx"
    fi
  fi
  _ble_canvas_x=$x _ble_canvas_y=$y
}
_ble_canvas_excursion_x=
_ble_canvas_excursion_y=
function ble/canvas/excursion-start.draw {
  [[ $_ble_canvas_excursion ]] && return
  _ble_canvas_excursion=1
  _ble_canvas_excursion_x=$_ble_canvas_x
  _ble_canvas_excursion_y=$_ble_canvas_y
  ble/canvas/put.draw "$_ble_term_sc"
}
function ble/canvas/excursion-end.draw {
  [[ $_ble_canvas_excursion ]] || return
  _ble_canvas_excursion=
  ble/canvas/put.draw "$_ble_term_rc"
  _ble_canvas_x=$_ble_canvas_excursion_x
  _ble_canvas_y=$_ble_canvas_excursion_y
}
_ble_canvas_panel_class=()
_ble_canvas_panel_height=(1 0 0)
_ble_canvas_panel_focus=
_ble_canvas_panel_vfill=
_ble_canvas_panel_bottom= # 現在下部に居るかどうか
_ble_canvas_panel_tmargin='LINES!=1?1:0' # for visible-bell
function ble/canvas/panel/layout/.extract-heights {
  local i n=${#_ble_canvas_panel_class[@]}
  for ((i=0;i<n;i++)); do
    local height=0:0
    ble/function#try "${_ble_canvas_panel_class[i]}#panel::getHeight" "$i"
    mins[i]=${height%:*}
    maxs[i]=${height#*:}
  done
}
function ble/canvas/panel/layout/.determine-heights {
  local i n=${#_ble_canvas_panel_class[@]} ret
  ble/arithmetic/sum "${mins[@]}"; local min=$ret
  ble/arithmetic/sum "${maxs[@]}"; local max=$ret
  if ((max<=lines)); then
    heights=("${maxs[@]}")
  elif ((min<=lines)); then
    local room=$((lines-min))
    heights=("${mins[@]}")
    while ((room)); do
      local count=0 min_delta=-1 delta
      for ((i=0;i<n;i++)); do
        ((delta=maxs[i]-heights[i],delta>0)) || continue
        ((count++))
        ((min_delta<0||min_delta>delta)) && min_delta=$delta
      done
      ((count==0)) && break
      if ((count*min_delta<=room)); then
        for ((i=0;i<n;i++)); do
          ((maxs[i]-heights[i]>0)) || continue
          ((heights[i]+=min_delta))
        done
        ((room-=count*min_delta))
      else
        local delta=$((room/count)) rem=$((room%count)) count=0
        for ((i=0;i<n;i++)); do
          ((maxs[i]-heights[i]>0)) || continue
          ((heights[i]+=delta))
          ((count++<rem)) && ((heights[i]++))
        done
        ((room=0))
      fi
    done
  else
    heights=("${mins[@]}")
    local excess=$((min-lines))
    for ((i=n-1;i>=0;i--)); do
      local sub=$((heights[i]-heights[i]*lines/min))
      if ((sub<excess)); then
        ((excess-=sub))
        ((heights[i]-=sub))
      else
        ((heights[i]-=excess))
        break
      fi
    done
  fi
}
function ble/canvas/panel/layout/.get-available-height {
  local index=$1
  local lines=$((${LINES:-25}-_ble_canvas_panel_tmargin))
  local -a mins=() maxs=()
  ble/canvas/panel/layout/.extract-heights
  maxs[index]=${LINES:-25}
  local -a heights=()
  ble/canvas/panel/layout/.determine-heights
  ret=${heights[index]}
}
function ble/canvas/panel/reallocate-height.draw {
  local lines=$((${LINES:-25}-_ble_canvas_panel_tmargin))
  local i n=${#_ble_canvas_panel_class[@]}
  local -a mins=() maxs=()
  ble/canvas/panel/layout/.extract-heights
  local -a heights=()
  ble/canvas/panel/layout/.determine-heights
  for ((i=0;i<n;i++)); do
    ((heights[i]<_ble_canvas_panel_height[i])) &&
      ble/canvas/panel#set-height.draw "$i" "${heights[i]}"
  done
  for ((i=0;i<n;i++)); do
    ((heights[i]>_ble_canvas_panel_height[i])) &&
      ble/canvas/panel#set-height.draw "$i" "${heights[i]}"
  done
}
function ble/canvas/panel/is-last-line {
  local ret
  ble/arithmetic/sum "${_ble_canvas_panel_height[@]}"
  ((_ble_canvas_y==ret-1))
}
function ble/canvas/panel/goto-bottom-dock.draw {
  if [[ ! $_ble_canvas_panel_bottom ]]; then
    _ble_canvas_panel_bottom=1
    ble/canvas/excursion-start.draw
    ble/canvas/put-cup.draw "$LINES" 0 # 一番下の行に移動
    ble/arithmetic/sum "${_ble_canvas_panel_height[@]}"
    ((_ble_canvas_x=0,_ble_canvas_y=ret-1))
  fi
}
function ble/canvas/panel/goto-top-dock.draw {
  if [[ $_ble_canvas_panel_bottom ]]; then
    _ble_canvas_panel_bottom=
    ble/canvas/excursion-end.draw
  fi
}
function ble/canvas/panel/goto-vfill.draw {
  ble/canvas/panel/has-bottom-dock || return 1
  local ret
  ble/canvas/panel/goto-top-dock.draw
  ble/arithmetic/sum "${_ble_canvas_panel_height[@]::_ble_canvas_panel_vfill}"
  ble/canvas/goto.draw 0 "$ret" sgr0
  return 0
}
function ble/canvas/panel/save-position {
  ret=$_ble_canvas_x:$_ble_canvas_y:$_ble_canvas_panel_bottom
  [[ :$2: == *:goto-top-dock:* ]] &&
    ble/canvas/panel/goto-top-dock.draw
}
function ble/canvas/panel/load-position {
  local -a DRAW_BUFF=()
  ble/canvas/panel/load-position.draw "$@"
  ble/canvas/bflush.draw
}
function ble/canvas/panel/load-position.draw {
  local data=$1
  local x=${data%%:*}; data=${data#*:}
  local y=${data%%:*}; data=${data#*:}
  local bottom=$data
  if [[ $bottom ]]; then
    ble/canvas/panel/goto-bottom-dock.draw
  else
    ble/canvas/panel/goto-top-dock.draw
  fi
  ble/canvas/goto.draw "$x" "$y"
}
function ble/canvas/panel/has-bottom-dock {
  local ret; ble/canvas/panel/bottom-dock#height
  ((ret))
}
function ble/canvas/panel/bottom-dock#height {
  ret=0
  [[ $_ble_canvas_panel_vfill && $_ble_term_rc ]] || return 0
  ble/arithmetic/sum "${_ble_canvas_panel_height[@]:_ble_canvas_panel_vfill}"
}
function ble/canvas/panel/top-dock#height {
  if [[ $_ble_canvas_panel_vfill && $_ble_term_rc ]]; then
    ble/arithmetic/sum "${_ble_canvas_panel_height[@]::_ble_canvas_panel_vfill}"
  else
    ble/arithmetic/sum "${_ble_canvas_panel_height[@]}"
  fi
}
function ble/canvas/panel/bottom-dock#invalidate {
  [[ $_ble_canvas_panel_vfill && $_ble_term_rc ]] || return 0
  local index n=${#_ble_canvas_panel_class[@]}
  for ((index=_ble_canvas_panel_vfill;index<n;index++)); do
    local panel_class=${_ble_canvas_panel_class[index]}
    local panel_height=${_ble_canvas_panel_height[index]}
    ((panel_height)) &&
      ble/function#try "$panel_class#panel::invalidate" "$index" 0 "$panel_height"
  done
}
function ble/canvas/panel#is-bottom {
  [[ $_ble_canvas_panel_vfill && $_ble_term_rc ]] && (($1>=_ble_canvas_panel_vfill))
}
function ble/canvas/panel#get-origin {
  local ret index=$1 prefix=
  [[ $2 == --prefix=* ]] && prefix=${2#*=}
  ble/arithmetic/sum "${_ble_canvas_panel_height[@]::index}"
  ((${prefix}x=0,${prefix}y=ret))
}
function ble/canvas/panel#goto.draw {
  local index=$1 x=${2-0} y=${3-0} opts=$4 ret
  if ble/canvas/panel#is-bottom "$index"; then
    ble/canvas/panel/goto-bottom-dock.draw
  else
    ble/canvas/panel/goto-top-dock.draw
  fi
  ble/arithmetic/sum "${_ble_canvas_panel_height[@]::index}"
  ble/canvas/goto.draw "$x" $((ret+y)) "$opts"
}
function ble/canvas/panel#put.draw {
  ble/canvas/put.draw "$2"
  ble/canvas/panel#report-cursor-position "$1" "$3" "$4"
}
function ble/canvas/panel#report-cursor-position {
  local index=$1 x=${2-0} y=${3-0} ret
  ble/arithmetic/sum "${_ble_canvas_panel_height[@]::index}"
  ((_ble_canvas_x=x,_ble_canvas_y=ret+y))
}
function ble/canvas/panel/increase-total-height.draw {
  local delta=$1
  ((delta>0)) || return 1
  local ret
  ble/canvas/panel/top-dock#height; local top_height=$ret
  ble/canvas/panel/bottom-dock#height; local bottom_height=$ret
  if ((bottom_height)); then
    ble/canvas/panel/goto-top-dock.draw
    if [[ $_ble_term_DECSTBM ]]; then
      ble/canvas/excursion-start.draw
      ble/canvas/put.draw $'\e[1;'$((LINES-bottom_height))'r'
      ble/canvas/excursion-end.draw
      ble/canvas/goto.draw 0 $((top_height==0?0:top_height-1)) sgr0
      ble/canvas/put-ind.draw $((top_height-1+delta-_ble_canvas_y))
      ((_ble_canvas_y=top_height-1+delta))
      ble/canvas/excursion-start.draw
      ble/canvas/put.draw "$_ble_term_DECSTBM_reset"
      ble/canvas/excursion-end.draw
      return 0
    else
      ble/canvas/panel/bottom-dock#invalidate
    fi
  fi
  local old_height=$((top_height+bottom_height))
  local new_height=$((old_height+delta))
  ble/canvas/goto.draw 0 $((top_height==0?0:top_height-1)) sgr0
  ble/canvas/put-ind.draw $((new_height-1-_ble_canvas_y)); ((_ble_canvas_y=new_height-1))
  ble/canvas/panel/goto-vfill.draw &&
    ble/canvas/put-il.draw "$delta" vfill
}
function ble/canvas/panel#set-height.draw {
  local index=$1 new_height=$2 opts=$3
  ((new_height<0)) && new_height=0
  local old_height=${_ble_canvas_panel_height[index]}
  local delta=$((new_height-old_height))
  if ((delta==0)); then
    if [[ :$opts: == *:clear:* ]]; then
      ble/canvas/panel#clear.draw "$index"
      return $?
    else
      return 1
    fi
  elif ((delta>0)); then
    ble/canvas/panel/increase-total-height.draw "$delta"
    ble/canvas/panel/goto-vfill.draw &&
      ble/canvas/put-dl.draw "$delta" vfill
    ((_ble_canvas_panel_height[index]=new_height))
    case :$opts: in
    (*:clear:*)
      ble/canvas/panel#goto.draw "$index" 0 0 sgr0
      ble/canvas/put-clear-lines.draw "$old_height" "$new_height" panel ;;
    (*:shift:*) # 先頭に行挿入
      ble/canvas/panel#goto.draw "$index" 0 0 sgr0
      ble/canvas/put-il.draw "$delta" panel ;;
    (*) # 末尾に行挿入
      ble/canvas/panel#goto.draw "$index" 0 "$old_height" sgr0
      ble/canvas/put-il.draw "$delta" panel ;;
    esac
  else
    ((delta=-delta))
    case :$opts: in
    (*:clear:*)
      ble/canvas/panel#goto.draw "$index" 0 0 sgr0
      ble/canvas/put-clear-lines.draw "$old_height" "$new_height" panel ;;
    (*:shift:*) # 先頭を削除
      ble/canvas/panel#goto.draw "$index" 0 0 sgr0
      ble/canvas/put-dl.draw "$delta" panel ;;
    (*) # 末尾を削除
      ble/canvas/panel#goto.draw "$index" 0 "$new_height" sgr0
      ble/canvas/put-dl.draw "$delta" panel ;;
    esac
    ((_ble_canvas_panel_height[index]=new_height))
    ble/canvas/panel/goto-vfill.draw &&
      ble/canvas/put-il.draw "$delta" vfill
  fi
  ble/function#try "${_ble_canvas_panel_class[index]}#panel::onHeightChange" "$index"
  return 0
}
function ble/canvas/panel#increase-height.draw {
  local index=$1 delta=$2 opts=$3
  ble/canvas/panel#set-height.draw "$index" $((_ble_canvas_panel_height[index]+delta)) "$opts"
}
function ble/canvas/panel#set-height-and-clear.draw {
  local index=$1 new_height=$2
  ble/canvas/panel#set-height.draw "$index" "$new_height" clear
}
function ble/canvas/panel#clear.draw {
  local index=$1
  local height=${_ble_canvas_panel_height[index]}
  if ((height)); then
    ble/canvas/panel#goto.draw "$index" 0 0 sgr0
    ble/canvas/put-clear-lines.draw "$height"
  fi
}
function ble/canvas/panel#clear-after.draw {
  local index=$1 x=$2 y=$3
  local height=${_ble_canvas_panel_height[index]}
  ((y<height)) || return 1
  ble/canvas/panel#goto.draw "$index" "$x" "$y" sgr0
  ble/canvas/put.draw "$_ble_term_el"
  local rest_lines=$((height-(y+1)))
  if ((rest_lines)); then
    ble/canvas/put.draw "$_ble_term_ind"
    [[ $_ble_term_ind != $'\eD' ]] &&
      ble/canvas/put-hpa.draw $((x+1))
    ble/canvas/put-clear-lines.draw "$rest_lines"
    ble/canvas/put-cuu.draw 1
  fi
}
function ble/canvas/panel/clear {
  local -a DRAW_BUFF=()
  local index n=${#_ble_canvas_panel_class[@]}
  for ((index=0;index<n;index++)); do
    local panel_class=${_ble_canvas_panel_class[index]}
    local panel_height=${_ble_canvas_panel_height[index]}
    ((panel_height)) || continue
    ble/canvas/panel#clear.draw "$index"
    ble/function#try "$panel_class#panel::invalidate" "$index" 0 "$panel_height"
  done
  ble/canvas/bflush.draw
}
function ble/canvas/panel/invalidate {
  local opts=$1
  if [[ :$opts: == *:height:* ]]; then
    local -a DRAW_BUFF=()
    ble/canvas/excursion-end.draw
    ble/canvas/put.draw "$_ble_term_cr$_ble_term_ed"
    _ble_canvas_x=0 _ble_canvas_y=0
    ble/array#fill-range _ble_canvas_panel_height 0 "${#_ble_canvas_panel_height[@]}" 0
    ble/canvas/panel/reallocate-height.draw
    ble/canvas/bflush.draw
  fi
  local index n=${#_ble_canvas_panel_class[@]}
  for ((index=0;index<n;index++)); do
    local panel_class=${_ble_canvas_panel_class[index]}
    local panel_height=${_ble_canvas_panel_height[index]}
    ((panel_height)) || continue
    ble/function#try "$panel_class#panel::invalidate" "$index" 0 "$panel_height"
  done
}
function ble/canvas/panel/render {
  local index n=${#_ble_canvas_panel_class[@]} pos=
  for ((index=0;index<n;index++)); do
    local panel_class=${_ble_canvas_panel_class[index]}
    local panel_height=${_ble_canvas_panel_height[index]}
    ble/function#try "$panel_class#panel::render" "$index" 0 "$panel_height"
    if [[ $_ble_canvas_panel_focus ]] && ((index==_ble_canvas_panel_focus)); then
      local ret; ble/canvas/panel/save-position; local pos=$ret
    fi
  done
  [[ $pos ]] && ble/canvas/panel/load-position "$pos"
  return 0
}
function ble/canvas/panel/ensure-tmargin.draw {
  local tmargin=$((_ble_canvas_panel_tmargin))
  ((tmargin>LINES)) && tmargin=$LINES
  ((tmargin>0)) || return 0
  local ret
  ble/canvas/panel/save-position; local pos=$ret
  ble/canvas/panel/goto-top-dock.draw
  ble/canvas/panel/top-dock#height; local top_height=$ret
  ble/canvas/panel/bottom-dock#height; local bottom_height=$ret
  if ((bottom_height)); then
    if [[ $_ble_term_DECSTBM ]]; then
      ble/canvas/excursion-start.draw
      ble/canvas/put.draw $'\e[1;'$((LINES-bottom_height))'r'
      ble/canvas/excursion-end.draw
      ble/canvas/goto.draw 0 0 sgr0
      if [[ $_ble_term_ri ]]; then
        ble/canvas/put-ri.draw "$tmargin"
        ble/canvas/put-cud.draw "$tmargin"
      else
        ble/canvas/put-ind.draw $((top_height-1+tmargin))
        ble/canvas/put-cuu.draw $((top_height-1+tmargin))
        ble/canvas/excursion-start.draw
        ble/canvas/put-cup.draw 1 1
        ble/canvas/put-il.draw "$tmargin" no-lastline
        ble/canvas/excursion-end.draw
      fi
      ble/canvas/excursion-start.draw
      ble/canvas/put.draw "$_ble_term_DECSTBM_reset"
      ble/canvas/excursion-end.draw
      ble/canvas/panel/load-position.draw "$pos"
      return 0
    else
      ble/canvas/panel/bottom-dock#invalidate
    fi
  fi
  ble/canvas/goto.draw 0 0 sgr0
  if [[ $_ble_term_ri ]]; then
    ble/canvas/put-ri.draw "$tmargin"
    ble/canvas/put-cud.draw "$tmargin"
  else
    local total_height=$((top_height+bottom_height))
    ble/canvas/put-ind.draw $((total_height-1+tmargin))
    ble/canvas/put-cuu.draw $((total_height-1+tmargin))
    if [[ $_ble_term_rc ]]; then
      ble/canvas/excursion-start.draw
      ble/canvas/put-cup.draw 1 1
      ble/canvas/put-il.draw "$tmargin" no-lastline
      ble/canvas/excursion-end.draw
    else
      ble/canvas/put-il.draw "$tmargin" no-lastline
    fi
    ble/canvas/put-cud.draw "$tmargin"
  fi
  ble/canvas/panel/load-position.draw "$pos"
}
bleopt/declare -v history_limit_length 10000
_ble_history=()
_ble_history_edit=()
_ble_history_dirt=()
_ble_history_index=0
_ble_history_count=
function ble/builtin/history/is-empty {
  ! ble/util/assign.has-output 'history 1'
}
function ble/builtin/history/.get-min {
  ble/util/assign min 'builtin history | head -1'
  ble/string#split-words min "$min"
}
function ble/builtin/history/.get-max {
  ble/util/assign max 'builtin history 1'
  ble/string#split-words max "$max"
}
_ble_history_load_done=
function ble/history:bash/clear-background-load {
  blehook/invoke history_reset_background
}
if ((_ble_bash>=40000)); then
  _ble_history_load_resume=0
  _ble_history_load_bgpid=
  function ble/history:bash/load/.background-initialize {
    if ble/builtin/history/is-empty; then
      builtin history -n
    fi
    local HISTTIMEFORMAT=__ble_ext__
    local -x INDEX_FILE=$history_indfile
    local -x opt_source= opt_null=
    if [[ $load_strategy == source ]]; then
      opt_source=1
    elif [[ $load_strategy == mapfile ]]; then
      opt_null=1
    fi
    local apos=\'
    builtin history $arg_count | ble/bin/awk -v apos="$apos" -v arg_offset="$arg_offset" -v _ble_bash="$_ble_bash" '
      function s2i_initialize() {
        for (i = 0; i < 16; i++)
          xdigit2int[sprintf("%x", i)] = i;
        for (i = 10; i < 16; i++)
          xdigit2int[sprintf("%X", i)] = i;
      }
      function s2i(s, base, _, i, n, r) {
        if (!base) base = 10;
        r = 0;
        n = length(s);
        for (i = 1; i <= n; i++)
          r = r * base + xdigit2int[substr(s, i, 1)];
        return r;
      }
      function c2s_initialize(_, i) {
        if (sprintf("%c", 945) == "α") {
          C2S_UNICODE_PRINTF_C = 1;
        } else {
          C2S_UNICODE_PRINTF_C = 0;
          for (i = 1; i <= 255; i++)
            c2s_byte2char[i] = sprintf("%c", i);
        }
      }
      function c2s(code, _, leadbyte_mark, leadbyte_sup, tail) {
        if (C2S_UNICODE_PRINTF_C)
          return sprintf("%c", code);
        leadbyte_sup = 128; # 0x80
        leadbyte_mark = 0;
        tail = "";
        while (leadbyte_sup && code >= leadbyte_sup) {
          leadbyte_sup /= 2;
          leadbyte_mark = leadbyte_mark ? leadbyte_mark / 2 : 65472; # 0xFFC0
          tail = c2s_byte2char[128 + int(code % 64)] tail;
          code = int(code / 64);
        }
        return c2s_byte2char[(leadbyte_mark + code) % 256] tail;
      }
      function es_initialize(_, c) {
        es_control_chars["a"] = "\a";
        es_control_chars["b"] = "\b";
        es_control_chars["t"] = "\t";
        es_control_chars["n"] = "\n";
        es_control_chars["v"] = "\v";
        es_control_chars["f"] = "\f";
        es_control_chars["r"] = "\r";
        es_control_chars["e"] = "\033";
        es_control_chars["E"] = "\033";
        es_control_chars["?"] = "?";
        es_control_chars[apos] = apos;
        es_control_chars["\""] = "\"";
        es_control_chars["\\"] = "\\";
        for (c = 32; c < 127; c++)
          es_s2c[sprintf("%c", c)] = c;
      }
      function es_unescape(s, _, head, c) {
        head = "";
        while (match(s, /^[^\\]*\\/)) {
          head = head substr(s, 1, RLENGTH - 1);
          s = substr(s, RLENGTH + 1);
          if ((c = es_control_chars[substr(s, 1, 1)])) {
            head = head c;
            s = substr(s, 2);
          } else if (match(s, /^[0-9]([0-9][0-9]?)?/)) {
            head = head c2s(s2i(substr(s, 1, RLENGTH), 8) % 256);
            s = substr(s, RLENGTH + 1);
          } else if (match(s, /^x[0-9a-fA-F][0-9a-fA-F]?/)) {
            head = head c2s(s2i(substr(s, 2, RLENGTH - 1), 16));
            s = substr(s, RLENGTH + 1);
          } else if (match(s, /^U[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]([0-9a-fA-F]([0-9a-fA-F][0-9a-fA-F]?)?)?/)) {
            head = head c2s(s2i(substr(s, 2, RLENGTH - 1), 16));
            s = substr(s, RLENGTH + 1);
          } else if (match(s, /^[uU][0-9a-fA-F]([0-9a-fA-F]([0-9a-fA-F][0-9a-fA-F]?)?)?/)) {
            head = head c2s(s2i(substr(s, 2, RLENGTH - 1), 16));
            s = substr(s, RLENGTH + 1);
          } else if (match(s, /^c[ -~]/)) {
            c = es_s2c[substr(s, 2, 1)];
            head = head c2s(_ble_bash >= 40400 && c == 63 ? 127 : c % 32);
            s = substr(s, 3);
          } else {
            head = head "\\";
          }
        }
        return head s;
      }
      BEGIN {
        s2i_initialize();
        c2s_initialize();
        es_initialize();
        INDEX_FILE = ENVIRON["INDEX_FILE"];
        opt_null = ENVIRON["opt_null"];
        opt_source = ENVIRON["opt_source"];
        if (!opt_null && !opt_source)
          printf("") > INDEX_FILE; # create file
        n = 0;
        hindex = arg_offset;
      }
      function flush_line() {
        if (n < 1) return;
        if (opt_null) {
          if (t ~ /^eval -- \$'$apos'([^'$apos'\\]|\\.)*'$apos'$/)
            t = es_unescape(substr(t, 11, length(t) - 11));
          printf("%s%c", t, 0);
        } else if (opt_source) {
          if (t ~ /^eval -- \$'$apos'([^'$apos'\\]|\\.)*'$apos'$/)
            t = es_unescape(substr(t, 11, length(t) - 11));
          gsub(/'$apos'/, "'$apos'\\'$apos$apos'", t);
          print "_ble_history[" hindex "]=" apos t apos;
        } else {
          if (n == 1) {
            if (t ~ /^eval -- \$'$apos'([^'$apos'\\]|\\.)*'$apos'$/)
              print hindex > INDEX_FILE;
          } else {
            gsub(/['$apos'\\]/, "\\\\&", t);
            gsub(/\n/, "\\n", t);
            print hindex > INDEX_FILE;
            t = "eval -- $" apos t apos;
          }
          print t;
        }
        hindex++;
        n = 0;
        t = "";
      }
      {
        if (sub(/^ *[0-9]+\*? +(__ble_ext__|\?\?)/, "", $0))
          flush_line();
        t = ++n == 1 ? $0 : t "\n" $0;
      }
      END { flush_line(); }
    ' >| "$history_tmpfile.part"
    ble/bin/mv -f "$history_tmpfile.part" "$history_tmpfile"
  }
  function ble/history:bash/load {
    local opts=$1
    local opt_async=; [[ :$opts: == *:async:* ]] && opt_async=1
    local load_strategy=mapfile
    if [[ $OSTYPE == cygwin* || $OSTYPE == msys* ]]; then
      load_strategy=source
    elif ((_ble_bash<50200)); then
      load_strategy=nlfix
    fi
    local arg_count= arg_offset=0
    [[ :$opts: == *:append:* ]] &&
      arg_offset=${#_ble_history[@]}
    local rex=':count=([0-9]+):'; [[ :$opts: =~ $rex ]] && arg_count=${BASH_REMATCH[1]}
    local history_tmpfile=$_ble_base_run/$$.history.load
    local history_indfile=$_ble_base_run/$$.history.multiline-index
    [[ $opt_async || :$opts: == *:init:* ]] || _ble_history_load_resume=0
    [[ ! $opt_async ]] && ((_ble_history_load_resume<6)) &&
      blehook/invoke history_message "loading history ..."
    while :; do
      case $_ble_history_load_resume in
      (0) # 履歴ファイル生成を Background で開始
          if [[ $_ble_history_load_bgpid ]]; then
            builtin kill -9 "$_ble_history_load_bgpid" &>/dev/null
            _ble_history_load_bgpid=
          fi
          : >| "$history_tmpfile"
          if [[ $opt_async ]]; then
            _ble_history_load_bgpid=$(
              shopt -u huponexit; ble/history:bash/load/.background-initialize </dev/null &>/dev/null & ble/util/print $!)
            function ble/history:bash/load/.background-initialize-completed {
              local history_tmpfile=$_ble_base_run/$$.history.load
              [[ -s $history_tmpfile ]] || ! builtin kill -0 "$_ble_history_load_bgpid"
            } &>/dev/null
            ((_ble_history_load_resume++))
          else
            ble/history:bash/load/.background-initialize
            ((_ble_history_load_resume+=3))
          fi ;;
      (1) if [[ $opt_async ]] && ble/util/is-running-in-idle; then
            ble/util/idle.wait-condition ble/history:bash/load/.background-initialize-completed
            ((_ble_history_load_resume++))
            return 147
          fi
          ((_ble_history_load_resume++)) ;;
      (2) while ! ble/history:bash/load/.background-initialize-completed; do
            ble/util/msleep 50
            [[ $opt_async ]] && ! ble/util/idle/IS_IDLE && return 148
          done
          ((_ble_history_load_resume++)) ;;
      (3) _ble_history_load_bgpid=
          ((arg_offset==0)) && _ble_history=()
          if [[ $load_strategy == source ]]; then
            source "$history_tmpfile"
          elif [[ $load_strategy == nlfix ]]; then
            builtin mapfile -O "$arg_offset" -t _ble_history < "$history_tmpfile"
          else
            builtin mapfile -O "$arg_offset" -t -d '' _ble_history < "$history_tmpfile"
          fi
          ((_ble_history_load_resume++)) ;;
      (4) ((arg_offset==0)) && _ble_history_edit=()
          if [[ $load_strategy == source ]]; then
            _ble_history_edit=("${_ble_history[@]}")
          elif [[ $load_strategy == nlfix ]]; then
            builtin mapfile -O "$arg_offset" -t _ble_history_edit < "$history_tmpfile"
          else
            builtin mapfile -O "$arg_offset" -t -d '' _ble_history_edit < "$history_tmpfile"
          fi
          : >| "$history_tmpfile"
          if [[ $load_strategy != nlfix ]]; then
            ((_ble_history_load_resume+=3))
            return 0
          else
            ((_ble_history_load_resume++))
          fi ;;
      (5) local -a indices_to_fix
          ble/util/mapfile indices_to_fix < "$history_indfile"
          local i rex='^eval -- \$'\''([^\'\'']|\\.)*'\''$'
          for i in "${indices_to_fix[@]}"; do
            [[ ${_ble_history[i]} =~ $rex ]] &&
              builtin eval "_ble_history[i]=${_ble_history[i]:8}"
          done
          ((_ble_history_load_resume++)) ;;
      (6) local -a indices_to_fix
          [[ ${indices_to_fix+set} ]] ||
            ble/util/mapfile indices_to_fix < "$history_indfile"
          for i in "${indices_to_fix[@]}"; do
            [[ ${_ble_history_edit[i]} =~ $rex ]] &&
              builtin eval "_ble_history_edit[i]=${_ble_history_edit[i]:8}"
          done
          ((_ble_history_load_resume++)) ;;
      (7) [[ $opt_async ]] || blehook/invoke history_message
          ((_ble_history_load_resume++))
          return 0 ;;
      (*) return 1 ;;
      esac
      [[ $opt_async ]] && ! ble/util/idle/IS_IDLE && return 148
    done
  }
  blehook history_reset_background+=_ble_history_load_resume=0
else
  function ble/history:bash/load/.generate-source {
    if ble/builtin/history/is-empty; then
      builtin history -n
    fi
    local HISTTIMEFORMAT=__ble_ext__
    local apos="'"
    builtin history $arg_count | ble/bin/awk -v apos="'" '
      BEGIN { n = ""; }
      /^ *[0-9]+\*? +(__ble_ext__|\?\?)#[0-9]/ { next; }
      /^ *[0-9]+\*? +(__ble_ext__|\?\?)/ {
        if (n != "") {
          n = "";
          print "  " apos t apos;
        }
        n = $1; t = "";
        sub(/^ *[0-9]+\*? +(__ble_ext__|\?\?)/, "", $0);
      }
      {
        line = $0;
        if (line ~ /^eval -- \$'$apos'([^'$apos'\\]|\\.)*'$apos'$/)
          line = apos substr(line, 9) apos;
        else
          gsub(apos, apos "\\" apos apos, line);
        gsub(/\001/, "'$apos'${_ble_term_SOH}'$apos'", line);
        gsub(/\177/, "'$apos'${_ble_term_DEL}'$apos'", line);
        gsub(/\015/, "'$apos'${_ble_term_CR}'$apos'", line);
        t = t != "" ? t "\n" line : line;
      }
      END {
        if (n != "") {
          n = "";
          print "  " apos t apos;
        }
      }
    '
  }
  function ble/history:bash/load {
    local opts=$1
    local opt_append=
    [[ :$opts: == *:append:* ]] && opt_append=1
    local arg_count= rex=':count=([0-9]+):'
    [[ :$opts: =~ $rex ]] && arg_count=${BASH_REMATCH[1]}
    blehook/invoke history_message "loading history..."
    local result=$(ble/history:bash/load/.generate-source)
    local IFS=$_ble_term_IFS
    if [[ $opt_append ]]; then
      if ((_ble_bash>=30100)); then
        builtin eval -- "_ble_history+=($result)"
        builtin eval -- "_ble_history_edit+=($result)"
      else
        local -a A; builtin eval -- "A=($result)"
        _ble_history=("${_ble_history[@]}" "${A[@]}")
        _ble_history_edit=("${_ble_history[@]}" "${A[@]}")
      fi
    else
      builtin eval -- "_ble_history=($result)"
      _ble_history_edit=("${_ble_history[@]}")
    fi
    ble/util/unlocal IFS
    blehook/invoke history_message
  }
fi
function ble/history:bash/initialize {
  [[ $_ble_history_load_done ]] && return 0
  ble/history:bash/load "init:$@"; local ext=$?
  ((ext)) && return "$ext"
  local old_count=$_ble_history_count new_count=${#_ble_history[@]}
  _ble_history_load_done=1
  _ble_history_count=$new_count
  _ble_history_index=$_ble_history_count
  ble/history/.update-position
  local delta=$((new_count-old_count))
  ((delta>0)) && blehook/invoke history_insert "$old_count" "$delta"
}
if ((_ble_bash>=30100)); then
  _ble_history_mlfix_done=
  _ble_history_mlfix_resume=0
  _ble_history_mlfix_bgpid=
  function ble/history:bash/resolve-multiline/.awk {
    if ((_ble_bash>=50000)); then
      local -x epoch=$EPOCHSECONDS
    elif ((_ble_bash>=40400)); then
      local -x epoch
      ble/util/strftime -v epoch %s
    fi
    local -x reason=$1
    local apos=\'
    ble/bin/awk -v apos="$apos" -v _ble_bash="$_ble_bash" '
      BEGIN {
        q = apos;
        Q = apos "\\" apos apos;
        reason = ENVIRON["reason"];
        is_resolve = reason == "resolve";
        TMPBASE = ENVIRON["TMPBASE"];
        filename_source = TMPBASE ".part";
        if (is_resolve)
          print "builtin history -c" > filename_source
        entry_nline = 0;
        entry_text = "";
        entry_time = "";
        if (_ble_bash >= 40400)
          entry_time = ENVIRON["epoch"];
        command_count = 0;
        multiline_count = 0;
        modification_count = 0;
        read_section_count = 0;
      }
      function write_flush(_, i, filename_section, t, c) {
        if (command_count == 0) return;
        if (command_count >= 2 || entry_time) {
          filename_section = TMPBASE "." read_section_count++ ".part";
          for (i = 0; i < command_count; i++) {
            t = command_time[i];
            c = command_text[i];
            if (t) print "#" t > filename_section;
            print c > filename_section;
          }
          print "HISTTIMEFORMAT=%s builtin history -r " filename_section > filename_source;
        } else {
          for (i = 0; i < command_count; i++) {
            c = command_text[i];
            gsub(/'$apos'/, Q, c);
            print "builtin history -s -- " q c q > filename_source;
          }
        }
        command_count = 0;
      }
      function write_complex(value) {
        write_flush();
        print "builtin history -s -- " value > filename_source;
      }
      function register_command(cmd) {
        command_time[command_count] = entry_time;
        command_text[command_count] = cmd;
        command_count++;
      }
      function is_escaped_command(cmd) {
        return cmd ~ /^eval -- \$'$apos'([^'$apos'\\]|\\[\\'$apos'nt])*'$apos'$/;
      }
      function unescape_command(cmd) {
        cmd = substr(cmd, 11, length(cmd) - 11);
        gsub(/\\\\/, "\\q", cmd);
        gsub(/\\n/, "\n", cmd);
        gsub(/\\t/, "\t", cmd);
        gsub(/\\'$apos'/, "'$apos'", cmd);
        gsub(/\\q/, "\\", cmd);
        return cmd;
      }
      function register_escaped_command(cmd) {
        multiline_count++;
        modification_count++;
        if (_ble_bash >= 40400) {
          register_command(unescape_command(cmd));
        } else {
          write_complex(substr(cmd, 9));
        }
      }
      function register_multiline_command(cmd) {
        multiline_count++;
        if (_ble_bash >= 40040) {
          register_command(cmd);
        } else {
          gsub(/'$apos'/, Q, cmd);
          write_complex(q cmd q);
        }
      }
      function flush_entry() {
        if (entry_nline < 1) return;
        if (is_escaped_command(entry_text)) {
          register_escaped_command(entry_text)
        } else if (entry_nline > 1) {
          register_multiline_command(entry_text);
        } else {
          register_command(entry_text);
        }
        entry_nline = 0;
        entry_text = "";
      }
      function save_timestamp(line) {
        if (is_resolve) {
          if (line ~ /^ *[0-9]+\*? +__ble_time_[0-9]+__/) {
            sub(/^ *[0-9]+\*? +__ble_time_/, "", line);
            sub(/__.*$/, "", line);
            entry_time = line;
          }
        } else {
          if (line ~ /^#[0-9]/) {
            sub(/^#/, "", line);
            sub(/[^0-9].*$/, "", line);
            entry_time = line;
          }
        }
      }
      {
        if (is_resolve) {
          save_timestamp($0);
          if (sub(/^ *[0-9]+\*? +(__ble_time_[0-9]+__|\?\?)/, "", $0))
            flush_entry();
          entry_text = ++entry_nline == 1 ? $0 : entry_text "\n" $0;
        } else {
          if ($0 ~ /^#[0-9]/) {
            save_timestamp($0);
            next;
          } else {
            flush_entry();
            entry_text = $0;
            entry_nline = 1;
          }
        }
      }
      END {
        flush_entry();
        write_flush();
        if (is_resolve)
          print "builtin history -a /dev/null" > filename_source
        print "multiline_count=" multiline_count;
        print "modification_count=" modification_count;
      }
    '
  }
  function ble/history:bash/resolve-multiline/.cleanup {
    local file
    for file in "$TMPBASE".*; do : >| "$file"; done
  }
  function ble/history:bash/resolve-multiline/.worker {
    local HISTTIMEFORMAT=__ble_time_%s__
    local -x TMPBASE=$_ble_base_run/$$.history.mlfix
    local multiline_count=0 modification_count=0
    builtin eval -- "$(builtin history | ble/history:bash/resolve-multiline/.awk resolve 2>/dev/null)"
    if ((modification_count)); then
      ble/bin/mv -f "$TMPBASE.part" "$TMPBASE.sh"
    else
      ble/util/print : >| "$TMPBASE.sh"
    fi
  }
  function ble/history:bash/resolve-multiline/.load {
    local TMPBASE=$_ble_base_run/$$.history.mlfix
    local HISTCONTROL= HISTSIZE= HISTIGNORE=
    source "$TMPBASE.sh"
    ble/history:bash/resolve-multiline/.cleanup
  }
  function ble/history:bash/resolve-multiline.impl {
    local opts=$1
    local opt_async=; [[ :$opts: == *:async:* ]] && opt_async=1
    local history_tmpfile=$_ble_base_run/$$.history.mlfix.sh
    [[ $opt_async || :$opts: == *:init:* ]] || _ble_history_mlfix_resume=0
    [[ ! $opt_async ]] && ((_ble_history_mlfix_resume<=4)) &&
      blehook/invoke history_message "resolving multiline history ..."
    while :; do
      case $_ble_history_mlfix_resume in
      (0) if [[ $opt_async ]] && ble/builtin/history/is-empty; then
            ble/util/idle.wait-user-input
            ((_ble_history_mlfix_resume++))
            return 147
          fi
          ((_ble_history_mlfix_resume++)) ;;
      (1) # 履歴ファイル生成を Background で開始
        if [[ $_ble_history_mlfix_bgpid ]]; then
          builtin kill -9 "$_ble_history_mlfix_bgpid" &>/dev/null
          _ble_history_mlfix_bgpid=
        fi
        : >| "$history_tmpfile"
        if [[ $opt_async ]]; then
          _ble_history_mlfix_bgpid=$(
            shopt -u huponexit; ble/history:bash/resolve-multiline/.worker </dev/null &>/dev/null & ble/util/print $!)
          function ble/history:bash/resolve-multiline/.worker-completed {
            local history_tmpfile=$_ble_base_run/$$.history.mlfix.sh
            [[ -s $history_tmpfile ]] || ! builtin kill -0 "$_ble_history_mlfix_bgpid"
          } &>/dev/null
          ((_ble_history_mlfix_resume++))
        else
          ble/history:bash/resolve-multiline/.worker
          ((_ble_history_mlfix_resume+=3))
        fi ;;
      (2) if [[ $opt_async ]] && ble/util/is-running-in-idle; then
            ble/util/idle.wait-condition ble/history:bash/resolve-multiline/.worker-completed
            ((_ble_history_mlfix_resume++))
            return 147
          fi
          ((_ble_history_mlfix_resume++)) ;;
      (3) while ! ble/history:bash/resolve-multiline/.worker-completed; do
            ble/util/msleep 50
            [[ $opt_async ]] && ! ble/util/idle/IS_IDLE && return 148
          done
          ((_ble_history_mlfix_resume++)) ;;
      (4) _ble_history_mlfix_bgpid=
          ble/history:bash/resolve-multiline/.load
          [[ $opt_async ]] || blehook/invoke history_message
          ((_ble_history_mlfix_resume++))
          return 0 ;;
      (*) return 1 ;;
      esac
      [[ $opt_async ]] && ! ble/util/idle/IS_IDLE && return 148
    done
  }
  function ble/history:bash/resolve-multiline {
    [[ $_ble_history_mlfix_done ]] && return 0
    if [[ $1 == sync ]]; then
      ((_ble_bash>=40000)) && [[ $BASHPID != $$ ]] && return 0
      ble/builtin/history/is-empty && return 0
    fi
    ble/history:bash/resolve-multiline.impl "$@"; local ext=$?
    ((ext)) && return "$ext"
    _ble_history_mlfix_done=1
    return 0
  }
  ((_ble_bash>=40000)) &&
    ble/util/idle.push 'ble/history:bash/resolve-multiline async'
  blehook history_reset_background+=_ble_history_mlfix_resume=0
  function ble/history:bash/resolve-multiline/readfile {
    local filename=$1
    local -x TMPBASE=$_ble_base_run/$$.history.read
    ble/history:bash/resolve-multiline/.awk read < "$filename" &>/dev/null
    source "$TMPBASE.part"
    ble/history:bash/resolve-multiline/.cleanup
  }
fi
function ble/history:bash/TRAPEXIT {
  ble/util/is-running-in-subshell && return 0
  if shopt -q histappend &>/dev/null; then
    ble/builtin/history -a
  else
    ble/builtin/history -w
  fi
}
blehook EXIT+=ble/history:bash/TRAPEXIT
function ble/history:bash/reset {
  if ((_ble_bash>=40000)); then
    _ble_history_load_done=
    ble/history:bash/clear-background-load
    ble/util/idle.push 'ble/history:bash/initialize async'
  elif ((_ble_bash>=30100)) && [[ $bleopt_history_lazyload ]]; then
    _ble_history_load_done=
  else
    ble/history:bash/initialize
  fi
}
function ble/builtin/history/.touch-histfile {
  local touch=$_ble_base_run/$$.history.touch
  : >| "$touch"
}
if [[ ! ${_ble_builtin_history_initialized+set} ]]; then
  _ble_builtin_history_initialized=
  _ble_builtin_history_histnew_count=0
  _ble_builtin_history_histapp_count=0
  _ble_builtin_history_wskip=0
  _ble_builtin_history_prevmax=0
  builtin eval -- "${_ble_util_gdict_declare//NAME/_ble_builtin_history_rskip_dict}"
  function ble/builtin/history/.get-rskip {
    local file=$1 ret
    ble/gdict#get _ble_builtin_history_rskip_dict "$file"
    rskip=$ret
  }
  function ble/builtin/history/.set-rskip {
    local file=$1
    ble/gdict#set _ble_builtin_history_rskip_dict "$file" "$2"
  }
  function ble/builtin/history/.add-rskip {
    local file=$1 ret
    ble/gdict#get _ble_builtin_history_rskip_dict "$file"
    ((ret+=$2))
    ble/gdict#set _ble_builtin_history_rskip_dict "$file" "$ret"
  }
fi
function ble/builtin/history/.initialize {
  [[ $_ble_builtin_history_initialized ]] && return 0
  local line; ble/util/assign line 'builtin history 1'
  [[ ! $line && :$1: == *:skip0:* ]] && return 1
  _ble_builtin_history_initialized=1
  local histnew=$_ble_base_run/$$.history.new
  : >| "$histnew"
  if [[ $line ]]; then
    local histini=$_ble_base_run/$$.history.ini
    local histapp=$_ble_base_run/$$.history.app
    HISTTIMEFORMAT=1 builtin history -a "$histini"
    if [[ -s $histini ]]; then
      ble/bin/sed '/^#\([0-9].*\)/{s//    0  __ble_time_\1__/;N;s/\n//;}' "$histini" >> "$histapp"
      : >| "$histini"
    fi
  else
    ble/builtin/history/option:r
  fi
  local histfile=${HISTFILE:-$HOME/.bash_history}
  local rskip=$(ble/bin/wc -l "$histfile" 2>/dev/null)
  ble/string#split-words rskip "$rskip"
  local min; ble/builtin/history/.get-min
  local max; ble/builtin/history/.get-max
  ((max&&max-min+1<rskip&&(rskip=max-min+1)))
  _ble_builtin_history_wskip=$max
  _ble_builtin_history_prevmax=$max
  ble/builtin/history/.set-rskip "$histfile" "$rskip"
  return 0
}
function ble/builtin/history/.delete-range {
  local beg=$1 end=${2:-$1}
  if ((_ble_bash>=50000&&beg<end)); then
    builtin history -d "$beg-$end"
  else
    local i
    for ((i=end;i>=beg;i--)); do
      builtin history -d "$i"
    done
  fi
}
function ble/builtin/history/.check-uncontrolled-change {
  [[ $_ble_decode_bind_state == none ]] && return 0
  local filename=${1-} opts=${2-} prevmax=$_ble_builtin_history_prevmax
  local max; ble/builtin/history/.get-max
  if ((max!=prevmax)); then
    if [[ $filename && :$opts: == *:append:* ]] && ((_ble_builtin_history_wskip<prevmax&&prevmax<max)); then
      (
        ble/builtin/history/.delete-range $((prevmax+1)) "$max"
        ble/builtin/history/.write "$filename" "$_ble_builtin_history_wskip" append:fetch
      )
    fi
    _ble_builtin_history_wskip=$max
    _ble_builtin_history_prevmax=$max
  fi
}
function ble/builtin/history/.load-recent-entries {
  [[ $_ble_decode_bind_state == none ]] && return 0
  local delta=$1
  ((delta>0)) || return 0
  if [[ ! $_ble_history_load_done ]]; then
    ble/history:bash/clear-background-load
    _ble_history_count=
    return 0
  fi
  if ((_ble_bash>=40000&&delta>=10000)); then
    ble/history:bash/reset
    return 0
  fi
  ble/history:bash/load append:count=$delta
  local ocount=$_ble_history_count ncount=${#_ble_history[@]}
  ((_ble_history_index==_ble_history_count)) && _ble_history_index=$ncount
  _ble_history_count=$ncount
  ble/history/.update-position
  blehook/invoke history_insert "$ocount" "$delta"
}
function ble/builtin/history/.read {
  local file=$1 skip=${2:-0} fetch=$3
  local -x histnew=$_ble_base_run/$$.history.new
  if [[ -s $file ]]; then
    local script=$(ble/bin/awk -v skip=$skip '
      BEGIN { histnew = ENVIRON["histnew"]; count = 0; }
      NR <= skip { next; }
      { print $0 >> histnew; count++; }
      END {
        print "ble/builtin/history/.set-rskip \"$file\" " NR;
        print "((_ble_builtin_history_histnew_count+=" count "))";
      }
    ' "$file")
    builtin eval -- "$script"
  else
    ble/builtin/history/.set-rskip "$file" 0
  fi
  if [[ ! $fetch && -s $histnew ]]; then
    local nline=$_ble_builtin_history_histnew_count
    ble/history:bash/resolve-multiline/readfile "$histnew"
    : >| "$histnew"
    _ble_builtin_history_histnew_count=0
    ble/builtin/history/.load-recent-entries "$nline"
    local max; ble/builtin/history/.get-max
    _ble_builtin_history_wskip=$max
    _ble_builtin_history_prevmax=$max
  fi
}
function ble/builtin/history/.write {
  local -x file=$1 skip=${2:-0} opts=$3
  local -x histapp=$_ble_base_run/$$.history.app
  declare -p HISTTIMEFORMAT &>/dev/null
  local -x flag_timestamp=$(($?==0))
  local min; ble/builtin/history/.get-min
  local max; ble/builtin/history/.get-max
  ((skip<min-1&&(skip=min-1)))
  local delta=$((max-skip))
  if ((delta>0)); then
    local HISTTIMEFORMAT=__ble_time_%s__
    if [[ :$opts: == *:append:* ]]; then
      builtin history "$delta" >> "$histapp"
      ((_ble_builtin_history_histapp_count+=delta))
    else
      builtin history "$delta" >| "$histapp"
      _ble_builtin_history_histapp_count=$delta
    fi
  fi
  if [[ :$opts: != *:fetch:* && -s $histapp ]]; then
    if [[ ! -e $file ]]; then
      (umask 077; : >| "$file")
    elif [[ :$opts: != *:append:* ]]; then
      : >| "$file"
    fi
    local apos=\'
    < "$histapp" ble/bin/awk '
      BEGIN {
        file = ENVIRON["file"];
        flag_timestamp = ENVIRON["flag_timestamp"];
        timestamp = "";
        mode = 0;
      }
      function flush_line() {
        if (!mode) return;
        mode = 0;
        if (text ~ /\n/) {
          gsub(/['$apos'\\]/, "\\\\&", text);
          gsub(/\n/, "\\n", text);
          gsub(/\t/, "\\t", text);
          text = "eval -- $'$apos'" text "'$apos'"
        }
        if (timestamp != "")
          print timestamp >> file;
        print text >> file;
      }
      function extract_timestamp(line) {
        if (!sub(/^ *[0-9]+\*? +__ble_time_/, "", line)) return "";
        if (!sub(/__.*$/, "", line)) return "";
        if (!(line ~ /^[0-9]+$/)) return "";
        return "#" line;
      }
      /^ *[0-9]+\*? +(__ble_time_[0-9]+__|\?\?)?/ {
        flush_line();
        mode = 1;
        text = "";
        if (flag_timestamp)
          timestamp = extract_timestamp($0);
        sub(/^ *[0-9]+\*? +(__ble_time_[0-9]+__|\?\?)?/, "", $0);
      }
      { text = text != "" ? text "\n" $0 : $0; }
      END { flush_line(); }
    '
    ble/builtin/history/.add-rskip "$file" "$_ble_builtin_history_histapp_count"
    : >| "$histapp"
    _ble_builtin_history_histapp_count=0
  fi
  _ble_builtin_history_wskip=$max
  _ble_builtin_history_prevmax=$max
}
function ble/builtin/history/array#delete-hindex {
  local array_name=$1; shift
  local script='
    local -a out=()
    local i shift=0
    for i in "${!ARR[@]}"; do
      local delete=
      while (($#)); do
        if [[ $1 == *-* ]]; then
          local b=${1%-*} e=${1#*-}
          ((i<b)) && break
          if ((i<e)); then
            delete=1 # delete
            break
          else
            ((shift+=e-b))
            shift
          fi
        else
          ((i<$1)) && break
          ((i==$1)) && delete=1
          ((shift++))
          shift
        fi
      done
      [[ ! $delete ]] &&
        out[i-shift]=${ARR[i]}
    done
    ARR=()
    for i in "${!out[@]}"; do ARR[i]=${out[i]}; done'
  builtin eval -- "${script//ARR/$array_name}"
}
function ble/builtin/history/array#insert-range {
  local array_name=$1 beg=$2 len=$3
  local script='
    local -a out=()
    local i
    for i in "${!ARR[@]}"; do
      out[i<beg?beg:i+len]=${ARR[i]}
    done
    ARR=()
    for i in "${!out[@]}"; do ARR[i]=${out[i]}; done'
  builtin eval -- "${script//ARR/$array_name}"
}
blehook history_delete+=ble/builtin/history/delete.hook
blehook history_clear+=ble/builtin/history/clear.hook
blehook history_insert+=ble/builtin/history/insert.hook
function ble/builtin/history/delete.hook {
  ble/builtin/history/array#delete-hindex _ble_history_dirt "$@"
}
function ble/builtin/history/clear.hook {
  _ble_history_dirt=()
}
function ble/builtin/history/insert.hook {
  ble/builtin/history/array#insert-range _ble_history_dirt "$@"
}
function ble/builtin/history/option:c {
  ble/builtin/history/.initialize skip0 || return "$?"
  builtin history -c
  _ble_builtin_history_wskip=0
  _ble_builtin_history_prevmax=0
  if [[ $_ble_decode_bind_state != none ]]; then
    if [[ $_ble_history_load_done ]]; then
      _ble_history=()
      _ble_history_edit=()
      _ble_history_count=0
      _ble_history_index=0
    else
      ble/history:bash/clear-background-load
      _ble_history_count=
    fi
    ble/history/.update-position
    blehook/invoke history_clear
  fi
}
function ble/builtin/history/option:d {
  ble/builtin/history/.initialize skip0 || return "$?"
  local rex='^(-?[0-9]+)-(-?[0-9]+)$'
  if [[ $1 =~ $rex ]]; then
    local beg=${BASH_REMATCH[1]} end=${BASH_REMATCH[2]}
  else
    local beg=$(($1))
    local end=$beg
  fi
  local min; ble/builtin/history/.get-min
  local max; ble/builtin/history/.get-max
  ((beg<0)) && ((beg+=max+1)); ((beg<min?(beg=min):(beg>max&&(beg=max))))
  ((end<0)) && ((end+=max+1)); ((end<min?(end=min):(end>max&&(end=max))))
  ((beg<=end)) || return 0
  ble/builtin/history/.delete-range "$beg" "$end"
  if ((_ble_builtin_history_wskip>=end)); then
    ((_ble_builtin_history_wskip-=end-beg+1))
  elif ((_ble_builtin_history_wskip>beg-1)); then
    ((_ble_builtin_history_wskip=beg-1))
  fi
  if [[ $_ble_decode_bind_state != none ]]; then
    if [[ $_ble_history_load_done ]]; then
      local N=${#_ble_history[@]}
      local b=$((beg-1+N-max)) e=$((end+N-max))
      blehook/invoke history_delete "$b-$e"
      if ((_ble_history_index>=e)); then
        ((_ble_history_index-=e-b))
      elif ((_ble_history_index>=b)); then
        _ble_history_index=$b
      fi
      _ble_history=("${_ble_history[@]::b}" "${_ble_history[@]:e}")
      _ble_history_edit=("${_ble_history_edit[@]::b}" "${_ble_history_edit[@]:e}")
      _ble_history_count=${#_ble_history[@]}
    else
      ble/history:bash/clear-background-load
      _ble_history_count=
    fi
    ble/history/.update-position
  fi
  local max; ble/builtin/history/.get-max
  _ble_builtin_history_prevmax=$max
}
function ble/builtin/history/option:a {
  ble/builtin/history/.initialize skip0 || return "$?"
  local histfile=${HISTFILE:-$HOME/.bash_history}
  local filename=${1:-$histfile}
  ble/builtin/history/.check-uncontrolled-change "$filename" append
  local rskip; ble/builtin/history/.get-rskip "$filename"
  ble/builtin/history/.write "$filename" "$_ble_builtin_history_wskip" append:fetch
  [[ -r $filename ]] && ble/builtin/history/.read "$filename" "$rskip" fetch
  ble/builtin/history/.write "$filename" "$_ble_builtin_history_wskip" append
  builtin history -a /dev/null # Bash 終了時に書き込まない
}
function ble/builtin/history/option:n {
  local histfile=${HISTFILE:-$HOME/.bash_history}
  local filename=${1:-$histfile}
  if [[ $filename == $histfile ]]; then
    local touch=$_ble_base_run/$$.history.touch
    [[ $touch -nt $histfile ]] && return 0
    : >| "$touch"
  fi
  ble/builtin/history/.initialize
  local rskip; ble/builtin/history/.get-rskip "$filename"
  ble/builtin/history/.read "$filename" "$rskip"
}
function ble/builtin/history/option:w {
  ble/builtin/history/.initialize skip0 || return "$?"
  local histfile=${HISTFILE:-$HOME/.bash_history}
  local filename=${1:-$histfile}
  local rskip; ble/builtin/history/.get-rskip "$filename"
  [[ -r $filename ]] && ble/builtin/history/.read "$filename" "$rskip" fetch
  ble/builtin/history/.write "$filename" 0
  builtin history -a /dev/null # Bash 終了時に書き込まない
}
function ble/builtin/history/option:r {
  local histfile=${HISTFILE:-$HOME/.bash_history}
  local filename=${1:-$histfile}
  ble/builtin/history/.initialize
  ble/builtin/history/.read "$filename" 0
}
function ble/builtin/history/option:p {
  ((_ble_bash>=40000)) || ble/builtin/history/is-empty ||
    ble/history:bash/resolve-multiline sync
  local line1= line2=
  ble/util/assign line1 'HISTTIMEFORMAT= builtin history 1'
  builtin history -p -- '' &>/dev/null
  ble/util/assign line2 'HISTTIMEFORMAT= builtin history 1'
  if [[ $line1 != "$line2" ]]; then
    local rex_head='^[[:space:]]*[0-9]+[[:space:]]*'
    [[ $line1 =~ $rex_head ]] &&
      line1=${line1:${#BASH_REMATCH}}
    if ((_ble_bash<30100)); then
      local tmp=$_ble_base_run/$$.history.tmp
      printf '%s\n' "$line1" "$line1" >| "$tmp"
      builtin history -r "$tmp"
    else
      builtin history -s -- "$line1"
      builtin history -s -- "$line1"
    fi
  fi
  builtin history -p -- "$@"
}
function ble/builtin/history/option:s {
  ble/builtin/history/.initialize
  if [[ $_ble_decode_bind_state == none ]]; then
    builtin history -s -- "$@"
    return 0
  fi
  local cmd=$1
  if [[ $HISTIGNORE ]]; then
    local pats pat
    ble/string#split pats : "$HISTIGNORE"
    for pat in "${pats[@]}"; do
      [[ $cmd == $pat ]] && return 0
    done
  fi
  local histfile=
  if [[ $_ble_history_load_done ]]; then
    if [[ $HISTCONTROL ]]; then
      local ignorespace ignoredups erasedups spec
      for spec in ${HISTCONTROL//:/ }; do
        case "$spec" in
        (ignorespace) ignorespace=1 ;;
        (ignoredups)  ignoredups=1 ;;
        (ignoreboth)  ignorespace=1 ignoredups=1 ;;
        (erasedups)   erasedups=1 ;;
        esac
      done
      if [[ $ignorespace ]]; then
        [[ $cmd == [' 	']* ]] && return 0
      fi
      if [[ $ignoredups ]]; then
        local lastIndex=$((${#_ble_history[@]}-1))
        ((lastIndex>=0)) && [[ $cmd == "${_ble_history[lastIndex]}" ]] && return 0
      fi
      if [[ $erasedups ]]; then
        local -a delete_indices=()
        local shift_histindex_next=0
        local shift_wskip=0
        local i N=${#_ble_history[@]}
        for ((i=0;i<N-1;i++)); do
          if [[ ${_ble_history[i]} == "$cmd" ]]; then
            builtin unset -v '_ble_history[i]'
            builtin unset -v '_ble_history_edit[i]'
            ble/array#push delete_indices "$i"
            ((i<_ble_builtin_history_wskip&&shift_wskip++))
            ((i<HISTINDEX_NEXT&&shift_histindex_next++))
          fi
        done
        if ((${#delete_indices[@]})); then
          _ble_history=("${_ble_history[@]}")
          _ble_history_edit=("${_ble_history_edit[@]}")
          blehook/invoke history_delete "${delete_indices[@]}"
          ((_ble_builtin_history_wskip-=shift_wskip))
          [[ ${HISTINDEX_NEXT+set} ]] && ((HISTINDEX_NEXT-=shift_histindex_next))
        fi
        ((N)) && [[ ${_ble_history[N-1]} == "$cmd" ]] && return 0
      fi
    fi
    local topIndex=${#_ble_history[@]}
    _ble_history[topIndex]=$cmd
    _ble_history_edit[topIndex]=$cmd
    _ble_history_count=$((topIndex+1))
    _ble_history_index=$_ble_history_count
    ((_ble_bash<30100)) && histfile=${HISTFILE:-$HOME/.bash_history}
  else
    if [[ $HISTCONTROL ]]; then
      _ble_history_count=
    else
      [[ $_ble_history_count ]] &&
        ((_ble_history_count++))
    fi
  fi
  ble/history/.update-position
  if [[ $histfile ]]; then
    if [[ $cmd == *$'\n'* ]]; then
      ble/util/sprintf cmd 'eval -- %q' "$cmd"
    fi
    local tmp=$_ble_base_run/$$.history.tmp
    [[ $bleopt_history_share ]] ||
      ble/util/print "$cmd" >> "$histfile"
    ble/util/print "$cmd" >| "$tmp"
    builtin history -r "$tmp"
  else
    ble/history:bash/clear-background-load
    builtin history -s -- "$cmd"
  fi
  local max; ble/builtin/history/.get-max
  _ble_builtin_history_prevmax=$max
}
function ble/builtin/history {
  local set shopt; ble/base/.adjust-bash-options set shopt
  local opt_d= flag_error=
  local opt_c= opt_p= opt_s=
  local opt_a= flags=
  while [[ $1 == -* ]]; do
    local arg=$1; shift
    [[ $arg == -- ]] && break
    if [[ $arg == --help ]]; then
      flags=h$flags
      continue
    fi
    local i n=${#arg}
    for ((i=1;i<n;i++)); do
      local c=${arg:i:1}
      case $c in
      (c) opt_c=1 ;;
      (s) opt_s=1 ;;
      (p) opt_p=1 ;;
      (d)
        if ((!$#)); then
          ble/util/print 'ble/builtin/history: missing option argument for "-d".' >&2
          flag_error=1
        elif ((i+1<n)); then
          opt_d=${arg:i+1}; i=$n
        else
          opt_d=$1; shift
        fi ;;
      ([anwr])
        if [[ $opt_a && $c != $opt_a ]]; then
          ble/util/print 'ble/builtin/history: cannot use more than one of "-anrw".' >&2
          flag_error=1
        elif ((i+1<n)); then
          opt_a=$c
          set -- "${arg:i+1}" "$@"
        else
          opt_a=$c
        fi ;;
      (*)
        ble/util/print "ble/builtin/history: unknown option \"-$c\"." >&2
        flag_error=1 ;;
      esac
    done
  done
  if [[ $flag_error ]]; then
    builtin history --usage 2>&1 1>/dev/null | ble/bin/grep ^history >&2
    ble/base/.restore-bash-options set shopt
    return 2
  fi
  if [[ $flags == *h* ]]; then
    builtin history --help
    local ext=$?
    ble/base/.restore-bash-options set shopt
    return "$ext"
  fi
  [[ ! $_ble_attached || $_ble_edit_exec_inside_userspace ]] &&
    ble/base/adjust-BASH_REMATCH
  local flag_processed=
  if [[ $opt_c ]]; then
    ble/builtin/history/option:c
    flag_processed=1
  fi
  if [[ $opt_s ]]; then
    local IFS=$_ble_term_IFS
    ble/builtin/history/option:s "$*"
    flag_processed=1
  elif [[ $opt_d ]]; then
    ble/builtin/history/option:d "$opt_d"
    flag_processed=1
  elif [[ $opt_a ]]; then
    ble/builtin/history/option:"$opt_a" "$1"
    flag_processed=1
  fi
  if [[ $flag_processed ]]; then
    ble/base/.restore-bash-options set shopt
    return 0
  fi
  if [[ $opt_p ]]; then
    ble/builtin/history/option:p "$@"
  else
    builtin history "$@"
  fi; local ext=$?
  [[ ! $_ble_attached || $_ble_edit_exec_inside_userspace ]] &&
    ble/base/restore-BASH_REMATCH
  ble/base/.restore-bash-options set shopt
  return "$ext"
}
function history { ble/builtin/history "$@"; }
_ble_history_prefix=
function ble/history/set-prefix {
  _ble_history_prefix=$1
  ble/history/.update-position
}
_ble_history_COUNT=
_ble_history_INDEX=
function ble/history/.update-position {
  if [[ $_ble_history_prefix ]]; then
    builtin eval -- "_ble_history_COUNT=\${#${_ble_history_prefix}_history[@]}"
    ((_ble_history_INDEX=${_ble_history_prefix}_history_index))
  else
    if [[ ! $_ble_history_load_done ]]; then
      if [[ ! $_ble_history_count ]]; then
        local min max
        ble/builtin/history/.get-min
        ble/builtin/history/.get-max
        ((_ble_history_count=max-min+1))
      fi
      _ble_history_index=$_ble_history_count
    fi
    _ble_history_COUNT=$_ble_history_count
    _ble_history_INDEX=$_ble_history_index
  fi
}
function ble/history/update-position {
  [[ $_ble_history_prefix$_ble_history_load_done ]] ||
    ble/history/.update-position
}
function ble/history/onleave.fire {
  blehook/invoke history_onleave "$@"
}
function ble/history/initialize {
  [[ ! $_ble_history_prefix ]] &&
    ble/history:bash/initialize
}
function ble/history/get-count {
  local _var=count _ret
  [[ $1 == -v ]] && { _var=$2; shift 2; }
  ble/history/.update-position
  (($_var=_ble_history_COUNT))
}
function ble/history/get-index {
  local _var=index
  [[ $1 == -v ]] && { _var=$2; shift 2; }
  ble/history/.update-position
  (($_var=_ble_history_INDEX))
}
function ble/history/set-index {
  _ble_history_INDEX=$1
  ((${_ble_history_prefix:-_ble}_history_index=_ble_history_INDEX))
}
function ble/history/get-entry {
  local __var=entry
  [[ $1 == -v ]] && { __var=$2; shift 2; }
  if [[ $_ble_history_prefix$_ble_history_load_done ]]; then
    builtin eval -- "$__var=\${${_ble_history_prefix:-_ble}_history[\$1]}"
  else
    builtin eval -- "$__var="
  fi
}
function ble/history/get-edited-entry {
  local __var=entry
  [[ $1 == -v ]] && { __var=$2; shift 2; }
  if [[ $_ble_history_prefix$_ble_history_load_done ]]; then
    builtin eval -- "$__var=\${${_ble_history_prefix:-_ble}_history_edit[\$1]}"
  else
    builtin eval -- "$__var=\$_ble_edit_str"
  fi
}
function ble/history/set-edited-entry {
  ble/history/initialize
  local index=$1 str=$2
  local code='
    if [[ ! ${PREFIX_history_edit[index]+set} || ${PREFIX_history_edit[index]} != "$str" ]]; then
      PREFIX_history_edit[index]=$str
      PREFIX_history_dirt[index]=1
    fi'
  builtin eval -- "${code//PREFIX/${_ble_history_prefix:-_ble}}"
}
function ble/history/.add-command-history {
  [[ -o history ]] || ((_ble_bash<30200)) || return 1
  [[ $MC_SID == $$ && $LINENO -le 2 && ( $1 == *PROMPT_COMMAND=* || $1 == *PS1=* ) ]] && return 1
  if [[ $_ble_history_load_done ]]; then
    _ble_history_index=${#_ble_history[@]}
    ble/history/.update-position
    local index
    for index in "${!_ble_history_dirt[@]}"; do
      _ble_history_edit[index]=${_ble_history[index]}
    done
    _ble_history_dirt=()
    ble-edit/undo/clear-all
  fi
  if [[ $bleopt_history_share ]]; then
    ble/builtin/history/option:n
    ble/builtin/history/option:s "$1"
    ble/builtin/history/option:a
    ble/builtin/history/.touch-histfile
  else
    ble/builtin/history/option:s "$1"
  fi
}
function ble/history/add {
  local command=$1
  ((bleopt_history_limit_length>0&&${#command}>bleopt_history_limit_length)) && return 1
  if [[ $_ble_history_prefix ]]; then
    local code='
      local index
      for index in "${!PREFIX_history_dirt[@]}"; do
        PREFIX_history_edit[index]=${PREFIX_history[index]}
      done
      PREFIX_history_dirt=()
      local topIndex=${#PREFIX_history[@]}
      PREFIX_history[topIndex]=$command
      PREFIX_history_edit[topIndex]=$command
      PREFIX_history_index=$((++topIndex))
      _ble_history_COUNT=$topIndex
      _ble_history_INDEX=$topIndex'
    builtin eval -- "${code//PREFIX/$_ble_history_prefix}"
  else
    blehook/invoke ADDHISTORY "$command" &&
      ble/history/.add-command-history "$command"
  fi
}
function ble/history/.read-isearch-options {
  local opts=$1
  search_type=fixed
  case :$opts: in
  (*:regex:*)     search_type=regex ;;
  (*:glob:*)      search_type=glob  ;;
  (*:head:*)      search_type=head ;;
  (*:tail:*)      search_type=tail ;;
  (*:condition:*) search_type=condition ;;
  (*:predicate:*) search_type=predicate ;;
  esac
  [[ :$opts: != *:stop_check:* ]]; has_stop_check=$?
  [[ :$opts: != *:progress:* ]]; has_progress=$?
  [[ :$opts: != *:backward:* ]]; has_backward=$?
}
function ble/history/isearch-backward-blockwise {
  local opts=$1
  local search_type has_stop_check has_progress has_backward
  ble/history/.read-isearch-options "$opts"
  ble/history/initialize
  if [[ $_ble_history_prefix ]]; then
    local -a _ble_history_edit
    builtin eval "_ble_history_edit=(\"\${${_ble_history_prefix}_history_edit[@]}\")"
  fi
  local NSTPCHK=1000 # 十分高速なのでこれぐらい大きくてOK
  local NPROGRESS=$((NSTPCHK*2)) # 倍数である必要有り
  local irest block j i=$index
  index=
  local flag_cycled= range_min range_max
  while :; do
    if ((i<=start)); then
      range_min=0 range_max=$start
    else
      flag_cycled=1
      range_min=$((start+1)) range_max=$i
    fi
    while ((i>=range_min)); do
      ((block=range_max-i,
        block<5&&(block=5),
        block>i+1-range_min&&(block=i+1-range_min),
        irest=NSTPCHK-isearch_time%NSTPCHK,
        block>irest&&(block=irest)))
      case $search_type in
      (regex)     for ((j=i-block;++j<=i;)); do
                    [[ ${_ble_history_edit[j]} =~ $needle ]] && index=$j
                  done ;;
      (glob)      for ((j=i-block;++j<=i;)); do
                    [[ ${_ble_history_edit[j]} == $needle ]] && index=$j
                  done ;;
      (head)      for ((j=i-block;++j<=i;)); do
                    [[ ${_ble_history_edit[j]} == "$needle"* ]] && index=$j
                  done ;;
      (tail)      for ((j=i-block;++j<=i;)); do
                    [[ ${_ble_history_edit[j]} == *"$needle" ]] && index=$j
                  done ;;
      (condition) builtin eval "function ble-edit/isearch/.search-block.proc {
                    local LINE INDEX
                    for ((j=i-block;++j<=i;)); do
                      LINE=\${_ble_history_edit[j]} INDEX=\$j
                      { $needle; } && index=\$j
                    done
                  }"
                  ble-edit/isearch/.search-block.proc ;;
      (predicate) for ((j=i-block;++j<=i;)); do
                    "$needle" "${_ble_history_edit[j]}" "$j" && index=$j
                  done ;;
      (*)         for ((j=i-block;++j<=i;)); do
                    [[ ${_ble_history_edit[j]} == *"$needle"* ]] && index=$j
                  done ;;
      esac
      ((isearch_time+=block))
      [[ $index ]] && return 0
      ((i-=block))
      if ((has_stop_check&&isearch_time%NSTPCHK==0)) && ble/decode/has-input; then
        index=$i
        return 148
      elif ((has_progress&&isearch_time%NPROGRESS==0)); then
        "$isearch_progress_callback" "$i"
      fi
    done
    if [[ ! $flag_cycled && :$opts: == *:cyclic:* ]]; then
      ((i=${#_ble_history_edit[@]}-1))
      ((start<i)) || return 1
    else
      return 1
    fi
  done
}
function ble/history/forward-isearch.impl {
  local opts=$1
  local search_type has_stop_check has_progress has_backward
  ble/history/.read-isearch-options "$opts"
  ble/history/initialize
  if [[ $_ble_history_prefix ]]; then
    local -a _ble_history_edit
    builtin eval "_ble_history_edit=(\"\${${_ble_history_prefix}_history_edit[@]}\")"
  fi
  while :; do
    local flag_cycled= expr_cond expr_incr
    if ((has_backward)); then
      if ((index<=start)); then
        expr_cond='index>=0' expr_incr='index--'
      else
        expr_cond='index>start' expr_incr='index--' flag_cycled=1
      fi
    else
      if ((index>=start)); then
        expr_cond="index<${#_ble_history_edit[@]}" expr_incr='index++'
      else
        expr_cond="index<start" expr_incr='index++' flag_cycled=1
      fi
    fi
    case $search_type in
    (regex)
      for ((;expr_cond;expr_incr)); do
        ((isearch_time++,has_stop_check&&isearch_time%100==0)) &&
          ble/decode/has-input && return 148
        [[ ${_ble_history_edit[index]} =~ $needle ]] && return 0
        ((has_progress&&isearch_time%1000==0)) &&
          "$isearch_progress_callback" "$index"
      done ;;
    (glob)
      for ((;expr_cond;expr_incr)); do
        ((isearch_time++,has_stop_check&&isearch_time%100==0)) &&
          ble/decode/has-input && return 148
        [[ ${_ble_history_edit[index]} == $needle ]] && return 0
        ((has_progress&&isearch_time%1000==0)) &&
          "$isearch_progress_callback" "$index"
      done ;;
    (head)
      for ((;expr_cond;expr_incr)); do
        ((isearch_time++,has_stop_check&&isearch_time%100==0)) &&
          ble/decode/has-input && return 148
        [[ ${_ble_history_edit[index]} == "$needle"* ]] && return 0
        ((has_progress&&isearch_time%1000==0)) &&
          "$isearch_progress_callback" "$index"
      done ;;
    (tail)
      for ((;expr_cond;expr_incr)); do
        ((isearch_time++,has_stop_check&&isearch_time%100==0)) &&
          ble/decode/has-input && return 148
        [[ ${_ble_history_edit[index]} == *"$needle" ]] && return 0
        ((has_progress&&isearch_time%1000==0)) &&
          "$isearch_progress_callback" "$index"
      done ;;
    (condition)
      for ((;expr_cond;expr_incr)); do
        ((isearch_time++,has_stop_check&&isearch_time%100==0)) &&
          ble/decode/has-input && return 148
        LINE=${_ble_history_edit[index]} INDEX=$index builtin eval -- "$needle" && return 0
        ((has_progress&&isearch_time%1000==0)) &&
          "$isearch_progress_callback" "$index"
      done ;;
    (predicate)
      for ((;expr_cond;expr_incr)); do
        ((isearch_time++,has_stop_check&&isearch_time%100==0)) &&
          ble/decode/has-input && return 148
        "$needle" "${_ble_history_edit[index]}" "$index" && return 0
        ((has_progress&&isearch_time%1000==0)) &&
          "$isearch_progress_callback" "$index"
      done ;;
    (*)
      for ((;expr_cond;expr_incr)); do
        ((isearch_time++,has_stop_check&&isearch_time%100==0)) &&
          ble/decode/has-input && return 148
        [[ ${_ble_history_edit[index]} == *"$needle"* ]] && return 0
        ((has_progress&&isearch_time%1000==0)) &&
          "$isearch_progress_callback" "$index"
      done ;;
    esac
    if [[ ! $flag_cycled && :$opts: == *:cyclic:* ]]; then
      if ((has_backward)); then
        ((index=${#_ble_history_edit[@]}-1))
        ((index>start)) || return 1
      else
        ((index=0))
        ((index<start)) || return 1
      fi
    else
      return 1
    fi
  done
}
function ble/history/isearch-forward {
  ble/history/forward-isearch.impl "$1"
}
function ble/history/isearch-backward {
  ble/history/forward-isearch.impl "$1:backward"
}
bleopt/declare -v edit_vbell ''
bleopt/declare -v edit_abell 1
bleopt/declare -v history_lazyload 1
bleopt/declare -v delete_selection_mode 1
bleopt/declare -n indent_offset 4
bleopt/declare -n indent_tabs 1
bleopt/declare -v undo_point end
bleopt/declare -n edit_forced_textmap 1
function ble/edit/use-textmap {
  ble/textmap#is-up-to-date && return 0
  ((bleopt_edit_forced_textmap)) || return 1
  ble/widget/.update-textmap
  return 0
}
bleopt/declare -n edit_line_type logical
function bleopt/check:edit_line_type {
  if [[ $value != logical && $value != graphical ]]; then
    ble/util/print "bleopt edit_line_type: Unexpected value '$value'. 'logical' or 'graphical' is expected." >&2
    return 1
  fi
}
function ble/edit/performs-on-graphical-line {
  [[ $edit_line_type == graphical ]] || return 1
  ble/textmap#is-up-to-date && return 0
  ((bleopt_edit_forced_textmap)) || return 1
  ble/widget/.update-textmap
  return 0
}
bleopt/declare -n info_display top
function bleopt/check:info_display {
  case $value in
  (top)
    [[ $_ble_canvas_panel_vfill == 3 ]] && return 0
    _ble_canvas_panel_vfill=3
    [[ $_ble_attached ]] && ble/canvas/panel/clear
    return 0 ;;
  (bottom)
    [[ $_ble_canvas_panel_vfill == 2 ]] && return 0
    _ble_canvas_panel_vfill=2
    [[ $_ble_attached ]] && ble/canvas/panel/clear
    return 0 ;;
  (*)
    ble/util/print "bleopt: Invalid value for 'info_display': $value"
    return 1 ;;
  esac
}
bleopt/declare -v prompt_ps1_final ''
bleopt/declare -v prompt_ps1_transient ''
bleopt/declare -v prompt_rps1 ''
bleopt/declare -v prompt_rps1_final ''
bleopt/declare -v prompt_rps1_transient ''
bleopt/declare -v prompt_xterm_title  ''
bleopt/declare -v prompt_screen_title ''
bleopt/declare -v prompt_term_status  ''
bleopt/declare -o rps1 prompt_rps1
bleopt/declare -o rps1_transient prompt_rps1_transient
bleopt/declare -v prompt_eol_mark $'\e[94m[ble: EOF]\e[m'
bleopt/declare -v prompt_ruler ''
bleopt/declare -v prompt_status_line  ''
bleopt/declare -n prompt_status_align $'justify=\r'
ble/color/defface prompt_status_line fg=231,bg=240
bleopt/declare -v prompt_command_changes_layout ''
function bleopt/check:prompt_status_align {
  case $value in
  (left|right|center|justify|justify=?*)
    ble/prompt/unit#clear _ble_prompt_status hash
    return 0 ;;
  (*)
    ble/util/print "bleopt prompt_status_align: unsupported value: '$value'" >&2
    return 1 ;;
  esac
}
bleopt/declare -n internal_exec_type gexec
function bleopt/check:internal_exec_type {
  if ! ble/is-function "ble-edit/exec:$value/process"; then
    ble/util/print "bleopt: Invalid value internal_exec_type='$value'. A function 'ble-edit/exec:$value/process' is not defined." >&2
    return 1
  fi
}
bleopt/declare -v internal_suppress_bash_output 1
bleopt/declare -n internal_ignoreeof_trap 'Use "exit" to leave the shell.'
bleopt/declare -v allow_exit_with_jobs ''
bleopt/declare -v history_share ''
bleopt/declare -v accept_line_threshold 5
bleopt/declare -v exec_errexit_mark $'\e[91m[ble: exit %d]\e[m'
bleopt/declare -v exec_elapsed_mark $'\e[94m[ble: elapsed %s (CPU %s%%)]\e[m'
bleopt/declare -v exec_elapsed_enabled 'usr+sys>=10000'
bleopt/declare -v line_limit_length 10000
bleopt/declare -v line_limit_type none
_ble_app_render_mode=panel
_ble_app_winsize=()
_ble_app_render_Processing=
function ble/application/.set-up-render-mode {
  [[ $1 == "$_ble_app_render_mode" ]] && return 0
  case $1 in
  (panel)
    ble/term/leave-altscr
    ble/canvas/panel/invalidate ;;
  (forms:*)
    ble/term/enter-altscr
    ble/util/buffer "$_ble_term_clear"
    ble/util/buffer $'\e[H'
    _ble_canvas_x=0 _ble_canvas_y=0 ;;
  (*)
    ble/util/print "ble/edit: unrecognized render mode '$1'."
    return 1 ;;
  esac
}
function ble/application/push-render-mode {
  ble/application/.set-up-render-mode "$1" || return 1
  ble/array#unshift _ble_app_render_mode "$1"
}
function ble/application/pop-render-mode {
  [[ ${_ble_app_render_mode[1]} ]] || return 1
  ble/application/.set-up-render-mode "${_ble_app_render_mode[1]}"
  ble/array#shift _ble_app_render_mode
}
function ble/application/render {
  local _ble_app_render_Processing=1
  {
    local render=$_ble_app_render_mode
    case $render in
    (panel)
      local _ble_prompt_update=owner
      ble/prompt/update
      ble/canvas/panel/render ;;
    (forms:*)
      ble/forms/render "${render#*:}" ;;
    esac
    _ble_app_winsize=("$COLUMNS" "$LINES")
    ble/util/buffer.flush >&2
  }
  ble/util/unlocal _ble_app_render_Processing
  if [[ $_ble_application_render_winch ]]; then
    _ble_application_render_winch=
    ble/application/onwinch
  fi
}
function ble/application/onwinch {
  if [[ $_ble_app_render_Processing || $_ble_decode_hook_Processing == body || $_ble_decode_hook_Processing == prologue ]]; then
    _ble_application_render_winch=1
    return 0
  fi
  _ble_textmap_pos=()
  local old_size= i
  for ((i=0;i<20;i++)); do
    (ble/util/msleep 50)
    ble/util/joblist.check ignore-volatile-jobs
    local size=$LINES:$COLUMNS
    [[ $size == "$old_size" ]] && break
    local _ble_app_render_Processing=1
    {
      old_size=$size
      case $bleopt_canvas_winch_action in
      (clear)
        ble/util/buffer "$_ble_term_clear" ;;
      (redraw-here)
        if ((COLUMNS<_ble_app_winsize[0])); then
          local -a DRAW_BUFF=()
          ble/canvas/panel#goto.draw 0 0 0
          ble/canvas/bflush.draw
        fi ;;
      (redraw-prev)
        local -a DRAW_BUFF=()
        ble/canvas/panel#goto.draw 0 0 0
        ble/canvas/bflush.draw ;;
      esac
      ble/canvas/panel/invalidate height # 高さの再確保も含めて。
    }
    ble/util/unlocal _ble_app_render_Processing
    ble/application/render
  done
}
_ble_canvas_panel_focus=0
_ble_canvas_panel_class=(ble/textarea ble/textarea ble/edit/info ble/prompt/status)
_ble_canvas_panel_vfill=3
_ble_edit_command_layout_level=0
function ble/edit/enter-command-layout {
  ((_ble_edit_command_layout_level++==0)) || return 0
  ble/edit/info#collapse "$_ble_edit_info_panel"
  ble/prompt/status#collapse
}
function ble/edit/leave-command-layout {
  ((_ble_edit_command_layout_level>0&&
      --_ble_edit_command_layout_level==0)) || return 0
  blehook/invoke info_reveal
  ble/edit/info/default
}
function ble/edit/clear-command-layout {
  ((_ble_edit_command_layout_level>0)) || return 0
  _ble_edit_command_layout_level=1
  ble/edit/leave-command-layout
}
function ble/edit/is-command-layout {
  ((_ble_edit_command_layout_level>0))
}
_ble_prompt_status_panel=3
_ble_prompt_status_dirty=
_ble_prompt_status_data=()
_ble_prompt_status_bbox=()
function ble/prompt/status#panel::invalidate {
  _ble_prompt_status_dirty=1
}
function ble/prompt/status#panel::render {
  [[ $_ble_prompt_status_dirty ]] || return 0
  _ble_prompt_status_dirty=
  local index=$1
  local height; ble/prompt/status#panel::getHeight "$index"
  [[ ${height#*:} == 1 ]] || return 0
  local -a DRAW_BUFF=()
  height=$3
  if ((height!=1)); then
    ble/canvas/panel/reallocate-height.draw
    ble/canvas/bflush.draw
    height=${_ble_canvas_panel_height[index]}
    ((height==0)) && return 0
  fi
  local esc=${_ble_prompt_status_data[10]}
  if [[ $esc ]]; then
    local prox=${_ble_prompt_status_data[11]}
    local proy=${_ble_prompt_status_data[12]}
    ble/canvas/panel#goto.draw "$_ble_prompt_status_panel"
    ble/canvas/panel#put.draw "$_ble_prompt_status_panel" "$esc" "$prox" "$proy"
  else
    ble/canvas/panel#clear.draw "$_ble_prompt_status_panel"
  fi
  ble/canvas/bflush.draw
}
function ble/prompt/status#panel::getHeight {
  if ble/edit/is-command-layout || [[ ! ${_ble_prompt_status_data[10]} ]]; then
    height=0:0
  else
    height=0:1
  fi
}
function ble/prompt/status#panel::onHeightChange {
  ble/prompt/status#panel::invalidate
}
function ble/prompt/status#collapse {
  local -a DRAW_BUFF=()
  ble/canvas/panel#set-height.draw "$_ble_prompt_status_panel" 0
  ble/canvas/bflush.draw
}
_ble_prompt_hash=
_ble_prompt_version=0
function ble/prompt/.escape-control-characters {
  ret=$1
  local ctrl=$'\001-\037\177'
  case $_ble_util_locale_encoding in
  (UTF-8) ctrl=$ctrl$'\302\200-\302\237' ;;
  (C)     ctrl=$ctrl$'\200-\237' ;;
  esac
  local LC_ALL= LC_COLLATE=C glob_ctrl=[$ctrl]
  [[ $ret == *$glob_ctrl* ]] || return 0
  local out= head tail=$ret cs
  while head=${tail%%$glob_ctrl*}; [[ $head != "$tail" ]]; do
    ble/util/s2c "${tail:${#head}:1}"
    ble/unicode/GraphemeCluster/.get-ascii-rep "$ret" # -> cs
    out=$out$head$'\e[9807m'$cs$'\e[9807m'
    tail=${tail#*$glob_ctrl}
  done
  ret=$out$tail
}
ble/function#suppress-stderr ble/prompt/.escape-control-characters # LC_COLLATE
function ble/prompt/.initialize-constant {
  local __ps=$1 __defeval=$2 __opts=$3
  if ((_ble_bash>=40400)); then
    ret=${__ps@P}
  else
    builtin eval -- "$__defeval"
  fi
  if [[ $__opts == *:escape:* ]]; then
    if ((_ble_bash>=50200)); then
      if [[ $ret == *\^['A'-'Z[\]^_?']* ]]; then
        builtin eval -- "$__defeval"
        ble/prompt/.escape-control-characters "$ret"
      elif [[ $ret == *$'\t'* ]]; then
        ble/prompt/.escape-control-characters "$ret"
      fi
    else
      ble/prompt/.escape-control-characters "$_ble_prompt_const_s"
    fi
  fi
}
function ble/prompt/initialize {
  local ret
  ble/prompt/.initialize-constant '\H' 'ret=$HOSTNAME' escape
  _ble_prompt_const_H=$ret
  if local rex='^[0-9]+(\.[0-9]){3}$'; [[ $HOSTNAME =~ $rex ]]; then
    _ble_prompt_const_h=$_ble_prompt_const_H
  else
    _ble_prompt_const_h=${_ble_prompt_const_H%%.*}
  fi
  ble/prompt/.initialize-constant '\l' 'ble/util/assign ret "ble/bin/tty 2>/dev/null";ret=${ret##*/}'
  _ble_prompt_const_l=$ret
  ble/prompt/.initialize-constant '\s' 'ret=${0##*/}' escape
  _ble_prompt_const_s=$ret
  ble/prompt/.initialize-constant '\s' 'ret=$USER' escape
  _ble_prompt_const_u=$ret
  ble/util/sprintf _ble_prompt_const_v '%d.%d' "${BASH_VERSINFO[0]}" "${BASH_VERSINFO[1]}"
  ble/util/sprintf _ble_prompt_const_V '%d.%d.%d' "${BASH_VERSINFO[0]}" "${BASH_VERSINFO[1]}" "${BASH_VERSINFO[2]}"
  if [[ $EUID -eq 0 ]]; then
    _ble_prompt_const_root='#'
  else
    _ble_prompt_const_root='$'
  fi
  if [[ $OSTYPE == cygwin* ]]; then
    local windir=/cygdrive/c/Windows
    if [[ $WINDIR == [a-zA-Z]:\\* ]]; then
      local bsl='\' sl=/
      local c=${WINDIR::1} path=${WINDIR:3}
      if [[ $c == [A-Z] ]]; then
        if ((_ble_bash>=40000)); then
          c=${c,?}
        else
          local ret
          ble/util/s2c "$c"
          ble/util/c2s $((ret+32))
          c=$ret
        fi
      fi
      windir=/cygdrive/$c/${path//"$bsl"/"$sl"}
    fi
    if [[ -e $windir && -w $windir ]]; then
      _ble_prompt_const_root='#'
    fi
  elif [[ $OSTYPE == msys* ]]; then
    if ble/bin#has id getent; then
      local id getent
      ble/util/assign id 'id -G'
      ble/util/assign getent 'getent -w group S-1-16-12288'
      ble/string#split getent : "$getent"
      [[ " $id " == *" ${getent[1]} "* ]] &&
        _ble_prompt_const_root='#'
    fi
  fi
}
function ble/prompt/unit#update {
  local unit=$1
  local prompt_unit_changed=
  local prompt_unit_expired=
  local ohashref=${unit}_data[1]; ohashref=${!ohashref-}
  if [[ ! $ohashref ]]; then
    prompt_unit_expired=1
  else
    ble/prompt/unit#update/.update-dependencies "$ohashref"
    local ohash=${unit}_data[2]; ohash=${!ohash}
    builtin eval -- "local nhash=\"$ohashref\"" 2>/dev/null
    [[ $nhash != "$ohash" ]] && prompt_unit_expired=1
  fi
  if [[ $prompt_unit_expired ]]; then
    local prompt_unit=$unit
    local prompt_hashref_dep= # プロンプト間依存性
    local prompt_hashref_var= # 変数に対する依存性
    ble/prompt/unit:"$unit"/update "$unit" &&
      ((prompt_unit_changed=1,${unit}_data[0]++))
    local hashref=${prompt_hashref_base-'$_ble_prompt_version'}:$prompt_hashref_dep:$prompt_hashref_var
    builtin eval -- "${unit}_data[1]=\$hashref"
    builtin eval -- "${unit}_data[2]=\"$hashref\"" 2>/dev/null
    ble/util/unlocal prompt_unit prompt_hashref_dep
  fi
  if [[ $prompt_unit ]]; then
    local ref1='$'$unit'_data'
    [[ ,$prompt_hashref_dep, != *,"$ref1",* ]] &&
      prompt_hashref_dep=$prompt_hashref_dep${prompt_hashref_dep:+,}$ref1
  fi
  [[ $prompt_unit_changed ]]
}
function ble/prompt/unit#update/.update-dependencies {
  local ohashref=$1
  local otree=${ohashref#*:}; otree=${otree%%:*}
  if [[ $otree ]]; then
    ble/string#split otree , "$otree"
    if [[ ! $ble_prompt_unit_processing ]]; then
      local ble_prompt_unit_processing=1
      "${_ble_util_set_declare[@]//NAME/ble_prompt_unit_mark}" # WA #D1570
    elif ble/set#contains ble_prompt_unit_mark "$unit"; then
      ble/util/print "ble/prompt: FATAL: detected cyclic dependency ($unit required by $ble_prompt_unit_parent)" >/dev/tty
      return 1
    fi
    local ble_prompt_unit_parent=$unit
    ble/set#add ble_prompt_unit_mark "$unit"
    local prompt_unit= # 依存関係の登録はしない
    local child
    for child in "${otree[@]}"; do
      [[ $child == '$'?*'_data' ]] || continue
      child=${child:1:${#child}-6}
      ble/is-function ble/prompt/unit:"$child"/update &&
        ble/prompt/unit#update "$child"
    done
    ble/set#remove ble_prompt_unit_mark "$unit"
  fi
}
function ble/prompt/unit#clear {
  local prefix=$1
  builtin eval -- "${prefix}_data[2]="
}
function ble/prompt/unit/assign {
  local var=$1 value=$2
  [[ $value == "${!var}" ]] && return 1
  prompt_unit_changed=1
  builtin eval -- "$var=\$value"
}
function ble/prompt/unit/add-hash {
  [[ $prompt_unit && ,$prompt_hashref_var, != *,"$1",* ]] &&
    prompt_hashref_var=$prompt_hashref_var${prompt_hashref_var:+,}$1
  return 0
}
_ble_prompt_ps1_dirty=
_ble_prompt_ps1_data=(0 '' '' 0 0 0 32 0 '' '')
_ble_prompt_rps1_dirty=
_ble_prompt_rps1_data=()
_ble_prompt_rps1_gbox=()
_ble_prompt_rps1_shown=
_ble_prompt_xterm_title_dirty=
_ble_prompt_xterm_title_data=()
_ble_prompt_screen_title_dirty=
_ble_prompt_screen_title_data=()
_ble_prompt_term_status_dirty=
_ble_prompt_term_status_data=()
function ble/prompt/print {
  local ret=$1 a b
  [[ $prompt_noesc ]] ||
    ble/string#escape-characters "$ret" '\$"`'
  ble/canvas/put.draw "$ret"
}
function ble/prompt/process-prompt-string {
  local ps1=$1
  local i=0 iN=${#ps1}
  local rex_letters='^[^\]+|\\$'
  while ((i<iN)); do
    local tail=${ps1:i}
    if [[ $tail == '\'?* ]]; then
      ble/prompt/.process-backslash
    elif [[ $tail =~ $rex_letters ]]; then
      ble/canvas/put.draw "$BASH_REMATCH"
      ((i+=${#BASH_REMATCH}))
    else
      ble/canvas/put.draw "${tail::1}"
      ((i++))
    fi
  done
}
function ble/prompt/.process-backslash {
  ((i+=2))
  local c=${tail:1:1} pat='][#!$\'
  if [[ $c == ["$pat"] ]]; then
    case "$c" in
    (\[) ble/canvas/put.draw $'\001' ;; # \[ \] は後処理の為、適当な識別用の文字列を出力する。
    (\]) ble/canvas/put.draw $'\002' ;;
    ('#') # コマンド番号 (本当は history に入らない物もある…)
      ble/prompt/unit/add-hash '$_ble_edit_CMD'
      ble/canvas/put.draw "$_ble_edit_CMD" ;;
    (\!) # 編集行の履歴番号
      local count
      ble/history/get-count -v count
      ble/canvas/put.draw $((count+1)) ;;
    ('$') # # or $
      ble/prompt/print "$_ble_prompt_const_root" ;;
    (\\)
      ble/canvas/put.draw '\' ;;
    esac
  elif ble/is-function ble/prompt/backslash:"$c"; then
    ble/function#try ble/prompt/backslash:"$c"
  elif ble/is-function ble-edit/prompt/backslash:"$c"; then # deprecated name
    ble/function#try ble-edit/prompt/backslash:"$c"
  else
    ble/canvas/put.draw "\\$c"
  fi
}
function ble/prompt/backslash:0 { # 8進表現
  local rex='^\\[0-7]{1,3}'
  if [[ $tail =~ $rex ]]; then
    local seq=${BASH_REMATCH[0]}
    ((i+=${#seq}-2))
    builtin eval "c=\$'$seq'"
  fi
  ble/prompt/print "$c"
  return 0
}
function ble/prompt/backslash:1 { ble/prompt/backslash:0; }
function ble/prompt/backslash:2 { ble/prompt/backslash:0; }
function ble/prompt/backslash:3 { ble/prompt/backslash:0; }
function ble/prompt/backslash:4 { ble/prompt/backslash:0; }
function ble/prompt/backslash:5 { ble/prompt/backslash:0; }
function ble/prompt/backslash:6 { ble/prompt/backslash:0; }
function ble/prompt/backslash:7 { ble/prompt/backslash:0; }
function ble/prompt/backslash:a { # 0 BEL
  ble/canvas/put.draw ""
  return 0
}
function ble/prompt/backslash:e {
  ble/canvas/put.draw $'\e'
  return 0
}
function ble/prompt/backslash:n {
  ble/canvas/put.draw $'\n'
  return 0
}
function ble/prompt/backslash:r {
  ble/canvas/put.draw "$_ble_term_cr"
  return 0
}
_ble_prompt_cache_vars=(
  prompt_cache_d
  prompt_cache_t
  prompt_cache_A
  prompt_cache_T
  prompt_cache_at
  prompt_cache_j
  prompt_cache_wd
)
function ble/prompt/backslash:d { # ? 日付
  [[ $prompt_cache_d ]] || ble/util/strftime -v prompt_cache_d '%a %b %d'
  ble/prompt/print "$prompt_cache_d"
  return 0
}
function ble/prompt/backslash:t { # 8 時刻
  [[ $prompt_cache_t ]] || ble/util/strftime -v prompt_cache_t '%H:%M:%S'
  ble/prompt/print "$prompt_cache_t"
  return 0
}
function ble/prompt/backslash:A { # 5 時刻
  [[ $prompt_cache_A ]] || ble/util/strftime -v prompt_cache_A '%H:%M'
  ble/prompt/print "$prompt_cache_A"
  return 0
}
function ble/prompt/backslash:T { # 8 時刻
  [[ $prompt_cache_T ]] || ble/util/strftime -v prompt_cache_T '%I:%M:%S'
  ble/prompt/print "$prompt_cache_T"
  return 0
}
function ble/prompt/backslash:@ { # ? 時刻
  [[ $prompt_cache_at ]] || ble/util/strftime -v prompt_cache_at '%I:%M %p'
  ble/prompt/print "$prompt_cache_at"
  return 0
}
function ble/prompt/backslash:D {
  local rex='^\\D\{([^{}]*)\}' cache_D
  if [[ $tail =~ $rex ]]; then
    ble/util/strftime -v cache_D "${BASH_REMATCH[1]}"
    ble/prompt/print "$cache_D"
    ((i+=${#BASH_REMATCH}-2))
  else
    ble/prompt/print "\\$c"
  fi
  return 0
}
function ble/prompt/backslash:h { # = ホスト名
  ble/prompt/print "$_ble_prompt_const_h"
  return 0
}
function ble/prompt/backslash:H { # = ホスト名
  ble/prompt/print "$_ble_prompt_const_H"
  return 0
}
function ble/prompt/backslash:j { #   ジョブの数
  if [[ ! $prompt_cache_j ]]; then
    local joblist
    ble/util/joblist
    prompt_cache_j=${#joblist[@]}
  fi
  ble/canvas/put.draw "$prompt_cache_j"
  return 0
}
function ble/prompt/backslash:l { #   tty basename
  ble/prompt/print "$_ble_prompt_const_l"
  return 0
}
function ble/prompt/backslash:s { # 4 "bash"
  ble/prompt/print "$_ble_prompt_const_s"
  return 0
}
function ble/prompt/backslash:u { # = ユーザ名
  ble/prompt/print "$_ble_prompt_const_u"
  return 0
}
function ble/prompt/backslash:v { # = bash version %d.%d
  ble/prompt/print "$_ble_prompt_const_v"
  return 0
}
function ble/prompt/backslash:V { # = bash version %d.%d.%d
  ble/prompt/print "$_ble_prompt_const_V"
  return 0
}
function ble/prompt/backslash:w { # PWD
  ble/prompt/unit/add-hash '$PWD'
  ble/prompt/.update-working-directory
  local ret
  ble/prompt/.escape-control-characters "$prompt_cache_wd"
  ble/prompt/print "$ret"
  return 0
}
function ble/prompt/backslash:W { # PWD短縮
  ble/prompt/unit/add-hash '$PWD'
  if [[ ! ${PWD//'/'} ]]; then
    ble/prompt/print "$PWD"
  else
    ble/prompt/.update-working-directory
    local ret
    ble/prompt/.escape-control-characters "${prompt_cache_wd##*/}"
    ble/prompt/print "$ret"
  fi
  return 0
}
function ble/prompt/backslash:q {
  local rex='^\{([^{}]*)\}'
  if [[ ${tail:2} =~ $rex ]]; then
    local rematch=$BASH_REMATCH
    ((i+=${#rematch}))
    local word; ble/string#split-words word "${BASH_REMATCH[1]}"
    if [[ $word ]] && ble/is-function ble/prompt/backslash:"$word"; then
      ble/util/joblist.check
      ble/prompt/backslash:"${word[@]}"; local ext=$?
      ble/util/joblist.check ignore-volatile-jobs
      return "$?"
    else
      if [[ ! $word ]]; then
        ble/term/visible-bell "ble/prompt: invalid sequence \\q$rematch"
      elif ! ble/is-function ble/prompt/backslash:"$word"; then
        ble/term/visible-bell "ble/propmt: undefined named sequence \\q{$word}"
      fi
      ble/prompt/print "\\q$BASH_REMATCH"
      return 2
    fi
  else
    ble/prompt/print "\\$c"
  fi
  return 0
}
function ble/prompt/backslash:g {
  local rex='^\{([^{}]*)\}'
  if [[ ${tail:2} =~ $rex ]]; then
    ((i+=${#BASH_REMATCH}))
    local ret
    ble/color/gspec2g "${BASH_REMATCH[1]}"
    ble/color/g2sgr-ansi "$ret"
    ble/prompt/print "$ret"
  else
    ble/prompt/print "\\$c"
  fi
  return 0
}
function ble/prompt/backslash:position {
  ((_ble_textmap_dbeg>=0)) && ble/widget/.update-textmap
  local fmt=${1:-'(%s,%s)'} pos
  ble/prompt/unit/add-hash '${_ble_textmap_pos[_ble_edit_ind]}'
  ble/string#split-words pos "${_ble_textmap_pos[_ble_edit_ind]}"
  ble/util/sprintf pos "$fmt" $((pos[1]+1)) $((pos[0]+1))
  ble/prompt/print "$pos"
}
function ble/prompt/backslash:row {
  ((_ble_textmap_dbeg>=0)) && ble/widget/.update-textmap
  local pos
  ble/prompt/unit/add-hash '${_ble_textmap_pos[_ble_edit_ind]}'
  ble/string#split-words pos "${_ble_textmap_pos[_ble_edit_ind]}"
  ble/prompt/print $((pos[1]+1))
}
function ble/prompt/backslash:column {
  ((_ble_textmap_dbeg>=0)) && ble/widget/.update-textmap
  local pos
  ble/prompt/unit/add-hash '${_ble_textmap_pos[_ble_edit_ind]}'
  ble/string#split-words pos "${_ble_textmap_pos[_ble_edit_ind]}"
  ble/prompt/print $((pos[0]+1))
}
function ble/prompt/backslash:point {
  ble/prompt/unit/add-hash '$_ble_edit_ind'
  ble/prompt/print "$_ble_edit_ind"
}
function ble/prompt/backslash:mark {
  ble/prompt/unit/add-hash '$_ble_edit_mark'
  ble/prompt/print "$_ble_edit_mark"
}
function ble/prompt/backslash:history-index {
  ble/prompt/unit/add-hash '$_ble_history_INDEX'
  ble/canvas/put.draw $((_ble_history_INDEX+1))
}
function ble/prompt/backslash:history-percentile {
  ble/prompt/unit/add-hash '$_ble_history_INDEX'
  ble/prompt/unit/add-hash '$_ble_history_COUNT'
  local index=$_ble_history_INDEX
  local count=$_ble_history_COUNT
  ((count||count++))
  ble/canvas/put.draw "$((index*100/count))%"
}
function ble/prompt/.update-working-directory {
  [[ $prompt_cache_wd ]] && return 0
  if [[ ! ${PWD//'/'} ]]; then
    prompt_cache_wd=$PWD
    return 0
  fi
  local head= body=${PWD%/}
  if [[ $body == "$HOME" ]]; then
    prompt_cache_wd='~'
    return 0
  elif [[ $body == "$HOME"/* ]]; then
    head='~/'
    body=${body#"$HOME"/}
  fi
  if [[ $PROMPT_DIRTRIM ]]; then
    local dirtrim=$((PROMPT_DIRTRIM))
    local pat='[^/]'
    local count=${body//$pat}
    if ((${#count}>=dirtrim)); then
      local ret
      ble/string#repeat '/*' "$dirtrim"
      local omit=${body%$ret}
      ((${#omit}>3)) &&
        body=...${body:${#omit}}
    fi
  fi
  prompt_cache_wd=$head$body
}
function ble/prompt/.escape/check-double-quotation {
  if [[ $tail == '"'* ]]; then
    if [[ ! $nest ]]; then
      out=$out'\"'
      tail=${tail:1}
    else
      out=$out'"'
      tail=${tail:1}
      nest=\"$nest
      ble/prompt/.escape/update-rex_skip
    fi
    return 0
  else
    return 1
  fi
}
function ble/prompt/.escape/check-command-substitution {
  if [[ $tail == '$('* ]]; then
    out=$out'$('
    tail=${tail:2}
    nest=')'$nest
    ble/prompt/.escape/update-rex_skip
    return 0
  else
    return 1
  fi
}
function ble/prompt/.escape/check-parameter-expansion {
  if [[ $tail == '${'* ]]; then
    out=$out'${'
    tail=${tail:2}
    nest='}'$nest
    ble/prompt/.escape/update-rex_skip
    return 0
  else
    return 1
  fi
}
function ble/prompt/.escape/check-incomplete-quotation {
  if [[ $tail == '`'* ]]; then
    local rex='^`([^\`]|\\.)*\\$'
    [[ $tail =~ $rex ]] && tail=$tail'\'
    out=$out$tail'`'
    tail=
    return 0
  elif [[ $nest == ['})']* && $tail == \'* ]]; then
    out=$out$tail$q
    tail=
    return 0
  elif [[ $nest == ['})']* && $tail == \$\'* ]]; then
    local rex='^\$'$q'([^\'$q']|\\.)*\\$'
    [[ $tail =~ $rex ]] && tail=$tail'\'
    out=$out$tail$q
    tail=
    return 0
  elif [[ $tail == '\' ]]; then
    out=$out'\\'
    tail=
    return 0
  else
    return 1
  fi
}
function ble/prompt/.escape/update-rex_skip {
  if [[ $nest == \)* ]]; then
    rex_skip=$rex_skip_paren
  elif [[ $nest == \}* ]]; then
    rex_skip=$rex_skip_brace
  else
    rex_skip=$rex_skip_dquot
  fi
}
function ble/prompt/.escape {
  local tail=$1 out= nest=
  local q=\'
  local rex_bq='`([^\`]|\\.)*`'
  local rex_sq=$q'[^'$q']*'$q'|\$'$q'([^\'$q']|\\.)*'$q
  local rex_skip
  local rex_skip_dquot='^([^\"$`]|'$rex_bq'|\\.)+'
  local rex_skip_brace='^([^\"$`'$q'}]|'$rex_bq'|'$rex_sq'|\\.)+'
  local rex_skip_paren='^([^\"$`'$q'()]|'$rex_bq'|'$rex_sq'|\\.)+'
  ble/prompt/.escape/update-rex_skip
  while [[ $tail ]]; do
    if [[ $tail =~ $rex_skip ]]; then
      out=$out$BASH_REMATCH
      tail=${tail:${#BASH_REMATCH}}
    elif [[ $nest == ['})"']* && $tail == "${nest::1}"* ]]; then
      out=$out${nest::1}
      tail=${tail:1}
      nest=${nest:1}
      ble/prompt/.escape/update-rex_skip
    elif [[ $nest == \)* && $tail == \(* ]]; then
      out=$out'('
      tail=${tail:1}
      nest=')'$nest
    elif ble/prompt/.escape/check-double-quotation; then
      continue
    elif ble/prompt/.escape/check-command-substitution; then
      continue
    elif ble/prompt/.escape/check-parameter-expansion; then
      continue
    elif ble/prompt/.escape/check-incomplete-quotation; then
      continue
    else
      out=$out${tail::1}
      tail=${tail:1}
    fi
  done
  ret=$out$nest
}
function ble/prompt/.get-keymap-for-current-mode {
  ble/prompt/unit/add-hash '$_ble_decode_keymap,${_ble_decode_keymap_stack[*]}'
  keymap=$_ble_decode_keymap
  local index=${#_ble_decode_keymap_stack[@]}
  while :; do
    case $keymap in (vi_?map|emacs) return ;; esac
    ((--index<0)) && break
    keymap=${_ble_decode_keymap_stack[index]}
  done
}
function ble/prompt/.uses-builtin-prompt-expansion {
  ((_ble_bash>=40400)) || return 1
  local ps=$1
  local chars_safe_esc='][0-7aenrdtAT@DhHjlsuvV!$\wW'
  [[ ( $OSTYPE == cygwin || $OSTYPE == msys ) && $_ble_prompt_const_root == '#' ]] &&
    chars_safe_esc=${chars_safe_esc//'$'} # Note: cygwin では ble.sh 独自の方法で \$ を処理する。
  [[ $ps == *'\'[!"$chars_safe_esc"]* ]] && return 1
  local glob_ctrl=$'[\001-\037\177]'
  [[ $ps == *'\'[wW]* && $PWD == *$glob_ctrl* ]] && return 1
  [[ $ps == *'\s'* && $_ble_prompt_const_s == *$'\e'* ]] && return 1
  [[ $ps == *'\u'* && $_ble_prompt_const_u == *$'\e'* ]] && return 1
  [[ $ps == *'\h'* && $_ble_prompt_const_h == *$'\e'* ]] && return 1
  [[ $ps == *'\H'* && $_ble_prompt_const_H == *$'\e'* ]] && return 1
  return 0
}
function ble/prompt/.instantiate {
  trace_hash= esc= x=0 y=0 g=0 lc=32 lg=0
  local ps=$1 opts=$2 x0=$3 y0=$4 g0=$5 lc0=$6 lg0=$7 esc0=$8 trace_hash0=$9
  [[ ! $ps ]] && return 0
  local expanded=
  if ble/prompt/.uses-builtin-prompt-expansion "$ps"; then
    [[ $ps == *'\'[wW]* ]] && ble/prompt/unit/add-hash '$PWD'
    ble-edit/exec/.setexit "$_ble_edit_exec_lastarg"
    BASH_COMMAND=$_ble_edit_exec_BASH_COMMAND \
                builtin eval 'expanded=${ps@P}'
  else
    local prompt_noesc=
    shopt -q promptvars &>/dev/null || prompt_noesc=1
    local -a DRAW_BUFF=()
    ble/prompt/process-prompt-string "$ps"
    local processed; ble/canvas/sflush.draw -v processed
    if [[ ! $prompt_noesc ]]; then
      local ret
      ble/prompt/.escape "$processed"; local escaped=$ret
      expanded=${trace_hash0#*:} # Note: これは次行が失敗した時の既定値
      ble-edit/exec/.setexit "$_ble_edit_exec_lastarg"
      BASH_COMMAND=$_ble_edit_exec_BASH_COMMAND \
                  builtin eval "expanded=\"$escaped\""
    else
      expanded=$processed
    fi
  fi
  if [[ :$opts: == *:show-mode-in-prompt:* ]]; then
    if ble/util/test-rl-variable show-mode-in-prompt; then
      local keymap; ble/prompt/.get-keymap-for-current-mode
      local ret=
      case $keymap in
      (vi_imap) ble/util/read-rl-variable vi-ins-mode-string ;;
      (vi_[noxs]map) ble/util/read-rl-variable vi-cmd-mode-string ;;
      (emacs) ble/util/read-rl-variable emacs-mode-string ;;
      esac
      [[ $ret ]] && expanded=$expanded$ret
    fi
  fi
  if [[ :$opts: == *:no-trace:* ]]; then
    x=0 y=0 g=0 lc=32 lg=0
    esc=$expanded
  elif
    local rows=${prompt_rows:-${LINES:-25}}
    local cols=${prompt_cols:-${COLUMNS:-80}}
    local bleopt=$bleopt_char_width_mode,$bleopt_char_width_version,$bleopt_emoji_version,$bleopt_emoji_opts
    trace_hash=$opts#$rows,$cols#$bleopt#$expanded
    [[ $trace_hash != "$trace_hash0" ]]
  then
    local trace_opts=$opts:prompt
    [[ $bleopt_internal_suppress_bash_output ]] || trace_opts=$trace_opts:left-char
    x=0 y=0 g=0 lc=32 lg=0
    local ret
    LINES=$rows COLUMNS=$cols ble/canvas/trace "$expanded" "$trace_opts"; local traced=$ret
    ((lc<0&&(lc=0)))
    esc=$traced
    return 0
  else
    x=$x0 y=$y0 g=$g0 lc=$lc0 lg=$lg0
    esc=$esc0
    return 2
  fi
}
function ble/prompt/unit:{section}/clear {
  local prefix=$1 type=${2:-hash:draw}
  [[ :$type: == *:hash:* ]] &&
    builtin eval -- "${prefix}_data[2]="
  [[ :$type: == *:tail:* ]] &&
    builtin eval -- "${prefix}_data=(\"\${${prefix}_data[@]::10}\")"
  [[ :$type: == *:draw:* ]] &&
    builtin eval -- "${prefix}_dirty=1"
  [[ :$type: == *:all:* ]] &&
    builtin eval -- "${prefix}_data=(\"\${${prefix}_data[0]}\")"
  return 0
}
function ble/prompt/unit:{section}/get {
  local ref=${1}_data[8]; ret=${!ref}
}
function ble/prompt/unit:{section}/update {
  local prefix=$1 ps=$2 opts=$3
  local -a vars; vars=(data dirty)
  [[ :$opts: == *:measure-bbox:* ]] && ble/array#push vars bbox
  [[ :$opts: == *:measure-gbox:* ]] && ble/array#push vars gbox
  local "${vars[@]/%/=}" # #D1570 OK
  ble/util/restore-vars "${prefix}_" "${vars[@]}"
  local has_changed=
  if [[ $prompt_unit_expired ]]; then
    local original_esc=${data[8]}:${data[9]}:${data[10]} # esc:trace_hash:tailor
    if [[ $ps ]]; then
      [[ :$opts: == *:measure-bbox:* ]] &&
        local x1=${bbox[0]} y1=${bbox[1]} x2=${bbox[2]} y2=${bbox[3]}
      [[ :$opts: == *:measure-gbox:* ]] &&
        local gx1=${gbox[0]} gy1=${gbox[1]} gx2=${gbox[2]} gy2=${gbox[3]}
      local trace_hash esc x y g lc lg
      ble/prompt/.instantiate "$ps" "$opts" "${data[@]:3:7}"
      data=("${data[0]:-0}" '' '' "$x" "$y" "$g" "$lc" "$lg" "$esc" "$trace_hash" "${data[@]:10}")
      [[ :$opts: == *:measure-bbox:* ]] &&
        bbox=("$x1" "$y1" "$x2" "$y2")
      [[ :$opts: == *:measure-gbox:* ]] &&
        gbox=("$gx1" "$gy1" "$gx2" "$gy2")
    else
      data=("${data[0]:-0}" '' '' 0 0 0 32 0 '' '' "${data[@]:10}")
      [[ :$opts: == *:measure-bbox:* ]] && bbox=()
      [[ :$opts: == *:measure-gbox:* ]] && gbox=()
    fi
    [[ ${data[8]}:${data[9]}:${data[10]} != "$original_esc" ]] && has_changed=1
  fi
  [[ $has_changed ]] && ((dirty=1))
  ble/util/save-vars "${prefix}_" "${vars[@]}"
  [[ $has_changed ]]
}
function ble/prompt/unit:_ble_prompt_ps1/update {
  ble/prompt/unit/add-hash '$prompt_ps1'
  ble/prompt/unit:{section}/update _ble_prompt_ps1 "$prompt_ps1" show-mode-in-prompt
}
function ble/prompt/unit:_ble_prompt_rps1/update {
  ble/prompt/unit/add-hash '$prompt_rps1'
  ble/prompt/unit/add-hash '$_ble_prompt_ps1_data'
  local cols=${COLUMNS-80}
  local ps1x=${_ble_prompt_ps1_data[3]}
  local ps1y=${_ble_prompt_ps1_data[4]}
  local prompt_rows=$((ps1y+1)) prompt_cols=$cols
  ble/prompt/unit:{section}/update _ble_prompt_rps1 "$prompt_rps1" confine:relative:right:measure-gbox || return 1
  local esc=${_ble_prompt_rps1_data[8]} width=
  if [[ $esc ]]; then
    ((width=_ble_prompt_rps1_gbox[2]-_ble_prompt_rps1_gbox[0]))
    ((width&&20+width<cols&&ps1x+10+width<cols)) || esc= width=
  fi
  _ble_prompt_rps1_data[10]=$esc
  _ble_prompt_rps1_data[11]=$width
  return 0
}
function  ble/prompt/unit:_ble_prompt_xterm_title/update {
  ble/prompt/unit/add-hash '$bleopt_prompt_xterm_title'
  local prompt_rows=1
  ble/prompt/unit:{section}/update _ble_prompt_xterm_title "$bleopt_prompt_xterm_title" confine:no-trace || return 1
  local esc=${_ble_prompt_xterm_title_data[8]}
  [[ $esc ]] && esc=$'\e]0;'${esc//[! -~]/'#'}$'\a'
  _ble_prompt_xterm_title_data[10]=$esc
  return 0
}
function ble/prompt/unit:_ble_prompt_screen_title/update {
  ble/prompt/unit/add-hash '$bleopt_prompt_screen_title'
  local prompt_rows=1
  ble/prompt/unit:{section}/update _ble_prompt_screen_title "$bleopt_prompt_screen_title" confine:no-trace || return 1
  local esc=${_ble_prompt_screen_title_data[8]}
  [[ $esc ]] && esc=$'\ek'${esc//[! -~]/'#'}$'\e\\'
  _ble_prompt_screen_title_data[10]=$esc
  return 0
}
function ble/prompt/unit:_ble_prompt_term_status/update {
  ble/prompt/unit/add-hash '$bleopt_prompt_term_status'
  local prompt_rows=1
  ble/prompt/unit:{section}/update _ble_prompt_term_status "$bleopt_prompt_term_status" confine:no-trace || return 1
  local esc=${_ble_prompt_term_status_data[8]}
  if [[ $esc ]]; then
    esc=$_ble_term_tsl${esc//[! -~]/'#'}$_ble_term_fsl
  else
    esc=$_ble_term_dsl
  fi
  _ble_prompt_term_status_data[10]=$esc
  return 0
}
function ble/prompt/unit:_ble_prompt_status/update {
  ble/prompt/unit/add-hash '$bleopt_prompt_status_align'
  ble/prompt/unit/add-hash '$bleopt_prompt_status_line'
  local ps=$bleopt_prompt_status_line
  local cols=$COLUMNS; ((_ble_term_xenl||cols--))
  local trace_opts=confine:relative:measure-bbox:noscrc:face0=prompt_status_line
  local rex='^justify(=[^:]+)?$'
  [[ $bleopt_prompt_status_align =~ $rex ]] &&
    trace_opts=$trace_opts:$BASH_REMATCH
  local prompt_cols=1 prompt_cols=$cols
  ble/prompt/unit:{section}/update _ble_prompt_status "$ps" "$trace_opts" || return 1
  local esc=${_ble_prompt_status_data[8]}
  if [[ $ps && $esc ]]; then
    local x=${_ble_prompt_status_data[3]}
    local y=${_ble_prompt_status_data[4]}
    local x1=${_ble_prompt_status_bbox[0]}
    local x2=${_ble_prompt_status_bbox[2]}
    local -a DRAW_BUFF=()
    local ret
    ble/color/face2g prompt_status_line; local g0=$ret
    ble/color/g2sgr "$g0"; local sgr=$ret
    if ((g0==0||_ble_term_bce)); then
      ble/canvas/put.draw "$sgr$_ble_term_el$_ble_term_sgr0"
    else
      ble/string#reserve-prototype "$cols"
      ble/canvas/put.draw "$sgr${_ble_string_prototype::cols}"
      ble/canvas/put-cub.draw "$cols"
      ble/canvas/put.draw "$_ble_term_sgr0"
    fi
    local xshift=0
    case $bleopt_prompt_status_align in
    (center) ((xshift=cols/2-(x2+x1)/2)) ;;
    (right)  ((xshift=cols-x2)) ;;
    esac
    if ((xshift>0)); then
      ((x+=xshift))
      ble/canvas/put-cuf.draw "$xshift"
    fi
    ble/canvas/put.draw "$esc"
    ble/canvas/sflush.draw -v esc
    _ble_prompt_status_data[10]=$esc
    _ble_prompt_status_data[11]=$x
    _ble_prompt_status_data[12]=$y
  else
    _ble_prompt_status_data[10]=
    _ble_prompt_status_data[11]=
    _ble_prompt_status_data[12]=
  fi
  return 0
}
if ble/is-function ble/util/idle.push; then
  _ble_prompt_timeout_task=
  _ble_prompt_timeout_lineno=
  function ble/prompt/timeout/process {
    ble/util/idle.suspend # exit に失敗した時の為 task を suspend にする
    local msg="${_ble_term_setaf[12]}[ble: auto-logout]$_ble_term_sgr0 timed out waiting for input"
    ble/widget/.internal-print-command '
      ble/util/print "$msg"
      builtin exit 0 &>/dev/null
      builtin exit 0 &>/dev/null' pre-flush
    return 1 # exit に失敗した時
  } >/dev/tty
  function ble/prompt/timeout/check {
    [[ $_ble_edit_lineno == "$_ble_prompt_timeout_lineno" ]] && return 0
    _ble_prompt_timeout_lineno=$_ble_edit_lineno
    if [[ ${TMOUT:-} =~ ^[0-9]+ ]] && ((BASH_REMATCH>0)); then
      if [[ ! $_ble_prompt_timeout_task ]]; then
        ble/util/idle.push -Z 'ble/prompt/timeout/process'
        _ble_prompt_timeout_task=$_ble_util_idle_lasttask
      fi
      ble/util/idle#sleep "$_ble_prompt_timeout_task" $((BASH_REMATCH*1000))
    elif [[ $_ble_prompt_timeout_task ]]; then
      ble/util/idle#suspend "$_ble_prompt_timeout_task"
    fi
  }
else
  function ble/prompt/timeout/check { ((1)); }
fi
function ble/prompt/update/.has-prompt_command {
  [[ ${_ble_edit_PROMPT_COMMAND[*]} == *[![:space:]]* ]]
}
function _ble_prompt_update__eval_prompt_command_1 {
  local _ble_edit_exec_TRAPDEBUG_enabled=1
  ble-edit/exec/.setexit "$_ble_edit_exec_lastarg"
  BASH_COMMAND=$_ble_edit_exec_BASH_COMMAND \
    builtin eval -- "$1"
}
ble/function#trace _ble_prompt_update__eval_prompt_command_1
function ble/prompt/update/.eval-prompt_command {
  ((${#PROMPT_COMMAND[@]})) || return 0
  local _command _ble_edit_exec_TRAPDEBUG_adjusted=1
  ble-edit/exec:gexec/.TRAPDEBUG/restore filter
  for _command in "${PROMPT_COMMAND[@]}"; do
    [[ $_command ]] || continue
    _ble_prompt_update__eval_prompt_command_1 "$_command"
  done
  _ble_edit_exec_gexec__TRAPDEBUG_adjust
}
_ble_prompt_update=
_ble_prompt_update_dirty=
_ble_prompt_rps1_enabled=
function ble/prompt/update {
  local opts=:$1: dirty=
  local count; ble/history/get-count
  local version=$COLUMNS:$_ble_edit_lineno:$count
  if [[ :$opts: == *:check-dirty:* && $_ble_prompt_update == owner ]]; then
    if [[ $_ble_prompt_update_dirty && :$opts: != *:leave:* && $_ble_prompt_hash == "$version" ]]; then
      [[ $_ble_prompt_update_dirty == dirty ]]; local ext=$?
      _ble_prompt_update_dirty=done
      return "$ext"
    fi
  fi
  ble/prompt/timeout/check
  _ble_prompt_rps1_enabled=
  if ((_ble_textarea_panel==0)); then # 補助プロンプトに対しては PROMPT_COMMAND は実行しない
    if [[ ${_ble_prompt_hash%:*} != "${version%:*}" && $opts != *:leave:* ]]; then
      if ble/prompt/update/.has-prompt_command || blehook/has-hook PRECMD; then
        if [[ $bleopt_prompt_command_changes_layout ]]; then
          ble/edit/enter-command-layout # #D1800 pair=leave-command-layout
          local -a DRAW_BUFF=()
          ble/canvas/panel#goto.draw 0 0 0 sgr0
          ble/canvas/bflush.draw
          ble/util/buffer.flush >&2
        fi
        ((_ble_edit_attached)) && ble-edit/restore-PS1
        ble-edit/exec:gexec/invoke-hook-with-setexit PRECMD
        ble/prompt/update/.eval-prompt_command
        ((_ble_edit_attached)) && ble-edit/adjust-PS1
        if [[ $bleopt_prompt_command_changes_layout ]]; then
          ble/edit/leave-command-layout # #D1800 pair=enter-command-layout
        fi
      fi
    fi
  fi
  local prompt_opts=
  local prompt_ps1=$_ble_edit_PS1
  local prompt_rps1=$bleopt_prompt_rps1
  if [[ $opts == *:leave:* ]]; then
    local ps1f=$bleopt_prompt_ps1_final
    local rps1f=$bleopt_prompt_rps1_final
    local ps1t=$bleopt_prompt_ps1_transient
    [[ :$ps1t: == *:trim:* || :$ps1t: == *:same-dir:* && $PWD != $_ble_edit_line_opwd ]] && ps1t=
    if [[ $ps1f || $rps1f || $ps1t ]]; then
      prompt_opts=$prompt_opts:leave-rewrite
      [[ $ps1f || $ps1t ]] && prompt_ps1=$ps1f
      [[ $rps1f ]] && prompt_rps1=$rps1f
      ble/textarea#invalidate
    fi
  fi
  if [[ :$prompt_opts: == *:leave-rewrite:* || $_ble_prompt_hash != "$version" ]]; then
    _ble_prompt_hash=$version
    ((_ble_prompt_version++))
  fi
  ble/history/update-position
  local prompt_hashref_base='$_ble_prompt_version'
  local prompt_rows=${LINES:-25}
  local prompt_cols=${COLUMNS:-80}
  local "${_ble_prompt_cache_vars[@]/%/=}" # #D1570 OK
  ble/prompt/unit#update _ble_prompt_ps1 && dirty=1
  [[ $MC_SID == $$ ]] && { [[ $dirty ]]; return $?; }
  ((_ble_textarea_panel==0)) || { [[ $dirty ]]; return $?; }
  if [[ :$opts: == *:leave:* && ! $rps1f && $bleopt_prompt_rps1_transient ]]; then
    [[ ${_ble_prompt_rps1_data[10]} ]] && dirty=1 _ble_prompt_rps1_enabled=erase
  else
    [[ $prompt_rps1 || ${_ble_prompt_rps1_data[10]} ]] &&
      ble/prompt/unit#update _ble_prompt_rps1 && dirty=1
    [[ ${_ble_prompt_rps1_data[10]} ]] && _ble_prompt_rps1_enabled=1
  fi
  case ${_ble_term_TERM:-$TERM:-} in
  (sun*|minix*) ;; # black list
  (*)
    [[ $bleopt_prompt_xterm_title || ${_ble_prompt_xterm_title_data[10]} ]] &&
      ble/prompt/unit#update _ble_prompt_xterm_title && dirty=1 ;;
  esac
  case ${_ble_term_TERM:-$TERM:-} in
  (screen:*|tmux:*|contra:*|screen.*|screen-*)
    [[ $bleopt_prompt_screen_title || ${_ble_prompt_screen_title_data[10]} ]] &&
      ble/prompt/unit#update _ble_prompt_screen_title && dirty=1 ;;
  esac
  if [[ $_ble_term_tsl && $_ble_term_fsl ]]; then
    [[ $bleopt_prompt_term_status || ${_ble_prompt_term_status_data[10]} ]] &&
      ble/prompt/unit#update _ble_prompt_term_status && dirty=1
  fi
  [[ $bleopt_prompt_status_line || ${_ble_prompt_status_data[10]} ]] &&
    ble/prompt/unit#update _ble_prompt_status && dirty=1
  [[ $dirty ]] && _ble_prompt_update_dirty=dirty
  [[ $dirty ]]
}
function ble/prompt/clear {
  _ble_prompt_hash=
  ble/textarea#invalidate
}
_ble_prompt_ruler=('' '' 0)
function ble/prompt/print-ruler.draw {
  [[ $bleopt_prompt_ruler ]] || return 0
  local command=$1 opts=$2 cols=$COLUMNS
  local rex_eval_prefix='(([!{]|time|if|then|elif|while|until|do|exec|eval|command|env|nice|nohup|xargs|sudo)[[:space:]]+)?'
  local rex_clear_command='(tput[[:space:]]+)?(clear|reset)'
  local rex=$'(^|[\n;&|(])[[:space:]]*'$rex_eval_prefix$rex_clear_command'([ \t\n;&|)]|$)'
  [[ $command =~ $rex ]] && return 0
  if [[ :$opts: == *:keep-info:* ]]; then
    ble/canvas/panel#increase-height.draw "$_ble_textarea_panel" 1
    ble/canvas/panel#goto.draw "$_ble_textarea_panel" 0 0
    ((_ble_canvas_panel_height[_ble_textarea_panel]--))
  fi
  if [[ $bleopt_prompt_ruler == empty-line ]]; then
    ble/canvas/put.draw $'\n'
  else
    if [[ $bleopt_prompt_ruler != "${_ble_prompt_ruler[0]}" ]]; then
      if [[ $bleopt_prompt_ruler ]]; then
        local ret= x=0 y=0 g=0 x1=0 x2=0 y1=0 y2=0
        LINES=1 COLUMNS=$cols ble/canvas/trace "$bleopt_prompt_ruler" truncate:measure-bbox
        _ble_prompt_ruler=("$bleopt_prompt_ruler" "$ret" "$x2")
        if ((!_ble_prompt_ruler[2])); then
          _ble_prompt_ruler[1]=${_ble_prompt_ruler[1]}' '
          ((_ble_prompt_ruler[2]++))
        fi
      else
        _ble_prompt_ruler=('' '' 0)
      fi
    fi
    local w=${_ble_prompt_ruler[2]}
    local repeat=$((cols/w))
    ble/string#repeat "${_ble_prompt_ruler[1]}" "$repeat"
    ble/canvas/put.draw "$ret"
    ble/string#repeat ' ' $((cols-repeat*w))
    ble/canvas/put.draw "$ret"
    ((_ble_term_xenl)) && ble/canvas/put.draw $'\n'
  fi
}
function ble/prompt/print-ruler.buff {
  local -a DRAW_BUFF=()
  ble/prompt/print-ruler.draw "$@"
  ble/canvas/bflush.draw
}
function ble/edit/info/.initialize-size {
  local ret
  ble/canvas/panel/layout/.get-available-height "$_ble_edit_info_panel"
  cols=${COLUMNS-80} lines=$ret
}
_ble_edit_info_panel=2
_ble_edit_info=(0 0 "")
_ble_edit_info_invalidated=
function ble/edit/info#panel::getHeight {
  (($1!=_ble_edit_info_panel)) && return 0
  if ble/edit/is-command-layout || [[ ! ${_ble_edit_info[2]} ]]; then
    height=0:0
  else
    height=1:$((_ble_edit_info[1]+1))
  fi
}
function ble/edit/info#panel::invalidate {
  (($1!=_ble_edit_info_panel)) && return 0
  _ble_edit_info_invalidated=1
}
function ble/edit/info#panel::render {
  (($1!=_ble_edit_info_panel)) && return 0
  ble/edit/is-command-layout && return 0
  [[ $_ble_edit_info_invalidated ]] || return 0
  local x=${_ble_edit_info[0]} y=${_ble_edit_info[1]} content=${_ble_edit_info[2]}
  local -a DRAW_BUFF=()
  if [[ ! $content ]]; then
    ble/canvas/panel#set-height.draw "$_ble_edit_info_panel" 0
  else
    ble/canvas/panel/reallocate-height.draw
    if ((y<_ble_canvas_panel_height[$1])); then
      ble/canvas/panel#clear.draw "$_ble_edit_info_panel"
      ble/canvas/panel#goto.draw "$_ble_edit_info_panel"
      ble/canvas/put.draw "$content"
      ((_ble_canvas_y+=y,_ble_canvas_x=x))
    else
      _ble_edit_info=(0 0 "")
      ble/canvas/panel#set-height.draw "$_ble_edit_info_panel" 0
    fi
  fi
  ble/canvas/bflush.draw
  _ble_edit_info_invalidated=
}
function ble/edit/info#collapse {
  local panel=${1-$_ble_prompt_info_panel}
  ((panel!=_ble_edit_info_panel)) && return 0
  local -a DRAW_BUFF=()
  ble/canvas/panel#set-height.draw "$panel" 0
  ble/canvas/bflush.draw
  _ble_edit_info_invalidated=1
}
function ble/edit/info/.construct-content {
  local cols lines
  ble/edit/info/.initialize-size
  x=0 y=0 content=
  local type=$1 text=$2
  case "$1" in
  (clear) ;;
  (ansi|esc)
    local trace_opts=truncate
    [[ $bleopt_info_display == bottom ]] && trace_opts=$trace_opts:noscrc
    [[ $1 == esc ]] && trace_opts=$trace_opts:terminfo
    local ret= g=0
    LINES=$lines ble/canvas/trace "$text" "$trace_opts"
    content=$ret ;;
  (text)
    local ret
    ble/canvas/trace-text "$text"
    content=$ret ;;
  (store)
    x=$2 y=$3 content=$4
    ((y<lines)) || ble/edit/info/.construct-content esc "$content" ;;
  (*)
    ble/util/print "usage: ble/edit/info/.construct-content type text" >&2 ;;
  esac
}
function ble/edit/info/.render-content {
  local x=$1 y=$2 content=$3 opts=$4
  if [[ $content != "${_ble_edit_info[2]}" ]]; then
    _ble_edit_info=("$x" "$y" "$content")
    _ble_edit_info_invalidated=1
  fi
  [[ :$opts: == *:defer:* ]] && return 0
  [[ $_ble_app_render_mode == panel ]] || return 0
  ble/edit/info#panel::render "$_ble_edit_info_panel"
}
_ble_edit_info_default=(0 0 "")
_ble_edit_info_scene=default
function ble/edit/info/show {
  local type=$1 text=$2
  if [[ $text ]]; then
    local x y content=
    ble/edit/info/.construct-content "$@"
    ble/edit/info/.render-content "$x" "$y" "$content"
    ble/util/buffer.flush >&2
    _ble_edit_info_scene=show
  else
    ble/edit/info/default
  fi
}
function ble/edit/info/set-default {
  local type=$1 text=$2
  local x y content
  ble/edit/info/.construct-content "$type" "$text"
  _ble_edit_info_default=("$x" "$y" "$content")
  [[ $_ble_edit_info_scene == default ]] &&
    ble/edit/info/.render-content "${_ble_edit_info_default[@]}" defer
}
function ble/edit/info/default {
  _ble_edit_info_scene=default
  if (($#)); then
    ble/edit/info/set-default "$@"
  else
    ble/edit/info/.render-content "${_ble_edit_info_default[@]}" defer
  fi
  return 0
}
function ble/edit/info/clear {
  [[ ${_ble_edit_info[2]} ]] || return 1
  [[ $_ble_app_render_mode == panel ]] || return 0
  _ble_edit_info_scene=clear
  ble/edit/info/.render-content 0 0 ""
}
function ble/edit/info/immediate-show {
  local ret; ble/canvas/panel/save-position
  ble/edit/info/show "$@"
  ble/canvas/panel/load-position "$ret"
  ble/util/buffer.flush >&2
}
function ble/edit/info/immediate-default {
  local ret; ble/canvas/panel/save-position
  ble/edit/info/default
  ble/edit/info/.render-content "${_ble_edit_info_default[@]}"
  ble/canvas/panel/load-position "$ret"
  ble/util/buffer.flush >&2
}
_ble_edit_VARNAMES=(
  _ble_edit_str
  _ble_edit_ind
  _ble_edit_mark
  _ble_edit_mark_active
  _ble_edit_overwrite_mode
  _ble_edit_line_disabled
  _ble_edit_arg
  _ble_edit_dirty_draw_beg
  _ble_edit_dirty_draw_end
  _ble_edit_dirty_draw_end0
  _ble_edit_dirty_syntax_beg
  _ble_edit_dirty_syntax_end
  _ble_edit_dirty_syntax_end0
  _ble_edit_dirty_observer
  _ble_edit_kill_index
  _ble_edit_kill_ring
  _ble_edit_kill_type)
_ble_edit_str=
_ble_edit_ind=0
_ble_edit_mark=0
_ble_edit_mark_active=
_ble_edit_overwrite_mode=
_ble_edit_line_disabled=
_ble_edit_arg=
_ble_edit_kill_index=0
_ble_edit_kill_ring=()
_ble_edit_kill_type=()
function ble-edit/content/replace {
  local beg=$1 end=$2
  local ins=$3 reason=${4:-edit}
  _ble_edit_str="${_ble_edit_str::beg}""$ins""${_ble_edit_str:end}"
  ble-edit/content/.update-dirty-range "$beg" $((beg+${#ins})) "$end" "$reason"
  ble/util/assert \
    '((0<=_ble_edit_dirty_syntax_beg&&_ble_edit_dirty_syntax_end<=${#_ble_edit_str}))' \
    "0 <= beg=$_ble_edit_dirty_syntax_beg <= end=$_ble_edit_dirty_syntax_end <= len=${#_ble_edit_str}; beg=$beg, end=$end, ins(${#ins})=$ins" ||
    {
      _ble_edit_dirty_syntax_beg=0
      _ble_edit_dirty_syntax_end=${#_ble_edit_str}
      _ble_edit_dirty_syntax_end0=0
      local olen=$((${#_ble_edit_str}-${#ins}+end-beg))
      ((olen<0&&(olen=0),
        _ble_edit_ind>olen&&(_ble_edit_ind=olen),
        _ble_edit_mark>olen&&(_ble_edit_mark=olen)))
    }
}
function ble-edit/content/reset {
  local str=$1 reason=${2:-edit}
  local beg=0 end=${#str} end0=${#_ble_edit_str}
  _ble_edit_str=$str
  ble-edit/content/.update-dirty-range "$beg" "$end" "$end0" "$reason"
  ble/util/assert \
    '((0<=_ble_edit_dirty_syntax_beg&&_ble_edit_dirty_syntax_end<=${#_ble_edit_str}))' \
    "0 <= beg=$_ble_edit_dirty_syntax_beg <= end=$_ble_edit_dirty_syntax_end <= len=${#_ble_edit_str}; str(${#str})=$str" ||
    {
      _ble_edit_dirty_syntax_beg=0
      _ble_edit_dirty_syntax_end=${#_ble_edit_str}
      _ble_edit_dirty_syntax_end0=0
    }
}
function ble-edit/content/reset-and-check-dirty {
  local str=$1 reason=${2:-edit}
  [[ $_ble_edit_str == "$str" ]] && return 0
  local ret pref suff
  ble/string#common-prefix "$_ble_edit_str" "$str"; pref=$ret
  local dmin=${#pref}
  ble/string#common-suffix "${_ble_edit_str:dmin}" "${str:dmin}"; suff=$ret
  local dmax0=$((${#_ble_edit_str}-${#suff})) dmax=$((${#str}-${#suff}))
  _ble_edit_str=$str
  ble-edit/content/.update-dirty-range "$dmin" "$dmax" "$dmax0" "$reason"
}
function ble-edit/content/replace-limited {
  insert=$3
  if [[ $bleopt_line_limit_type == discard ]]; then
    local ibeg=$1 iend=$2 opts=:$4:
    local limit=$((bleopt_line_limit_length))
    if ((limit)); then
      local inslimit=$((limit-${#_ble_edit_str}+(iend-ibeg)))
      ((inslimit<iend-ibeg&&(inslimit=iend-ibeg)))
      ((${#insert}>inslimit)) && insert=${insert::inslimit}
      if [[ ! $insert ]] && ((ibeg==iend)); then
        [[ $opts == *:nobell:* ]] ||
          ble/widget/.bell "ble: reached line_limit_length=$limit"
        return 1
      fi
    fi
  fi
  ble-edit/content/replace "$1" "$2" "$insert"
}
function ble-edit/content/check-limit {
  local opts=:${1:-truncate:editor}:
  if [[ $opts == *:${bleopt_line_limit_type:-none}:* ]]; then
    local limit=$((bleopt_line_limit_length))
    if ((limit>0&&${#_ble_edit_str}>limit)); then
      local ble_edit_line_limit=$limit
      ble-decode-key "$_ble_decode_KCODE_LINE_LIMIT"
    fi
  fi
}
function ble/widget/__line_limit__ {
  local editor=ble/widget/${1:-edit-and-execute-command.impl}
  local limit=$ble_edit_line_limit
  case ${bleopt_line_limit_type:-none} in
  (editor)
    local content=$_ble_edit_str
    ble-edit/content/reset "# reached line_limit_length=$limit"
    _ble_edit_ind=0 _ble_edit_mark=0
    "$editor" "$content"
    (($?==127)) &&
      ble-edit/content/reset "${content::limit}"
    return 1 ;;
  (truncate|*)
    ble-edit/content/replace "$limit" "${#_ble_edit_str}" ''
    ((_ble_edit_ind>limit&&(_ble_edit_ind=limit)))
    ((_ble_edit_mark>limit&&(_ble_edit_mark=limit)))
    return 1 ;;
  esac
  return 0
}
_ble_edit_dirty_draw_beg=-1
_ble_edit_dirty_draw_end=-1
_ble_edit_dirty_draw_end0=-1
_ble_edit_dirty_syntax_beg=0
_ble_edit_dirty_syntax_end=0
_ble_edit_dirty_syntax_end0=1
_ble_edit_dirty_observer=()
function ble-edit/content/.update-dirty-range {
  ble/dirty-range#update --prefix=_ble_edit_dirty_draw_ "${@:1:3}"
  ble/dirty-range#update --prefix=_ble_edit_dirty_syntax_ "${@:1:3}"
  ble/textmap#update-dirty-range "${@:1:3}"
  local obs
  for obs in "${_ble_edit_dirty_observer[@]}"; do "$obs" "$@"; done
}
function ble-edit/content/update-syntax {
  if ble/util/import/is-loaded "$_ble_base/lib/core-syntax.sh"; then
    local beg end end0
    ble/dirty-range#load --prefix=_ble_edit_dirty_syntax_
    if ((beg>=0)); then
      ble/dirty-range#clear --prefix=_ble_edit_dirty_syntax_
      ble/syntax/parse "$_ble_edit_str" '' "$beg" "$end" "$end0"
    fi
  fi
}
function ble-edit/content/eolp {
  local pos=${1:-$_ble_edit_ind}
  ((pos==${#_ble_edit_str})) || [[ ${_ble_edit_str:pos:1} == $'\n' ]]
}
function ble-edit/content/bolp {
  local pos=${1:-$_ble_edit_ind}
  ((pos<=0)) || [[ ${_ble_edit_str:pos-1:1} == $'\n' ]]
}
function ble-edit/content/find-logical-eol {
  local index=${1:-$_ble_edit_ind} offset=${2:-0}
  if ((offset>0)); then
    local text=${_ble_edit_str:index}
    local rex=$'^([^\n]*\n){0,'$((offset-1))$'}([^\n]*\n)?[^\n]*'
    [[ $text =~ $rex ]]
    ((ret=index+${#BASH_REMATCH}))
    [[ ${BASH_REMATCH[2]} ]]
  elif ((offset<0)); then
    local text=${_ble_edit_str::index}
    local rex=$'(\n[^\n]*){0,'$((-offset-1))$'}(\n[^\n]*)?$'
    [[ $text =~ $rex ]]
    if [[ $BASH_REMATCH ]]; then
      ((ret=index-${#BASH_REMATCH}))
      [[ ${BASH_REMATCH[2]} ]]
    else
      ble-edit/content/find-logical-eol "$index" 0
      return 1
    fi
  else
    local text=${_ble_edit_str:index}
    text=${text%%$'\n'*}
    ((ret=index+${#text}))
    return 0
  fi
}
function ble-edit/content/find-logical-bol {
  local index=${1:-$_ble_edit_ind} offset=${2:-0}
  if ((offset>0)); then
    local rex=$'^([^\n]*\n){0,'$((offset-1))$'}([^\n]*\n)?'
    [[ ${_ble_edit_str:index} =~ $rex ]]
    if [[ $BASH_REMATCH ]]; then
      ((ret=index+${#BASH_REMATCH}))
      [[ ${BASH_REMATCH[2]} ]]
    else
      ble-edit/content/find-logical-bol "$index" 0
      return 1
    fi
  elif ((offset<0)); then
    ble-edit/content/find-logical-eol "$index" "$offset"; local ext=$?
    ble-edit/content/find-logical-bol "$ret" 0
    return "$ext"
  else
    local text=${_ble_edit_str::index}
    text=${text##*$'\n'}
    ((ret=index-${#text}))
    return 0
  fi
}
function ble-edit/content/find-non-space {
  local bol=$1
  local rex=$'^[ \t]*'; [[ ${_ble_edit_str:bol} =~ $rex ]]
  ret=$((bol+${#BASH_REMATCH}))
}
function ble-edit/content/is-single-line {
  [[ $_ble_edit_str != *$'\n'* ]]
}
function ble-edit/content/get-arg {
  local default_value=$1
  local value=$_ble_edit_arg
  _ble_edit_arg=
  if [[ $value == +* ]]; then
    if [[ $value == + ]]; then
      arg=4
      return 0
    fi
    value=${value#+}
  fi
  if [[ $value == -* ]]; then
    if [[ $value == - ]]; then
      arg=-1
    else
      arg=$((-10#0${value#-}))
    fi
  else
    if [[ $value ]]; then
      arg=$((10#0$value))
    else
      arg=$default_value
    fi
  fi
}
function ble-edit/content/clear-arg {
  _ble_edit_arg=
}
function ble-edit/content/toggle-arg {
  if [[ $_ble_edit_arg == + ]]; then
    _ble_edit_arg=
  elif [[ $_ble_edit_arg && $_ble_edit_arg != +* ]]; then
    _ble_edit_arg=+$_ble_edit_arg
  else
    _ble_edit_arg=+
  fi
}
function ble/keymap:generic/clear-arg {
  if [[ $_ble_decode_keymap == vi_[noxs]map ]]; then
    ble/keymap:vi/clear-arg
  else
    ble-edit/content/clear-arg
  fi
}
function ble/widget/append-arg-or {
  local n=${#KEYS[@]}; ((n&&n--))
  local code=$((KEYS[n]&_ble_decode_MaskChar))
  ((code==0)) && return 1
  local ret; ble/util/c2s "$code"; local ch=$ret
  if
    if [[ $_ble_edit_arg == + ]]; then
      [[ $ch == [-0-9] ]] && _ble_edit_arg=
    elif [[ $_ble_edit_arg == +* ]]; then
      false
    elif [[ $_ble_edit_arg ]]; then
      [[ $ch == [0-9] ]]
    else
      ((KEYS[n]&_ble_decode_MaskFlag))
    fi
  then
    ble/decode/widget/skip-lastwidget
    _ble_edit_arg=$_ble_edit_arg$ch
  else
    ble/widget/"$@"
  fi
}
function ble/widget/append-arg {
  ble/widget/append-arg-or self-insert
}
function ble/widget/universal-arg {
  ble/decode/widget/skip-lastwidget
  ble-edit/content/toggle-arg
}
function ble-edit/content/prepend-kill-ring {
  _ble_edit_kill_index=0
  local otext=${_ble_edit_kill_ring[0]-} ntext=$1
  local otype=${_ble_edit_kill_type[0]-} ntype=$2
  if [[ $otype == L || $ntype == L ]]; then
    ntext=${ntext%$'\n'}$'\n'
    otext=${otext%$'\n'}$'\n'
    _ble_edit_kill_ring[0]=$ntext$otext
    _ble_edit_kill_type[0]=L
  elif [[ $otype == B:* ]]; then
    if [[ $ntype != B:* ]]; then
      ntext=${ntext%$'\n'}$'\n'
      local ret; ble/string#count-char "$ntext" $'\n'
      ble/string#repeat '0 ' "$ret"
      ntype=B:${ret%' '}
    fi
    _ble_edit_kill_ring[0]=$ntext$otext
    _ble_edit_kill_type[0]="B:${ntype#B:} ${otype#B:}"
  else
    _ble_edit_kill_ring[0]=$ntext$otext
    _ble_edit_kill_type[0]=$otype
  fi
}
function ble-edit/content/append-kill-ring {
  _ble_edit_kill_index=0
  local otext=${_ble_edit_kill_ring[0]-} ntext=$1
  local otype=${_ble_edit_kill_type[0]-} ntype=$2
  if [[ $otype == L || $ntype == L ]]; then
    ntext=${ntext%$'\n'}$'\n'
    otext=${otext%$'\n'}$'\n'
    _ble_edit_kill_ring[0]=$otext$ntext
    _ble_edit_kill_type[0]=L
  elif [[ $otype == B:* ]]; then
    if [[ $ntype != B:* ]]; then
      ntext=${ntext%$'\n'}$'\n'
      local ret; ble/string#count-char "$ntext" $'\n'
      ble/string#repeat '0 ' "$ret"
      ntype=B:${ret%' '}
    fi
    _ble_edit_kill_ring[0]=$otext$ntext
    _ble_edit_kill_type[0]="B:${otype#B:} ${ntype#B:}"
  else
    _ble_edit_kill_ring[0]=$otext$ntext
    _ble_edit_kill_type[0]=$otype
  fi
}
function ble-edit/content/push-kill-ring {
  if ((${#_ble_edit_kill_ring[@]})) && [[ ${LASTWIDGET#ble/widget/} == kill-* || ${LASTWIDGET#ble/widget/} == copy-* ]]; then
    local name; ble/string#split-words name "${WIDGET#ble/widget/}"
    if [[ $name == kill-backward-* || $name == copy-backward-* ]]; then
      ble-edit/content/prepend-kill-ring "$1" "$2"
      return "$?"
    elif [[ $name != kill-region* && $name != copy-region* ]]; then
      ble-edit/content/append-kill-ring "$1" "$2"
      return "$?"
    fi
  fi
  _ble_edit_kill_index=0
  ble/array#unshift _ble_edit_kill_ring "$1"
  ble/array#unshift _ble_edit_kill_type "$2"
}
_ble_edit_PS1_adjusted=
_ble_edit_PS1='\s-\v\$ '
_ble_edit_PROMPT_COMMAND=
function ble-edit/adjust-PS1 {
  [[ $_ble_edit_PS1_adjusted ]] && return 0
  _ble_edit_PS1_adjusted=1
  _ble_edit_PS1=$PS1
  if [[ $bleopt_internal_suppress_bash_output ]]; then
    PS1='[ble: press RET to continue]'
  else
    PS1=
  fi
  if ble/is-array PROMPT_COMMAND; then
    ble/idict#copy _ble_edit_PROMPT_COMMAND PROMPT_COMMAND
  else
    ble/variable#copy-state PROMPT_COMMAND _ble_edit_PROMPT_COMMAND
  fi
  builtin unset -v PROMPT_COMMAND
}
function ble-edit/restore-PS1 {
  [[ $_ble_edit_PS1_adjusted ]] || return 1
  _ble_edit_PS1_adjusted=
  PS1=$_ble_edit_PS1
  if ble/is-array _ble_edit_PROMPT_COMMAND; then
    ble/idict#copy PROMPT_COMMAND _ble_edit_PROMPT_COMMAND
  else
    ble/variable#copy-state _ble_edit_PROMPT_COMMAND PROMPT_COMMAND
  fi
}
_ble_edit_IGNOREEOF_adjusted=
_ble_edit_IGNOREEOF=
function ble-edit/adjust-IGNOREEOF {
  [[ $_ble_edit_IGNOREEOF_adjusted ]] && return 0
  _ble_edit_IGNOREEOF_adjusted=1
  if [[ ${IGNOREEOF+set} ]]; then
    _ble_edit_IGNOREEOF=$IGNOREEOF
  else
    builtin unset -v _ble_edit_IGNOREEOF
  fi
  if ((_ble_bash>=40000)); then
    builtin unset -v IGNOREEOF
  else
    IGNOREEOF=9999
  fi
}
function ble-edit/restore-IGNOREEOF {
  [[ $_ble_edit_IGNOREEOF_adjusted ]] || return 1
  _ble_edit_IGNOREEOF_adjusted=
  if [[ ${_ble_edit_IGNOREEOF+set} ]]; then
    IGNOREEOF=$_ble_edit_IGNOREEOF
  else
    builtin unset -v IGNOREEOF
  fi
}
_ble_edit_READLINE=()
function ble-edit/adjust-READLINE {
  [[ $_ble_edit_READLINE ]] && return 0
  _ble_edit_READLINE=1
  ble/variable#copy-state READLINE_LINE  '_ble_edit_READLINE[1]'
  ble/variable#copy-state READLINE_POINT '_ble_edit_READLINE[2]'
  ble/variable#copy-state READLINE_MARK  '_ble_edit_READLINE[3]'
}
function ble-edit/restore-READLINE {
  [[ $_ble_edit_READLINE ]] || return 0
  _ble_edit_READLINE=
  ble/variable#copy-state '_ble_edit_READLINE[1]' READLINE_LINE
  ble/variable#copy-state '_ble_edit_READLINE[2]' READLINE_POINT
  ble/variable#copy-state '_ble_edit_READLINE[3]' READLINE_MARK
}
function ble-edit/eval-IGNOREEOF {
  local value=
  if [[ $_ble_edit_IGNOREEOF_adjusted ]]; then
    value=${_ble_edit_IGNOREEOF-0}
  else
    value=${IGNOREEOF-0}
  fi
  if [[ $value && ! ${value//[0-9]} ]]; then
    ret=$((10#0$value))
  else
    ret=10
  fi
}
bleopt/declare -n canvas_winch_action redraw-here
function ble-edit/attach/TRAPWINCH {
  ((_ble_edit_attached)) && [[ $_ble_term_state == internal ]] || return 0
  ble/application/onwinch 2>&$_ble_util_fd_stderr
}
_ble_edit_attached=0
function ble-edit/attach/.attach {
  ((_ble_edit_attached)) && return 0
  _ble_edit_attached=1
  if [[ ! ${_ble_edit_LINENO+set} ]]; then
    _ble_edit_LINENO=${BASH_LINENO[${#BASH_LINENO[@]}-1]}
    ((_ble_edit_LINENO<0)) && _ble_edit_LINENO=0
    builtin unset -v LINENO; LINENO=$_ble_edit_LINENO
    _ble_edit_CMD=$_ble_edit_LINENO
  fi
  ble/builtin/trap/install-hook WINCH readline
  blehook WINCH-+=ble-edit/attach/TRAPWINCH
  ble-edit/adjust-PS1
  ble-edit/adjust-READLINE
  ble-edit/adjust-IGNOREEOF
  [[ $bleopt_internal_exec_type == exec ]] && _ble_edit_IFS=$IFS
}
function ble-edit/attach/.detach {
  ((!_ble_edit_attached)) && return 0
  ble-edit/restore-PS1
  ble-edit/restore-READLINE
  ble-edit/restore-IGNOREEOF
  [[ $bleopt_internal_exec_type == exec ]] && IFS=$_ble_edit_IFS
  _ble_edit_attached=0
}
_ble_textarea_VARNAMES=(
  _ble_textarea_buffer
  _ble_textarea_bufferName
  _ble_textarea_cur
  _ble_textarea_panel
  _ble_textarea_scroll
  _ble_textarea_scroll_new
  _ble_textarea_gendx
  _ble_textarea_gendy
  _ble_textarea_invalidated
  _ble_textarea_version
  _ble_textarea_caret_state
  _ble_textarea_cache
  _ble_textarea_render_defer)
_ble_textarea_local_VARNAMES=()
function ble/textarea#panel::getHeight {
  if [[ $1 == "$_ble_textarea_panel" ]]; then
    local min=$((_ble_prompt_ps1_data[4]+1)) max=$((_ble_textmap_endy+1))
    ((min<max&&min++))
    height=$min:$max
  else
    height=0:${_ble_canvas_panel_height[$1]}
  fi
}
function ble/textarea#panel::onHeightChange {
  [[ $1 == "$_ble_textarea_panel" ]] || return 1
  if [[ ! $ble_textarea_render_flag ]]; then
    ble/textarea#invalidate
  fi
}
function ble/textarea#panel::invalidate {
  if (($1==_ble_textarea_panel)); then
    ble/textarea#invalidate
  fi
}
function ble/textarea#panel::render {
  if (($1==_ble_textarea_panel)); then
    ble/textarea#render
  fi
}
_ble_textarea_buffer=()
_ble_textarea_bufferName=
function ble/textarea#update-text-buffer {
  local iN=${#text}
  local beg end end0
  ble/dirty-range#load --prefix=_ble_edit_dirty_draw_
  ble/dirty-range#clear --prefix=_ble_edit_dirty_draw_
  local HIGHLIGHT_BUFF HIGHLIGHT_UMIN HIGHLIGHT_UMAX
  ble/highlight/layer/update "$text" '' "$beg" "$end" "$end0"
  ble/urange#update "$HIGHLIGHT_UMIN" "$HIGHLIGHT_UMAX"
  if ((${#_ble_textmap_ichg[@]})); then
    local ichg g ret
    builtin eval "_ble_textarea_buffer=(\"\${$HIGHLIGHT_BUFF[@]}\")"
    HIGHLIGHT_BUFF=_ble_textarea_buffer
    for ichg in "${_ble_textmap_ichg[@]}"; do
      ble/highlight/layer/getg "$ichg"
      ble/color/g2sgr "$g"
      _ble_textarea_buffer[ichg]=$ret${_ble_textmap_glyph[ichg]}
    done
  fi
  _ble_textarea_bufferName=$HIGHLIGHT_BUFF
}
function ble/textarea#update-left-char {
  local index=$1
  if [[ $bleopt_internal_suppress_bash_output ]]; then
    lc=32 lg=0
    return 0
  fi
  if ((index==0)); then
    lc=${_ble_prompt_ps1_data[6]}
    lg=${_ble_prompt_ps1_data[7]}
    return 0
  fi
  local cx cy
  ble/textmap#getxy.cur --prefix=c "$index"
  local lcs ret
  if ((cx==0)); then
    if ((index==iN)); then
      ret=32
    else
      lcs=${_ble_textmap_glyph[index]}
      ble/util/s2c "$lcs"
    fi
    local g; ble/highlight/layer/getg "$index"; lg=$g
    ((lc=ret==10?32:ret))
  else
    lcs=${_ble_textmap_glyph[index-1]}
    ble/util/s2c "${lcs:${#lcs}-1}"
    local g; ble/highlight/layer/getg $((index-1)); lg=$g
    ((lc=ret))
  fi
}
function ble/textarea#slice-text-buffer {
  ble/textmap#assert-up-to-date
  local iN=$_ble_textmap_length
  local i1=${1:-0} i2=${2:-$iN}
  ((i1<0&&(i1+=iN,i1<0&&(i1=0)),
    i2<0&&(i2+=iN)))
  if ((i1<i2&&i1<iN)); then
    local g
    ble/highlight/layer/getg "$i1"
    ble/color/g2sgr "$g"
    IFS= builtin eval "ret=\"\$ret\${$_ble_textarea_bufferName[*]:i1:i2-i1}\""
    if [[ $_ble_textarea_bufferName == _ble_textarea_buffer ]]; then
      local out= rex_nl='^(\[[ -?]*[@-~]|[ -/]+[@-~]|[])*'$_ble_term_nl
      while [[ $ret == *"$_ble_term_cr"* ]]; do
        out=$out${ret%%"$_ble_term_cr"*}
        ret=${ret#*"$_ble_term_cr"}
        if [[ $ret =~ $rex_nl ]]; then
          out=$out$_ble_term_nl
        elif [[ ! $ret ]]; then
          if ((i2==iN)); then
            out=$out' '$_ble_term_cr${_ble_term_ech//'%d'/1}
          else
            out=$out$_ble_term_nl
          fi
        fi
      done
      ret=$out$ret
    fi
  else
    ret=
  fi
}
_ble_textarea_cur=(0 0 32 0)
_ble_textarea_panel=0
_ble_textarea_scroll=
_ble_textarea_scroll_new=
_ble_textarea_gendx=0
_ble_textarea_gendy=0
_ble_textarea_invalidated=1
function ble/textarea#invalidate {
  if [[ $1 == str || $1 == partial ]]; then
    ((_ble_textarea_version++))
  else
    _ble_textarea_invalidated=1
  fi
  return 0
}
function ble/textarea#render/.erase-forward-line.draw {
  local eraser=$_ble_term_sgr0$_ble_term_el
  if [[ :$render_opts: == *:relative:* ]]; then
    local width=$((cols-x))
    if ((width==0)); then
      eraser=
    elif [[ $_ble_term_ech ]]; then
      eraser=$_ble_term_sgr0${_ble_term_ech//'%d'/$width}
    else
      ble/string#reserve-prototype "$width"
      eraser=$_ble_term_sgr0${_ble_string_prototype::width}${_ble_term_cub//'%d'/$width}
    fi
  fi
  ble/canvas/put.draw "$eraser"
}
function ble/textarea#render/.determine-scroll {
  local nline=$((endy+1))
  if ((height!=nline)); then
    ble/canvas/panel/reallocate-height.draw
    height=${_ble_canvas_panel_height[_ble_textarea_panel]}
  fi
  if ((height<nline)); then
    ((scroll<=nline-height)) || ((scroll=nline-height))
    local _height=$((height-begy)) _nline=$((nline-begy)) _cy=$((cy-begy))
    local margin=$((_height>=6&&_nline>_height+2?2:1))
    local smin smax
    ((smin=_cy-_height+margin,
      smin>nline-height&&(smin=nline-height),
      smax=_cy-margin,
      smax<0&&(smax=0)))
    if ((scroll>smax)); then
      scroll=$smax
    elif ((scroll<smin)); then
      scroll=$smin
    fi
    local wmin=0 wmax index
    if ((scroll)); then
      ble/textmap#get-index-at 0 $((scroll+begy+1)); wmin=$index
    fi
    ble/textmap#get-index-at "$cols" $((scroll+height-1)); wmax=$index
    ((umin<umax)) &&
      ((umin<wmin&&(umin=wmin),
        umax>wmax&&(umax=wmax)))
  else
    scroll=
    if ! ble/util/assert '((height==nline))'; then
      ble/canvas/panel#set-height.draw "$_ble_textarea_panel" "$nline"
      height=$nline
    fi
  fi
}
function ble/textarea#render/.perform-scroll {
  local new_scroll=$1
  if ((new_scroll!=_ble_textarea_scroll)); then
    local scry=$((begy+1))
    local scrh=$((height-scry))
    local fmin fmax index
    if ((_ble_textarea_scroll>new_scroll)); then
      local shift=$((_ble_textarea_scroll-new_scroll))
      local draw_shift=$((shift<scrh?shift:scrh))
      ble/canvas/panel#goto.draw "$_ble_textarea_panel" 0 $((height-draw_shift))
      ble/canvas/put-dl.draw "$draw_shift" panel
      ble/canvas/panel#goto.draw "$_ble_textarea_panel" 0 "$scry"
      ble/canvas/put-il.draw "$draw_shift" panel
      if ((new_scroll==0)); then
        fmin=0
      else
        ble/textmap#get-index-at 0 $((scry+new_scroll)); fmin=$index
      fi
      ble/textmap#get-index-at "$cols" $((scry+new_scroll+draw_shift-1)); fmax=$index
    else
      local shift=$((new_scroll-_ble_textarea_scroll))
      local draw_shift=$((shift<scrh?shift:scrh))
      ble/canvas/panel#goto.draw "$_ble_textarea_panel" 0 "$scry"
      ble/canvas/put-dl.draw "$draw_shift" panel
      ble/canvas/panel#goto.draw "$_ble_textarea_panel" 0 $((height-draw_shift))
      ble/canvas/put-il.draw "$draw_shift" panel
      ble/textmap#get-index-at 0 $((new_scroll+height-draw_shift)); fmin=$index
      ble/textmap#get-index-at "$cols" $((new_scroll+height-1)); fmax=$index
    fi
    if ((fmin<fmax)); then
      local fmaxx fmaxy fminx fminy
      ble/textmap#getxy.out --prefix=fmin "$fmin"
      ble/textmap#getxy.out --prefix=fmax "$fmax"
      ble/canvas/panel#goto.draw "$_ble_textarea_panel" "$fminx" $((fminy-new_scroll))
      ((new_scroll==0)) &&
        x=$fminx ble/textarea#render/.erase-forward-line.draw # ... を消す
      local ret; ble/textarea#slice-text-buffer "$fmin" "$fmax"
      ble/canvas/put.draw "$ret"
      ((_ble_canvas_x=fmaxx,
        _ble_canvas_y+=fmaxy-fminy))
      ((umin<umax)) &&
        ((fmin<=umin&&umin<fmax&&(umin=fmax),
          fmin<umax&&umax<=fmax&&(umax=fmin)))
    fi
    _ble_textarea_scroll=$new_scroll
    ble/textarea#render/.show-scroll-at-first-line
  fi
}
function ble/textarea#render/.show-scroll-at-first-line {
  if ((_ble_textarea_scroll!=0)); then
    ble/canvas/panel#goto.draw "$_ble_textarea_panel" "$begx" "$begy"
    local scroll_status="(line $((_ble_textarea_scroll+2))) ..."
    scroll_status=${scroll_status::cols-1-begx}
    x=$begx ble/textarea#render/.erase-forward-line.draw
    ble/canvas/put.draw "$eraser$_ble_term_bold$scroll_status$_ble_term_sgr0"
    ((_ble_canvas_x+=${#scroll_status}))
  fi
}
function ble/textarea#render/.erase-rprompt {
  [[ $_ble_prompt_rps1_shown ]] || return 0
  _ble_prompt_rps1_shown=
  local rps1_height=${_ble_prompt_rps1_gbox[3]}
  local -a DRAW_BUFF=()
  local y=0
  for ((y=0;y<rps1_height;y++)); do
    ble/canvas/panel#goto.draw "$_ble_textarea_panel" $((cols+1)) "$y" sgr0
    ble/canvas/put.draw "$_ble_term_el"
  done
  ble/canvas/bflush.draw
}
function ble/textarea#render/.cleanup-trailing-spaces-after-newline {
  local -a DRAW_BUFF=()
  local -a buffer; ble/string#split-lines buffer "$text"
  local line index=0 pos
  for line in "${buffer[@]}"; do
    ((index+=${#line}))
    ble/string#split-words pos "${_ble_textmap_pos[index]}"
    ble/canvas/panel#goto.draw "$_ble_textarea_panel" "${pos[0]}" "${pos[1]}" sgr0
    ble/canvas/put.draw "$_ble_term_el"
    ((index++))
  done
  ble/canvas/bflush.draw
  _ble_prompt_rps1_shown=
}
function ble/textarea#render/.show-control-string {
  local ref_dirty=${1}_dirty ref_output=${1}_data[10] force=$2
  [[ $force || ${!ref_dirty} ]] || return 0
  ble/canvas/put.draw "${!ref_output}"
  builtin eval -- "$ref_dirty="
  return 0
}
function ble/textarea#render/.show-prompt {
  [[ $1 || $_ble_prompt_ps1_dirty ]] || return 0
  local esc=${_ble_prompt_ps1_data[8]}
  local prox=${_ble_prompt_ps1_data[3]}
  local proy=${_ble_prompt_ps1_data[4]}
  ble/canvas/panel#goto.draw "$_ble_textarea_panel"
  ble/canvas/panel#put.draw "$_ble_textarea_panel" "$esc" "$prox" "$proy"
  _ble_prompt_ps1_dirty=
}
function ble/textarea#render/.show-rprompt {
  [[ $1 || $_ble_prompt_rps1_dirty ]] || return 0
  local rps1out=${_ble_prompt_rps1_data[8]}
  local rps1x=$((_ble_prompt_rps1_data[3]+COLUMNS-_ble_prompt_rps1_gbox[2]))
  local rps1y=${_ble_prompt_rps1_data[4]}
  ble/canvas/panel#goto.draw "$_ble_textarea_panel" 0 0
  ble/canvas/panel#put.draw "$_ble_textarea_panel" "$rps1out" "$rps1x" "$rps1y"
  _ble_prompt_rps1_dirty=
  _ble_prompt_rps1_shown=1
}
function ble/textarea#focus {
  local -a DRAW_BUFF=()
  ble/canvas/panel#goto.draw "$_ble_textarea_panel" "${_ble_textarea_cur[0]}" "${_ble_textarea_cur[1]}"
  ble/canvas/bflush.draw
}
_ble_textarea_caret_state=::
_ble_textarea_version=0
function ble/textarea#render {
  local opts=$1
  local ble_textarea_render_flag=1 # ble/textarea#panel::onHeightChange から参照する
  local caret_state=$_ble_textarea_version:$_ble_edit_ind:$_ble_edit_mark:$_ble_edit_mark_active:$_ble_edit_line_disabled:$_ble_edit_overwrite_mode
  local dirty=
  if ble/prompt/update "check-dirty:$opts"; then
    dirty=1
  elif ((_ble_edit_dirty_draw_beg>=0)); then
    dirty=1
  elif [[ $_ble_textarea_invalidated ]]; then
    dirty=1
  elif [[ $_ble_textarea_caret_state != "$caret_state" ]]; then
    dirty=1
  elif [[ $_ble_textarea_scroll != "$_ble_textarea_scroll_new" ]]; then
    dirty=1
  elif [[ :$opts: == *:leave:* || :$opts: == *:update:* ]]; then
    dirty=1
  fi
  if [[ ! $dirty ]]; then
    ble/textarea#focus
    return 0
  fi
  local cols=${COLUMNS-80}
  local subprompt_enabled=
  ((_ble_textarea_panel==0)) && subprompt_enabled=1
  local rps1_enabled=$_ble_prompt_rps1_enabled
  local rps1_width=${_ble_prompt_rps1_data[11]}
  if [[ $rps1_enabled ]]; then
    ((cols-=rps1_width+1,_ble_term_xenl||cols--))
    if [[ $rps1_enabled == erase ]]; then
      ble/textarea#render/.erase-rprompt
      rps1_enabled=
    fi
  fi
  local text=$_ble_edit_str index=$_ble_edit_ind
  local iN=${#text}
  ((index<0?(index=0):(index>iN&&(index=iN))))
  local umin=-1 umax=-1
  local x=${_ble_prompt_ps1_data[3]}
  local y=${_ble_prompt_ps1_data[4]}
  local render_opts=
  [[ $rps1_enabled ]] && render_opts=relative
  COLUMNS=$cols ble/textmap#update "$text" "$render_opts" # [ref] x y
  ble/urange#update "$_ble_textmap_umin" "$_ble_textmap_umax" # [ref] umin umax
  ble/urange#clear --prefix=_ble_textmap_
  local DMIN=$_ble_edit_dirty_draw_beg
  ble-edit/content/update-syntax
  ble/textarea#update-text-buffer # [in] text index [ref] lc lg;
  local lc=32 lg=0
  [[ $bleopt_internal_suppress_bash_output ]] ||
    ble/textarea#update-left-char "$index"
  local -a DRAW_BUFF=()
  local begx=$_ble_textmap_begx begy=$_ble_textmap_begy
  local endx=$_ble_textmap_endx endy=$_ble_textmap_endy
  local cx cy
  ble/textmap#getxy.cur --prefix=c "$index" # → cx cy
  local cols=$_ble_textmap_cols
  local height=${_ble_canvas_panel_height[_ble_textarea_panel]}
  local scroll=${_ble_textarea_scroll_new:-$_ble_textarea_scroll}
  ble/textarea#render/.determine-scroll # update: height scroll umin umax
  local gend gendx gendy
  if [[ $scroll ]]; then
    ble/textmap#get-index-at "$cols" $((height+scroll-1)); gend=$index
    ble/textmap#getxy.out --prefix=gend "$gend"
    ((gendy-=scroll))
  else
    gend=$iN gendx=$endx gendy=$endy
  fi
  _ble_textarea_gendx=$gendx _ble_textarea_gendy=$gendy
  local ret esc_line= esc_line_set=
  if [[ ! $_ble_textarea_invalidated ]]; then
    [[ ! $rps1_enabled && $_ble_prompt_rps1_shown || $rps1_enabled && $_ble_prompt_rps1_dirty ]] &&
      ble/textarea#render/.cleanup-trailing-spaces-after-newline
    ble/textarea#render/.perform-scroll "$scroll" # update: umin umax
    _ble_textarea_scroll_new=$_ble_textarea_scroll
    [[ $rps1_enabled ]] && ble/textarea#render/.show-rprompt
    ble/textarea#render/.show-prompt
    if [[ $subprompt_enabled ]]; then
      ble/textarea#render/.show-control-string _ble_prompt_xterm_title
      ble/textarea#render/.show-control-string _ble_prompt_screen_title
      ble/textarea#render/.show-control-string _ble_prompt_term_status
    fi
    if ((umin<umax)); then
      local uminx uminy umaxx umaxy
      ble/textmap#getxy.out --prefix=umin "$umin"
      ble/textmap#getxy.out --prefix=umax "$umax"
      ble/canvas/panel#goto.draw "$_ble_textarea_panel" "$uminx" $((uminy-_ble_textarea_scroll))
      ble/textarea#slice-text-buffer "$umin" "$umax"
      ble/canvas/panel#put.draw "$_ble_textarea_panel" "$ret" "$umaxx" $((umaxy-_ble_textarea_scroll))
    fi
    if ((DMIN>=0)); then
      local endY=$((endy-_ble_textarea_scroll))
      if ((endY<height)); then
        if [[ :$render_opts: == *:relative:* ]]; then
          ble/canvas/panel#goto.draw "$_ble_textarea_panel" "$endx" "$endY"
          x=$endx ble/textarea#render/.erase-forward-line.draw
          ble/canvas/panel#clear-after.draw "$_ble_textarea_panel" 0 $((endY+1))
        else
          ble/canvas/panel#clear-after.draw "$_ble_textarea_panel" "$endx" "$endY"
        fi
      fi
    fi
  else
    ble/canvas/panel#clear.draw "$_ble_textarea_panel"
    _ble_prompt_rps1_shown=
    [[ $rps1_enabled ]] && ble/textarea#render/.show-rprompt force
    ble/textarea#render/.show-prompt force
    if [[ $subprompt_enabled ]]; then
      ble/textarea#render/.show-control-string _ble_prompt_xterm_title  force
      ble/textarea#render/.show-control-string _ble_prompt_screen_title force
      ble/textarea#render/.show-control-string _ble_prompt_term_status  force
    fi
    _ble_textarea_scroll=$scroll
    _ble_textarea_scroll_new=$_ble_textarea_scroll
    if [[ ! $_ble_textarea_scroll ]]; then
      ble/textarea#slice-text-buffer # → ret
      esc_line=$ret esc_line_set=1
      ble/canvas/panel#put.draw "$_ble_textarea_panel" "$ret" "$_ble_textarea_gendx" "$_ble_textarea_gendy"
    else
      ble/textarea#render/.show-scroll-at-first-line
      local gbeg=0
      if ((_ble_textarea_scroll)); then
        ble/textmap#get-index-at 0 $((_ble_textarea_scroll+begy+1)); gbeg=$index
      fi
      local gbegx gbegy
      ble/textmap#getxy.out --prefix=gbeg "$gbeg"
      ((gbegy-=_ble_textarea_scroll))
      ble/canvas/panel#goto.draw "$_ble_textarea_panel" "$gbegx" "$gbegy"
      ((_ble_textarea_scroll==0)) &&
        x=$gbegx ble/textarea#render/.erase-forward-line.draw # ... を消す
      ble/textarea#slice-text-buffer "$gbeg" "$gend"
      ble/canvas/panel#put.draw "$_ble_textarea_panel" "$ret" "$_ble_textarea_gendx" "$_ble_textarea_gendy"
    fi
  fi
  local gcx=$cx gcy=$((cy-_ble_textarea_scroll))
  ble/canvas/panel#goto.draw "$_ble_textarea_panel" "$gcx" "$gcy"
  ble/canvas/bflush.draw
  _ble_textarea_cur=("$gcx" "$gcy" "$lc" "$lg")
  _ble_textarea_invalidated= _ble_textarea_caret_state=$caret_state
  if [[ ! $bleopt_internal_suppress_bash_output ]]; then
    if [[ ! $esc_line_set ]]; then
      if [[ ! $_ble_textarea_scroll ]]; then
        ble/textarea#slice-text-buffer
        esc_line=$ret
      else
        local _ble_canvas_x=$begx _ble_canvas_y=$begy
        DRAW_BUFF=()
        ble/textarea#render/.show-scroll-at-first-line
        local gbeg=0
        if ((_ble_textarea_scroll)); then
          ble/textmap#get-index-at 0 $((_ble_textarea_scroll+begy+1)); gbeg=$index
        fi
        local gbegx gbegy
        ble/textmap#getxy.out --prefix=gbeg "$gbeg"
        ((gbegy-=_ble_textarea_scroll))
        ble/canvas/panel#goto.draw "$_ble_textarea_panel" "$gbegx" "$gbegy"
        ((_ble_textarea_scroll==0)) &&
          x=$gbegx ble/textarea#render/.erase-forward-line.draw # ... を消す
        ble/textarea#slice-text-buffer "$gbeg" "$gend"
        ble/canvas/put.draw "$ret"
        ble/canvas/sflush.draw -v esc_line
      fi
    fi
    local esc=${_ble_prompt_ps1_data[8]}
    esc=${_ble_prompt_xterm_title_data[10]}$esc
    esc=${_ble_prompt_screen_title_data[10]}$esc
    esc=${_ble_prompt_term_status_data[10]}$esc
    _ble_textarea_cache=(
      "$esc$esc_line"
      "${_ble_textarea_cur[@]}"
      "$_ble_textarea_gendx" "$_ble_textarea_gendy")
  fi
}
function ble/textarea#redraw {
  ble/textarea#invalidate
  ble/textarea#render
}
_ble_textarea_cache=()
function ble/textarea#redraw-cache {
  if [[ ! $_ble_textarea_scroll && ${_ble_textarea_cache[0]+set} ]]; then
    local -a d; d=("${_ble_textarea_cache[@]}")
    local -a DRAW_BUFF=()
    ble/canvas/panel#clear.draw "$_ble_textarea_panel"
    ble/canvas/panel#goto.draw "$_ble_textarea_panel"
    ble/canvas/put.draw "${d[0]}"
    ble/canvas/panel#report-cursor-position "$_ble_textarea_panel" "${d[5]}" "${d[6]}"
    _ble_textarea_gendx=${d[5]}
    _ble_textarea_gendy=${d[6]}
    _ble_textarea_cur=("${d[@]:1:4}")
    ble/canvas/panel#goto.draw "$_ble_textarea_panel" "${_ble_textarea_cur[0]}" "${_ble_textarea_cur[1]}"
    ble/canvas/bflush.draw
  else
    ble/textarea#redraw
  fi
}
function ble/textarea#adjust-for-bash-bind {
  ble-edit/adjust-PS1
  if [[ $bleopt_internal_suppress_bash_output ]]; then
    READLINE_LINE=$'\n' READLINE_POINT=0 READLINE_MARK=0
  else
    local -a DRAW_BUFF=()
    local ret lc=${_ble_textarea_cur[2]} lg=${_ble_textarea_cur[3]}
    ble/util/c2s "$lc"
    READLINE_LINE=$ret READLINE_MARK=0
    if ((_ble_textarea_cur[0]==0)); then
      READLINE_POINT=0
    else
      ble/util/c2w "$lc"
      ((ret>0)) && ble/canvas/put-cub.draw "$ret"
      ble/util/c2bc "$lc"
      READLINE_POINT=$ret
    fi
    ble/color/g2sgr "$lg"
    ble/canvas/put.draw "$ret"
  fi
}
function ble/textarea#save-state {
  local prefix=$1
  local -a vars=()
  ble/array#push vars _ble_edit_PS1 _ble_prompt_ps1_data
  ble/array#push vars "${_ble_edit_VARNAMES[@]}"
  ble/array#push vars "${_ble_textmap_VARNAMES[@]}"
  ble/array#push vars _ble_highlight_layer__list
  local layer names
  for layer in "${_ble_highlight_layer__list[@]}"; do
    builtin eval "ble/array#push vars \"\${!_ble_highlight_layer_$layer@}\""
  done
  ble/array#push vars "${_ble_textarea_VARNAMES[@]}"
  ble/array#push vars "${_ble_syntax_VARNAMES[@]}"
  ble/array#push vars "${_ble_textarea_local_VARNAMES[@]}"
  builtin eval -- "${prefix}_VARNAMES=(\"\${vars[@]}\")"
  ble/util/save-vars "$prefix" "${vars[@]}"
}
function ble/textarea#restore-state {
  local prefix=$1
  if builtin eval "[[ \$prefix && \${${prefix}_VARNAMES+set} ]]"; then
    builtin eval "ble/util/restore-vars $prefix \"\${${prefix}_VARNAMES[@]}\""
  else
    ble/util/print "ble/textarea#restore-state: unknown prefix '$prefix'." >&2
    return 1
  fi
}
function ble/textarea#clear-state {
  local prefix=$1
  if [[ $prefix ]]; then
    local vars=${prefix}_VARNAMES
    builtin eval "builtin unset -v \"\${$vars[@]/#/$prefix}\" $vars"
  else
    ble/util/print "ble/textarea#restore-state: unknown prefix '$prefix'." >&2
    return 1
  fi
}
_ble_textarea_render_defer=
function ble/textarea#render-defer.idle {
  ble/util/idle.wait-user-input
  [[ $_ble_textarea_render_defer ]] || return 0
  local ble_textarea_render_defer_running=1
  ble/util/buffer.flush >&2
  _ble_textarea_render_defer=
  blehook/invoke textarea_render_defer
  ble/textarea#render update
  [[ $_ble_textarea_render_defer ]] &&
    ble/util/idle.continue
  return 0
}
ble/function#try ble/util/idle.push-background ble/textarea#render-defer.idle
function ble/widget/.update-textmap {
  local cols=${COLUMNS:-80} render_opts=
  if [[ $_ble_prompt_rps1_enabled ]]; then
    local rps1_width=${_ble_prompt_rps1_data[11]}
    render_opts=relative
    ((cols-=rps1_width+1,_ble_term_xenl||cols--))
  fi
  local x=$_ble_textmap_begx y=$_ble_textmap_begy
  COLUMNS=$cols ble/textmap#update "$_ble_edit_str" "$render_opts"
}
function ble/widget/do-lowercase-version {
  local n=${#KEYS[@]}; ((n&&n--))
  local flag=$((KEYS[n]&_ble_decode_MaskFlag))
  local char=$((KEYS[n]&_ble_decode_MaskChar))
  if ((65<=char&&char<=90)); then
    ble/decode/widget/skip-lastwidget
    ble/decode/widget/redispatch-by-keys $((flag|char+32)) "${KEYS[@]:1}"
  else
    return 125
  fi
}
function ble/widget/redraw-line {
  ble-edit/content/clear-arg
  ble/textarea#invalidate
}
function ble/widget/clear-screen {
  ble-edit/content/clear-arg
  ble/edit/enter-command-layout # #D1800 pair=leave-command-layout
  ble/textarea#invalidate
  local -a DRAW_BUFF=()
  ble/canvas/panel/goto-top-dock.draw
  ble/canvas/bflush.draw
  ble/util/buffer "$_ble_term_clear"
  _ble_canvas_x=0 _ble_canvas_y=0
  ble/term/visible-bell/cancel-erasure
  ble/edit/leave-command-layout # #D1800 pair=enter-command-layout
}
function ble/widget/clear-display {
  ble/util/buffer $'\e[3J'
  ble/widget/clear-screen
}
function ble/edit/display-version/git-rev-parse {
  ret=
  local git_base opts=$2
  case $1 in
  (.)       git_base=$PWD ;;
  (./*)     git_base=$PWD/${1#./} ;;
  (..|../*) git_base=$PWD/$1 ;;
  (*)       git_base=$1 ;;
  esac
  "${_ble_util_set_declare[@]//NAME/visited}"
  until [[ -s $git_base/HEAD || -s $git_base/.git/HEAD ]]; do
    ble/set#contains visited "$git_base" && return 1
    ble/set#add visited "$git_base"
    if [[ -f $git_base/.git ]]; then
      local content
      ble/util/mapfile content < "$git_base/.git"
      if ble/string#match "$content" '^gitdir: (.*)'; then
        git_base=$git_base/${BASH_REMATCH[1]}
        continue
      fi
    fi
    if [[ :$opts: == *:parent:* && $git_base == */* ]]; then
      git_base=${git_base%/*}
      continue
    fi
    break
  done
  [[ -s $git_base/HEAD ]] || git_base=$git_base/.git
  local head=$git_base/HEAD
  if [[ -f $head ]]; then
    local content
    ble/util/mapfile content < "$head"
    if ble/string#match "$content" '^ref: (.*)$'; then
      head=$git_base/${BASH_REMATCH[1]}
      ble/util/mapfile content < "$head"
    fi
    if ble/string#match "$content" '^[a-f0-9]+$'; then
      content=${content::8}
    fi
    ret=$content
    [[ $ret ]]
    return $?
  fi
  return 1
}
function ble/edit/display-version/git-hash-object {
  local file=$1 size
  if ! ble/util/assign size 'ble/bin/wc -c "$file" 2>/dev/null'; then
    ret='error'
    return 1
  fi
  ble/string#split-words size "$size"
  if ble/bin#has git; then
    ble/util/assign ret 'git hash-object "$file"'
    ret="hash:$ret, $size bytes"
  elif ble/bin#has sha1sum; then
    local _ble_local_tmpfile; ble/util/assign/.mktmp
    { printf 'blob %d\0' "$size"; ble/bin/cat "$file"; } >| "$_ble_local_tmpfile"
    blob_data=$_ble_local_tmpfile ble/util/assign ret 'sha1sum "$blob_data"'
    ble/util/assign/.rmtmp
    ble/string#split-words ret "$ret"
    ret="sha1:$ret, $size bytes"
  elif ble/bin#has cksum; then
    ble/util/assign ret 'cksum "$file"'
    ble/string#split-words ret "$ret"
    ble/util/sprintf ret 'cksum:%08x, %d bytes' "$ret" "$size"
  else
    ret=size:$size
  fi
}
function ble/edit/display-version/add-line {
  lines[iline++]=$1
}
function ble/edit/display-version/check:bash-completion {
  [[ ${BASH_COMPLETION_VERSINFO[0]-} ]] || return 1
  local patch=${BASH_COMPLETION_VERSINFO[2]-}
  local version=${BASH_COMPLETION_VERSINFO[0]}.${BASH_COMPLETION_VERSINFO[1]:-y}${patch:+.$patch}
  local source lineno ret
  if ble/function#get-source-and-lineno _init_completion; then
    if ble/edit/display-version/git-rev-parse "${source%/*}"; then
      version=$sgrV$version+$ret$sgr0
    elif ble/edit/display-version/git-hash-object "$source"; then
      version="$sgrV$version$sgr0 ($ret)"
    fi
  fi
  ble/edit/display-version/add-line "${sgrF}bash-completion$sgr0, version $version$label_noarch"
}
function ble/edit/display-version/check:bash-preexec {
  local source lineno ret
  ble/function#get-source-and-lineno __bp_preexec_invoke_exec || return 1
  local version="${source/#$HOME/~}$label_noarch"
  if ble/edit/display-version/git-rev-parse "${source%/*}"; then
    version="version $sgrV+$ret$sgr0$label_noarch"
  elif ble/edit/display-version/git-hash-object "$source"; then
    version="($ret)$label_noarch"
  fi
  local file=${source##*/}
  if [[ $file == bash-preexec.sh || $file == bash-preexec.bash ]]; then
    file=
  else
    file=" ($file)"
  fi
  local integ=
  ble/util/import/is-loaded contrib/bash-preexec && integ=$label_integration
  ble/edit/display-version/add-line "${sgrF}bash-preexec$sgr0$file, $version$integ"
}
function ble/edit/display-version/check:fzf {
  local source lineno ret
  if ble/function#get-source-and-lineno __fzf_select__; then
    local version="${source/#$HOME/~}$label_noarch"
    if ble/edit/display-version/git-rev-parse "${source%/*}" parent; then
      version="version $sgrV+$ret$sgr0$label_noarch"
    elif ble/edit/display-version/git-hash-object "$source"; then
      version="($ret)$label_noarch"
    fi
    local integ=
    ble/util/import/is-loaded contrib/fzf-key-bindings && integ=$label_integration
    ble/edit/display-version/add-line "${sgrC}fzf$sgr0 ${sgrF}key-bindings$sgr0, $version$integ"
  fi
  if ble/function#get-source-and-lineno __fzf_orig_completion; then
    local version="${source/#$HOME/~}$label_noarch"
    if ble/edit/display-version/git-rev-parse "${source%/*}" parent; then
      version="version $sgrV+$ret$sgr0$label_noarch"
    elif ble/edit/display-version/git-hash-object "$source"; then
      version="($ret)$label_noarch"
    fi
    local integ=
    ble/util/import/is-loaded contrib/fzf-completion && integ=$label_integration
    ble/edit/display-version/add-line "${sgrC}fzf$sgr0 ${sgrF}completion$sgr0, $version$integ"
  fi
}
function ble/edit/display-version/check:starship {
  local source lineno
  ble/function#get-source-and-lineno starship_precmd || return 1
  local sed_script='s/^[[:space:]]*PS1="\$(\(.\{1,\}\) prompt .*)";\{0,1\}$/\1/p'
  ble/util/assign-array starship 'declare -f starship_precmd | ble/bin/sed -n "$sed_script"'
  if ! ble/bin#has "$starship"; then
    { builtin eval -- "starship=$starship" && ble/bin#has "$starship"; } ||
      { starship=starship; ble/bin#has "$starship"; } || return 1
  fi
  local awk_script='
    sub(/^starship /, "") { version = $0; next; }
    sub(/^branch:/, "") { gsub(/[[:space:]]/, "_"); if ($0 != "") version = version "-" $0; next; }
    sub(/^commit_hash:/, "") { gsub(/[[:space:]]/, "_"); if ($0 != "") version = version "+" $0; next; }
    sub(/^build_time:/, "") { build_time = $0; }
    sub(/^build_env:/, "") { build_env = $0; }
    END {
      if (version != "") {
        print version;
        print build_env, build_time
      }
    }
  '
  local version=
  ble/util/assign-array version '"$starship" --version | ble/bin/awk "$awk_script"'
  [[ $version ]] || return 1
  local ret; ble/string#trim "${version[1]}"; local build=$ret
  ble/edit/display-version/add-line "${sgrF}starship${sgr0}, version $sgrV$version$sgr0${build:+ ($build)}"
}
function ble/edit/display-version/check:bash-it {
  [[ ${BASH_IT-} ]] && ble/is-function bash-it || return 1
  local version= ret
  if ble/edit/display-version/git-rev-parse "$BASH_IT"; then
    version="version $sgrV+$ret$sgr0$label_noarch"
  elif ble/edit/display-version/git-hash-object "$BASH_IT/bash_it.sh"; then
    version="($ret)$label_noarch"
  else
    version="(bash-it version)"
  fi
  local modules=
  if ble/is-function _bash-it-component-item-is-enabled; then
    local category subdir suffix
    for category in aliases:alias completion plugins:plugin; do
      local subdir=${category%:*} suffix=${category#*:} list
      list=()
      local file name
      for file in "$BASH_IT/$subdir/available"/*.*.bash; do
        name=${file##*/}
        name=${name%."$suffix"*.bash}
        _bash-it-component-item-is-enabled "$suffix" "$name" && ble/array#push list "$name"
      done
      modules="$modules, $suffix(${list[*]})"
    done
  fi
  ble/edit/display-version/add-line "${sgrF}bash-it$sgr0${theme:+ ($theme)}, $version$modules"
}
function ble/edit/display-version/check:oh-my-bash {
  local source lineno ret version=
  if [[ ${OMB_VERSINFO-set} ]] && ble/function#get-source-and-lineno _omb_module_require; then
    version=${OMB_VERSINFO[0]}.${OMB_VERSINFO[1]}.${OMB_VERSINFO[2]}
    if ble/edit/display-version/git-rev-parse "${source%/*}"; then
      version="version $sgrV$version+$ret$sgr0$label_noarch"
    elif ble/edit/display-version/git-hash-object "$source"; then
      version="version $sgrV$version$sgr0 ($ret)$label_noarch"
    else
      version="version $sgrV$version$sgr0$label_noarch"
    fi
  elif [[ ${OSH_CUSTOM-set} ]] && ble/function#get-source-and-lineno is_plugin; then
    version="${source/#$HOME/~}$label_noarch"
    if ble/edit/display-version/git-rev-parse "${source%/*}" parent; then
      version="version $sgrV+$ret$sgr0$label_noarch"
    elif ble/edit/display-version/git-hash-object "$source"; then
      version="($ret)$label_noarch"
    fi
  fi
  if [[ $version ]]; then
    local theme=${OMB_THEME-${OSH_THEME-}}
    local modules="aliases(${aliases[*]}), completions(${completions[*]}), plugins(${plugins[*]})"
    ble/edit/display-version/add-line "${sgrF}oh-my-bash$sgr0${theme:+ ($theme)}, $version, $modules"
  fi
}
function ble/edit/display-version/check:sbp {
  local source lineno ret
  ble/function#get-source-and-lineno _sbp_set_prompt || return 1
  local version="${source/#$HOME/~}$label_noarch"
  if ble/edit/display-version/git-rev-parse "${source%/*}"; then
    version="version $sgrV+$ret$sgr0$label_noarch"
  elif ble/edit/display-version/git-hash-object "$source"; then
    version="($ret)$label_noarch"
  fi
  local hooks="hooks(${settings_hooks[*]-${SBP_HOOKS[*]}})"
  local left="left(${settings_segments_left[*]-${SBP_SEGMENTS_LEFT[*]}})"
  local right="right(${settings_segments_right[*]-${RBP_SEGMENTS_RIGHT[*]}})"
  local modules="$hooks, $left, $right"
  ble/edit/display-version/add-line "${sgrF}sbp$sgr0, $version, $modules"
}
function ble/edit/display-version/check:gitstatus {
  local source lineno ret
  ble/function#get-source-and-lineno gitstatus_query || return 1
  local version="${source/#$HOME/~}$label_noarch"
  if ble/edit/display-version/git-rev-parse "${source%/*}"; then
    version="version $sgrV+$ret$sgr0$label_noarch"
  elif ble/edit/display-version/git-hash-object "$source"; then
    version="($ret)$label_noarch"
  fi
  ble/edit/display-version/add-line "${sgrF}romkatv/gitstatus$sgr0, $version"
}
function ble/widget/display-shell-version {
  ble-edit/content/clear-arg
  local sgrC= sgrF= sgrV= sgrA= sgr2= sgr3= sgr0=
  if [[ -t 1 ]]; then
    sgr0=$_ble_term_sgr0
    ble/color/face2sgr command_file; sgrC=$ret
    ble/color/face2sgr command_function; sgrF=$ret
    ble/color/face2sgr syntax_expr; sgrV=$ret
    ble/color/face2sgr varname_readonly; sgrA=$ret
    ble/color/face2sgr syntax_varname; sgr2=$ret
    ble/color/face2sgr syntax_quoted; sgr3=$ret
  fi
  local label_noarch=" (${sgrA}noarch$sgr0)"
  local label_integration=" $_ble_term_bold(integration: on)$sgr0"
  local lines="${sgrC}GNU bash$sgr0, version $sgrV$BASH_VERSION$sgr0 ($sgrA$MACHTYPE$sgr0)" iline=1
  lines[iline++]="${sgrF}ble.sh$sgr0, version $sgrV$BLE_VERSION$sgr0$label_noarch"
  ble/edit/display-version/check:bash-completion
  ble/edit/display-version/check:fzf
  ble/edit/display-version/check:bash-preexec
  ble/edit/display-version/check:starship
  ble/edit/display-version/check:bash-it
  ble/edit/display-version/check:oh-my-bash
  ble/edit/display-version/check:sbp
  ble/edit/display-version/check:gitstatus
  local q=\'
  local ret='(unset)'
  [[ ${LANG+set} ]] && ble/string#quote-word "$LANG" quote-empty:sgrq="$sgr3":sgr0="$sgr0"
  local var line="${_ble_term_bold}locale$sgr0: ${sgr2}LANG$sgrV=$sgr0$ret"
  for var in "${!LC_@}"; do
    ble/string#quote-word "${!var}" quote-empty:sgrq="$sgr3":sgr0="$sgr0"
    line="$line $sgr2$var$sgrV=$sgr0$ret"
  done
  lines[iline++]=$line
  ret='(unset)'
  [[ ${TERM+set} ]] && ble/string#quote-word "$TERM" quote-empty:sgrq="$sgr3":sgr0="$sgr0"
  local i line="${_ble_term_bold}terminal$sgr0: ${sgr2}TERM$sgrV=$sgr0$ret"
  line="$line ${sgr2}wcwidth$sgrV=$sgr0$bleopt_char_width_version-$bleopt_char_width_mode${bleopt_emoji_width:+/$bleopt_emoji_version-$bleopt_emoji_width+$bleopt_emoji_opts}"
  for i in "${!_ble_term_DA2R[@]}"; do
    line="$line, $sgrC${_ble_term_TERM[i]-unknown}$sgr0 ($sgrV${_ble_term_DA2R[i]}$sgr0)"
  done
  lines[iline++]=$line
  ble/widget/print "${lines[@]}"
}
function ble/widget/readline-dump-functions {
  ble-edit/content/clear-arg
  local ret
  ble/util/assign ret 'ble/builtin/bind -P'
  ble/widget/print "$ret"
}
function ble/widget/readline-dump-macros {
  ble-edit/content/clear-arg
  local ret
  ble/util/assign ret 'ble/builtin/bind -S'
  ble/widget/print "$ret"
}
function ble/widget/readline-dump-variables {
  ble-edit/content/clear-arg
  local ret
  ble/util/assign ret 'ble/builtin/bind -V'
  ble/widget/print "$ret"
}
function ble/widget/re-read-init-file {
  ble-edit/content/clear-arg
  local inputrc=$INPUTRC
  [[ $inputrc && -e $inputrc ]] || inputrc=~/.inputrc
  [[ -e $inputrc ]] || return 0
  ble/decode/read-inputrc "$inputrc"
  _ble_builtin_bind_keymap=
}
function ble/widget/overwrite-mode {
  ble-edit/content/clear-arg
  if [[ $_ble_edit_overwrite_mode ]]; then
    _ble_edit_overwrite_mode=
  else
    _ble_edit_overwrite_mode=1
  fi
}
function ble/widget/set-mark {
  ble-edit/content/clear-arg
  _ble_edit_mark=$_ble_edit_ind
  _ble_edit_mark_active=1
}
function ble/widget/kill-forward-text {
  ble-edit/content/clear-arg
  ((_ble_edit_ind>=${#_ble_edit_str})) && return 0
  ble-edit/content/push-kill-ring "${_ble_edit_str:_ble_edit_ind}"
  ble-edit/content/replace "$_ble_edit_ind" ${#_ble_edit_str} ''
  ((_ble_edit_mark>_ble_edit_ind&&(_ble_edit_mark=_ble_edit_ind)))
}
function ble/widget/kill-backward-text {
  ble-edit/content/clear-arg
  ((_ble_edit_ind==0)) && return 0
  ble-edit/content/push-kill-ring "${_ble_edit_str::_ble_edit_ind}"
  ble-edit/content/replace 0 "$_ble_edit_ind" ''
  ((_ble_edit_mark=_ble_edit_mark<=_ble_edit_ind?0:_ble_edit_mark-_ble_edit_ind))
  _ble_edit_ind=0
}
function ble/widget/exchange-point-and-mark {
  ble-edit/content/clear-arg
  local m=$_ble_edit_mark p=$_ble_edit_ind
  _ble_edit_ind=$m _ble_edit_mark=$p
}
function ble/widget/@marked {
  if [[ $_ble_edit_mark_active != S ]]; then
    _ble_edit_mark=$_ble_edit_ind
    _ble_edit_mark_active=S
  fi
  ble/decode/widget/dispatch "$@"
}
function ble/widget/@nomarked {
  if [[ $_ble_edit_mark_active == S ]]; then
    _ble_edit_mark_active=
  fi
  ble/decode/widget/dispatch "$@"
}
function ble/widget/.process-range-argument {
  p0=$1 p1=$2 len=${#_ble_edit_str}
  local pt
  ((
    p0>len?(p0=len):p0<0&&(p0=0),
    p1>len?(p1=len):p0<0&&(p1=0),
    p1<p0&&(pt=p1,p1=p0,p0=pt),
    (len=p1-p0)>0
  ))
}
function ble/widget/.delete-range {
  local p0 p1 len
  ble/widget/.process-range-argument "${@:1:2}" || return 1
  if ((len)); then
    ble-edit/content/replace "$p0" "$p1" ''
    ((
      _ble_edit_ind>p1? (_ble_edit_ind-=len):
      _ble_edit_ind>p0&&(_ble_edit_ind=p0),
      _ble_edit_mark>p1? (_ble_edit_mark-=len):
      _ble_edit_mark>p0&&(_ble_edit_mark=p0)
    ))
  fi
  return 0
}
function ble/widget/.kill-range {
  local p0 p1 len
  ble/widget/.process-range-argument "${@:1:2}" || return 1
  ble-edit/content/push-kill-ring "${_ble_edit_str:p0:len}" "$4"
  if ((len)); then
    ble-edit/content/replace "$p0" "$p1" ''
    ((
      _ble_edit_ind>p1? (_ble_edit_ind-=len):
      _ble_edit_ind>p0&&(_ble_edit_ind=p0),
      _ble_edit_mark>p1? (_ble_edit_mark-=len):
      _ble_edit_mark>p0&&(_ble_edit_mark=p0)
    ))
  fi
  return 0
}
function ble/widget/.copy-range {
  local p0 p1 len
  ble/widget/.process-range-argument "${@:1:2}" || return 1
  ble-edit/content/push-kill-ring "${_ble_edit_str:p0:len}" "$4"
}
function ble/widget/.replace-range {
  local p0 p1 len
  ble/widget/.process-range-argument "${@:1:2}"
  local insert; ble-edit/content/replace-limited "$p0" "$p1" "$3"
  local inslen=${#insert} delta
  ((delta=inslen-len)) &&
    ((_ble_edit_ind>p1?(_ble_edit_ind+=delta):
      _ble_edit_ind>=p0&&(_ble_edit_ind=p0+inslen),
      _ble_edit_mark>p1?(_ble_edit_mark+=delta):
      _ble_edit_mark>p0&&(_ble_edit_mark=p0)))
  return 0
}
function ble/widget/delete-region {
  ble-edit/content/clear-arg
  ble/widget/.delete-range "$_ble_edit_mark" "$_ble_edit_ind"
  _ble_edit_mark_active=
}
function ble/widget/kill-region {
  ble-edit/content/clear-arg
  ble/widget/.kill-range "$_ble_edit_mark" "$_ble_edit_ind"
  _ble_edit_mark_active=
}
function ble/widget/copy-region {
  ble-edit/content/clear-arg
  ble/widget/.copy-range "$_ble_edit_mark" "$_ble_edit_ind"
  _ble_edit_mark_active=
}
function ble/widget/delete-region-or {
  if [[ $_ble_edit_mark_active ]]; then
    ble/widget/delete-region
  else
    ble/decode/widget/dispatch "$@"
  fi
}
function ble/widget/kill-region-or {
  if [[ $_ble_edit_mark_active ]]; then
    ble/widget/kill-region
  else
    ble/decode/widget/dispatch "$@"
  fi
}
function ble/widget/copy-region-or {
  if [[ $_ble_edit_mark_active ]]; then
    ble/widget/copy-region
  else
    ble/decode/widget/dispatch "$@"
  fi
}
function ble/widget/yank {
  local arg; ble-edit/content/get-arg 1
  local nkill=${#_ble_edit_kill_ring[@]}
  if ((nkill==0)); then
    ble/widget/.bell 'no strings in kill-ring'
    _ble_edit_yank_index=
    return 1
  fi
  local index=$_ble_edit_kill_index
  local delta=$((arg-1))
  if ((delta)); then
    ((index=(index+delta)%nkill,
      index=(index+nkill)%nkill))
    _ble_edit_kill_index=$index
  fi
  local insert=${_ble_edit_kill_ring[index]}
  _ble_edit_yank_index=$index
  if [[ $insert ]]; then
    ble-edit/content/replace-limited "$_ble_edit_ind" "$_ble_edit_ind" "$insert"
    ((_ble_edit_mark=_ble_edit_ind,
      _ble_edit_ind+=${#insert}))
    _ble_edit_mark_active=
  fi
}
_ble_edit_yank_index=
function ble/edit/yankpop.impl {
  local arg=$1
  local nkill=${#_ble_edit_kill_ring[@]}
  ((_ble_edit_yank_index=(_ble_edit_yank_index+arg)%nkill,
    _ble_edit_yank_index=(_ble_edit_yank_index+nkill)%nkill))
  local insert=${_ble_edit_kill_ring[_ble_edit_yank_index]}
  ble-edit/content/replace-limited "$_ble_edit_mark" "$_ble_edit_ind" "$insert"
  ((_ble_edit_ind=_ble_edit_mark+${#insert}))
}
function ble/widget/yank-pop {
  local opts=$1
  local arg; ble-edit/content/get-arg 1
  if ! [[ $_ble_edit_yank_index && ${LASTWIDGET%%' '*} == ble/widget/yank ]]; then
    ble/widget/.bell
    return 1
  fi
  [[ :$opts: == *:backward:* ]] && ((arg=-arg))
  ble/edit/yankpop.impl "$arg"
  _ble_edit_mark_active=insert
  ble/decode/keymap/push yankpop
}
function ble/widget/yankpop/next {
  local arg; ble-edit/content/get-arg 1
  ble/edit/yankpop.impl "$arg"
}
function ble/widget/yankpop/prev {
  local arg; ble-edit/content/get-arg 1
  ble/edit/yankpop.impl $((-arg))
}
function ble/widget/yankpop/exit {
  ble/decode/keymap/pop
  _ble_edit_mark_active=
}
function ble/widget/yankpop/cancel {
  ble-edit/content/replace "$_ble_edit_mark" "$_ble_edit_ind" ''
  _ble_edit_ind=$_ble_edit_mark
  ble/widget/yankpop/exit
}
function ble/widget/yankpop/exit-default {
  ble/widget/yankpop/exit
  ble/decode/widget/skip-lastwidget
  ble/decode/widget/redispatch-by-keys "${KEYS[@]}"
}
function ble-decode/keymap:yankpop/define {
  ble-decode/keymap:safe/bind-arg yankpop/exit-default
  ble-bind -f __default__ 'yankpop/exit-default'
  ble-bind -f __line_limit__ nop
  ble-bind -f 'C-g'       'yankpop/cancel'
  ble-bind -f 'C-x C-g'   'yankpop/cancel'
  ble-bind -f 'C-M-g'     'yankpop/cancel'
  ble-bind -f 'M-y'       'yankpop/next'
  ble-bind -f 'M-S-y'     'yankpop/prev'
  ble-bind -f 'M-Y'       'yankpop/prev'
}
function ble/widget/.bell {
  [[ $bleopt_edit_vbell ]] && ble/term/visible-bell "$1"
  [[ $bleopt_edit_abell ]] && ble/term/audible-bell
  return 0
}
function ble/widget/bell {
  ble-edit/content/clear-arg
  _ble_edit_mark_active=
  _ble_edit_arg=
  blehook/invoke widget_bell
  ble/widget/.bell "$1"
}
function ble/widget/nop { :; }
function ble/widget/insert-string {
  local IFS=$_ble_term_IFS
  local content="$*"
  local arg; ble-edit/content/get-arg 1
  if ((arg<0)); then
    ble/widget/.bell "negative repetition number $arg"
    return 1
  elif ((arg==0)); then
    return 0
  elif ((arg>1)); then
    local ret; ble/string#repeat "$content" "$arg"; content=$ret
  fi
  ble/widget/.insert-string "$content"
}
function ble/widget/.insert-string {
  local insert=$1
  [[ $insert ]] || return 1
  ble-edit/content/replace-limited "$_ble_edit_ind" "$_ble_edit_ind" "$insert"
  local dx=${#insert}
  ((
    _ble_edit_mark>_ble_edit_ind&&(_ble_edit_mark+=dx),
    _ble_edit_ind+=dx
  ))
  _ble_edit_mark_active=
}
if [[ -c /dev/clipboard ]]; then
  function ble/widget/paste-from-clipboard {
    local clipboard
    if ! ble/util/readfile clipboard /dev/clipboard; then
      ble/widget/.bell
      return 1
    fi
    ble/widget/insert-string "$clipboard"
    return 0
  }
fi
_ble_edit_lastarg_index=
_ble_edit_lastarg_delta=
_ble_edit_lastarg_nth=
function ble/widget/insert-arg.impl {
  local beg=$1 end=$2 index=$3 delta=$4 nth=$5
  ((delta)) || delta=1
  ble/history/initialize
  local hit= lastarg=
  local decl=$(
    local original=${_ble_edit_str:beg:end-beg}
    local count=; ((delta>0)) && count=_ble_history_COUNT
    while :; do
      if ((delta>0)); then
        ((index+1>=count)) && break
        ((index+=delta,delta=1))
        ((index>=count&&(index=count-1)))
      else
        ((index-1<0)) && break
        ((index+=delta,delta=-1))
        ((index<0&&(index=0)))
      fi
      local entry; ble/history/get-edited-entry "$index"
      builtin history -s -- "$entry"
      local hist_expanded
      if ble-edit/hist_expanded.update '!!:'"$nth" &&
          [[ $hist_expanded != "$original" ]]; then
        hit=1 lastarg=$hist_expanded
        ble/util/declare-print-definitions hit lastarg
        break
      fi
    done
    _ble_edit_lastarg_index=$index
    _ble_edit_lastarg_delta=$delta
    _ble_edit_lastarg_nth=$nth
    ble/util/declare-print-definitions \
      _ble_edit_lastarg_index \
      _ble_edit_lastarg_delta \
      _ble_edit_lastarg_nth
  )
  builtin eval -- "$decl"
  if [[ $hit ]]; then
    local insert; ble-edit/content/replace-limited "$beg" "$end" "$lastarg"
    ((_ble_edit_mark=beg,_ble_edit_ind=beg+${#insert}))
    return 0
  else
    ble/widget/.bell
    return 1
  fi
}
function ble/widget/insert-nth-argument {
  ble/history/initialize
  local arg; ble-edit/content/get-arg '^'
  local beg=$_ble_edit_ind end=$_ble_edit_ind
  local index=$_ble_history_INDEX
  local delta=-1 nth=$arg
  ble/widget/insert-arg.impl "$beg" "$end" "$index" "$delta" "$nth"
}
function ble/widget/insert-last-argument {
  ble/history/initialize
  local arg; ble-edit/content/get-arg '$'
  local beg=$_ble_edit_ind end=$_ble_edit_ind
  local index=$_ble_history_INDEX
  local delta=-1 nth=$arg
  ble/widget/insert-arg.impl "$beg" "$end" "$index" "$delta" "$nth" || return "$?"
  _ble_edit_mark_active=insert
  ble/decode/keymap/push lastarg
}
function ble/widget/lastarg/next {
  local arg; ble-edit/content/get-arg 1
  local beg=$_ble_edit_mark
  local end=$_ble_edit_ind
  local index=$_ble_edit_lastarg_index
  local delta
  if [[ $arg ]]; then
    delta=$((-arg))
  else
    ((delta=_ble_edit_lastarg_delta>=0?1:-1))
  fi
  local nth=$_ble_edit_lastarg_nth
  ble/widget/insert-arg.impl "$beg" "$end" "$index" "$delta" "$nth"
}
function ble/widget/lastarg/exit {
  ble/decode/keymap/pop
  _ble_edit_mark_active=
}
function ble/widget/lastarg/cancel {
  ble-edit/content/replace "$_ble_edit_mark" "$_ble_edit_ind" ''
  _ble_edit_ind=$_ble_edit_mark
  ble/widget/lastarg/exit
}
function ble/widget/lastarg/exit-default {
  ble/widget/lastarg/exit
  ble/decode/widget/skip-lastwidget
  ble/decode/widget/redispatch-by-keys "${KEYS[@]}"
}
function ble/highlight/layer:region/mark:insert/get-face {
  face=region_insert
}
function ble-decode/keymap:lastarg/define {
  ble-decode/keymap:safe/bind-arg lastarg/exit-default
  ble-bind -f __default__ 'lastarg/exit-default'
  ble-bind -f __line_limit__ nop
  ble-bind -f 'C-g'       'lastarg/cancel'
  ble-bind -f 'C-x C-g'   'lastarg/cancel'
  ble-bind -f 'C-M-g'     'lastarg/cancel'
  ble-bind -f 'M-.'       'lastarg/next'
  ble-bind -f 'M-_'       'lastarg/next'
}
function ble/widget/self-insert/.get-code {
  if ((${#KEYS[@]})); then
    code=${KEYS[${#KEYS[@]}-1]}
    local flag=$((code&_ble_decode_MaskFlag))
    local char=$((code&_ble_decode_MaskChar))
    if ((flag==0&&char<_ble_decode_FunctionKeyBase)); then
      code=$char
      return 0
    elif ((flag==_ble_decode_Ctrl&&(char==63||91<=char&&char<=122)&&(char&0x1F)!=0)); then
      ((char=char==63?127:char&0x1F))
      code=$char
      return 0
    fi
  fi
  if ((${#CHARS[@]})); then
    code=${CHARS[${#CHARS[@]}-1]}
    return 0
  fi
  code=0
  return 1
}
function ble/widget/self-insert {
  local code; ble/widget/self-insert/.get-code
  ((code==0)) && return 0
  ((code==127&&_ble_bash<30100)) && return 0
  local ibeg=$_ble_edit_ind iend=$_ble_edit_ind
  local ret ins; ble/util/c2s "$code"; ins=$ret
  local arg; ble-edit/content/get-arg 1
  if ((arg<0)); then
    ble/widget/.bell "negative repetition number $arg"
    return 1
  elif ((arg==0)) || [[ ! $ins ]]; then
    arg=0 ins=
  elif ((arg>1)); then
    ble/string#repeat "$ins" "$arg"; ins=$ret
  fi
  if [[ $bleopt_delete_selection_mode && $_ble_edit_mark_active ]]; then
    ((_ble_edit_mark<_ble_edit_ind?(ibeg=_ble_edit_mark):(iend=_ble_edit_mark),
      _ble_edit_ind=ibeg))
    ((arg==0&&ibeg==iend)) && return 0
  elif [[ $_ble_edit_overwrite_mode ]] && ((code!=10&&code!=9)); then
    ((arg==0)) && return 0
    local removed_width
    if [[ $_ble_edit_overwrite_mode == R ]]; then
      local removed_text=${_ble_edit_str:ibeg:arg}
      removed_text=${removed_text%%[$'\n\t']*}
      removed_width=${#removed_text}
      ((iend+=removed_width))
    else
      local ret w; ble/util/c2w-edit "$code"; w=$((arg*ret))
      local iN=${#_ble_edit_str}
      for ((removed_width=0;removed_width<w&&iend<iN;iend++)); do
        local c1 w1
        ble/util/s2c "${_ble_edit_str:iend:1}"; c1=$ret
        [[ $c1 == 0 || $c1 == 10 || $c1 == 9 ]] && break
        ble/util/c2w-edit "$c1"; w1=$ret
        ((removed_width+=w1))
      done
      ((removed_width>w)) && ins=$ins${_ble_string_prototype::removed_width-w}
    fi
    if [[ :$ble_widget_self_insert_opts: == *:nolineext:* ]]; then
      if ((removed_width<arg)); then
        ble/widget/.bell
        return 0
      fi
    fi
  fi
  local insert; ble-edit/content/replace-limited "$ibeg" "$iend" "$ins"
  ((_ble_edit_ind+=${#insert},
    _ble_edit_mark>ibeg&&(
      _ble_edit_mark<iend?(
        _ble_edit_mark=_ble_edit_ind
      ):(
        _ble_edit_mark+=${#insert}-(iend-ibeg)))))
  _ble_edit_mark_active=
  return 0
}
function ble/widget/batch-insert.progress {
  ((index%${1:-257}==0&&N>=2000)) || return 1
  local ble_batch_insert_index=$index
  local ble_batch_insert_count=$N
  builtin eval -- "$_ble_decode_show_progress_hook"
}
function ble/widget/batch-insert {
  local -a chars; chars=("${KEYS[@]}")
  local -a KEYS=()
  local index=0 N=${#chars[@]}
  if [[ $_ble_edit_overwrite_mode ]]; then
    while ((index<N&&_ble_edit_ind<${#_ble_edit_str})); do
      KEYS=${chars[index]} ble/widget/self-insert
      ((index++))
    done
    ((index<N)) || return 0
  fi
  if [[ $bleopt_line_limit_type == discard ]]; then
    local limit=$((bleopt_line_limit_length))
    if ((limit&&${#_ble_edit_str}+N-index>=limit)); then
      chars=("${chars[@]::limit-${#_ble_edit_str}}")
      N=${#chars[@]}
      ((index<N)) || { ble/widget/.bell; return 1; }
    fi
  fi
  while ((index<N)) && [[ $_ble_edit_arg || $_ble_edit_mark_active ]]; do
    KEYS=${chars[index]} ble/widget/self-insert
    ((index++))
    ble/widget/batch-insert.progress
  done
  if ((index<N)); then
    local index0=$index ret ins
    for ((;index<N;index++)); do
      ((chars[index])) || builtin unset -v 'chars[index]'
      ble/widget/batch-insert.progress 2357
    done
    ble/util/chars2s "${chars[@]:index0}"; ins=$ret
    ble/widget/insert-string "$ins"
  fi
  ble-edit/content/check-limit truncate
}
function ble/widget/quoted-insert-char.hook {
  ble/widget/self-insert
}
function ble/widget/quoted-insert-char {
  _ble_edit_mark_active=
  _ble_decode_char__hook=ble/widget/quoted-insert-char.hook
  return 147
}
function ble/widget/quoted-insert.hook {
  local flag=$((KEYS[0]&_ble_decode_MaskFlag))
  local char=$((KEYS[0]&_ble_decode_MaskChar))
  if ((flag==0&&char<_ble_decode_FunctionKeyBase)); then
    ble/widget/self-insert
  elif ((flag==_ble_decode_Ctrl&&(char==63||91<=char&&char<=122)&&(char&0x1F)!=0)); then
    ((char=char==63?127:char&0x1F))
    local -a KEYS; KEYS=("$char")
    ble/widget/self-insert
  else
    local -a KEYS; KEYS=("${CHARS[@]}")
    ble/widget/batch-insert
  fi
}
function ble/widget/quoted-insert {
  _ble_edit_mark_active=
  _ble_decode_key__hook=ble/widget/quoted-insert.hook
  return 147
}
_ble_edit_bracketed_paste=()
_ble_edit_bracketed_paste_proc=
_ble_edit_bracketed_paste_count=0
function ble/widget/bracketed-paste {
  ble-edit/content/clear-arg
  _ble_edit_mark_active=
  _ble_edit_bracketed_paste=()
  _ble_edit_bracketed_paste_count=0
  _ble_edit_bracketed_paste_proc=ble/widget/bracketed-paste.proc
  _ble_decode_char__hook=ble/widget/bracketed-paste.hook
  return 147
}
function ble/widget/bracketed-paste.hook/check-end {
  local is_end= chars=
  if ((_ble_edit_bracketed_paste_count>=5)); then
    IFS=: builtin eval '_ble_edit_bracketed_paste=("${_ble_edit_bracketed_paste[*]}")'
    chars=:$_ble_edit_bracketed_paste
    if [[ $chars == *:50:48:49:126 ]]; then
      if [[ $chars == *:27:91:50:48:49:126 ]]; then # ESC [ 2 0 1 ~
        chars=${chars%:27:91:50:48:49:126} is_end=1
      elif [[ $chars == *:155:50:48:49:126 ]]; then # CSI 2 0 1 ~
        chars=${chars%:155:50:48:49:126} is_end=1
      fi
    fi
  fi
  [[ $is_end ]] || return 1
  _ble_decode_char__hook=
  chars=:${chars//:/::}:
  chars=${chars//:13::10:/:10:} # CR LF -> LF
  chars=${chars//:13:/:10:} # CR -> LF
  ble/string#split-words chars "${chars//:/ }"
  local proc=$_ble_edit_bracketed_paste_proc
  _ble_edit_bracketed_paste_proc=
  [[ $proc ]] && builtin eval -- "$proc \"\${chars[@]}\""
  return 0
}
function ble/widget/bracketed-paste.hook {
  ((_ble_edit_bracketed_paste_count%1000==0)) &&
    IFS=: builtin eval '_ble_edit_bracketed_paste=("${_ble_edit_bracketed_paste[*]}")' # contract
  _ble_edit_bracketed_paste[_ble_edit_bracketed_paste_count++]=$1
  (($1==126)) && ble/widget/bracketed-paste.hook/check-end && return 0
  if ((!_ble_debug_keylog_enabled)) && [[ ! $_ble_decode_keylog_chars_enabled ]]; then
    local char
    while ble/decode/char-hook/next-char; do
      _ble_edit_bracketed_paste[_ble_edit_bracketed_paste_count++]=$char
      ((char==126)) && ble/widget/bracketed-paste.hook/check-end && return 0
    done
  fi
  _ble_decode_char__hook=ble/widget/bracketed-paste.hook
  return 147
}
function ble/widget/bracketed-paste.proc {
  local -a KEYS; KEYS=("$@")
  ble/widget/batch-insert
}
function ble/widget/transpose-chars {
  local arg; ble-edit/content/get-arg ''
  if ((arg==0)); then
    [[ ! $arg ]] && ble-edit/content/eolp &&
      ((_ble_edit_ind>0&&_ble_edit_ind--))
    arg=1
  fi
  local p q r
  if ((arg>0)); then
    ((p=_ble_edit_ind-1,
      q=_ble_edit_ind,
      r=_ble_edit_ind+arg))
  else # arg<0
    ((p=_ble_edit_ind-1+arg,
      q=_ble_edit_ind,
      r=_ble_edit_ind+1))
  fi
  if ((p<0||${#_ble_edit_str}<r)); then
    ((_ble_edit_ind=arg<0?0:${#_ble_edit_str}))
    ble/widget/.bell
    return 1
  fi
  local a=${_ble_edit_str:p:q-p}
  local b=${_ble_edit_str:q:r-q}
  ble-edit/content/replace "$p" "$r" "$b$a"
  ((_ble_edit_ind+=arg))
  return 0
}
function ble/widget/.delete-backward-char {
  local a=${1:-1}
  if ((_ble_edit_ind-a<0)); then
    return 1
  fi
  local ins=
  if [[ $_ble_edit_overwrite_mode ]]; then
    local next=${_ble_edit_str:_ble_edit_ind:1}
    if [[ $next && $next != [$'\n\t'] ]]; then
      if [[ $_ble_edit_overwrite_mode == R ]]; then
        local w=$a
      else
        local w=0 ret i
        for ((i=0;i<a;i++)); do
          ble/util/s2c "${_ble_edit_str:_ble_edit_ind-a+i:1}"
          ble/util/c2w-edit "$ret"
          ((w+=ret))
        done
      fi
      if ((w)); then
        local ret; ble/string#repeat ' ' "$w"; ins=$ret
        ((_ble_edit_mark>=_ble_edit_ind&&(_ble_edit_mark+=w)))
      fi
    fi
  fi
  ble-edit/content/replace $((_ble_edit_ind-a)) "$_ble_edit_ind" "$ins"
  ((_ble_edit_ind-=a,
    _ble_edit_ind+a<_ble_edit_mark?(_ble_edit_mark-=a):
    _ble_edit_ind<_ble_edit_mark&&(_ble_edit_mark=_ble_edit_ind)))
  return 0
}
function ble/widget/.delete-char {
  local a=${1:-1}
  if ((a>0)); then
    if ((${#_ble_edit_str}<_ble_edit_ind+a)); then
      return 1
    else
      ble-edit/content/replace "$_ble_edit_ind" $((_ble_edit_ind+a)) ''
    fi
  elif ((a<0)); then
    ble/widget/.delete-backward-char $((-a)); return "$?"
  else
    if ((${#_ble_edit_str}==0)); then
      return 1
    elif ((_ble_edit_ind<${#_ble_edit_str})); then
      ble-edit/content/replace "$_ble_edit_ind" $((_ble_edit_ind+1)) ''
    else
      _ble_edit_ind=${#_ble_edit_str}
      ble/widget/.delete-backward-char 1; return "$?"
    fi
  fi
  ((_ble_edit_mark>_ble_edit_ind&&_ble_edit_mark--))
  return 0
}
function ble/widget/delete-forward-char {
  local arg; ble-edit/content/get-arg 1
  ((arg==0)) && return 0
  ble/widget/.delete-char "$arg" || ble/widget/.bell
}
function ble/widget/delete-backward-char {
  local arg; ble-edit/content/get-arg 1
  ((arg==0)) && return 0
  [[ $_ble_decode_keymap == vi_imap ]] && ble/keymap:vi/undo/add more
  ble/widget/.delete-char $((-arg)) || ble/widget/.bell
  [[ $_ble_decode_keymap == vi_imap ]] && ble/keymap:vi/undo/add more
}
_ble_edit_exit_count=0
function ble/widget/exit {
  ble-edit/content/clear-arg
  if [[ $WIDGET == "$LASTWIDGET" ]]; then
    ((_ble_edit_exit_count++))
  else
    _ble_edit_exit_count=1
  fi
  local ret; ble-edit/eval-IGNOREEOF
  if ((_ble_edit_exit_count<=ret)); then
    local remain=$((ret-_ble_edit_exit_count+1))
    ble/widget/.bell 'IGNOREEOF'
    ble/widget/print "IGNOREEOF($remain): Use \"exit\" to leave the shell."
    return 0
  fi
  local opts=$1
  ((_ble_bash>=40000)) && shopt -q checkjobs &>/dev/null && opts=$opts:checkjobs
  if [[ $bleopt_allow_exit_with_jobs ]]; then
    local ret
    if ble/util/assign ret 'compgen -A stopped -- ""' 2>/dev/null; [[ $ret ]]; then
      opts=$opts:twice
    elif [[ :$opts: == *:checkjobs:* ]]; then
      if ble/util/assign ret 'compgen -A running -- ""' 2>/dev/null; [[ $ret ]]; then
        opts=$opts:twice
      fi
    else
      opts=$opts:force
    fi
  fi
  if ! [[ :$opts: == *:force:* || :$opts: == *:twice:* && _ble_edit_exit_count -ge 2 ]]; then
    local joblist
    ble/util/joblist
    if ((${#joblist[@]})); then
      ble/widget/.bell "exit: There are remaining jobs."
      local q=\' Q="'\''" message=
      if [[ :$opts: == *:twice:* ]]; then
        message='There are remaining jobs. Input the same key to exit the shell anyway.'
      else
        message='There are remaining jobs. Use "exit" to leave the shell.'
      fi
      ble/widget/internal-command "ble/util/print '${_ble_term_setaf[12]}[ble: ${message//$q/$Q}]$_ble_term_sgr0'; jobs"
      return "$?"
    fi
  elif [[ :$opts: == *:checkjobs:* ]]; then
    local joblist
    ble/util/joblist
    ((${#joblist[@]})) && printf '%s\n' "${#joblist[@]}"
  fi
  _ble_edit_line_disabled=1 ble/textarea#render
  ble/edit/enter-command-layout # #D1800 pair=leave-command-layout
  local -a DRAW_BUFF=()
  ble/canvas/panel#goto.draw "$_ble_textarea_panel" "$_ble_textarea_gendx" "$_ble_textarea_gendy"
  ble/canvas/bflush.draw
  ble/util/buffer.print "${_ble_term_setaf[12]}[ble: exit]$_ble_term_sgr0"
  ble/util/buffer.flush >&2
  builtin exit 0 &>/dev/null
  builtin exit 0 &>/dev/null
  ble/edit/leave-command-layout # #D1800 pair=enter-command-layout
  return 1
}
function ble/widget/delete-forward-char-or-exit {
  if [[ $_ble_edit_str ]]; then
    ble/widget/delete-forward-char
  else
    ble/widget/exit
  fi
}
function ble/widget/delete-forward-backward-char {
  ble-edit/content/clear-arg
  ble/widget/.delete-char 0 || ble/widget/.bell
}
function ble/widget/delete-forward-char-or-list {
  local right=${_ble_edit_str:_ble_edit_ind}
  if [[ ! $right || $right == $'\n'* ]]; then
    ble/widget/complete show_menu
  else
    ble/widget/delete-forward-char
  fi
}
function ble/widget/delete-horizontal-space {
  local arg; ble-edit/content/get-arg ''
  local b=0 rex=$'[ \t]+$'
  [[ ${_ble_edit_str::_ble_edit_ind} =~ $rex ]] &&
    b=${#BASH_REMATCH}
  local a=0 rex=$'^[ \t]+'
  [[ ! $arg && ${_ble_edit_str:_ble_edit_ind} =~ $rex ]] &&
    a=${#BASH_REMATCH}
  ble/widget/.delete-range $((_ble_edit_ind-b)) $((_ble_edit_ind+a))
}
function ble/widget/.forward-char {
  ((_ble_edit_ind+=${1:-1}))
  if ((_ble_edit_ind>${#_ble_edit_str})); then
    _ble_edit_ind=${#_ble_edit_str}
    return 1
  elif ((_ble_edit_ind<0)); then
    _ble_edit_ind=0
    return 1
  fi
}
function ble/widget/forward-char {
  local arg; ble-edit/content/get-arg 1
  ((arg==0)) && return 0
  ble/widget/.forward-char "$arg" || ble/widget/.bell
}
function ble/widget/backward-char {
  local arg; ble-edit/content/get-arg 1
  ((arg==0)) && return 0
  ble/widget/.forward-char $((-arg)) || ble/widget/.bell
}
_ble_edit_character_search_arg=
function ble/widget/character-search-forward {
  local arg; ble-edit/content/get-arg 1
  _ble_edit_character_search_arg=$arg
  _ble_edit_mark_active=
  _ble_decode_char__hook=ble/widget/character-search.hook
}
function ble/widget/character-search-backward {
  local arg; ble-edit/content/get-arg 1
  ((_ble_edit_character_search_arg=-arg))
  _ble_edit_mark_active=
  _ble_decode_char__hook=ble/widget/character-search.hook
}
function ble/widget/character-search.hook {
  local char=${KEYS[0]}
  local ret; ble/util/c2s "${KEYS[0]}"; local c=$ret
  [[ $c ]] || return 1 # Note: C-@ の時は無視
  local arg=$_ble_edit_character_search_arg
  if ((arg>0)); then
    local right=${_ble_edit_str:_ble_edit_ind+1}
    if ble/string#index-of "$right" "$c" "$arg"; then
      ((_ble_edit_ind=_ble_edit_ind+1+ret))
    elif ble/string#last-index-of "$right" "$c"; then
      ble/widget/.bell "${arg}th character not found"
      ((_ble_edit_ind=_ble_edit_ind+1+ret))
    else
      ble/widget/.bell 'character not found'
      return 1
    fi
  elif ((arg<0)); then
    local left=${_ble_edit_str::_ble_edit_ind}
    if ble/string#last-index-of "$left" "$c" $((-arg)); then
      _ble_edit_ind=$ret
    elif ble/string#index-of "$left" "$c"; then
      ble/widget/.bell "$((-arg))th last character not found"
      _ble_edit_ind=$ret
    else
      ble/widget/.bell 'character not found'
      return 1
    fi
  fi
  return 0
}
function ble/widget/.locate-forward-byte {
  local delta=$1 ret
  if ((delta==0)); then
    return 0
  elif ((delta>0)); then
    local right=${_ble_edit_str:index:delta}
    local rlen=${#right}
    ble/util/strlen "$right"; local rsz=$ret
    if ((delta>=rsz)); then
      ((index+=rlen))
      ((delta==rsz)); return "$?"
    else
      while ((delta&&rlen>=2)); do
        local mlen=$((rlen/2))
        local m=${right::mlen}
        ble/util/strlen "$m"; local msz=$ret
        if ((delta>=msz)); then
          right=${right:mlen}
          ((index+=mlen,
            rlen-=mlen,
            delta-=msz))
          ((rlen>delta)) &&
            right=${right::delta} rlen=$delta
        else
          right=$m rlen=$mlen
        fi
      done
      ((delta&&rlen&&index++))
      return 0
    fi
  elif ((delta<0)); then
    ((delta=-delta))
    local left=${_ble_edit_str::index}
    local llen=${#left}
    ((llen>delta)) && left=${left:llen-delta} llen=$delta
    ble/util/strlen "$left"; local lsz=$ret
    if ((delta>=lsz)); then
      ((index-=llen))
      ((delta==lsz)); return "$?"
    else
      while ((delta&&llen>=2)); do
        local mlen=$((llen/2))
        local m=${left:llen-mlen}
        ble/util/strlen "$m"; local msz=$ret
        if ((delta>=msz)); then
          left=${left::llen-mlen}
          ((index-=mlen,
            llen-=mlen,
            delta-=msz))
          ((llen>delta)) &&
            left=${left:llen-delta} llen=$delta
        else
          left=$m llen=$mlen
        fi
      done
      ((delta&&llen&&index--))
      return 0
    fi
  fi
}
function ble/widget/forward-byte {
  local arg; ble-edit/content/get-arg 1
  ((arg==0)) && return 0
  local index=$_ble_edit_ind
  ble/widget/.locate-forward-byte "$arg" || ble/widget/.bell
  _ble_edit_ind=$index
}
function ble/widget/backward-byte {
  local arg; ble-edit/content/get-arg 1
  ((arg==0)) && return 0
  local index=$_ble_edit_ind
  ble/widget/.locate-forward-byte $((-arg)) || ble/widget/.bell
  _ble_edit_ind=$index
}
function ble/widget/end-of-text {
  local arg; ble-edit/content/get-arg ''
  if [[ $arg ]]; then
    if ((arg>=10)); then
      _ble_edit_ind=0
    else
      ((arg<0&&(arg=0)))
      local index=$(((19-2*arg)*${#_ble_edit_str}/20))
      local ret; ble-edit/content/find-logical-bol "$index"
      _ble_edit_ind=$ret
    fi
  else
    _ble_edit_ind=${#_ble_edit_str}
  fi
}
function ble/widget/beginning-of-text {
  local arg; ble-edit/content/get-arg ''
  if [[ $arg ]]; then
    if ((arg>=10)); then
      _ble_edit_ind=${#_ble_edit_str}
    else
      ((arg<0&&(arg=0)))
      local index=$(((2*arg+1)*${#_ble_edit_str}/20))
      local ret; ble-edit/content/find-logical-bol "$index"
      _ble_edit_ind=$ret
    fi
  else
    _ble_edit_ind=0
  fi
}
function ble/widget/beginning-of-logical-line {
  local arg; ble-edit/content/get-arg 1
  local ret; ble-edit/content/find-logical-bol "$_ble_edit_ind" $((arg-1))
  _ble_edit_ind=$ret
}
function ble/widget/end-of-logical-line {
  local arg; ble-edit/content/get-arg 1
  local ret; ble-edit/content/find-logical-eol "$_ble_edit_ind" $((arg-1))
  _ble_edit_ind=$ret
}
function ble/widget/kill-backward-logical-line {
  local arg; ble-edit/content/get-arg ''
  if [[ $arg ]]; then
    local ret; ble-edit/content/find-logical-eol "$_ble_edit_ind" $((-arg)); local index=$ret
    if ((arg>0)); then
      if ((_ble_edit_ind<=index)); then
        index=0
      else
        ble/string#count-char "${_ble_edit_str:index:_ble_edit_ind-index}" $'\n'
        ((ret<arg)) && index=0
      fi
      [[ $flag_beg ]] && index=0
    fi
    ret=$index
  else
    local ret; ble-edit/content/find-logical-bol
    ((0<ret&&ret==_ble_edit_ind&&ret--))
  fi
  ble/widget/.kill-range "$ret" "$_ble_edit_ind"
}
function ble/widget/kill-forward-logical-line {
  local arg; ble-edit/content/get-arg ''
  if [[ $arg ]]; then
    local ret; ble-edit/content/find-logical-bol "$_ble_edit_ind" "$arg"; local index=$ret
    if ((arg>0)); then
      if ((index<=_ble_edit_ind)); then
        index=${#_ble_edit_str}
      else
        ble/string#count-char "${_ble_edit_str:_ble_edit_ind:index-_ble_edit_ind}" $'\n'
        ((ret<arg)) && index=${#_ble_edit_str}
      fi
    fi
    ret=$index
  else
    local ret; ble-edit/content/find-logical-eol
    ((ret<${#_ble_edit_str}&&_ble_edit_ind==ret&&ret++))
  fi
  ble/widget/.kill-range "$_ble_edit_ind" "$ret"
}
function ble/widget/kill-logical-line {
  local arg; ble-edit/content/get-arg 0
  local bofs=0 eofs=0 bol=0 eol=${#_ble_edit_str}
  ((arg>0?(eofs=arg-1):(arg<0&&(bofs=arg+1))))
  ble-edit/content/find-logical-bol "$_ble_edit_ind" "$bofs" && local bol=$ret
  ble-edit/content/find-logical-eol "$_ble_edit_ind" "$eofs" && local eol=$ret
  [[ ${_ble_edit_str:eol:1} == $'\n' ]] && ((eol++))
  ((bol<eol)) && ble/widget/.kill-range "$bol" "$eol"
}
function ble/widget/forward-history-line.impl {
  local arg=$1
  ((arg==0)) && return 0
  local rest=$((arg>0?arg:-arg))
  if ((arg>0)); then
    if [[ ! $_ble_history_prefix && ! $_ble_history_load_done ]]; then
      ble/widget/.bell 'end of history'
      return 1
    fi
  fi
  ble/history/initialize
  local index=$_ble_history_INDEX
  local expr_next='--index>=0'
  if ((arg>0)); then
    local count=$_ble_history_COUNT
    expr_next="++index<=$count"
  fi
  while ((expr_next)); do
    if ((--rest<=0)); then
      ble-edit/history/goto "$index" # 位置は goto に任せる
      return "$?"
    fi
    local entry; ble/history/get-edited-entry "$index"
    if [[ $entry == *$'\n'* ]]; then
      local ret; ble/string#count-char "$entry" $'\n'
      if ((rest<=ret)); then
        ble-edit/history/goto "$index"
        if ((arg>0)); then
          ble-edit/content/find-logical-eol 0 "$rest"
        else
          ble-edit/content/find-logical-eol ${#entry} $((-rest))
        fi
        _ble_edit_ind=$ret
        return 0
      fi
      ((rest-=ret))
    fi
  done
  if ((arg>0)); then
    ble-edit/history/goto "$count"
    _ble_edit_ind=${#_ble_edit_str}
    ble/widget/.bell 'end of history'
  else
    ble-edit/history/goto 0
    _ble_edit_ind=0
    ble/widget/.bell 'beginning of history'
  fi
  return 0
}
function ble/widget/forward-logical-line.impl {
  local arg=$1 opts=$2
  ((arg==0)) && return 0
  local ind=$_ble_edit_ind
  if ((arg>0)); then
    ((ind<${#_ble_edit_str})) || return 1
  else
    ((ind>0)) || return 1
  fi
  local ret; ble-edit/content/find-logical-bol "$ind" "$arg"; local bol2=$ret
  if ((arg>0)); then
    if ((ind<bol2)); then
      ble/string#count-char "${_ble_edit_str:ind:bol2-ind}" $'\n'
      ((arg-=ret))
    fi
  else
    if ((ind>bol2)); then
      ble/string#count-char "${_ble_edit_str:bol2:ind-bol2}" $'\n'
      ((arg+=ret))
    fi
  fi
  if ((arg==0)); then
    ble-edit/content/find-logical-bol "$ind" ; local bol1=$ret
    ble-edit/content/find-logical-eol "$bol2"; local eol2=$ret
    local dst=$((bol2+ind-bol1))
    ((_ble_edit_ind=dst<eol2?dst:eol2))
    return 0
  fi
  if ((arg>0)); then
    ble-edit/content/find-logical-eol "$bol2"
  else
    ret=$bol2
  fi
  _ble_edit_ind=$ret
  if [[ :$opts: == *:history:* && ! $_ble_edit_mark_active ]]; then
    ble/widget/forward-history-line.impl "$arg"
    return "$?"
  fi
  if ((arg>0)); then
    ble/widget/.bell 'end of string'
  else
    ble/widget/.bell 'beginning of string'
  fi
  return 0
}
function ble/widget/forward-logical-line {
  local opts=$1
  local arg; ble-edit/content/get-arg 1
  ble/widget/forward-logical-line.impl "$arg" "$opts"
}
function ble/widget/backward-logical-line {
  local opts=$1
  local arg; ble-edit/content/get-arg 1
  ble/widget/forward-logical-line.impl $((-arg)) "$opts"
}
function ble/keymap:emacs/find-graphical-eol {
  local axis=${1:-$_ble_edit_ind} arg=${2:-0}
  local x y index
  ble/textmap#getxy.cur "$axis"
  ble/textmap#get-index-at 0 $((y+arg+1))
  if ((index>0)); then
    local ax ay
    ble/textmap#getxy.cur --prefix=a "$index"
    ((ay>y+arg&&index--))
  fi
  ret=$index
}
function ble/widget/beginning-of-graphical-line {
  ble/textmap#is-up-to-date || ble/widget/.update-textmap
  local arg; ble-edit/content/get-arg 1
  local x y index
  ble/textmap#getxy.cur "$_ble_edit_ind"
  ble/textmap#get-index-at 0 $((y+arg-1))
  _ble_edit_ind=$index
}
function ble/widget/end-of-graphical-line {
  ble/textmap#is-up-to-date || ble/widget/.update-textmap
  local arg; ble-edit/content/get-arg 1
  local ret; ble/keymap:emacs/find-graphical-eol "$_ble_edit_ind" $((arg-1))
  _ble_edit_ind=$ret
}
function ble/widget/kill-backward-graphical-line {
  ble/textmap#is-up-to-date || ble/widget/.update-textmap
  local arg; ble-edit/content/get-arg ''
  if [[ ! $arg ]]; then
    local x y index
    ble/textmap#getxy.cur "$_ble_edit_ind"
    ble/textmap#get-index-at 0 "$y"
    ((index==_ble_edit_ind&&index>0&&index--))
    ble/widget/.kill-range "$index" "$_ble_edit_ind"
  else
    local ret; ble/keymap:emacs/find-graphical-eol "$_ble_edit_ind" $((-arg))
    ble/widget/.kill-range "$ret" "$_ble_edit_ind"
  fi
}
function ble/widget/kill-forward-graphical-line {
  ble/textmap#is-up-to-date || ble/widget/.update-textmap
  local arg; ble-edit/content/get-arg ''
  local x y index ax ay
  ble/textmap#getxy.cur "$_ble_edit_ind"
  ble/textmap#get-index-at 0 $((y+${arg:-1}))
  if [[ ! $arg ]] && ((_ble_edit_ind<index-1)); then
    ble/textmap#getxy.cur --prefix=a "$index"
    ((ay>y&&index--))
  fi
  ble/widget/.kill-range "$_ble_edit_ind" "$index"
}
function ble/widget/kill-graphical-line {
  ble/textmap#is-up-to-date || ble/widget/.update-textmap
  local arg; ble-edit/content/get-arg 0
  local bofs=0 eofs=0
  ((arg>0?(eofs=arg-1):(arg<0&&(bofs=arg+1))))
  local x y index ax ay
  ble/textmap#getxy.cur "$_ble_edit_ind"
  ble/textmap#get-index-at 0 $((y+bofs))  ; local bol=$index
  ble/textmap#get-index-at 0 $((y+eofs+1)); local eol=$index
  ((bol<eol)) && ble/widget/.kill-range "$bol" "$eol"
}
function ble/widget/forward-graphical-line.impl {
  ble/textmap#is-up-to-date || ble/widget/.update-textmap
  local arg=$1 opts=$2
  ((arg==0)) && return 0
  local x y index ax ay
  ble/textmap#getxy.cur "$_ble_edit_ind"
  ble/textmap#get-index-at "$x" $((y+arg))
  ble/textmap#getxy.cur --prefix=a "$index"
  ((arg-=ay-y))
  _ble_edit_ind=$index # 何れにしても移動は行う
  ((arg==0)) && return 0
  if [[ :$opts: == *:history:* && ! $_ble_edit_mark_active ]]; then
    ble/widget/forward-history-line.impl "$arg"
    return "$?"
  fi
  if ((arg>0)); then
    ble/widget/.bell 'end of string'
  else
    ble/widget/.bell 'beginning of string'
  fi
  return 0
}
function ble/widget/forward-graphical-line {
  local opts=$1
  local arg; ble-edit/content/get-arg 1
  ble/widget/forward-graphical-line.impl "$arg" "$opts"
}
function ble/widget/backward-graphical-line {
  local opts=$1
  local arg; ble-edit/content/get-arg 1
  ble/widget/forward-graphical-line.impl $((-arg)) "$opts"
}
function ble/widget/beginning-of-line {
  if ble/edit/performs-on-graphical-line; then
    ble/widget/beginning-of-graphical-line
  else
    ble/widget/beginning-of-logical-line
  fi
}
function ble/widget/non-space-beginning-of-line {
  local old=$_ble_edit_ind
  ble/widget/beginning-of-logical-line
  local bol=$_ble_edit_ind ret=
  ble-edit/content/find-non-space "$bol"
  [[ $ret == $old ]] && ret=$bol # toggle
  _ble_edit_ind=$ret
  return 0
}
function ble/widget/end-of-line {
  if ble/edit/performs-on-graphical-line; then
    ble/widget/end-of-graphical-line
  else
    ble/widget/end-of-logical-line
  fi
}
function ble/widget/kill-backward-line {
  if ble/edit/performs-on-graphical-line; then
    ble/widget/kill-backward-graphical-line
  else
    ble/widget/kill-backward-logical-line
  fi
}
function ble/widget/kill-forward-line {
  if ble/edit/performs-on-graphical-line; then
    ble/widget/kill-forward-graphical-line
  else
    ble/widget/kill-forward-logical-line
  fi
}
function ble/widget/kill-line {
  if ble/edit/performs-on-graphical-line; then
    ble/widget/kill-graphical-line
  else
    ble/widget/kill-logical-line
  fi
}
function ble/widget/forward-line {
  if ble/edit/use-textmap; then
    ble/widget/forward-graphical-line "$@"
  else
    ble/widget/forward-logical-line "$@"
  fi
}
function ble/widget/backward-line {
  if ble/edit/use-textmap; then
    ble/widget/backward-graphical-line "$@"
  else
    ble/widget/backward-logical-line "$@"
  fi
}
function ble/edit/word:eword/setup {
  WSET='a-zA-Z0-9'; WSEP="^$WSET"
}
function ble/edit/word:cword/setup {
  WSET='_a-zA-Z0-9'; WSEP="^$WSET"
}
function ble/edit/word:uword/setup {
  WSEP="$_ble_term_IFS"; WSET="^$WSEP"
}
function ble/edit/word:sword/setup {
  WSEP=$'|&;()<> \t\n'; WSET="^$WSEP"
}
function ble/edit/word:fword/setup {
  WSEP="/$_ble_term_IFS"; WSET="^$WSEP"
}
function ble/edit/word/skip-backward {
  local set=$1 head=${_ble_edit_str::x}
  head=${head##*[$set]}
  ((x-=${#head},${#head}))
}
function ble/edit/word/skip-forward {
  local set=$1 tail=${_ble_edit_str:x}
  tail=${tail%%[$set]*}
  ((x+=${#tail},${#tail}))
}
function ble/edit/word/locate-backward {
  local x=${1:-$_ble_edit_ind} arg=${2:-1}
  while ((arg--)); do
    ble/edit/word/skip-backward "$WSET"; c=$x
    ble/edit/word/skip-backward "$WSEP"; b=$x
  done
  ble/edit/word/skip-backward "$WSET"; a=$x
}
function ble/edit/word/locate-forward {
  local x=${1:-$_ble_edit_ind} arg=${2:-1}
  while ((arg--)); do
    ble/edit/word/skip-forward "$WSET"; s=$x
    ble/edit/word/skip-forward "$WSEP"; t=$x
  done
  ble/edit/word/skip-forward "$WSET"; u=$x
}
function ble/edit/word/forward-range {
  local arg=$1; ((arg)) || arg=1
  if ((arg<0)); then
    ble/edit/word/backward-range $((-arg))
    return "$?"
  fi
  local s t u; ble/edit/word/locate-forward "$x" "$arg"; y=$t
}
function ble/edit/word/backward-range {
  local arg=$1; ((arg)) || arg=1
  if ((arg<0)); then
    ble/edit/word/forward-range $((-arg))
    return "$?"
  fi
  local a b c; ble/edit/word/locate-backward "$x" "$arg"; y=$b
}
function ble/edit/word/current-range {
  local arg=$1; ((arg)) || arg=1
  if ((arg>0)); then
    local a b c; ble/edit/word/locate-backward "$x"
    local s t u; ble/edit/word/locate-forward "$a" "$arg"
    ((y=a,x<t&&(x=t)))
  elif ((arg<0)); then
    local s t u; ble/edit/word/locate-forward "$x"
    local a b c; ble/edit/word/locate-backward "$u" $((-arg))
    ((b<x&&(x=b),y=u))
  fi
  return 0
}
function ble/widget/word.impl {
  local operator=$1 direction=$2 wtype=$3
  local arg; ble-edit/content/get-arg 1
  local WSET WSEP; ble/edit/word:"$wtype"/setup
  local x=$_ble_edit_ind y=$_ble_edit_ind
  ble/function#try ble/edit/word/"$direction"-range "$arg"
  if ((x==y)); then
    ble/widget/.bell
    return 1
  fi
  case $operator in
  (goto) _ble_edit_ind=$y ;;
  (delete)
    [[ $_ble_decode_keymap == vi_imap && $direction == backward ]] &&
      ble/keymap:vi/undo/add more
    ble/widget/.delete-range "$x" "$y"
    [[ $_ble_decode_keymap == vi_imap && $direction == backward ]] &&
      ble/keymap:vi/undo/add more ;;
  (kill)   ble/widget/.kill-range "$x" "$y" ;;
  (copy)   ble/widget/.copy-range "$x" "$y" ;;
  (*)      ble/widget/.bell; return 1 ;;
  esac
}
function ble/widget/transpose-words.impl1 {
  local wtype=$1 arg=$2
  local WSET WSEP; ble/edit/word:"$wtype"/setup
  if ((arg==0)); then
    local x=$_ble_edit_ind
    ble/edit/word/skip-forward "$WSET"
    ble/edit/word/skip-forward "$WSEP"; local e1=$x
    ble/edit/word/skip-backward "$WSEP"; local b1=$x
    local x=$_ble_edit_mark
    ble/edit/word/skip-forward "$WSET"
    ble/edit/word/skip-forward "$WSEP"; local e2=$x
    ble/edit/word/skip-backward "$WSEP"; local b2=$x
  else
    local x=$_ble_edit_ind
    ble/edit/word/skip-backward "$WSET"
    ble/edit/word/skip-backward "$WSEP"; local b1=$x
    ble/edit/word/skip-forward "$WSEP"; local e1=$x
    if ((arg>0)); then
      x=$e1
      ble/edit/word/skip-forward "$WSET"; local b2=$x
      while ble/edit/word/skip-forward "$WSEP" || return 1; ((--arg>0)); do
        ble/edit/word/skip-forward "$WSET"
      done; local e2=$x
    else
      x=$b1
      ble/edit/word/skip-backward "$WSET"; local e2=$x
      while ble/edit/word/skip-backward "$WSEP" || return 1; ((++arg<0)); do
        ble/edit/word/skip-backward "$WSET"
      done; local b2=$x
    fi
  fi
  ((b1>b2)) && local b1=$b2 e1=$e2 b2=$b1 e2=$e1
  if ! ((b1<e1&&e1<=b2&&b2<e2)); then
    ble/widget/.bell
    return 1
  fi
  local word1=${_ble_edit_str:b1:e1-b1}
  local word2=${_ble_edit_str:b2:e2-b2}
  local sep=${_ble_edit_str:e1:b2-e1}
  ble/widget/.replace-range "$b1" "$e2" "$word2$sep$word1"
  _ble_edit_ind=$e2
}
function ble/widget/transpose-words.impl {
  local wtype=$1 arg; ble-edit/content/get-arg 1
  ble/widget/transpose-words.impl1 "$wtype" "$arg" && return 0
  ble/widget/.bell
  return 1
}
function ble/widget/filter-word.impl {
  local xword=$1 filter=$2
  if [[ $_ble_decode_keymap == vi_nmap ]]; then
    local ARG FLAG REG; ble/keymap:vi/get-arg 1
    local arg=$ARG
  else
    local arg; ble-edit/content/get-arg 1
  fi
  local WSET WSEP; ble/edit/word:"$xword"/setup
  local x=$_ble_edit_ind s t u
  ble/edit/word/locate-forward "$x" "$arg"
  if ((x==t)); then
    ble/widget/.bell
    [[ $_ble_decode_keymap == vi_nmap ]] &&
      ble/keymap:vi/adjust-command-mode
    return 1
  fi
  local word=${_ble_edit_str:x:t-x}
  "$filter" "$word"
  [[ $word != $ret ]] &&
    ble-edit/content/replace "$x" "$t" "$ret"
  if [[ $_ble_decode_keymap == vi_nmap ]]; then
    ble/keymap:vi/mark/set-previous-edit-area "$x" "$t"
    ble/keymap:vi/repeat/record
    ble/keymap:vi/adjust-command-mode
  fi
  _ble_edit_ind=$t
}
function ble/widget/forward-eword  { ble/widget/word.impl goto forward  eword; }
function ble/widget/backward-eword { ble/widget/word.impl goto backward eword; }
function ble/widget/delete-forward-eword  { ble/widget/word.impl delete forward  eword; }
function ble/widget/delete-backward-eword { ble/widget/word.impl delete backward eword; }
function ble/widget/delete-eword          { ble/widget/word.impl delete current  eword; }
function ble/widget/kill-forward-eword  { ble/widget/word.impl kill forward  eword; }
function ble/widget/kill-backward-eword { ble/widget/word.impl kill backward eword; }
function ble/widget/kill-eword          { ble/widget/word.impl kill current  eword; }
function ble/widget/copy-forward-eword  { ble/widget/word.impl copy forward  eword; }
function ble/widget/copy-backward-eword { ble/widget/word.impl copy backward eword; }
function ble/widget/copy-eword          { ble/widget/word.impl copy current  eword; }
function ble/widget/capitalize-eword { ble/widget/filter-word.impl eword ble/string#capitalize; }
function ble/widget/downcase-eword   { ble/widget/filter-word.impl eword ble/string#tolower; }
function ble/widget/upcase-eword     { ble/widget/filter-word.impl eword ble/string#toupper; }
function ble/widget/transpose-ewords { ble/widget/transpose-words.impl eword; }
function ble/widget/forward-cword  { ble/widget/word.impl goto forward  cword; }
function ble/widget/backward-cword { ble/widget/word.impl goto backward cword; }
function ble/widget/delete-forward-cword  { ble/widget/word.impl delete forward  cword; }
function ble/widget/delete-backward-cword { ble/widget/word.impl delete backward cword; }
function ble/widget/delete-cword          { ble/widget/word.impl delete current  cword; }
function ble/widget/kill-forward-cword  { ble/widget/word.impl kill forward  cword; }
function ble/widget/kill-backward-cword { ble/widget/word.impl kill backward cword; }
function ble/widget/kill-cword          { ble/widget/word.impl kill current  cword; }
function ble/widget/copy-forward-cword  { ble/widget/word.impl copy forward  cword; }
function ble/widget/copy-backward-cword { ble/widget/word.impl copy backward cword; }
function ble/widget/copy-cword          { ble/widget/word.impl copy current  cword; }
function ble/widget/capitalize-cword { ble/widget/filter-word.impl cword ble/string#capitalize; }
function ble/widget/downcase-cword   { ble/widget/filter-word.impl cword ble/string#tolower; }
function ble/widget/upcase-cword     { ble/widget/filter-word.impl cword ble/string#toupper; }
function ble/widget/transpose-cwords { ble/widget/transpose-words.impl cword; }
function ble/widget/forward-uword  { ble/widget/word.impl goto forward  uword; }
function ble/widget/backward-uword { ble/widget/word.impl goto backward uword; }
function ble/widget/delete-forward-uword  { ble/widget/word.impl delete forward  uword; }
function ble/widget/delete-backward-uword { ble/widget/word.impl delete backward uword; }
function ble/widget/delete-uword          { ble/widget/word.impl delete current  uword; }
function ble/widget/kill-forward-uword  { ble/widget/word.impl kill forward  uword; }
function ble/widget/kill-backward-uword { ble/widget/word.impl kill backward uword; }
function ble/widget/kill-uword          { ble/widget/word.impl kill current  uword; }
function ble/widget/copy-forward-uword  { ble/widget/word.impl copy forward  uword; }
function ble/widget/copy-backward-uword { ble/widget/word.impl copy backward uword; }
function ble/widget/copy-uword          { ble/widget/word.impl copy current  uword; }
function ble/widget/capitalize-uword { ble/widget/filter-word.impl uword ble/string#capitalize; }
function ble/widget/downcase-uword   { ble/widget/filter-word.impl uword ble/string#tolower; }
function ble/widget/upcase-uword     { ble/widget/filter-word.impl uword ble/string#toupper; }
function ble/widget/transpose-uwords { ble/widget/transpose-words.impl uword; }
function ble/widget/forward-sword  { ble/widget/word.impl goto forward  sword; }
function ble/widget/backward-sword { ble/widget/word.impl goto backward sword; }
function ble/widget/delete-forward-sword  { ble/widget/word.impl delete forward  sword; }
function ble/widget/delete-backward-sword { ble/widget/word.impl delete backward sword; }
function ble/widget/delete-sword          { ble/widget/word.impl delete current  sword; }
function ble/widget/kill-forward-sword  { ble/widget/word.impl kill forward  sword; }
function ble/widget/kill-backward-sword { ble/widget/word.impl kill backward sword; }
function ble/widget/kill-sword          { ble/widget/word.impl kill current  sword; }
function ble/widget/copy-forward-sword  { ble/widget/word.impl copy forward  sword; }
function ble/widget/copy-backward-sword { ble/widget/word.impl copy backward sword; }
function ble/widget/copy-sword          { ble/widget/word.impl copy current  sword; }
function ble/widget/capitalize-sword { ble/widget/filter-word.impl sword ble/string#capitalize; }
function ble/widget/downcase-sword   { ble/widget/filter-word.impl sword ble/string#tolower; }
function ble/widget/upcase-sword     { ble/widget/filter-word.impl sword ble/string#toupper; }
function ble/widget/transpose-swords { ble/widget/transpose-words.impl sword; }
function ble/widget/forward-fword  { ble/widget/word.impl goto forward  fword; }
function ble/widget/backward-fword { ble/widget/word.impl goto backward fword; }
function ble/widget/delete-forward-fword  { ble/widget/word.impl delete forward  fword; }
function ble/widget/delete-backward-fword { ble/widget/word.impl delete backward fword; }
function ble/widget/delete-fword          { ble/widget/word.impl delete current  fword; }
function ble/widget/kill-forward-fword  { ble/widget/word.impl kill forward  fword; }
function ble/widget/kill-backward-fword { ble/widget/word.impl kill backward fword; }
function ble/widget/kill-fword          { ble/widget/word.impl kill current  fword; }
function ble/widget/copy-forward-fword  { ble/widget/word.impl copy forward  fword; }
function ble/widget/copy-backward-fword { ble/widget/word.impl copy backward fword; }
function ble/widget/copy-fword          { ble/widget/word.impl copy current  fword; }
function ble/widget/capitalize-fword { ble/widget/filter-word.impl fword ble/string#capitalize; }
function ble/widget/downcase-fword   { ble/widget/filter-word.impl fword ble/string#tolower; }
function ble/widget/upcase-fword     { ble/widget/filter-word.impl fword ble/string#toupper; }
function ble/widget/transpose-fwords { ble/widget/transpose-words.impl fword; }
_ble_edit_exec_lines=()
_ble_edit_exec_lastexit=0
_ble_edit_exec_lastarg=$BASH
_ble_edit_exec_BASH_COMMAND=$BASH
function ble-edit/exec/register {
  if [[ $1 != *[!"$_ble_term_IFS"]* ]]; then
    ble/edit/leave-command-layout
    return 1
  fi
  ble/array#push _ble_edit_exec_lines "$1"
}
function ble-edit/exec/has-pending-commands {
  ((${#_ble_edit_exec_lines[@]}))
}
function ble-edit/exec/.setexit {
  return "$_ble_edit_exec_lastexit"
}
_ble_prompt_eol_mark=('' '' 0)
function ble-edit/exec/.adjust-eol {
  local cols=${COLUMNS:-80}
  local -a DRAW_BUFF=()
  if [[ $bleopt_prompt_eol_mark ]]; then
    if [[ $bleopt_prompt_eol_mark != "${_ble_prompt_eol_mark[0]}" ]]; then
      if [[ $bleopt_prompt_eol_mark ]]; then
        local ret= x=0 y=0 g=0 x1=0 x2=0 y1=0 y2=0
        LINES=1 COLUMNS=80 ble/canvas/trace "$bleopt_prompt_eol_mark" truncate:measure-bbox
        _ble_prompt_eol_mark=("$bleopt_prompt_eol_mark" "$ret" "$x2")
      else
        _ble_prompt_eol_mark=('' '' 0)
      fi
    fi
    local eol_mark=${_ble_prompt_eol_mark[1]}
    ble/canvas/put.draw "$_ble_term_sgr0$_ble_term_sc"
    local width=${_ble_prompt_eol_mark[2]} limit=$cols
    [[ $_ble_term_rc ]] || ((limit--))
    if ((width>limit)); then
      local x=0 y=0 g=0
      LINES=1 COLUMNS=$limit ble/canvas/trace.draw "$bleopt_prompt_eol_mark" truncate
      width=$x
    else
      ble/canvas/put.draw "$eol_mark"
    fi
    [[ $_ble_term_rc ]] || ble/canvas/put-cub.draw "$width"
    ble/canvas/put.draw "$_ble_term_sgr0$_ble_term_rc"
  fi
  local advance=$((_ble_term_xenl?cols-2:cols-3))
  if [[ $_ble_term_TERM == cygwin:* ]]; then
    while ((advance)); do
      ble/canvas/put-cuf.draw $((advance-advance/2))
      ((advance/=2))
    done
  else
    ble/canvas/put-cuf.draw "$advance"
  fi
  ble/canvas/put.draw "  $_ble_term_cr$_ble_term_el"
  ble/prompt/print-ruler.draw "$_ble_edit_exec_BASH_COMMAND"
  ble/canvas/bflush.draw
}
_ble_prompt_ps10_data=()
function ble/prompt/unit:_ble_prompt_ps10/update {
  ble/prompt/unit:{section}/update _ble_prompt_ps10 "$PS0" ''
}
function ble-edit/exec/print-PS0 {
  if [[ $PS0 ]]; then
    local version=$COLUMNS,$_ble_edit_lineno,$_ble_history_count,$_ble_edit_CMD
    local prompt_hashref_base='$version'
    local prompt_rows=${LINES:-25}
    local prompt_cols=${COLUMNS:-80}
    local "${_ble_prompt_cache_vars[@]/%/=}" # #D1570 OK
    ble/prompt/unit#update _ble_prompt_ps10
    ble/prompt/unit:{section}/get _ble_prompt_ps10
    ble/util/put "$ret"
  fi
}
_ble_builtin_exit_processing=
function ble/builtin/exit/.read-arguments {
  [[ ! $_ble_attached || $_ble_edit_exec_inside_userspace ]] &&
    ble/base/adjust-BASH_REMATCH
  while (($#)); do
    local arg=$1; shift
    if [[ $arg == --help ]]; then
      opt_flags=${opt_flags}H
    elif local rex='^[-+]?[0-9]+$'; [[ $arg =~ $rex ]]; then
      ble/array#push opt_args "$arg"
    else
      ble/util/print "exit: unrecognized argument '$arg'" >&2
      opt_flags=${opt_flags}E
    fi
  done
  if ((${#opt_args[@]}>=2)); then
    ble/util/print "exit: too many arguments" >&2
    opt_flags=${opt_flags}E
  fi
  [[ ! $_ble_attached || $_ble_edit_exec_inside_userspace ]] &&
    ble/base/restore-BASH_REMATCH
}
function ble/builtin/exit {
  local ext=$?
  if [[ ! $_ble_builtin_trap_processing ]] && { ble/util/is-running-in-subshell || [[ $_ble_decode_bind_state == none ]]; }; then
    (($#)) || set -- "$ext"
    builtin exit "$@"
    return $? # オプションの指定間違いなどで失敗する可能性がある。
  fi
  local set shopt; ble/base/.adjust-bash-options set shopt
  local opt_flags=
  local -a opt_args=()
  ble/builtin/exit/.read-arguments "$@"
  if [[ $opt_flags == *[EH]* ]]; then
    [[ $opt_flags == *H* ]] && builtin exit --help
    ble/base/.restore-bash-options set shopt
    return 2
  fi
  ((${#opt_args[@]})) || ble/array#push opt_args "$ext"
  if [[ $_ble_builtin_trap_processing ]]; then
    shopt -s extdebug
    _ble_edit_exec_TRAPDEBUG_EXIT=$opt_args
    ble-edit/exec:gexec/.TRAPDEBUG/trap
    return 0
  fi
  if [[ ! $_ble_builtin_exit_processing ]]; then
    local joblist
    ble/util/joblist
    if ((${#joblist[@]})); then
      local ret
      while
        local cancel_reason=
        if ble/util/assign ret 'compgen -A stopped -- ""' 2>/dev/null; [[ $ret ]]; then
          cancel_reason='stopped jobs'
        elif [[ :$opts: == *:checkjobs:* ]]; then
          if ble/util/assign ret 'compgen -A running -- ""' 2>/dev/null; [[ $ret ]]; then
            cancel_reason='running jobs'
          fi
        fi
        [[ $cancel_reason ]]
      do
        jobs
        ble/builtin/read -ep "\e[38;5;12m[ble: There are $cancel_reason]\e[m Leave the shell anyway? [yes/No] " ret
        case $ret in
        ([yY]|[yY][eE][sS]) break ;;
        ([nN]|[nN][oO]|'')
          ble/base/.restore-bash-options set shopt
          return 0 ;;
        esac
      done
    fi
    ble/util/print "${_ble_term_setaf[12]}[ble: exit]$_ble_term_sgr0" >&2
  fi
  if ((40400<=_ble_bash&&_ble_bash<50200)); then
    local global_TIMEFORMAT local_TIMEFORMAT
    ble/util/assign global_TIMEFORMAT 'ble/util/print-global-definitions TIMEFORMAT'
    if [[ $global_TIMEFORMAT == 'declare TIMEFORMAT; builtin unset -v TIMEFORMAT' ]]; then
      global_TIMEFORMAT='declare -g TIMEFORMAT=$'\''\nreal\t%3lR\nuser\t%3lU\nsys %3lS'\'
    else
      global_TIMEFORMAT="declare -g ${global_TIMEFORMAT#declare }"
    fi
    ble/variable#copy-state TIMEFORMAT local_TIMEFORMAT
    declare -g TIMEFORMAT=
    TIMEFORMAT=
  fi
  ble/base/.restore-bash-options set shopt
  _ble_builtin_exit_processing=1
  ble/fd#alloc _ble_builtin_exit_stdout '>&1' # EXIT trap で stdin/stdout を復元する
  ble/fd#alloc _ble_builtin_exit_stderr '>&2'
  builtin exit "${opt_args[@]}" &>/dev/null
  builtin exit "${opt_args[@]}" &>/dev/null
  _ble_builtin_exit_processing=
  ble/fd#close _ble_builtin_exit_stdout
  ble/fd#close _ble_builtin_exit_stderr
  if ((40400<=_ble_bash&&_ble_bash<50200)); then
    builtin eval -- "$global_TIMEFORMAT"
    ble/variable#copy-state local_TIMEFORMAT TIMEFORMAT
  fi
  return 1 # exit できなかった場合は 1 らしい
}
function exit { ble/builtin/exit "$@"; }
_ble_exec_time_TIMEFILE=$_ble_base_run/$$.exec.time
_ble_exec_time_TIMEFORMAT=
_ble_exec_time_tot=
_ble_exec_time_usr=
_ble_exec_time_sys=
function ble/exec/time#adjust-TIMEFORMAT {
  if [[ ${TIMEFORMAT+set} ]]; then
    _ble_exec_time_TIMEFORMAT=$TIMEFORMAT
  else
    builtin unset -v _ble_exec_time_TIMEFORMAT
  fi
  TIMEFORMAT='%R %U %S'
}
function ble/exec/time#restore-TIMEFORMAT {
  if [[ ${_ble_exec_time_TIMEFORMAT+set} ]]; then
    TIMEFORMAT=$_ble_exec_time_TIMEFORMAT
  else
    builtin unset -v 'TIMEFORMAT[0]'
  fi
  local tot usr sys dummy
  IFS=' ' builtin read -r tot usr sys dummy < "$_ble_exec_time_TIMEFILE"
  ((_ble_exec_time_tot=10#0${tot//[!0-9]}))
  ((_ble_exec_time_usr=10#0${usr//[!0-9]}))
  ((_ble_exec_time_sys=10#0${sys//[!0-9]}))
}
_ble_exec_time_TIMES=$_ble_base_run/$$.exec.times
_ble_exec_time_usr_self=
_ble_exec_time_sys_self=
function ble/exec/time/times.parse-time {
  local rex='^([0-9]+m)?([0-9]*)([^0-9ms][0-9]{3})?s?$'
  [[ $1 =~ $rex ]] || return 1
  local min=$((10#0${BASH_REMATCH[1]%m}))
  local sec=$((10#0${BASH_REMATCH[2]}))
  local msc=$((10#0${BASH_REMATCH[3]#?}))
  ((ret=(min*60+sec)*1000+msc))
  return 0
} 2>/dev/tty
function ble/exec/time/times.start {
  builtin times >| "$_ble_exec_time_TIMES"
}
function ble/exec/time/times.end {
  builtin times >> "$_ble_exec_time_TIMES"
  local times
  ble/util/readfile times "$_ble_exec_time_TIMES"
  ble/string#split-words times "$times"
  _ble_exec_time_usr_self=
  _ble_exec_time_sys_self=
  local ret= t1 t2
  ble/exec/time/times.parse-time "${times[0]}" && t1=$ret &&
    ble/exec/time/times.parse-time "${times[4]}" && t2=$ret &&
    ((_ble_exec_time_usr_self=t2>t1?t2-t1:0,
      _ble_exec_time_usr_self>_ble_exec_time_usr&&(
        _ble_exec_time_usr_self=_ble_exec_time_usr)))
  ble/exec/time/times.parse-time "${times[1]}" && t1=$ret &&
    ble/exec/time/times.parse-time "${times[5]}" && t2=$ret &&
    ((_ble_exec_time_sys_self=t2>t1?t2-t1:0,
      _ble_exec_time_sys_self>_ble_exec_time_sys&&(
        _ble_exec_time_sys_self=_ble_exec_time_sys)))
  return 0
}
function ble/exec/time#mark-enabled {
  local real=$_ble_exec_time_tot
  local usr=$_ble_exec_time_usr usr_self=$_ble_exec_time_usr_self
  local sys=$_ble_exec_time_sys sys_self=$_ble_exec_time_sys_self
  local usr_child=$((usr-usr_self))
  local sys_child=$((sys-sys_self))
  local cpu=$((real>0?(usr+sys)*100/real:0))
  ((bleopt_exec_elapsed_enabled))
}
_ble_exec_time_beg=
_ble_exec_time_end=
_ble_exec_time_ata=
function ble/exec/time#start {
  if ((_ble_bash>=50000)); then
    _ble_exec_time_EPOCHREALTIME_delay=0
    _ble_exec_time_EPOCHREALTIME_beg=
    _ble_exec_time_EPOCHREALTIME_end=
    function ble/exec/time#start {
      ble/exec/time/times.start
      _ble_exec_time_EPOCHREALTIME_beg=
      _ble_exec_time_EPOCHREALTIME_end=
    }
    function ble/exec/time#end {
      local beg=${_ble_exec_time_EPOCHREALTIME_beg//[!0-9]}
      local end=${_ble_exec_time_EPOCHREALTIME_end//[!0-9]}
      ((beg+=delay,beg>end)) && beg=$end
      _ble_exec_time_beg=$beg
      _ble_exec_time_end=$end
      _ble_exec_time_ata=$((end-beg))
      _ble_exec_time_LINENO=$LINENO
      ble/exec/time/times.end
    }
    function ble/exec/time#calibrate.restore-lastarg {
      _ble_exec_time_EPOCHREALTIME_beg=$EPOCHREALTIME
      return "$_ble_edit_exec_lastexit"
    }
    function ble/exec/time#calibrate.save-lastarg {
      _ble_exec_time_EPOCHREALTIME_end=$EPOCHREALTIME
      ble/exec/time#adjust-TIMEFORMAT
    }
    function ble/exec/time#calibrate {
      local _ble_edit_exec_lastexit=0
      local _ble_edit_exec_lastarg=hello
      local _ble_exec_time_EPOCHREALTIME_beg=
      local _ble_exec_time_EPOCHREALTIME_end=
      local _ble_exec_time_tot=
      local _ble_exec_time_usr=
      local _ble_exec_time_sys=
      local TIMEFORMAT=
      local script1='ble/exec/time#calibrate.restore-lastarg "$_ble_edit_exec_lastarg"'
      local script2='{ ble/exec/time#calibrate.save-lastarg; } &>/dev/null'
      local script=$script1$_ble_term_nl$script2$_ble_term_nl
      local -a hist=()
      local i
      for i in {00..99}; do
        { builtin eval -- "$script" 2>&$_ble_util_fd_stderr; } 2>| "$_ble_exec_time_TIMEFILE"
        ble/exec/time#restore-TIMEFORMAT
        local beg=${_ble_exec_time_EPOCHREALTIME_beg//[!0-9]}
        local end=${_ble_exec_time_EPOCHREALTIME_end//[!0-9]}
        ((hist[end-beg]++))
      done
      local -a keys; keys=("${!hist[@]}")
      keys=("${keys[@]::(${#keys[@]}+1)/2}") # Remove outliers
      local s=0 n=0 t
      for t in "${keys[@]}"; do ((s+=t*hist[t],n+=hist[t])); done
      ((_ble_exec_time_EPOCHREALTIME_delay=s/n))
    }
    ble/exec/time#calibrate
    builtin unset -f ble/exec/time#calibrate
    builtin unset -f ble/exec/time#calibrate.restore-lastarg
    builtin unset -f ble/exec/time#calibrate.save-lastarg
  else
    _ble_exec_time_CLOCK_base=0
    _ble_exec_time_CLOCK_beg=
    _ble_exec_time_CLOCK_end=
    function ble/exec/time#end.adjust {
      ((_ble_exec_time_beg<prev_end)) && _ble_exec_time_beg=$prev_end
      local delta=$((_ble_exec_time_end-_ble_exec_time_beg))
      if ((delta<_ble_exec_time_ata)); then
        _ble_exec_time_end=$((_ble_exec_time_beg+_ble_exec_time_ata))
      else
        _ble_exec_time_beg=$((_ble_exec_time_end-_ble_exec_time_ata))
      fi
      _ble_exec_time_LINENO=$LINENO
    }
    function ble/exec/time#start {
      ble/exec/time/times.start
      _ble_exec_time_CLOCK_beg=
      _ble_exec_time_CLOCK_end=
      local ret; ble/util/clock
      _ble_exec_time_CLOCK_beg=$ret
    }
    function ble/exec/time#end {
      local ret; ble/util/clock
      _ble_exec_time_CLOCK_end=$ret
      local prev_end=$_ble_exec_time_end
      _ble_exec_time_beg=$((_ble_exec_time_CLOCK_base+_ble_exec_time_CLOCK_beg*1000))
      _ble_exec_time_end=$((_ble_exec_time_CLOCK_base+_ble_exec_time_CLOCK_end*1000))
      _ble_exec_time_ata=$((_ble_exec_time_tot*1000))
      ble/exec/time#end.adjust
      ble/exec/time/times.end
    }
    case $_ble_util_clock_type in
    (printf) ;;
    (uptime|SECONDS)
      ble/util/assign _ble_exec_time_SECONDS_base 'ble/bin/date +%s000000'
      local ret; ble/util/clock
      ((_ble_exec_time_SECONDS_base-=ret*1000)) ;;
    (date)
      if ble/util/assign ret 'ble/bin/date +%6N' 2>/dev/null && [[ $ret ]]; then
        function ble/exec/time#start {
          ble/exec/time/times.start
          _ble_exec_time_CLOCK_beg=
          _ble_exec_time_CLOCK_end=
          ble/util/assign _ble_exec_time_CLOCK_beg 'ble/bin/date +%s%6N'
        }
        function ble/exec/time#end {
          ble/util/assign _ble_exec_time_CLOCK_end 'ble/bin/date +%s%6N'
          local prev_end=$_ble_exec_time_end
          _ble_exec_time_beg=$_ble_exec_time_CLOCK_beg
          _ble_exec_time_end=$_ble_exec_time_CLOCK_end
          _ble_exec_time_ata=$((_ble_exec_time_tot*1000))
          ble/exec/time#end.adjust
          ble/exec/time/times.end
        }
      fi ;;
    esac
  fi
  ble/exec/time#start
}
_ble_edit_exec_TRAPDEBUG_enabled=
_ble_edit_exec_TRAPDEBUG_lastexit=
_ble_edit_exec_TRAPDEBUG_lastarg=
_ble_edit_exec_TRAPDEBUG_postproc=
_ble_edit_exec_TRAPDEBUG_INT=
_ble_edit_exec_TRAPDEBUG_EXIT=
_ble_edit_exec_inside_begin=
_ble_edit_exec_inside_prologue=
_ble_edit_exec_inside_userspace=
ble/builtin/trap/reserve DEBUG
function ble-edit/exec:gexec/.TRAPDEBUG/trap {
  builtin trap -- 'ble-edit/exec:gexec/.TRAPDEBUG "$*"; builtin eval -- "$_ble_edit_exec_TRAPDEBUG_postproc"' DEBUG
}
_ble_edit_exec_TRAPDEBUG_adjusted=
function _ble_edit_exec_gexec__TRAPDEBUG_adjust {
  builtin trap - DEBUG
  _ble_edit_exec_TRAPDEBUG_adjusted=1
}
ble/function#trace _ble_edit_exec_gexec__TRAPDEBUG_adjust
function ble-edit/exec:gexec/.TRAPDEBUG/restore {
  _ble_edit_exec_TRAPDEBUG_adjusted=
  local opts=$1
  ble/builtin/trap/.initialize
  if [[ ${_ble_builtin_trap_handlers[_ble_builtin_trap_DEBUG]} ]]; then
    ble-edit/exec:gexec/.TRAPDEBUG/trap "$opts"
  fi
}
function ble-edit/exec:gexec/.TRAPDEBUG {
  local __lastexit=$? __lastarg=$_ bash_command=$BASH_COMMAND # Note XXXX: bash-3.0 では BASH_COMMAND が異なる。
  _ble_edit_exec_TRAPDEBUG_postproc=
  [[ $_ble_edit_exec_TRAPDEBUG_enabled || ! $_ble_attached ]] || return 0
  [[ $bash_command != *ble-edit/exec:gexec/.* ]] || return 0
  [[ ! ( ${FUNCNAME[1]-} == _ble_prompt_update__eval_prompt_command_1 && ( $bash_command == 'ble-edit/exec/.setexit '* || $bash_command == 'BASH_COMMAND='*' builtin eval -- '* ) ) ]] || return 0
  [[ ! ${_ble_builtin_trap_inside-} ]] || return 0
  if [[ $_ble_edit_exec_TRAPDEBUG_EXIT ]]; then
    local flag_clear= flag_exit= postproc=
    if [[ ! $_ble_builtin_trap_processing ]] || ((${#FUNCNAME[*]}<=1)); then
      flag_clear=2
      flag_exit=$_ble_edit_exec_TRAPDEBUG_EXIT
    else
      case " ${FUNCNAME[*]:1} " in
      (' ble/builtin/trap/invoke.sandbox ble/builtin/trap/invoke '*)
        _ble_trap_done=exit
        _ble_trap_lastarg=$_ble_edit_exec_TRAPDEBUG_EXIT
        postproc='ble/util/setexit 2'
        shopt -q extdebug || postproc='return 0' ;;
      (' blehook/invoke.sandbox blehook/invoke ble/builtin/trap/.handler '*)
        _ble_local_ext=$_ble_edit_exec_TRAPDEBUG_EXIT
        _ble_builtin_trap_processing=exit:$_ble_edit_exec_TRAPDEBUG_EXIT
        postproc='ble/util/setexit 2'
        shopt -q extdebug || postproc='return 0' ;;
      (' ble/builtin/trap/invoke '* | ' blehook/invoke '*)
        flag_clear=1 ;;
      (' ble/builtin/trap/.handler '* | ' ble-edit/exec:gexec/.TRAPDEBUG '*)
        flag_clear=2 ;;
      (*)
        postproc='ble/util/setexit 2'
        shopt -q extdebug || postproc='return 128' ;;
      esac
    fi
    if [[ $flag_clear ]]; then
      [[ $flag_clear == 2 ]] || shopt -u extdebug
      _ble_edit_exec_TRAPDEBUG_EXIT=
      [[ ${_ble_builtin_trap_handlers[_ble_builtin_trap_DEBUG]+set} ]] ||
        postproc="builtin trap - DEBUG${postproc:+;$postproc}"
      if [[ $flag_exit ]]; then
        builtin exit "$flag_exit"
      fi
    fi
    _ble_edit_exec_TRAPDEBUG_postproc=$postproc
  elif [[ $_ble_edit_exec_TRAPDEBUG_INT ]]; then
    local IFS=$_ble_term_IFS __set __shopt
    ble/base/.adjust-bash-options __set __shopt
    local _ble_builtin_trap_processing=$_ble_builtin_trap_DEBUG
    local _ble_builtin_trap_postproc
    ble/util/setexit "$__lastexit" "$__lastarg"
    ble/builtin/trap/invoke DEBUG
    _ble_edit_exec_TRAPDEBUG_postproc=$_ble_builtin_trap_postproc # unused
    local depth=${#FUNCNAME[*]}
    if ((depth>=2)) && ! ble/string#match "${FUNCNAME[*]:1}" '^ble-edit/exec:gexec/\.|(^| )ble/builtin/trap/\.handler'; then
      local source=${_ble_term_setaf[5]}${BASH_SOURCE[1]}
      local sep=${_ble_term_setaf[6]}:
      local lineno=${_ble_term_setaf[2]}${BASH_LINENO[0]}
      local func=${_ble_term_setaf[6]}' ('${_ble_term_setaf[4]}${FUNCNAME[1]}${1:+ $1}${_ble_term_setaf[6]}')'
      ble/util/print "${_ble_term_setaf[9]}[SIGINT]$_ble_term_sgr0 $source$sep$lineno$func$_ble_term_sgr0" >/dev/tty
      _ble_edit_exec_TRAPDEBUG_postproc="{ return $_ble_edit_exec_TRAPDEBUG_INT || break; } &>/dev/null"
    elif ((depth==1)) && ! ble/string#match "$bash_command" '^ble-edit/exec:gexec/\.'; then
      local source=${_ble_term_setaf[5]}global
      local sep=${_ble_term_setaf[6]}:
      ble/util/print "${_ble_term_setaf[9]}[SIGINT]$_ble_term_sgr0 $source$sep$_ble_term_sgr0 $bash_command" >/dev/tty
      _ble_edit_exec_TRAPDEBUG_postproc="break &>/dev/null"
    fi
    ble/base/.restore-bash-options __set __shopt
  elif [[ ${_ble_builtin_trap_handlers[_ble_builtin_trap_DEBUG]+set} ]]; then
    _ble_edit_exec_TRAPDEBUG_lastexit=$__lastexit
    _ble_edit_exec_TRAPDEBUG_lastarg=$__lastarg
    _ble_edit_exec_TRAPDEBUG_postproc='ble/util/setexit "$_ble_edit_exec_TRAPDEBUG_lastexit" "$_ble_edit_exec_TRAPDEBUG_lastarg"'
    local user_trap=${_ble_builtin_trap_handlers[_ble_builtin_trap_DEBUG]}
    if [[ $user_trap == *[![:space:]]* ]]; then
      _ble_edit_exec_TRAPDEBUG_postproc="$_ble_edit_exec_TRAPDEBUG_postproc;$user_trap"
    fi
  else
    _ble_edit_exec_TRAPDEBUG_postproc='builtin trap -- - DEBUG'
  fi
  return 0
}
_ble_builtin_trap_DEBUG_userTrapInitialized=
function ble/builtin/trap:DEBUG {
  _ble_builtin_trap_DEBUG_userTrapInitialized=1
  if [[ $1 != - && ( $_ble_edit_exec_TRAPDEBUG_enabled || ! $_ble_attached ) ]]; then
    ble-edit/exec:gexec/.TRAPDEBUG/trap
  fi
}
function _ble_builtin_trap_DEBUG__initialize {
  if [[ $_ble_builtin_trap_DEBUG_userTrapInitialized ]]; then
    builtin eval -- "function $FUNCNAME() ((1))"
    return 0
  elif [[ $1 == force ]] || ble/function/is-global-trace-context; then
    _ble_builtin_trap_DEBUG_userTrapInitialized=1
    builtin eval -- "function $FUNCNAME() ((1))"
    local tmp=$_ble_base_run/$$.trap.DEBUG ret
    builtin trap -p DEBUG >| "$tmp"
    local content; ble/util/readfile content "$tmp"
    ble/util/put '' >| "$tmp"
    case ${content#"trap -- '"} in
    (ble-edit/exec:gexec/.TRAPDEBUG*) ;; # ble-0.4
    (ble-edit/exec:exec/.eval-TRAPDEBUG*|ble-edit/exec:gexec/.eval-TRAPDEBUG*) ;; # ble-0.2
    (.ble-edit/exec:exec/eval-TRAPDEBUG*|.ble-edit/exec:gexec/eval-TRAPDEBUG*) ;; # ble-0.1
    (*) builtin eval -- "$content" ;; # ble/builtin/trap に処理させる
    esac
    return 0
  fi
}
ble/function#trace _ble_builtin_trap_DEBUG__initialize
_ble_builtin_trap_DEBUG__initialize
function ble-edit/exec:gexec/.TRAPINT {
  local sig=130
  ((_ble_bash>=40300)) || sig=128 # bash-4.2 以下は 128
  if [[ $_ble_attached ]]; then
    ble/util/print "$_ble_term_bold^C$_ble_term_sgr0" >&2
    _ble_edit_exec_TRAPDEBUG_INT=$sig
    ble-edit/exec:gexec/.TRAPDEBUG/trap
  else
    _ble_builtin_trap_postproc="{ return $sig || break; } &>/dev/tty"
  fi
}
function ble-edit/exec:gexec/.TRAPINT/reset {
  blehook INT-='ble-edit/exec:gexec/.TRAPINT'
}
function ble-edit/exec:gexec/invoke-hook-with-setexit {
  local -a BLE_PIPESTATUS
  BLE_PIPESTATUS=("${_ble_edit_exec_PIPESTATUS[@]}")
  ble-edit/exec/.setexit "$_ble_edit_exec_lastarg"
  BASH_COMMAND=$_ble_edit_exec_BASH_COMMAND \
    blehook/invoke "$@"
} >&$_ble_util_fd_stdout 2>&$_ble_util_fd_stderr
_ble_edit_exec_TERM=
function ble-edit/exec:gexec/TERM/is-dirty {
  [[ $TERM != "$_ble_edit_exec_TERM" ]] && return 0
  local bindp
  ble/util/assign bindp 'builtin bind -p'
  [[ $bindp != "$_ble_decode_bind_bindp" ]]
}
function ble-edit/exec:gexec/TERM/leave {
  _ble_edit_exec_TERM=$TERM
}
function ble-edit/exec:gexec/TERM/enter {
  if [[ $_ble_decode_bind_state != none ]] && ble-edit/exec:gexec/TERM/is-dirty; then
    ble/edit/info/immediate-show text 'ble: TERM has changed. rebinding...'
    ble/decode/detach
    if ! ble/decode/attach; then
      ble-detach
      ble-edit/bind/.check-detach && return 1
    fi
    ble/edit/info/immediate-default
  fi
}
function ble-edit/exec:gexec/.begin {
  _ble_edit_exec_inside_begin=1
  local IFS=$_ble_term_IFS
  _ble_edit_exec_PWD=$PWD
  ble-edit/exec:gexec/TERM/leave
  ble/term/leave
  ble-edit/bind/stdout.on
  ble/util/buffer.flush >&2
  ble/builtin/trap/install-hook INT # 何故か改めて実行しないと有効にならない
  blehook INT+='ble-edit/exec:gexec/.TRAPINT'
  ble-edit/exec:gexec/.TRAPDEBUG/restore
}
function ble-edit/exec:gexec/.end {
  _ble_edit_exec_inside_begin=
  local IFS=$_ble_term_IFS
  ble-edit/exec:gexec/.TRAPINT/reset
  builtin trap -- - DEBUG
  [[ $PWD != "$_ble_edit_exec_PWD" ]] && blehook/invoke CHPWD
  ble/util/joblist.flush >&2
  ble-edit/bind/.check-detach && return 0
  ble/term/enter
  ble-edit/exec:gexec/TERM/enter || return 0 # rebind に失敗した時 .tail せずに抜ける
  ble/util/c2w:auto/check
  ble/edit/clear-command-layout
  [[ $1 == restore ]] && return 0 # Note: 前回の呼出で .end に失敗した時 #D1170
  ble-edit/bind/.tail # flush will be called here
}
function ble-edit/exec:gexec/.prologue {
  _ble_edit_exec_inside_prologue=1
  local IFS=$_ble_term_IFS
  _ble_edit_exec_BASH_COMMAND=$1
  ble-edit/restore-PS1
  ble-edit/restore-READLINE
  ble-edit/restore-IGNOREEOF
  builtin unset -v HISTCMD; ble/history/get-count -v HISTCMD
  _ble_edit_exec_TRAPDEBUG_INT=
  ble/util/joblist.clear
  ble-edit/exec:gexec/invoke-hook-with-setexit PREEXEC "$_ble_edit_exec_BASH_COMMAND"
  ble-edit/exec/print-PS0 >&$_ble_util_fd_stdout 2>&$_ble_util_fd_stderr
  ((++_ble_edit_CMD))
  ble/exec/time#start
  ble/base/restore-BASH_REMATCH
}
function ble-edit/exec:gexec/.restore-lastarg {
  ble/base/restore-bash-options
  ble/base/restore-POSIXLY_CORRECT
  ble/base/restore-builtin-wrappers
  builtin eval -- "$_ble_bash_FUNCNEST_restore"
  _ble_edit_exec_TRAPDEBUG_enabled=1
  _ble_edit_exec_inside_userspace=1
  _ble_exec_time_EPOCHREALTIME_beg=$EPOCHREALTIME
  return "$_ble_edit_exec_lastexit" # set $?
} &>/dev/null # set -x 対策 #D0930
function ble-edit/exec:gexec/.save-lastarg {
  _ble_exec_time_EPOCHREALTIME_end=$EPOCHREALTIME \
    _ble_edit_exec_lastexit=$? \
    _ble_edit_exec_lastarg=$_ \
    _ble_edit_exec_PIPESTATUS=("${PIPESTATUS[@]}")
  _ble_edit_exec_inside_userspace=
  _ble_edit_exec_TRAPDEBUG_enabled=
  builtin eval -- "$_ble_bash_FUNCNEST_adjust"
  ble/base/adjust-bash-options
  ble/exec/time#adjust-TIMEFORMAT
  return "$_ble_edit_exec_lastexit"
}
function ble-edit/exec:gexec/.epilogue {
  _ble_exec_time_EPOCHREALTIME_end=${_ble_exec_time_EPOCHREALTIME_end:-$EPOCHREALTIME} \
    _ble_edit_exec_lastexit=$?
  _ble_edit_exec_inside_userspace=
  _ble_edit_exec_TRAPDEBUG_enabled=
  builtin eval -- "$_ble_bash_FUNCNEST_adjust"
  ble/base/adjust-builtin-wrappers-1
  if [[ $_ble_edit_exec_TRAPDEBUG_INT ]]; then
    if ((_ble_edit_exec_lastexit==0)); then
      _ble_edit_exec_lastexit=$_ble_edit_exec_TRAPDEBUG_INT
    fi
    _ble_edit_exec_TRAPDEBUG_INT=
  fi
  local IFS=$_ble_term_IFS
  builtin trap -- - DEBUG
  ble/base/adjust-bash-options
  ble/base/adjust-POSIXLY_CORRECT
  ble/base/adjust-builtin-wrappers-2
  ble/base/adjust-BASH_REMATCH
  ble-edit/adjust-IGNOREEOF
  ble-edit/adjust-READLINE
  ble-edit/adjust-PS1
  ble/exec/time#restore-TIMEFORMAT
  ble/exec/time#end
  ble/util/reset-keymap-of-editing-mode
  ble-edit/exec/.adjust-eol
  _ble_edit_exec_inside_prologue=
  ble/util/buffer.flush >&$_ble_util_fd_stderr
  ble-edit/exec:gexec/invoke-hook-with-setexit POSTEXEC
  local msg=
  if ((_ble_edit_exec_lastexit)); then
    ble-edit/exec:gexec/invoke-hook-with-setexit ERR
    if [[ $bleopt_exec_errexit_mark ]]; then
      local ret
      ble/util/sprintf ret "$bleopt_exec_errexit_mark" "$_ble_edit_exec_lastexit"
      msg=$ret
    fi
  fi
  if ble/exec/time#mark-enabled; then
    local format=$bleopt_exec_elapsed_mark
    if [[ $format ]]; then
      local ata=$((_ble_exec_time_ata/1000))
      if ((ata<1000)); then
        ata="${ata}ms"
      elif ((ata<1000*1000)); then
        ata="${ata::${#ata}-3}.${ata:${#ata}-3}s"
      elif ((ata/=1000,ata<3600*100)); then # ata [s]
        local min
        ((min=ata/60,ata%=60))
        if ((min<100)); then
          ata="${min}m${ata}s"
        else
          ata="$((min/60))h$((min%60))m${ata}s"
        fi
      else
        local hour
        ((ata/=60,hour=ata/60,ata%=60))
        ata="$((hour/24))d$((hour%24))h${ata}m"
      fi
      local cpu='--.-'
      if ((_ble_exec_time_tot)); then
        cpu=$(((_ble_exec_time_usr+_ble_exec_time_sys)*1000/_ble_exec_time_tot))
        cpu=$((cpu/10)).$((cpu%10))
      fi
      local ret
      ble/util/sprintf ret "$format" "$ata" "$cpu"
      msg=$msg$ret
      ble/string#ltrim "$_ble_edit_exec_BASH_COMMAND"
      msg="$msg $ret"
    fi
  fi
  if [[ $msg ]]; then
    x=0 y=0 g=0 LINES=1 ble/canvas/trace "$msg" confine:truncate
    ble/util/buffer.print "$ret"
  fi
}
function ble-edit/exec:gexec/.setup {
  ((${#_ble_edit_exec_lines[@]})) || [[ ! $_ble_edit_exec_TRAPDEBUG_adjusted ]] || return 1
  local buff='_ble_decode_bind_hook=' ibuff=1
  if [[ ! $_ble_edit_exec_TRAPDEBUG_adjusted ]]; then
    buff[ibuff++]='_ble_builtin_trap_DEBUG__initialize force'
    buff[ibuff++]=_ble_edit_exec_gexec__TRAPDEBUG_adjust
  fi
  local count=${#_ble_edit_exec_lines[@]}
  if ((count)); then
    ble/util/buffer.flush >&2
    local q=\' Q="'\''" cmd
    buff[ibuff++]=ble-edit/exec:gexec/.begin
    for cmd in "${_ble_edit_exec_lines[@]}"; do
      local prologue=""
      buff[ibuff++]="ble-edit/exec:gexec/.prologue '${cmd//$q/$Q}'"
      buff[ibuff++]='{ time builtin eval -- "ble-edit/exec:gexec/.restore-lastarg \"\$_ble_edit_exec_lastarg\"'
      buff[ibuff++]='$_ble_edit_exec_BASH_COMMAND'
      buff[ibuff++]='{ ble-edit/exec:gexec/.save-lastarg; } &>/dev/null' # Note: &>/dev/null は set -x 対策 #D0930
      buff[ibuff++]='" 2>&$_ble_util_fd_stderr; } 2>| "$_ble_exec_time_TIMEFILE"'
      buff[ibuff++]='{ ble-edit/exec:gexec/.epilogue; } 3>&2 &>/dev/null'
    done
    _ble_edit_exec_lines=()
    buff[ibuff++]=_ble_edit_exec_gexec__TRAPDEBUG_adjust
    buff[ibuff++]=ble-edit/exec:gexec/.end
  fi
  if ((ibuff>=2)); then
    IFS=$'\n' builtin eval '_ble_decode_bind_hook="${buff[*]}"'
  fi
  ((count>=1)); return $?
}
function ble-edit/exec:gexec/process {
  ble-edit/exec:gexec/.setup
  return $?
}
function ble-edit/exec:gexec/restore-state {
  [[ $_ble_edit_exec_inside_prologue ]] && ble-edit/exec:gexec/.epilogue 3>&2 &>/dev/null
  [[ $_ble_edit_exec_inside_begin ]] && ble-edit/exec:gexec/.end restore
}
: ${_ble_edit_lineno:=0}
_ble_edit_line_opwd=
function ble/widget/.insert-newline/trim-prompt {
  local ps1f=$bleopt_prompt_ps1_final
  local ps1t=$bleopt_prompt_ps1_transient
  if [[ ! $ps1f && :$ps1t: == *:trim:* ]]; then
    [[ :$ps1t: == *:same-dir:* && $PWD != $_ble_edit_line_opwd ]] && return
    local y=${_ble_prompt_ps1_data[4]}
    if ((y)); then
      ble/canvas/panel#goto.draw "$_ble_textarea_panel" 0 0
      ble/canvas/panel#increase-height.draw "$_ble_textarea_panel" $((-y)) shift
      ((_ble_textarea_gendy-=y))
    fi
  fi
}
function ble/widget/.insert-newline {
  local opts=$1
  local -a DRAW_BUFF=()
  if [[ :$opts: == *:keep-info:* && $_ble_textarea_panel == 0 ]] &&
       ! ble/util/joblist.has-events
  then
    ble/textarea#render leave
    ble/widget/.insert-newline/trim-prompt
    local textarea_height=${_ble_canvas_panel_height[_ble_textarea_panel]}
    ble/canvas/panel#increase-height.draw "$_ble_textarea_panel" 1
    ble/canvas/panel#goto.draw "$_ble_textarea_panel" 0 "$textarea_height" sgr0
    ble/canvas/bflush.draw
  else
    ble/edit/enter-command-layout # #D1800 checked=.insert-newline
    ble/textarea#render leave
    ble/widget/.insert-newline/trim-prompt
    ble/canvas/panel#goto.draw "$_ble_textarea_panel" "$_ble_textarea_gendx" "$_ble_textarea_gendy" sgr0
    ble/canvas/put.draw "$_ble_term_nl"
    ble/canvas/bflush.draw
    ble/util/joblist.bflush
  fi
  ((_ble_edit_lineno++))
  _ble_edit_line_opwd=$PWD
  ble/textarea#invalidate
  _ble_canvas_x=0 _ble_canvas_y=0
  _ble_textarea_gendx=0 _ble_textarea_gendy=0
  _ble_canvas_panel_height[_ble_textarea_panel]=1
}
function ble/widget/.hide-current-line {
  local opts=$1 y_erase=0
  [[ :$opts: == *:keep-header:* ]] && y_erase=${_ble_prompt_ps1_data[4]}
  local -a DRAW_BUFF=()
  if ((y_erase)); then
    ble/canvas/panel#clear-after.draw "$_ble_textarea_panel" 0 "$y_erase"
  else
    ble/canvas/panel#clear.draw "$_ble_textarea_panel"
  fi
  ble/canvas/panel#goto.draw "$_ble_textarea_panel" 0 "$y_erase"
  ble/canvas/bflush.draw
  ble/textarea#invalidate
  _ble_canvas_x=0 _ble_canvas_y=$y_erase
  _ble_textarea_gendx=0 _ble_textarea_gendy=$y_erase
  ((_ble_canvas_panel_height[_ble_textarea_panel]=1+y_erase))
}
function ble/widget/.newline/clear-content {
  [[ $_ble_edit_overwrite_mode ]] &&
    ble/term/cursor-state/reveal
  ble-edit/content/reset '' newline
  _ble_edit_ind=0
  _ble_edit_mark=0
  _ble_edit_mark_active=
  _ble_edit_overwrite_mode=
}
function ble/widget/.newline {
  local opts=$1
  _ble_edit_mark_active=
  if [[ $_ble_complete_menu_active ]]; then
    [[ $_ble_highlight_layer_menu_filter_beg ]] &&
      ble/textarea#invalidate str # (#D0995)
  fi
  _ble_complete_menu_active= ble/widget/.insert-newline "$opts" # #D1800 checked=.newline
  local ret; ble/string#count-char "$_ble_edit_str" $'\n'
  ((_ble_edit_LINENO+=1+ret))
  ((LINENO=_ble_edit_LINENO))
  ble/history/onleave.fire
  ble/widget/.newline/clear-content
}
function ble/widget/discard-line {
  ble-edit/content/clear-arg
  [[ $bleopt_history_share ]] && ble/builtin/history/option:n
  _ble_edit_line_disabled=1 ble/widget/.newline keep-info
  ble/textarea#render
}
function ble/edit/hist_expanded/.core {
  ble/builtin/history/option:p "$command"
}
function ble-edit/hist_expanded/.expand {
  ble/edit/hist_expanded/.core 2>/dev/null; local ext=$?
  ((ext)) && ble/util/print "$command"
  ble/util/put :
  return "$ext"
}
function ble-edit/hist_expanded.update {
  local command=$1
  if [[ ! -o histexpand || ! ${command//[ 	]} ]]; then
    hist_expanded=$command
    return 0
  elif ble/util/assign hist_expanded 'ble-edit/hist_expanded/.expand'; then
    hist_expanded=${hist_expanded%$_ble_term_nl:}
    return 0
  else
    hist_expanded=$command
    return 1
  fi
}
function ble/widget/accept-line {
  ble/decode/widget/keymap-dispatch "$@"
}
function ble/widget/default/accept-line {
  if [[ :$1: == *:syntax:* || $MC_SID == $$ && $LINENO == 0 ]]; then
    ble-edit/content/update-syntax
    if ! ble/syntax:bash/is-complete; then
      ble/widget/newline
      return "$?"
    fi
  fi
  ble-edit/content/clear-arg
  local command=$_ble_edit_str
  if [[ ! ${command//["$_ble_term_IFS"]} ]]; then
    [[ $bleopt_history_share ]] &&
      ble/builtin/history/option:n
    ble/widget/.newline keep-info
    ble/prompt/print-ruler.buff '' keep-info
    ble/textarea#render
    ble/util/buffer.flush >&2
    return 0
  fi
  local hist_expanded
  if ! ble-edit/hist_expanded.update "$command"; then
    ble/widget/.internal-print-command \
      'ble/edit/hist_expanded/.core 1>/dev/null' pre-flush # エラーメッセージを表示
    shopt -q histreedit &>/dev/null || ble/widget/.newline/clear-content
    return "$?"
  fi
  local hist_is_expanded=
  if [[ $hist_expanded != "$command" ]]; then
    if shopt -q histverify &>/dev/null; then
      _ble_edit_line_disabled=1 ble/widget/.insert-newline keep-info
      ble-edit/content/reset-and-check-dirty "$hist_expanded"
      _ble_edit_ind=${#hist_expanded}
      _ble_edit_mark=0
      _ble_edit_mark_active=
      return 0
    fi
    command=$hist_expanded
    hist_is_expanded=1
  fi
  ble/widget/.newline # #D1800 register
  [[ $hist_is_expanded ]] && ble/util/buffer.print "${_ble_term_setaf[12]}[ble: expand]$_ble_term_sgr0 $command"
  ble/history/add "$command"
  ble-edit/exec/register "$command"
}
function ble/widget/accept-and-next {
  ble-edit/content/clear-arg
  ble/history/initialize
  local index=$_ble_history_INDEX
  local count=$_ble_history_COUNT
  if ((index+1<count)); then
    local HISTINDEX_NEXT=$((index+1)) # to be modified in accept-line
    ble/widget/accept-line
    ble-edit/history/goto "$HISTINDEX_NEXT"
  else
    local content=$_ble_edit_str
    ble/widget/accept-line
    count=$_ble_history_COUNT
    if ((count)); then
      local entry; ble/history/get-entry $((count-1))
      if [[ $entry == "$content" ]]; then
        ble-edit/history/goto $((count-1))
      fi
    fi
    [[ $_ble_edit_str != "$content" ]] &&
      ble-edit/content/reset "$content"
  fi
}
function ble/widget/newline {
  ble/decode/widget/keymap-dispatch "$@"
}
function ble/widget/default/newline {
  local -a KEYS=(10)
  ble/widget/self-insert
}
function ble/widget/tab-insert {
  local -a KEYS=(9)
  ble/widget/self-insert
}
function ble-edit/is-single-complete-line {
  ble-edit/content/is-single-line || return 1
  [[ $_ble_edit_str ]] && ble/decode/has-input &&
    ((0<=bleopt_accept_line_threshold&&bleopt_accept_line_threshold<=_ble_decode_input_count+ble_decode_char_rest)) &&
    return 1
  if shopt -q cmdhist &>/dev/null; then
    ble-edit/content/update-syntax
    ble/syntax:bash/is-complete || return 1
  fi
  return 0
}
function ble/widget/accept-single-line-or {
  ble/decode/widget/keymap-dispatch "$@"
}
function ble/widget/default/accept-single-line-or {
  if ble-edit/is-single-complete-line; then
    ble/widget/accept-line
  else
    ble/widget/"$@"
  fi
}
function ble/widget/accept-single-line-or-newline {
  ble/widget/accept-single-line-or newline
}
function ble/widget/edit-and-execute-command.edit {
  local content=$1 opts=:$2:
  local file=$_ble_base_run/$$.blesh-fc.bash
  ble/util/print "$content" >| "$file"
  local fallback=vi
  if type emacs &>/dev/null; then
    fallback='emacs -nw'
  elif type vim &>/dev/null; then
    fallback=vim
  elif type nano &>/dev/null; then
    fallback=nano
  fi
  [[ $opts == *:no-newline:* ]] ||
    _ble_edit_line_disabled=1 ble/widget/.newline # #D1800 (呼び出し元で exec/register)
  ble/term/leave
  ${bleopt_editor:-${VISUAL:-${EDITOR:-$fallback}}} "$file"; local ext=$?
  ble/term/enter
  if ((ext)); then
    ble/widget/.bell
    return 127
  fi
  ble/util/readfile ret "$file"
  return 0
}
function ble/widget/edit-and-execute-command.impl {
  local ret=
  ble/widget/edit-and-execute-command.edit "$1"
  local command=$ret
  ble/string#match "$command" $'[\n]+$' &&
    command=${command::${#command}-${#BASH_REMATCH}}
  if [[ $command != *[!"$_ble_term_IFS"]* ]]; then
    ble/edit/leave-command-layout
    ble/widget/.bell
    return 1
  fi
  ble/util/buffer.print "${_ble_term_setaf[12]}[ble: fc]$_ble_term_sgr0 $command"
  ble/history/add "$command"
  ble-edit/exec/register "$command"
}
function ble/widget/edit-and-execute-command {
  ble-edit/content/clear-arg
  ble/widget/edit-and-execute-command.impl "$_ble_edit_str"
}
function ble/widget/insert-comment/.remove-comment {
  local comment_begin=$1
  ret=
  [[ $comment_begin ]] || return 1
  ble/string#escape-for-extended-regex "$comment_begin"; local rex_comment_begin=$ret
  local rex1=$'([ \t]*'$rex_comment_begin$')[^\n]*(\n|$)|[ \t]+(\n|$)|\n'
  local rex=$'^('$rex1')*$'; [[ $_ble_edit_str =~ $rex ]] || return 1
  local tail=$_ble_edit_str out=
  while [[ $tail && $tail =~ ^$rex1 ]]; do
    local rematch1=${BASH_REMATCH[1]}
    if [[ $rematch1 ]]; then
      out=$out${rematch1%?}${BASH_REMATCH:${#rematch1}}
    else
      out=$out$BASH_REMATCH
    fi
    tail=${tail:${#BASH_REMATCH}}
  done
  [[ $tail ]] && return 1
  ret=$out
}
function ble/widget/insert-comment/.insert {
  local arg=$1
  local ret='#'; ble/util/read-rl-variable comment-begin
  local comment_begin=${ret::1}
  local text=
  if [[ $arg ]] && ble/widget/insert-comment/.remove-comment "$comment_begin"; then
    text=$ret
  else
    text=$comment_begin${_ble_edit_str//$'\n'/$'\n'"$comment_begin"}
  fi
  ble-edit/content/reset-and-check-dirty "$text"
}
function ble/widget/insert-comment {
  local arg; ble-edit/content/get-arg ''
  ble/widget/insert-comment/.insert "$arg"
  ble/widget/accept-line
}
function ble/widget/alias-expand-line.proc {
  if ((tchild>=0)); then
    ble/syntax/tree-enumerate-children \
      ble/widget/alias-expand-line.proc
  elif [[ $wtype && ! ${wtype//[0-9]} ]] && ((wtype==_ble_ctx_CMDI)); then
    local word=${_ble_edit_str:wbegin:wlen}
    local ret; ble/alias#expand "$word"
    [[ $word == "$ret" ]] && return 0
    changed=1
    ble/widget/.replace-range "$wbegin" $((wbegin+wlen)) "$ret"
  fi
}
function ble/widget/alias-expand-line {
  ble-edit/content/clear-arg
  ble-edit/content/update-syntax
  local iN= changed=
  ble/syntax/tree-enumerate ble/widget/alias-expand-line.proc
  [[ $changed ]] && _ble_edit_mark_active=
}
function ble/widget/tilde-expand {
  ble-edit/content/clear-arg
  ble-edit/content/update-syntax
  local len=${#_ble_edit_str}
  local i=$len j=$len
  while ((--i>=0)); do
    ((_ble_syntax_attr[i])) || continue
    if ((_ble_syntax_attr[i]==_ble_attr_TILDE)); then
      local word=${_ble_edit_str:i:j-i}
      builtin eval "local path=$word"
      [[ $path != "$word" ]] &&
        ble/widget/.replace-range "$i" "$j" "$path"
    fi
    j=$i
  done
}
_ble_edit_shell_expand_ExpandWtype=()
function ble/widget/shell-expand-line.initialize {
  function ble/widget/shell-expand-line.initialize { :; }
  _ble_edit_shell_expand_ExpandWtype[_ble_ctx_CMDI]=1
  _ble_edit_shell_expand_ExpandWtype[_ble_ctx_ARGI]=1
  _ble_edit_shell_expand_ExpandWtype[_ble_ctx_ARGEI]=1
  _ble_edit_shell_expand_ExpandWtype[_ble_ctx_ARGVI]=1
  _ble_edit_shell_expand_ExpandWtype[_ble_ctx_RDRF]=1
  _ble_edit_shell_expand_ExpandWtype[_ble_ctx_RDRD]=1
  _ble_edit_shell_expand_ExpandWtype[_ble_ctx_RDRS]=1
  _ble_edit_shell_expand_ExpandWtype[_ble_ctx_VALI]=1
  _ble_edit_shell_expand_ExpandWtype[_ble_ctx_CONDI]=1
}
function ble/widget/shell-expand-line.expand-word {
  local word=$1
  ble/widget/shell-expand-line.initialize
  if [[ ! ${_ble_edit_shell_expand_ExpandWtype[wtype]} ]]; then
    ret=$word
    return 0
  fi
  ret=$word; [[ $ret == '~'* ]] && ret='\'$word
  ble/syntax:bash/simple-word/eval "$ret" noglob
  if [[ $word != $ret || ${#ret[@]} -ne 1 ]]; then
    [[ $opts == *:quote:* ]] && flags=${flags}q
    return 0
  fi
  if ((wtype==_ble_ctx_CMDI)); then
    ble/alias#expand "$word"
    [[ $word != $ret ]] && return 0
  fi
  ret=$word
}
function ble/widget/shell-expand-line.proc {
  [[ $wtype ]] || return 0
  if [[ ${wtype//[0-9]} ]]; then
    ble/syntax/tree-enumerate-children ble/widget/shell-expand-line.proc
    return 0
  fi
  local word=${_ble_edit_str:wbegin:wlen}
  local rex='^[_a-zA-Z][_a-zA-Z0-9]*=+?\('
  if ((wtype==_ble_attr_VAR)) && [[ $word =~ $rex ]]; then
    ble/syntax/tree-enumerate-children ble/widget/shell-expand-line.proc
    return 0
  fi
  local flags=
  local -a ret=() words=()
  ble/widget/shell-expand-line.expand-word "$word"
  words=("${ret[@]}")
  [[ ${#words[@]} -eq 1 && $word == "$ret" ]] && return 0
  if ((wtype==_ble_ctx_RDRF||wtype==_ble_ctx_RDRD||wtype==_ble_ctx_RDRS)); then
    local IFS=$_ble_term_IFS
    words=("${words[*]}")
  fi
  local q=\' Q="'\''" specialchars='\ ["'\''`$|&;<>()*?!^{,}'
  local w index=0 out=
  for w in "${words[@]}"; do
    ((index++)) && out=$out' '
    [[ $flags == *q* && $w == *["$specialchars"]* ]] && w=$q${w//$q/$Q}$q
    out=$out$w
  done
  changed=1
  ble/widget/.replace-range "$wbegin" $((wbegin+wlen)) "$out"
}
function ble/widget/shell-expand-line {
  local opts=:$1:
  ble-edit/content/clear-arg
  ble/widget/history-expand-line
  ble-edit/content/update-syntax
  local iN= changed=
  ble/syntax/tree-enumerate ble/widget/shell-expand-line.proc
  [[ $changed ]] && _ble_edit_mark_active=
}
_ble_edit_undo=()
_ble_edit_undo_index=0
_ble_edit_undo_history=()
_ble_edit_undo_hindex=
ble/array#push _ble_textarea_local_VARNAMES \
               _ble_edit_undo \
               _ble_edit_undo_index \
               _ble_edit_undo_history \
               _ble_edit_undo_hindex
function ble-edit/undo/.check-hindex {
  local hindex; ble/history/get-index -v hindex
  [[ $_ble_edit_undo_hindex == "$hindex" ]] && return 0
  if [[ $_ble_edit_undo_hindex ]]; then
    local uindex=${_ble_edit_undo_index:-${#_ble_edit_undo[@]}}
    local ret; ble/string#quote-words "$uindex" "${_ble_edit_undo[@]}"
    _ble_edit_undo_history[_ble_edit_undo_hindex]=$ret
  fi
  if [[ ${_ble_edit_undo_history[hindex]} ]]; then
    local data; builtin eval -- "data=(${_ble_edit_undo_history[hindex]})"
    _ble_edit_undo=("${data[@]:1}")
    _ble_edit_undo_index=${data[0]}
  else
    _ble_edit_undo=()
    _ble_edit_undo_index=0
  fi
  _ble_edit_undo_hindex=$hindex
}
function ble-edit/undo/clear-all {
  _ble_edit_undo=()
  _ble_edit_undo_index=0
  _ble_edit_undo_history=()
  _ble_edit_undo_hindex=
}
function ble-edit/undo/history-delete.hook {
  ble/builtin/history/array#delete-hindex _ble_edit_undo_history "$@"
  _ble_edit_undo_hindex=
}
function ble-edit/undo/history-clear.hook {
  ble-edit/undo/clear-all
}
function ble-edit/undo/history-insert.hook {
  ble/builtin/history/array#insert-range _ble_edit_undo_history "$@"
  local beg=$1 len=$2
  [[ $_ble_edit_undo_hindex ]] &&
    ((_ble_edit_undo_hindex>=beg)) &&
    ((_ble_edit_undo_hindex+=len))
}
blehook history_delete+=ble-edit/undo/history-delete.hook
blehook history_clear+=ble-edit/undo/history-clear.hook
blehook history_insert+=ble-edit/undo/history-insert.hook
function ble-edit/undo/.get-current-state {
  if ((_ble_edit_undo_index==0)); then
    str=
    if [[ $_ble_history_prefix || $_ble_history_load_done ]]; then
      local index; ble/history/get-index
      ble/history/get-entry -v str "$index"
    fi
    ind=${#entry}
  else
    local entry=${_ble_edit_undo[_ble_edit_undo_index-1]}
    str=${entry#*:} ind=${entry%%:*}
  fi
}
function ble-edit/undo/add {
  ble-edit/undo/.check-hindex
  local str ind; ble-edit/undo/.get-current-state
  [[ $str == "$_ble_edit_str" ]] && return 0
  _ble_edit_undo[_ble_edit_undo_index++]=$_ble_edit_ind:$_ble_edit_str
  if ((${#_ble_edit_undo[@]}>_ble_edit_undo_index)); then
    _ble_edit_undo=("${_ble_edit_undo[@]::_ble_edit_undo_index}")
  fi
}
function ble-edit/undo/.load {
  local str ind; ble-edit/undo/.get-current-state
  if [[ $bleopt_undo_point == end || $bleopt_undo_point == beg ]]; then
    local old=$_ble_edit_str new=$str ret
    if [[ $bleopt_undo_point == end ]]; then
      ble/string#common-suffix "${old:_ble_edit_ind}" "$new"; local s1=${#ret}
      local old=${old::${#old}-s1} new=${new:${#new}-s1}
      ble/string#common-prefix "${old::_ble_edit_ind}" "$new"; local p1=${#ret}
      local old=${old:p1} new=${new:p1}
      ble/string#common-suffix "$old" "$new"; local s2=${#ret}
      local old=${old::${#old}-s2} new=${new:${#new}-s2}
      ble/string#common-prefix "$old" "$new"; local p2=${#ret}
    else
      ble/string#common-prefix "${old::_ble_edit_ind}" "$new"; local p1=${#ret}
      local old=${old:p1} new=${new:p1}
      ble/string#common-suffix "${old:_ble_edit_ind-p1}" "$new"; local s1=${#ret}
      local old=${old::${#old}-s1} new=${new:${#new}-s1}
      ble/string#common-prefix "$old" "$new"; local p2=${#ret}
      local old=${old:p2} new=${new:p2}
      ble/string#common-suffix "$old" "$new"; local s2=${#ret}
    fi
    local beg=$((p1+p2)) end0=$((${#_ble_edit_str}-s1-s2)) end=$((${#str}-s1-s2))
    ble-edit/content/replace "$beg" "$end0" "${str:beg:end-beg}"
    if [[ $bleopt_undo_point == end ]]; then
      ind=$end
    else
      ind=$beg
    fi
  else
    ble-edit/content/reset-and-check-dirty "$str"
  fi
  _ble_edit_ind=$ind
  return 0
}
function ble-edit/undo/undo {
  local arg=${1:-1}
  ble-edit/undo/.check-hindex
  ble-edit/undo/add # 最後に add/load してから変更があれば記録
  ((_ble_edit_undo_index)) || return 1
  ((_ble_edit_undo_index-=arg))
  ((_ble_edit_undo_index<0&&(_ble_edit_undo_index=0)))
  ble-edit/undo/.load
}
function ble-edit/undo/redo {
  local arg=${1:-1}
  ble-edit/undo/.check-hindex
  ble-edit/undo/add # 最後に add/load してから変更があれば記録
  local ucount=${#_ble_edit_undo[@]}
  ((_ble_edit_undo_index<ucount)) || return 1
  ((_ble_edit_undo_index+=arg))
  ((_ble_edit_undo_index>=ucount&&(_ble_edit_undo_index=ucount)))
  ble-edit/undo/.load
}
function ble-edit/undo/revert {
  ble-edit/undo/.check-hindex
  ble-edit/undo/add # 最後に add/load してから変更があれば記録
  ((_ble_edit_undo_index)) || return 1
  ((_ble_edit_undo_index=0))
  ble-edit/undo/.load
}
function ble-edit/undo/revert-toggle {
  local arg=${1:-1}
  ((arg%2==0)) && return 0
  ble-edit/undo/.check-hindex
  ble-edit/undo/add # 最後に add/load してから変更があれば記録
  if ((_ble_edit_undo_index)); then
    ((_ble_edit_undo_index=0))
    ble-edit/undo/.load
  elif ((${#_ble_edit_undo[@]})); then
    ((_ble_edit_undo_index=${#_ble_edit_undo[@]}))
    ble-edit/undo/.load
  else
    return 1
  fi
}
_ble_edit_kbdmacro_record=
_ble_edit_kbdmacro_last=()
_ble_edit_kbdmacro_onplay=
function ble/widget/start-keyboard-macro {
  ble/keymap:generic/clear-arg
  [[ $_ble_edit_kbdmacro_onplay ]] && return 0 # 再生中は無視
  if ! ble/decode/charlog#start kbd-macro; then
    if [[ $_ble_decode_keylog_chars_enabled == kbd-macro ]]; then
      ble/widget/.bell 'kbd-macro: recording is already started'
    else
      ble/widget/.bell 'kbd-macro: the logging system is currently busy'
    fi
    return 1
  fi
  _ble_edit_kbdmacro_record=1
  if [[ $_ble_decode_keymap == emacs ]]; then
    ble/keymap:emacs/update-mode-name
  elif [[ $_ble_decode_keymap == vi_nmap ]]; then
    ble/keymap:vi/adjust-command-mode
  fi
  return 0
}
function ble/widget/end-keyboard-macro {
  ble/keymap:generic/clear-arg
  [[ $_ble_edit_kbdmacro_onplay ]] && return 0 # 再生中は無視
  if [[ $_ble_decode_keylog_chars_enabled != kbd-macro ]]; then
    ble/widget/.bell 'kbd-macro: recording is not running'
    return 1
  fi
  _ble_edit_kbdmacro_record=
  ble/decode/charlog#end-exclusive-depth1
  _ble_edit_kbdmacro_last=("${ret[@]}")
  if [[ $_ble_decode_keymap == emacs ]]; then
    ble/keymap:emacs/update-mode-name
  elif [[ $_ble_decode_keymap == vi_nmap ]]; then
    ble/keymap:vi/adjust-command-mode
  fi
  return 0
}
function ble/widget/call-keyboard-macro {
  local arg; ble-edit/content/get-arg 1
  ble/keymap:generic/clear-arg
  ((arg>0)) || return 1
  [[ $_ble_edit_kbdmacro_onplay ]] && return 0 # 再生中は無視
  local _ble_edit_kbdmacro_onplay=1
  if ((arg==1)); then
    ble/widget/.MACRO "${_ble_edit_kbdmacro_last[@]}"
  else
    local -a chars=()
    while ((arg-->0)); do
      ble/array#push chars "${_ble_edit_kbdmacro_last[@]}"
    done
    ble/widget/.MACRO "${chars[@]}"
  fi
  [[ $_ble_decode_keymap == vi_nmap ]] &&
    ble/keymap:vi/adjust-command-mode
}
function ble/widget/print-keyboard-macro {
  ble/keymap:generic/clear-arg
  local ret; ble/decode/charlog#encode "${_ble_edit_kbdmacro_last[@]}"
  ble/edit/info/show text "kbd-macro: $ret"
  [[ $_ble_decode_keymap == vi_nmap ]] &&
    ble/keymap:vi/adjust-command-mode
  return 0
}
bleopt/declare -v history_preserve_point ''
function ble-edit/history/goto {
  ble/history/initialize
  local histlen=$_ble_history_COUNT
  local index0=$_ble_history_INDEX
  local index1=$1
  ((index0==index1)) && return 0
  if ((index1>histlen)); then
    index1=$histlen
    ble/widget/.bell
  elif ((index1<0)); then
    index1=0
    ble/widget/.bell
  fi
  ((index0==index1)) && return 0
  if [[ $bleopt_history_share && ! $_ble_history_prefix && $_ble_decode_keymap != isearch ]]; then
    if ((index0==histlen||index1==histlen)); then
      ble/builtin/history/option:n
      local histlen2=$_ble_history_COUNT
      if ((histlen!=histlen2)); then
        ble/textarea#invalidate
        ble-edit/history/goto $((index1==histlen?histlen:index1))
        return "$?"
      fi
    fi
  fi
  ble/history/set-edited-entry "$index0" "$_ble_edit_str"
  ble/history/onleave.fire
  ble/history/set-index "$index1"
  local entry; ble/history/get-edited-entry -v entry "$index1"
  ble-edit/content/reset "$entry" history
  if [[ $bleopt_history_preserve_point ]]; then
    if ((_ble_edit_ind>${#_ble_edit_str})); then
      _ble_edit_ind=${#_ble_edit_str}
    fi
  else
    if ((index1<index0)); then
      _ble_edit_ind=${#_ble_edit_str}
    else
      local first_line=${_ble_edit_str%%$'\n'*}
      _ble_edit_ind=${#first_line}
    fi
  fi
  _ble_edit_mark=0
  _ble_edit_mark_active=
}
function ble-edit/history/history-message.hook {
  ((_ble_edit_attached)) || return 1
  local message=$1
  if [[ $message ]]; then
    ble/edit/info/immediate-show text "$message"
  else
    ble/edit/info/immediate-default
  fi
}
blehook history_message+=ble-edit/history/history-message.hook
function ble/widget/history-next {
  if [[ $_ble_history_prefix || $_ble_history_load_done ]]; then
    local arg; ble-edit/content/get-arg 1
    ble/history/initialize
    ble-edit/history/goto $((_ble_history_INDEX+arg))
  else
    ble-edit/content/clear-arg
    ble/widget/.bell
  fi
}
function ble/widget/history-prev {
  local arg; ble-edit/content/get-arg 1
  ble/history/initialize
  ble-edit/history/goto $((_ble_history_INDEX-arg))
}
function ble/widget/history-beginning {
  ble-edit/content/clear-arg
  ble-edit/history/goto 0
}
function ble/widget/history-end {
  ble-edit/content/clear-arg
  if [[ $_ble_history_prefix || $_ble_history_load_done ]]; then
    ble/history/initialize
    ble-edit/history/goto "$_ble_history_COUNT"
  else
    ble/widget/.bell
  fi
}
function ble/widget/history-expand-line {
  ble-edit/content/clear-arg
  local hist_expanded
  ble-edit/hist_expanded.update "$_ble_edit_str" || return 1
  [[ $_ble_edit_str == "$hist_expanded" ]] && return 1
  ble-edit/content/reset-and-check-dirty "$hist_expanded"
  _ble_edit_ind=${#hist_expanded}
  _ble_edit_mark=0
  _ble_edit_mark_active=
  return 0
}
function ble/widget/history-and-alias-expand-line {
  ble/widget/history-expand-line
  ble/widget/alias-expand-line
}
function ble/widget/history-expand-backward-line {
  ble-edit/content/clear-arg
  local prevline=${_ble_edit_str::_ble_edit_ind} hist_expanded
  ble-edit/hist_expanded.update "$prevline" || return 1
  [[ $prevline == "$hist_expanded" ]] && return 1
  local ret
  ble/string#common-prefix "$prevline" "$hist_expanded"; local dmin=${#ret}
  local insert; ble-edit/content/replace-limited "$dmin" "$_ble_edit_ind" "${hist_expanded:dmin}"
  ((_ble_edit_ind=dmin+${#insert}))
  _ble_edit_mark=0
  _ble_edit_mark_active=
  return 0
}
function ble/widget/magic-space {
  [[ $_ble_decode_keymap == vi_imap ]] &&
    local oind=$_ble_edit_ind ostr=$_ble_edit_str
  local arg; ble-edit/content/get-arg ''
  ble/widget/history-expand-backward-line ||
    ble/complete/sabbrev/expand
  local ext=$?
  ((ext==147)) && return 147 # sabbrev/expand でメニュー補完に入った時など。
  [[ $_ble_decode_keymap == vi_imap ]] &&
    if [[ $ostr != "$_ble_edit_str" ]]; then
      _ble_edit_ind=$oind _ble_edit_str=$ostr ble/keymap:vi/undo/add more
      ble/keymap:vi/undo/add more
    fi
  local -a KEYS=(32)
  _ble_edit_arg=$arg
  ble/widget/self-insert
}
function ble/highlight/layer:region/mark:search/get-face { face=region_match; }
function ble-edit/isearch/search {
  local needle=$1 opts=$2
  beg= end=
  [[ :$opts: != *:regex:* ]]; local has_regex=$?
  [[ :$opts: != *:extend:* ]]; local has_extend=$?
  local flag_empty_retry=
  if [[ :$opts: == *:-:* ]]; then
    local start=$((has_extend?_ble_edit_mark+1:_ble_edit_ind))
    if ((has_regex)); then
      ble-edit/isearch/.shift-backward-references
      local rex="^.*($needle)" padding=$((${#_ble_edit_str}-start))
      ((padding)) && rex="$rex.{$padding}"
      if [[ $_ble_edit_str =~ $rex ]]; then
        local rematch1=${BASH_REMATCH[1]}
        if [[ $rematch1 || $BASH_REMATCH == "$_ble_edit_str" || :$opts: == *:allow_empty:* ]]; then
          ((end=${#BASH_REMATCH}-padding,
            beg=end-${#rematch1}))
          return 0
        else
          flag_empty_retry=1
        fi
      fi
    else
      if [[ $needle ]]; then
        local target=${_ble_edit_str::start}
        local m=${target%"$needle"*}
        if [[ $target != "$m" ]]; then
          beg=${#m}
          end=$((beg+${#needle}))
          return 0
        fi
      else
        if [[ :$opts: == *:allow_empty:* ]] || ((--start>=0)); then
          ((beg=end=start))
          return 0
        fi
      fi
    fi
  elif [[ :$opts: == *:B:* ]]; then
    local start=$((has_extend?_ble_edit_ind:_ble_edit_ind-1))
    ((start<0)) && return 1
    if ((has_regex)); then
      ble-edit/isearch/.shift-backward-references
      local rex="^.{0,$start}($needle)"
      ((start==0)) && rex="^($needle)"
      if [[ $_ble_edit_str =~ $rex ]]; then
        local rematch1=${BASH_REMATCH[1]}
        if [[ $rematch1 || :$opts: == *:allow_empty:* ]]; then
          ((end=${#BASH_REMATCH},
            beg=end-${#rematch1}))
          return 0
        else
          flag_empty_retry=1
        fi
      fi
    else
      if [[ $needle ]]; then
        local target=${_ble_edit_str::start+${#needle}}
        local m=${target%"$needle"*}
        if [[ $target != "$m" ]]; then
          ((beg=${#m},
            end=beg+${#needle}))
          return 0
        fi
      else
        if [[ :$opts: == *:allow_empty:* ]] && ((--start>=0)); then
          ((beg=end=start))
          return 0
        fi
      fi
    fi
  else
    local start=$((has_extend?_ble_edit_mark:_ble_edit_ind))
    if ((has_regex)); then
      ble-edit/isearch/.shift-backward-references
      local rex="($needle).*\$"
      ((start)) && rex=".{$start}$rex"
      if [[ $_ble_edit_str =~ $rex ]]; then
        local rematch1=${BASH_REMATCH[1]}
        if [[ $rematch1 || :$opts: == *:allow_empty:* ]]; then
          ((beg=${#_ble_edit_str}-${#BASH_REMATCH}+start))
          ((end=beg+${#rematch1}))
          return 0
        else
          flag_empty_retry=1
        fi
      fi
    else
      if [[ $needle ]]; then
        local target=${_ble_edit_str:start}
        local m=${target#*"$needle"}
        if [[ $target != "$m" ]]; then
          ((end=${#_ble_edit_str}-${#m}))
          ((beg=end-${#needle}))
          return 0
        fi
      else
        if [[ :$opts: == *:allow_empty:* ]] || ((++start<=${#_ble_edit_str})); then
          ((beg=end=start))
          return 0
        fi
      fi
    fi
  fi
  if [[ $flag_empty_retry ]]; then
    if [[ :$opts: == *:[-B]:* ]]; then
      if ((--start>=0)); then
        local mark=$_ble_edit_mark; ((mark&&mark--))
        local ind=$_ble_edit_ind; ((ind&&ind--))
        opts=$opts:allow_empty
        _ble_edit_mark=$mark _ble_edit_ind=$ind ble-edit/isearch/search "$needle" "$opts"
        return 0
      fi
    else
      if ((++start<=${#_ble_edit_str})); then
        local mark=$_ble_edit_mark; ((mark<${#_ble_edit_str}&&mark++))
        local ind=$_ble_edit_ind; ((ind<${#_ble_edit_str}&&ind++))
        opts=$opts:allow_empty
        _ble_edit_mark=$mark _ble_edit_ind=$ind ble-edit/isearch/search "$needle" "$opts"
        return 0
      fi
    fi
  fi
  return 1
}
function ble-edit/isearch/.shift-backward-references {
    local rex_cc='\[[@][^]@]+[@]\]' # [:space:] [=a=] [.a.] など。
    local rex_bracket_expr='\[\^?]?('${rex_cc//@/:}'|'${rex_cc//@/=}'|'${rex_cc//@/.}'|[^][]|\[[^]:=.])*\[?\]'
    local rex='^('$rex_bracket_expr'|\\[^1-8])*\\[1-8]'
    local buff=
    while [[ $needle =~ $rex ]]; do
      local mlen=${#BASH_REMATCH}
      buff=$buff${BASH_REMATCH::mlen-1}$((10#0${BASH_REMATCH:mlen-1}+1))
      needle=${needle:mlen}
    done
    needle=$buff$needle
}
_ble_edit_isearch_str=
_ble_edit_isearch_dir=-
_ble_edit_isearch_arr=()
_ble_edit_isearch_old=
function ble-edit/isearch/status/append-progress-bar {
  ble/util/is-unicode-output || return 1
  local pos=$1 count=$2 dir=$3
  [[ :$dir: == *:-:* || :$dir: == *:backward:* ]] && ((pos=count-1-pos))
  local ret; ble/string#create-unicode-progress-bar "$pos" "$count" 5
  text=$text$' \e[1;38;5;69;48;5;253m'$ret$'\e[m '
}
function ble-edit/isearch/.show-status-with-progress.fib {
  local ll rr
  if [[ $_ble_edit_isearch_dir == - ]]; then
    ll=\<\< rr="  "
  else
    ll="  " rr=">>"
  fi
  local index; ble/history/get-index
  local histIndex='!'$((index+1))
  local text="(${#_ble_edit_isearch_arr[@]}: $ll $histIndex $rr) \`$_ble_edit_isearch_str'"
  if [[ $1 ]]; then
    local pos=$1
    local count; ble/history/get-count
    text=$text' searching...'
    ble-edit/isearch/status/append-progress-bar "$pos" "$count" "$_ble_edit_isearch_dir"
    local percentage=$((count?pos*1000/count:1000))
    text=$text" @$pos ($((percentage/10)).$((percentage%10))%)"
  fi
  ((fib_ntask)) && text="$text *$fib_ntask"
  ble/edit/info/show ansi "$text"
}
function ble-edit/isearch/.show-status.fib {
  ble-edit/isearch/.show-status-with-progress.fib
}
function ble-edit/isearch/show-status {
  local fib_ntask=${#_ble_util_fiberchain[@]}
  ble-edit/isearch/.show-status.fib
}
function ble-edit/isearch/erase-status {
  ble/edit/info/default
}
function ble-edit/isearch/.set-region {
  local beg=$1 end=$2
  if ((beg<end)); then
    if [[ $_ble_edit_isearch_dir == - ]]; then
      _ble_edit_ind=$beg
      _ble_edit_mark=$end
    else
      _ble_edit_ind=$end
      _ble_edit_mark=$beg
    fi
    _ble_edit_mark_active=search
  elif ((beg==end)); then
    _ble_edit_ind=$beg
    _ble_edit_mark=$beg
    _ble_edit_mark_active=
  else
    _ble_edit_mark_active=
  fi
}
function ble-edit/isearch/.push-isearch-array {
  local hash=$beg:$end:$needle
  local ilast=$((${#_ble_edit_isearch_arr[@]}-1))
  if ((ilast>=0)) && [[ ${_ble_edit_isearch_arr[ilast]} == "$ind:"[-+]":$hash" ]]; then
    builtin unset -v "_ble_edit_isearch_arr[$ilast]"
    return 0
  fi
  local oind; ble/history/get-index -v oind
  local obeg=$_ble_edit_ind oend=$_ble_edit_mark
  [[ $_ble_edit_mark_active ]] || oend=$obeg
  ((obeg>oend)) && local obeg=$oend oend=$obeg
  local oneedle=$_ble_edit_isearch_str
  local ohash=$obeg:$oend:$oneedle
  [[ $ind == "$oind" && $hash == "$ohash" ]] && return 0
  ble/array#push _ble_edit_isearch_arr "$oind:$_ble_edit_isearch_dir:$ohash"
}
function ble-edit/isearch/.goto-match.fib {
  local ind=$1 beg=$2 end=$3 needle=$4
  ble-edit/isearch/.push-isearch-array
  _ble_edit_isearch_str=$needle
  [[ $needle ]] && _ble_edit_isearch_old=$needle
  local oind; ble/history/get-index -v oind
  ((oind!=ind)) && ble-edit/history/goto "$ind"
  ble-edit/isearch/.set-region "$beg" "$end"
  ble-edit/isearch/.show-status.fib
  ble/textarea#redraw
}
function ble-edit/isearch/.next.fib {
  local opts=$1
  if [[ ! $fib_suspend ]]; then
    if [[ :$opts: == *:forward:* || :$opts: == *:backward:* ]]; then
      if [[ :$opts: == *:forward:* ]]; then
        _ble_edit_isearch_dir=+
      else
        _ble_edit_isearch_dir=-
      fi
    fi
    local needle=${2-$_ble_edit_isearch_str}
    local beg= end= search_opts=$_ble_edit_isearch_dir
    if [[ :$opts: == *:append:* ]]; then
      search_opts=$search_opts:extend
      ble/path#remove opts append
    fi
    if [[ $needle ]] && ble-edit/isearch/search "$needle" "$search_opts"; then
      local ind; ble/history/get-index -v ind
      ble-edit/isearch/.goto-match.fib "$ind" "$beg" "$end" "$needle"
      return 0
    fi
  fi
  ble-edit/isearch/.next-history.fib "$opts" "$needle"
}
function ble-edit/isearch/.next-history.fib {
  local opts=$1
  if [[ $fib_suspend ]]; then
    local needle=${fib_suspend#*:} isAdd=
    local index start; builtin eval -- "${fib_suspend%%:*}"
    fib_suspend=
  else
    local needle=${2-$_ble_edit_isearch_str} isAdd=
    [[ :$opts: == *:append:* ]] && isAdd=1
    ble/history/initialize
    local start=$_ble_history_INDEX
    local index=$start
  fi
  if ((!isAdd)); then
    if [[ $_ble_edit_isearch_dir == - ]]; then
      ((index--))
    else
      ((index++))
    fi
  fi
  local isearch_progress_callback=ble-edit/isearch/.show-status-with-progress.fib
  if [[ $_ble_edit_isearch_dir == - ]]; then
    ble/history/isearch-backward-blockwise stop_check:progress
  else
    ble/history/isearch-forward stop_check:progress
  fi
  local ext=$?
  if ((ext==0)); then
    local str; ble/history/get-edited-entry -v str "$index"
    if [[ $needle ]]; then
      if [[ $_ble_edit_isearch_dir == - ]]; then
        local prefix=${str%"$needle"*}
      else
        local prefix=${str%%"$needle"*}
      fi
      local beg=${#prefix} end=$((${#prefix}+${#needle}))
    else
      local beg=${#str} end=${#str}
    fi
    ble-edit/isearch/.goto-match.fib "$index" "$beg" "$end" "$needle"
  elif ((ext==148)); then
    fib_suspend="index=$index start=$start:$needle"
    return 0
  else
    ble/widget/.bell "isearch: \`$needle' not found"
    return 0
  fi
}
function ble-edit/isearch/forward.fib {
  if [[ ! $_ble_edit_isearch_str ]]; then
    ble-edit/isearch/.next.fib forward "$_ble_edit_isearch_old"
  else
    ble-edit/isearch/.next.fib forward
  fi
}
function ble-edit/isearch/backward.fib {
  if [[ ! $_ble_edit_isearch_str ]]; then
    ble-edit/isearch/.next.fib backward "$_ble_edit_isearch_old"
  else
    ble-edit/isearch/.next.fib backward
  fi
}
function ble-edit/isearch/self-insert.fib {
  local needle=
  if [[ ! $fib_suspend ]]; then
    local code=$1
    ((code==0)) && return 0
    local ret; ble/util/c2s "$code"
    needle=$_ble_edit_isearch_str$ret
  fi
  ble-edit/isearch/.next.fib append "$needle"
}
function ble-edit/isearch/insert-string.fib {
  local needle=
  [[ ! $fib_suspend ]] &&
    needle=$_ble_edit_isearch_str$1
  ble-edit/isearch/.next.fib append "$needle"
}
function ble-edit/isearch/history-forward.fib {
  _ble_edit_isearch_dir=+
  ble-edit/isearch/.next-history.fib
}
function ble-edit/isearch/history-backward.fib {
  _ble_edit_isearch_dir=-
  ble-edit/isearch/.next-history.fib
}
function ble-edit/isearch/history-self-insert.fib {
  local needle=
  if [[ ! $fib_suspend ]]; then
    local code=$1
    ((code==0)) && return 0
    local ret; ble/util/c2s "$code"
    needle=$_ble_edit_isearch_str$ret
  fi
  ble-edit/isearch/.next-history.fib append "$needle"
}
function ble-edit/isearch/prev {
  local sz=${#_ble_edit_isearch_arr[@]}
  ((sz==0)) && return 0
  local ilast=$((sz-1))
  local top=${_ble_edit_isearch_arr[ilast]}
  builtin unset -v '_ble_edit_isearch_arr[ilast]'
  local ind dir beg end
  ind=${top%%:*}; top=${top#*:}
  dir=${top%%:*}; top=${top#*:}
  beg=${top%%:*}; top=${top#*:}
  end=${top%%:*}; top=${top#*:}
  _ble_edit_isearch_dir=$dir
  ble-edit/history/goto "$ind"
  ble-edit/isearch/.set-region "$beg" "$end"
  _ble_edit_isearch_str=$top
  [[ $top ]] && _ble_edit_isearch_old=$top
  ble-edit/isearch/show-status
}
function ble-edit/isearch/process {
  local isearch_time=0
  ble/util/fiberchain#resume
  ble-edit/isearch/show-status
}
function ble/widget/isearch/forward {
  ble/util/fiberchain#push forward
  ble-edit/isearch/process
}
function ble/widget/isearch/backward {
  ble/util/fiberchain#push backward
  ble-edit/isearch/process
}
function ble/widget/isearch/self-insert {
  local code; ble/widget/self-insert/.get-code
  ((code==0)) && return 0
  ble/util/fiberchain#push "self-insert $code"
  ble-edit/isearch/process
}
function ble/widget/isearch/history-forward {
  ble/util/fiberchain#push history-forward
  ble-edit/isearch/process
}
function ble/widget/isearch/history-backward {
  ble/util/fiberchain#push history-backward
  ble-edit/isearch/process
}
function ble/widget/isearch/history-self-insert {
  local code; ble/widget/self-insert/.get-code
  ((code==0)) && return 0
  ble/util/fiberchain#push "history-self-insert $code"
  ble-edit/isearch/process
}
function ble/widget/isearch/prev {
  local nque
  if ((nque=${#_ble_util_fiberchain[@]})); then
    local ret; ble/array#pop _ble_util_fiberchain
    ble-edit/isearch/process
  else
    ble-edit/isearch/prev
  fi
}
function ble/widget/isearch/.restore-mark-state {
  local old_mark_active=${_ble_edit_isearch_save[3]}
  if [[ $old_mark_active ]]; then
    local index; ble/history/get-index
    if ((index==_ble_edit_isearch_save[0])); then
      _ble_edit_mark=${_ble_edit_isearch_save[2]}
      if [[ $old_mark_active != S ]] || ((_ble_edit_ind==_ble_edit_isearch_save[1])); then
        _ble_edit_mark_active=$old_mark_active
      fi
    fi
  fi
}
function ble/widget/isearch/exit.impl {
  ble/decode/keymap/pop
  _ble_edit_isearch_arr=()
  _ble_edit_isearch_dir=
  _ble_edit_isearch_str=
  ble-edit/isearch/erase-status
}
function ble/widget/isearch/exit-with-region {
  ble/widget/isearch/exit.impl
  [[ $_ble_edit_mark_active ]] &&
    _ble_edit_mark_active=S
}
function ble/widget/isearch/exit {
  ble/widget/isearch/exit.impl
  _ble_edit_mark_active=
  ble/widget/isearch/.restore-mark-state
}
function ble/widget/isearch/cancel {
  if ((${#_ble_util_fiberchain[@]})); then
    ble/util/fiberchain#clear
    ble-edit/isearch/show-status # 進捗状況だけ消去
  else
    if ((${#_ble_edit_isearch_arr[@]})); then
      local step
      ble/string#split step : "${_ble_edit_isearch_arr[0]}"
      ble-edit/history/goto "${step[0]}"
    fi
    ble/widget/isearch/exit.impl
    _ble_edit_ind=${_ble_edit_isearch_save[1]}
    _ble_edit_mark=${_ble_edit_isearch_save[2]}
    _ble_edit_mark_active=${_ble_edit_isearch_save[3]}
  fi
}
function ble/widget/isearch/exit-default {
  ble/widget/isearch/exit-with-region
  ble/decode/widget/skip-lastwidget
  ble/decode/widget/redispatch-by-keys "${KEYS[@]}"
}
function ble/widget/isearch/accept-line {
  if ((${#_ble_util_fiberchain[@]})); then
    ble/widget/.bell "isearch: now searching..."
  else
    ble/widget/isearch/exit
    ble-decode-key 13 # RET
  fi
}
function ble/widget/isearch/exit-delete-forward-char {
  ble/widget/isearch/exit
  ble/widget/delete-forward-char
}
function ble/widget/history-isearch.impl {
  local opts=$1
  ble/keymap:generic/clear-arg
  ble/decode/keymap/push isearch
  ble/util/fiberchain#initialize ble-edit/isearch
  local index; ble/history/get-index
  _ble_edit_isearch_save=("$index" "$_ble_edit_ind" "$_ble_edit_mark" "$_ble_edit_mark_active")
  if [[ :$opts: == *:forward:* ]]; then
    _ble_edit_isearch_dir=+
  else
    _ble_edit_isearch_dir=-
  fi
  _ble_edit_isearch_arr=()
  _ble_edit_mark=$_ble_edit_ind
  ble-edit/isearch/show-status
}
function ble/widget/history-isearch-backward {
  ble/widget/history-isearch.impl backward
}
function ble/widget/history-isearch-forward {
  ble/widget/history-isearch.impl forward
}
function ble-decode/keymap:isearch/define {
  ble-bind -f __defchar__ isearch/self-insert
  ble-bind -f __line_limit__ nop
  ble-bind -f C-r         isearch/backward
  ble-bind -f C-s         isearch/forward
  ble-bind -f 'C-?'       isearch/prev
  ble-bind -f 'DEL'       isearch/prev
  ble-bind -f 'C-h'       isearch/prev
  ble-bind -f 'BS'        isearch/prev
  ble-bind -f __default__ isearch/exit-default
  ble-bind -f 'C-g'       isearch/cancel
  ble-bind -f 'C-x C-g'   isearch/cancel
  ble-bind -f 'C-M-g'     isearch/cancel
  ble-bind -f C-m         isearch/exit
  ble-bind -f RET         isearch/exit
  ble-bind -f C-j         isearch/accept-line
  ble-bind -f C-RET       isearch/accept-line
}
_ble_edit_nsearch_input=
_ble_edit_nsearch_needle=
_ble_edit_nsearch_index0=
_ble_edit_nsearch_opts=
_ble_edit_nsearch_stack=()
_ble_edit_nsearch_match=
_ble_edit_nsearch_index=
_ble_edit_nsearch_prev=
function ble/highlight/layer:region/mark:nsearch/get-face {
  face=region_match
}
function ble/highlight/layer:region/mark:nsearch/get-selection {
  local beg=$_ble_edit_mark
  local end=$((_ble_edit_mark+${#_ble_edit_nsearch_needle}))
  selection=("$beg" "$end")
}
function ble-edit/nsearch/.show-status.fib {
  [[ :$_ble_edit_nsearch_opts: == *:hide-status:* ]] && return 0
  local ll=\<\< rr=">>" # Note: Emacs workaround: '<<' や "<<" と書けない。
  local match=$_ble_edit_nsearch_match index0=$_ble_edit_nsearch_index0
  if ((match>index0)); then
    ll="  "
  elif ((match<index0)); then
    rr="  "
  fi
  local sindex='!'$((_ble_edit_nsearch_match+1))
  local nmatch=${#_ble_edit_nsearch_stack[@]}
  local needle=$_ble_edit_nsearch_needle
  local text="(nsearch#$nmatch: $ll $sindex $rr) \`$needle'"
  if [[ $1 ]]; then
    local pos=$1
    local count; ble/history/get-count
    text=$text' searching...'
    ble-edit/isearch/status/append-progress-bar "$pos" "$count" "$_ble_edit_isearch_opts"
    local percentage=$((count?pos*1000/count:1000))
    text=$text" @$pos ($((percentage/10)).$((percentage%10))%)"
  fi
  local ntask=$fib_ntask
  ((ntask)) && text="$text *$ntask"
  ble/edit/info/show ansi "$text"
}
function ble-edit/nsearch/show-status {
  local fib_ntask=${#_ble_util_fiberchain[@]}
  ble-edit/nsearch/.show-status.fib
}
function ble-edit/nsearch/erase-status {
  ble/edit/info/default
}
function ble-edit/nsearch/.goto-match {
  local index=$1 opts=$2
  local direction=backward
  [[ :$opts: == *:forward:* ]] && direction=forward
  local needle=$_ble_edit_nsearch_needle
  local old_match=$_ble_edit_nsearch_match
  ble/array#push _ble_edit_nsearch_stack "$direction,$old_match,$_ble_edit_ind,$_ble_edit_mark:$_ble_edit_str"
  if [[ ! $index ]]; then
    ble/history/get-index
  elif [[ :$opts: == *:action=load:* ]]; then
    local old_index; ble/history/get-index -v old_index
    if ((index!=old_index)); then
      local line; ble/history/get-edited-entry -v line "$index"
      ble-edit/content/reset-and-check-dirty "$line"
    fi
  else
    ble-edit/history/goto "$index"
  fi
  local prefix=${_ble_edit_str%%"$needle"*}
  local beg=${#prefix}
  local end=$((beg+${#needle}))
  _ble_edit_nsearch_match=$index
  _ble_edit_nsearch_index=$index
  _ble_edit_mark=$beg
  local is_end_marker=
  local rex=':point=([^:]*):'
  [[ :$opts: =~ $rex ]]
  case ${BASH_REMATCH[1]} in
  (begin)       _ble_edit_ind=0 ;;
  (end)         _ble_edit_ind=${#_ble_edit_str} is_end_marker=1 ;;
  (match-begin) _ble_edit_ind=$beg ;;
  (match-end|*) _ble_edit_ind=$end is_end_marker=1 ;;
  esac
  if [[ $is_end_marker ]] && ((_ble_edit_ind)); then
    if local ret; ble/decode/keymap/get-parent; [[ $ret == vi_[noxs]map ]]; then
      ble-edit/content/bolp || ((_ble_edit_ind--))
    fi
  fi
  if ((beg!=end)); then
    _ble_edit_mark_active=nsearch
  else
    _ble_edit_mark_active=
  fi
}
function ble-edit/nsearch/.search.fib {
  local opts=$1
  local opt_forward=
  [[ :$opts: == *:forward:* ]] && opt_forward=1
  local nstack=${#_ble_edit_nsearch_stack[@]}
  if ((nstack>=2)); then
    local record_type=${_ble_edit_nsearch_stack[nstack-1]%%,*}
    if
      if [[ $opt_forward ]]; then
        [[ $record_type == backward ]]
      else
        [[ $record_type == forward ]]
      fi
    then
      local ret; ble/array#pop _ble_edit_nsearch_stack
      local record line=${ret#*:}
      ble/string#split record , "${ret%%:*}"
      if [[ :$opts: == *:action=load:* ]]; then
        ble-edit/content/reset-and-check-dirty "$line"
      else
        ble-edit/history/goto "${record[1]}"
      fi
      _ble_edit_nsearch_match=${record[1]}
      _ble_edit_nsearch_index=${record[1]}
      _ble_edit_ind=${record[2]}
      _ble_edit_mark=${record[3]}
      if ((_ble_edit_mark!=_ble_edit_ind)); then
        _ble_edit_mark_active=nsearch
      else
        _ble_edit_mark_active=
      fi
      ble-edit/nsearch/.show-status.fib
      ble/textarea#redraw
      fib_suspend=
      return 0
    fi
  fi
  local index start opt_resume=
  if [[ $fib_suspend ]]; then
    opt_resume=1
    builtin eval -- "$fib_suspend"
    fib_suspend=
  else
    local index=$_ble_edit_nsearch_index
    if ((nstack==1)); then
      local index0=$_ble_edit_nsearch_index0
      ((opt_forward?index<index0:index>index0)) &&
        index=$index0
    fi
    local start=$index
  fi
  local needle=$_ble_edit_nsearch_needle
  if
    if [[ $opt_forward ]]; then
      local count; ble/history/get-count
      [[ $opt_resume ]] || ((++index))
      ((index<=count))
    else
      [[ $opt_resume ]] || ((--index))
      ((index>=0))
    fi
  then
    local isearch_time=$fib_clock
    local isearch_progress_callback=ble-edit/nsearch/.show-status.fib
    local isearch_opts=stop_check:progress; [[ :$opts: != *:substr:* ]] && isearch_opts=$isearch_opts:head
    if [[ $opt_forward ]]; then
      ble/history/isearch-forward "$isearch_opts"; local ext=$?
    else
      ble/history/isearch-backward-blockwise "$isearch_opts"; local ext=$?
    fi
    fib_clock=$isearch_time
  else
    local ext=1
  fi
  if ((ext==0)); then
    ble-edit/nsearch/.goto-match "$index" "$opts"
    ble-edit/nsearch/.show-status.fib
    ble/textarea#redraw
  elif ((ext==148)); then
    fib_suspend="index=$index start=$start"
    return 148
  else
    ble/widget/.bell "ble.sh: nsearch: '$needle' not found"
    ble-edit/nsearch/.show-status.fib
    if [[ $opt_forward ]]; then
      local count; ble/history/get-count
      ((_ble_edit_nsearch_index=count-1))
    else
      ((_ble_edit_nsearch_index=0))
    fi
    return "$ext"
  fi
}
function ble-edit/nsearch/forward.fib {
  ble-edit/nsearch/.search.fib "$_ble_edit_nsearch_opts:forward"
}
function ble-edit/nsearch/backward.fib {
  ble-edit/nsearch/.search.fib "$_ble_edit_nsearch_opts:backward"
}
function ble/widget/history-search {
  local opts=$1
  if [[ :$opts: == *:input:* || :$opts: == *:again:* && ! $_ble_edit_nsearch_input ]]; then
    ble/builtin/read -ep "nsearch> " _ble_edit_nsearch_needle || return 1
    _ble_edit_nsearch_input=$_ble_edit_nsearch_needle
  elif [[ :$opts: == *:again:* ]]; then
    _ble_edit_nsearch_needle=$_ble_edit_nsearch_input
  else
    local len=$_ble_edit_ind
    if [[ $_ble_decode_keymap == vi_[noxs]map ]]; then
      ble-edit/content/eolp || ((len++))
    fi
    _ble_edit_nsearch_needle=${_ble_edit_str::len}
  fi
  if [[ ! $_ble_edit_nsearch_needle ]]; then
    local empty=empty-search
    local rex='.*:empty=([^:]*):'
    [[ :$opts: =~ $rex ]] && empty=${BASH_REMATCH[1]}
    case $empty in
    (history-move)
      if [[ :$opts: == *:forward:* ]]; then
        ble/widget/history-next
      else
        ble/widget/history-prev
      fi && _ble_edit_ind=0
      return $? ;;
    (hide-status)
      opts=$opts:hide-status ;;
    (emulate-readline)
      opts=hide-status:point=end:$opts ;;
    (previous-search)
      _ble_edit_nsearch_needle=$_ble_edit_nsearch_prev ;;
    esac
  fi
  _ble_edit_nsearch_prev=$_ble_edit_nsearch_needle
  ble/keymap:generic/clear-arg
  _ble_edit_nsearch_stack=()
  local index; ble/history/get-index
  _ble_edit_nsearch_index0=$index
  _ble_edit_nsearch_opts=$opts
  ble/path#remove _ble_edit_nsearch_opts forward
  ble/path#remove _ble_edit_nsearch_opts backward
  _ble_edit_nsearch_match=$index
  _ble_edit_nsearch_index=$index
  _ble_edit_mark_active=
  ble/decode/keymap/push nsearch
  if
    if [[ :$opts: == *:substr:* ]]; then
      [[ $_ble_edit_str == *"$_ble_edit_nsearch_needle"* ]]
    else
      [[ $_ble_edit_str == "$_ble_edit_nsearch_needle"* ]]
    fi
  then
    ble-edit/nsearch/.goto-match '' "$opts"
  fi
  ble/util/fiberchain#initialize ble-edit/nsearch
  if [[ :$opts: == *:forward:* ]]; then
    ble/util/fiberchain#push forward
  else
    ble/util/fiberchain#push backward
  fi
  ble/util/fiberchain#resume
}
function ble/widget/history-nsearch-backward {
  ble/widget/history-search "input:substr:backward:$1"
}
function ble/widget/history-nsearch-forward {
  ble/widget/history-search "input:substr:forward:$1"
}
function ble/widget/history-nsearch-backward-again {
  ble/widget/history-search "again:substr:backward:$1"
}
function ble/widget/history-nsearch-forward-again {
  ble/widget/history-search "again:substr:forward:$1"
}
function ble/widget/history-search-backward {
  ble/widget/history-search "backward:$1"
}
function ble/widget/history-search-forward {
  ble/widget/history-search "forward:$1"
}
function ble/widget/history-substring-search-backward {
  ble/widget/history-search "substr:backward:$1"
}
function ble/widget/history-substring-search-forward {
  ble/widget/history-search "substr:forward:$1"
}
function ble/widget/nsearch/forward {
  local ntask=${#_ble_util_fiberchain[@]}
  if ((ntask>=1)) && [[ ${_ble_util_fiberchain[ntask-1]%%:*} == backward ]]; then
    local ret; ble/array#pop _ble_util_fiberchain
  else
    ble/util/fiberchain#push forward
  fi
  ble/util/fiberchain#resume
}
function ble/widget/nsearch/backward {
  local ntask=${#_ble_util_fiberchain[@]}
  if ((ntask>=1)) && [[ ${_ble_util_fiberchain[ntask-1]%%:*} == forward ]]; then
    local ret; ble/array#pop _ble_util_fiberchain
  else
    ble/util/fiberchain#push backward
  fi
  ble/util/fiberchain#resume
}
function ble/widget/nsearch/.exit {
  ble/decode/keymap/pop
  _ble_edit_mark_active=
  ble-edit/nsearch/erase-status
}
function ble/widget/nsearch/exit {
  if [[ :$_ble_edit_nsearch_opts: == *:immediate-accept:* ]]; then
    ble/widget/nsearch/accept-line
  else
    ble/widget/nsearch/.exit
  fi
}
function ble/widget/nsearch/exit-default {
  ble/widget/nsearch/.exit
  ble/decode/widget/skip-lastwidget
  ble/decode/widget/redispatch-by-keys "${KEYS[@]}"
}
function ble/widget/nsearch/cancel {
  if ((${#_ble_util_fiberchain[@]})); then
    ble/util/fiberchain#clear
    ble-edit/nsearch/show-status
  else
    ble/widget/nsearch/.exit
    local record=${_ble_edit_nsearch_stack[0]}
    if [[ $record ]]; then
      local line=${record#*:}
      ble/string#split record , "${record%%:*}"
      if [[ :$_ble_edit_nsearch_opts: == *:action=load:* ]]; then
        ble-edit/content/reset-and-check-dirty "$line"
      else
        ble-edit/history/goto "$_ble_edit_nsearch_index0"
      fi
      _ble_edit_ind=${record[2]}
      _ble_edit_mark=${record[3]}
    fi
  fi
}
function ble/widget/nsearch/accept-line {
  if ((${#_ble_util_fiberchain[@]})); then
    ble/widget/.bell "nsearch: now searching..."
  else
    ble/widget/nsearch/.exit
    ble-decode-key 13 # RET
  fi
}
function ble-decode/keymap:nsearch/define {
  ble-bind -f __default__ nsearch/exit-default
  ble-bind -f __line_limit__ nop
  ble-bind -f 'C-g'       nsearch/cancel
  ble-bind -f 'C-x C-g'   nsearch/cancel
  ble-bind -f 'C-M-g'     nsearch/cancel
  ble-bind -f C-m         nsearch/exit
  ble-bind -f RET         nsearch/exit
  ble-bind -f C-j         nsearch/accept-line
  ble-bind -f C-RET       nsearch/accept-line
  ble-bind -f C-r         nsearch/backward
  ble-bind -f C-s         nsearch/forward
  ble-bind -f C-p         nsearch/backward
  ble-bind -f C-n         nsearch/forward
  ble-bind -f up          nsearch/backward
  ble-bind -f down        nsearch/forward
  ble-bind -f prior       nsearch/backward
  ble-bind -f next        nsearch/forward
}
function ble-decode/keymap:safe/.bind {
  [[ $ble_bind_nometa && $1 == *M-* ]] && return 0
  ble-bind -f "$1" "$2"
}
function ble-decode/keymap:safe/bind-common {
  ble-decode/keymap:safe/.bind insert      'overwrite-mode'
  ble-decode/keymap:safe/.bind __batch_char__ 'batch-insert'
  ble-decode/keymap:safe/.bind __defchar__ 'self-insert'
  ble-decode/keymap:safe/.bind 'C-q'       'quoted-insert'
  ble-decode/keymap:safe/.bind 'C-v'       'quoted-insert'
  ble-decode/keymap:safe/.bind 'M-C-m'     'newline'
  ble-decode/keymap:safe/.bind 'M-RET'     'newline'
  ble-decode/keymap:safe/.bind paste_begin 'bracketed-paste'
  ble-decode/keymap:safe/.bind 'C-@'       'set-mark'
  ble-decode/keymap:safe/.bind 'C-SP'      'set-mark'
  ble-decode/keymap:safe/.bind 'NUL'       'set-mark'
  ble-decode/keymap:safe/.bind 'M-SP'      'set-mark'
  ble-decode/keymap:safe/.bind 'C-x C-x'   'exchange-point-and-mark'
  ble-decode/keymap:safe/.bind 'C-w'       'kill-region-or kill-backward-uword'
  ble-decode/keymap:safe/.bind 'M-w'       'copy-region-or copy-backward-uword'
  ble-decode/keymap:safe/.bind 'C-y'       'yank'
  ble-decode/keymap:safe/.bind 'M-y'       'yank-pop'
  ble-decode/keymap:safe/.bind 'M-S-y'     'yank-pop backward'
  ble-decode/keymap:safe/.bind 'M-Y'       'yank-pop backward'
  ble-decode/keymap:safe/.bind 'M-\'       'delete-horizontal-space'
  ble-decode/keymap:safe/.bind 'C-f'       '@nomarked forward-char'
  ble-decode/keymap:safe/.bind 'C-b'       '@nomarked backward-char'
  ble-decode/keymap:safe/.bind 'right'     '@nomarked forward-char'
  ble-decode/keymap:safe/.bind 'left'      '@nomarked backward-char'
  ble-decode/keymap:safe/.bind 'S-C-f'     '@marked forward-char'
  ble-decode/keymap:safe/.bind 'S-C-b'     '@marked backward-char'
  ble-decode/keymap:safe/.bind 'S-right'   '@marked forward-char'
  ble-decode/keymap:safe/.bind 'S-left'    '@marked backward-char'
  ble-decode/keymap:safe/.bind 'C-d'       'delete-region-or delete-forward-char'
  ble-decode/keymap:safe/.bind 'delete'    'delete-region-or delete-forward-char'
  ble-decode/keymap:safe/.bind 'C-?'       'delete-region-or delete-backward-char'
  ble-decode/keymap:safe/.bind 'DEL'       'delete-region-or delete-backward-char'
  ble-decode/keymap:safe/.bind 'C-h'       'delete-region-or delete-backward-char'
  ble-decode/keymap:safe/.bind 'BS'        'delete-region-or delete-backward-char'
  ble-decode/keymap:safe/.bind 'C-t'       'transpose-chars'
  ble-decode/keymap:safe/.bind 'C-right'   '@nomarked forward-cword'
  ble-decode/keymap:safe/.bind 'C-left'    '@nomarked backward-cword'
  ble-decode/keymap:safe/.bind 'M-right'   '@nomarked forward-sword'
  ble-decode/keymap:safe/.bind 'M-left'    '@nomarked backward-sword'
  ble-decode/keymap:safe/.bind 'S-C-right' '@marked forward-cword'
  ble-decode/keymap:safe/.bind 'S-C-left'  '@marked backward-cword'
  ble-decode/keymap:safe/.bind 'M-S-right' '@marked forward-sword'
  ble-decode/keymap:safe/.bind 'M-S-left'  '@marked backward-sword'
  ble-decode/keymap:safe/.bind 'M-d'       'kill-forward-cword'
  ble-decode/keymap:safe/.bind 'M-h'       'kill-backward-cword'
  ble-decode/keymap:safe/.bind 'C-delete'  'delete-forward-cword'
  ble-decode/keymap:safe/.bind 'C-_'       'delete-backward-cword'
  ble-decode/keymap:safe/.bind 'C-DEL'     'delete-backward-cword'
  ble-decode/keymap:safe/.bind 'C-BS'      'delete-backward-cword'
  ble-decode/keymap:safe/.bind 'M-delete'  'copy-forward-sword'
  ble-decode/keymap:safe/.bind 'M-C-?'     'copy-backward-sword'
  ble-decode/keymap:safe/.bind 'M-DEL'     'copy-backward-sword'
  ble-decode/keymap:safe/.bind 'M-C-h'     'copy-backward-sword'
  ble-decode/keymap:safe/.bind 'M-BS'      'copy-backward-sword'
  ble-decode/keymap:safe/.bind 'M-f'       '@nomarked forward-cword'
  ble-decode/keymap:safe/.bind 'M-b'       '@nomarked backward-cword'
  ble-decode/keymap:safe/.bind 'M-F'       '@marked forward-cword'
  ble-decode/keymap:safe/.bind 'M-B'       '@marked backward-cword'
  ble-decode/keymap:safe/.bind 'M-S-f'     '@marked forward-cword'
  ble-decode/keymap:safe/.bind 'M-S-b'     '@marked backward-cword'
  ble-decode/keymap:safe/.bind 'M-c'       'capitalize-eword'
  ble-decode/keymap:safe/.bind 'M-l'       'downcase-eword'
  ble-decode/keymap:safe/.bind 'M-u'       'upcase-eword'
  ble-decode/keymap:safe/.bind 'M-t'       'transpose-ewords'
  ble-decode/keymap:safe/.bind 'C-a'       '@nomarked beginning-of-line'
  ble-decode/keymap:safe/.bind 'C-e'       '@nomarked end-of-line'
  ble-decode/keymap:safe/.bind 'home'      '@nomarked beginning-of-line'
  ble-decode/keymap:safe/.bind 'end'       '@nomarked end-of-line'
  ble-decode/keymap:safe/.bind 'S-C-a'     '@marked beginning-of-line'
  ble-decode/keymap:safe/.bind 'S-C-e'     '@marked end-of-line'
  ble-decode/keymap:safe/.bind 'S-home'    '@marked beginning-of-line'
  ble-decode/keymap:safe/.bind 'S-end'     '@marked end-of-line'
  ble-decode/keymap:safe/.bind 'M-m'       '@nomarked non-space-beginning-of-line'
  ble-decode/keymap:safe/.bind 'M-S-m'     '@marked non-space-beginning-of-line'
  ble-decode/keymap:safe/.bind 'M-M'       '@marked non-space-beginning-of-line'
  ble-decode/keymap:safe/.bind 'C-p'       '@nomarked backward-line' # overwritten by bind-history
  ble-decode/keymap:safe/.bind 'up'        '@nomarked backward-line' # overwritten by bind-history
  ble-decode/keymap:safe/.bind 'C-n'       '@nomarked forward-line'  # overwritten by bind-history
  ble-decode/keymap:safe/.bind 'down'      '@nomarked forward-line'  # overwritten by bind-history
  ble-decode/keymap:safe/.bind 'C-k'       'kill-forward-line'
  ble-decode/keymap:safe/.bind 'C-u'       'kill-backward-line'
  ble-decode/keymap:safe/.bind 'S-C-p'     '@marked backward-line'
  ble-decode/keymap:safe/.bind 'S-up'      '@marked backward-line'
  ble-decode/keymap:safe/.bind 'S-C-n'     '@marked forward-line'
  ble-decode/keymap:safe/.bind 'S-down'    '@marked forward-line'
  ble-decode/keymap:safe/.bind 'C-home'    '@nomarked beginning-of-text'
  ble-decode/keymap:safe/.bind 'C-end'     '@nomarked end-of-text'
  ble-decode/keymap:safe/.bind 'S-C-home'  '@marked beginning-of-text'
  ble-decode/keymap:safe/.bind 'S-C-end'   '@marked end-of-text'
  ble-decode/keymap:safe/.bind 'C-x ('     'start-keyboard-macro'
  ble-decode/keymap:safe/.bind 'C-x )'     'end-keyboard-macro'
  ble-decode/keymap:safe/.bind 'C-x e'     'call-keyboard-macro'
  ble-decode/keymap:safe/.bind 'C-x P'     'print-keyboard-macro'
  ble-decode/keymap:safe/.bind 'C-]'       'character-search-forward'
  ble-decode/keymap:safe/.bind 'M-C-]'     'character-search-backward'
}
function ble-decode/keymap:safe/bind-history {
  ble-decode/keymap:safe/.bind 'C-r'       'history-isearch-backward'
  ble-decode/keymap:safe/.bind 'C-s'       'history-isearch-forward'
  ble-decode/keymap:safe/.bind 'M-<'       'history-beginning'
  ble-decode/keymap:safe/.bind 'M->'       'history-end'
  ble-decode/keymap:safe/.bind 'C-prior'   'history-beginning'
  ble-decode/keymap:safe/.bind 'C-next'    'history-end'
  ble-decode/keymap:safe/.bind 'C-p'       '@nomarked backward-line history'
  ble-decode/keymap:safe/.bind 'up'        '@nomarked backward-line history'
  ble-decode/keymap:safe/.bind 'C-n'       '@nomarked forward-line history'
  ble-decode/keymap:safe/.bind 'down'      '@nomarked forward-line history'
  ble-decode/keymap:safe/.bind 'prior'     'history-search-backward' # bash-5.2
  ble-decode/keymap:safe/.bind 'next'      'history-search-forward'  # bash-5.2
  ble-decode/keymap:safe/.bind 'C-x C-p'   'history-search-backward'
  ble-decode/keymap:safe/.bind 'C-x up'    'history-search-backward'
  ble-decode/keymap:safe/.bind 'C-x C-n'   'history-search-forward'
  ble-decode/keymap:safe/.bind 'C-x down'  'history-search-forward'
  ble-decode/keymap:safe/.bind 'C-x p'     'history-substring-search-backward'
  ble-decode/keymap:safe/.bind 'C-x n'     'history-substring-search-forward'
  ble-decode/keymap:safe/.bind 'C-x <'     'history-nsearch-backward'
  ble-decode/keymap:safe/.bind 'C-x >'     'history-nsearch-forward'
  ble-decode/keymap:safe/.bind 'C-x ,'     'history-nsearch-backward-again'
  ble-decode/keymap:safe/.bind 'C-x .'     'history-nsearch-forward-again'
  ble-decode/keymap:safe/.bind 'M-.'       'insert-last-argument'
  ble-decode/keymap:safe/.bind 'M-_'       'insert-last-argument'
  ble-decode/keymap:safe/.bind 'M-C-y'     'insert-nth-argument'
}
function ble-decode/keymap:safe/bind-complete {
  ble-decode/keymap:safe/.bind 'C-i'       'complete'
  ble-decode/keymap:safe/.bind 'TAB'       'complete'
  ble-decode/keymap:safe/.bind 'M-?'       'complete show_menu'
  ble-decode/keymap:safe/.bind 'M-*'       'complete insert_all'
  ble-decode/keymap:safe/.bind 'M-{'       'complete insert_braces'
  ble-decode/keymap:safe/.bind 'C-TAB'     'menu-complete'
  ble-decode/keymap:safe/.bind 'S-C-i'     'menu-complete backward'
  ble-decode/keymap:safe/.bind 'S-TAB'     'menu-complete backward'
  ble-decode/keymap:safe/.bind 'auto_complete_enter' 'auto-complete-enter'
  ble-decode/keymap:safe/.bind 'M-/'       'complete context=filename'
  ble-decode/keymap:safe/.bind 'M-~'       'complete context=username'
  ble-decode/keymap:safe/.bind 'M-$'       'complete context=variable'
  ble-decode/keymap:safe/.bind 'M-@'       'complete context=hostname'
  ble-decode/keymap:safe/.bind 'M-!'       'complete context=command'
  ble-decode/keymap:safe/.bind 'C-x /'     'complete show_menu:context=filename'
  ble-decode/keymap:safe/.bind 'C-x ~'     'complete show_menu:context=username'
  ble-decode/keymap:safe/.bind 'C-x $'     'complete show_menu:context=variable'
  ble-decode/keymap:safe/.bind 'C-x @'     'complete show_menu:context=hostname'
  ble-decode/keymap:safe/.bind 'C-x !'     'complete show_menu:context=command'
  ble-decode/keymap:safe/.bind "M-'"       'sabbrev-expand'
  ble-decode/keymap:safe/.bind "C-x '"     'sabbrev-expand'
  ble-decode/keymap:safe/.bind 'C-x C-r'   'dabbrev-expand'
  ble-decode/keymap:safe/.bind 'M-g'       'complete context=glob'
  ble-decode/keymap:safe/.bind 'C-x *'     'complete insert_all:context=glob'
  ble-decode/keymap:safe/.bind 'C-x g'     'complete show_menu:context=glob'
  ble-decode/keymap:safe/.bind 'M-C-i'     'complete context=dynamic-history'
  ble-decode/keymap:safe/.bind 'M-TAB'     'complete context=dynamic-history'
}
function ble-decode/keymap:safe/bind-arg {
  local append_arg=append-arg${1:+'-or '}$1
  ble-decode/keymap:safe/.bind M-C-u 'universal-arg'
  ble-decode/keymap:safe/.bind M-- "$append_arg"
  ble-decode/keymap:safe/.bind M-0 "$append_arg"
  ble-decode/keymap:safe/.bind M-1 "$append_arg"
  ble-decode/keymap:safe/.bind M-2 "$append_arg"
  ble-decode/keymap:safe/.bind M-3 "$append_arg"
  ble-decode/keymap:safe/.bind M-4 "$append_arg"
  ble-decode/keymap:safe/.bind M-5 "$append_arg"
  ble-decode/keymap:safe/.bind M-6 "$append_arg"
  ble-decode/keymap:safe/.bind M-7 "$append_arg"
  ble-decode/keymap:safe/.bind M-8 "$append_arg"
  ble-decode/keymap:safe/.bind M-9 "$append_arg"
  ble-decode/keymap:safe/.bind C-- "$append_arg"
  ble-decode/keymap:safe/.bind C-0 "$append_arg"
  ble-decode/keymap:safe/.bind C-1 "$append_arg"
  ble-decode/keymap:safe/.bind C-2 "$append_arg"
  ble-decode/keymap:safe/.bind C-3 "$append_arg"
  ble-decode/keymap:safe/.bind C-4 "$append_arg"
  ble-decode/keymap:safe/.bind C-5 "$append_arg"
  ble-decode/keymap:safe/.bind C-6 "$append_arg"
  ble-decode/keymap:safe/.bind C-7 "$append_arg"
  ble-decode/keymap:safe/.bind C-8 "$append_arg"
  ble-decode/keymap:safe/.bind C-9 "$append_arg"
  ble-decode/keymap:safe/.bind -   "$append_arg"
  ble-decode/keymap:safe/.bind 0   "$append_arg"
  ble-decode/keymap:safe/.bind 1   "$append_arg"
  ble-decode/keymap:safe/.bind 2   "$append_arg"
  ble-decode/keymap:safe/.bind 3   "$append_arg"
  ble-decode/keymap:safe/.bind 4   "$append_arg"
  ble-decode/keymap:safe/.bind 5   "$append_arg"
  ble-decode/keymap:safe/.bind 6   "$append_arg"
  ble-decode/keymap:safe/.bind 7   "$append_arg"
  ble-decode/keymap:safe/.bind 8   "$append_arg"
  ble-decode/keymap:safe/.bind 9   "$append_arg"
}
function ble/widget/safe/__attach__ {
  ble/edit/info/set-default text ''
}
function ble-decode/keymap:safe/define {
  local ble_bind_nometa=
  ble-decode/keymap:safe/bind-common
  ble-decode/keymap:safe/bind-history
  ble-decode/keymap:safe/bind-complete
  ble-bind -f 'C-d'      'delete-region-or delete-forward-char-or-exit'
  ble-bind -f 'SP'       magic-space
  ble-bind -f 'M-^'      history-expand-line
  ble-bind -f __attach__     safe/__attach__
  ble-bind -f __line_limit__ __line_limit__
  ble-bind -f 'C-c'      discard-line
  ble-bind -f 'C-j'      accept-line
  ble-bind -f 'C-RET'    accept-line
  ble-bind -f 'C-m'      accept-single-line-or-newline
  ble-bind -f 'RET'      accept-single-line-or-newline
  ble-bind -f 'C-o'      accept-and-next
  ble-bind -f 'C-x C-e'  edit-and-execute-command
  ble-bind -f 'M-#'      insert-comment
  ble-bind -f 'M-C-e'    shell-expand-line
  ble-bind -f 'M-&'      tilde-expand
  ble-bind -f 'C-g'      bell
  ble-bind -f 'C-x C-g'  bell
  ble-bind -f 'C-M-g'    bell
  ble-bind -f 'C-l'      clear-screen
  ble-bind -f 'C-M-l'    redraw-line
  ble-bind -f 'f1'       command-help
  ble-bind -f 'C-x C-v'  display-shell-version
  ble-bind -c 'C-z'      fg
  ble-bind -c 'M-z'      fg
}
function ble-edit/bind/load-editing-mode:safe {
  ble/decode/keymap#load safe
}
ble/util/autoload "keymap/emacs.sh" \
                  ble-decode/keymap:emacs/define
ble/util/autoload "keymap/vi.sh" \
                  ble-decode/keymap:vi_{i,n,o,x,s,c}map/define
ble/util/autoload "keymap/vi_digraph.sh" \
                  ble-decode/keymap:vi_digraph/define
function ble/widget/.change-editing-mode {
  [[ $_ble_decode_bind_state == none ]] && return 0
  local mode=$1
  if [[ $bleopt_default_keymap == auto ]]; then
    if [[ ! -o $mode ]]; then
      set -o "$mode"
      ble/decode/reset-default-keymap
      ble/decode/detach
      ble/decode/attach || ble-detach
    fi
  else
    bleopt default_keymap="$mode"
  fi
}
function ble/widget/emacs-editing-mode {
  ble/widget/.change-editing-mode emacs
}
function ble/widget/vi-editing-mode {
  ble/widget/.change-editing-mode vi
}
_ble_edit_read_accept=
_ble_edit_read_result=
function ble/widget/read/accept {
  _ble_edit_read_accept=1
  _ble_edit_read_result=$_ble_edit_str
  ble/decode/keymap/pop
}
function ble/widget/read/cancel {
  local _ble_edit_line_disabled=1
  ble/widget/read/accept
  _ble_edit_read_accept=2
}
function ble/widget/read/delete-forward-char-or-cancel {
  if [[ $_ble_edit_str ]]; then
    ble/widget/delete-forward-char
  else
    ble/widget/read/cancel
  fi
}
function ble/widget/read/__line_limit__.edit {
  local content=$1
  ble/widget/edit-and-execute-command.edit "$content" no-newline; local ext=$?
  ((ext==127)) && return "$ext"
  ble-edit/content/reset "$ret"
  ble/widget/read/accept
}
function ble/widget/read/__line_limit__ {
  ble/widget/__line_limit__ read/__line_limit__.edit
}
function ble-decode/keymap:read/define {
  local ble_bind_nometa=
  ble-decode/keymap:safe/bind-common
  ble-decode/keymap:safe/bind-history
  ble-bind -f __line_limit__ read/__line_limit__
  ble-bind -f 'C-c' read/cancel
  ble-bind -f 'C-\' read/cancel
  ble-bind -f 'C-m' read/accept
  ble-bind -f 'RET' read/accept
  ble-bind -f 'C-j' read/accept
  ble-bind -f 'C-d' 'delete-region-or read/delete-forward-char-or-cancel'
  ble-bind -f  'C-g'     bell
  ble-bind -f  'C-l'     redraw-line
  ble-bind -f  'C-M-l'   redraw-line
  ble-bind -f  'C-x C-v' display-shell-version
  ble-bind -f 'C-^' bell
}
_ble_edit_read_history=()
_ble_edit_read_history_edit=()
_ble_edit_read_history_dirt=()
_ble_edit_read_history_index=0
function ble/builtin/read/.process-option {
  case $1 in
  (-e) opt_flags=${opt_flags}r ;;
  (-i) opt_default=$2 ;;
  (-p) opt_prompt=$2 ;;
  (-u) opt_fd=$2
       ble/array#push opts_in "$@" ;;
  (-t) opt_timeout=$2 ;;
  (*)  ble/array#push opts "$@" ;;
  esac
}
function ble/builtin/read/.read-arguments {
  local is_normal_args=
  vars=()
  opts=()
  while (($#)); do
    local arg=$1; shift
    if [[ $is_normal_args || $arg != -* ]]; then
      ble/array#push vars "$arg"
    elif [[ $arg == -- ]]; then
      is_normal_args=1
    elif [[ $arg == --* ]]; then
      case $arg in
      (--help)
        opt_flags=${opt_flags}H ;;
      (*)
        ble/util/print "read: unrecognized long option '$arg'" >&2
        opt_flags=${opt_flags}E ;;
      esac
    else
      local i n=${#arg} c
      for ((i=1;i<n;i++)); do
        c=${arg:i:1}
        case ${arg:i} in
        ([adinNptu])
          if (($#)); then
            ble/builtin/read/.process-option -$c "$1"; shift
          else
            ble/util/print "read: missing option argument for '-$c'" >&2
            opt_flags=${opt_flags}E
          fi
          break ;;
        ([adinNptu]*) ble/builtin/read/.process-option -$c "${arg:i+1}"; break ;;
        ([ers]*)      ble/builtin/read/.process-option -$c ;;
        (*)
          ble/util/print "read: unrecognized option '-$c'" >&2
          opt_flags=${opt_flags}E ;;
        esac
      done
    fi
  done
}
function ble/builtin/read/.set-up-textarea {
  ble/decode/keymap/push read || return 1
  [[ $_ble_edit_read_context == external ]] &&
    _ble_canvas_panel_height[0]=0
  _ble_textarea_panel=1
  _ble_canvas_panel_focus=1
  ble/textarea#invalidate
  ble/edit/info/set-default ansi ''
  _ble_edit_PS1=$opt_prompt
  _ble_prompt_ps1_data=(0 '' '' 0 0 0 32 0 "" "")
  _ble_edit_dirty_observer=()
  ble/widget/.newline/clear-content
  _ble_edit_arg=
  ble-edit/content/reset "$opt_default" newline
  _ble_edit_ind=${#opt_default}
  ble-edit/undo/clear-all
  ble/history/set-prefix _ble_edit_read_
  _ble_syntax_lang=text
  _ble_highlight_layer__list=(plain region overwrite_mode disabled)
  return 0
}
function ble/builtin/read/TRAPWINCH {
  local IFS=$_ble_term_IFS
  _ble_textmap_pos=()
  ble/util/buffer "$_ble_term_ed"
  ble/textarea#redraw
}
function ble/builtin/read/.loop {
  set +m # ジョブ管理を無効にする
  shopt -u failglob
  local ret; ble/canvas/panel/save-position; local pos0=$ret
  ble/builtin/read/.set-up-textarea || return 1
  ble/builtin/trap/install-hook WINCH readline
  blehook WINCH=ble/builtin/read/TRAPWINCH
  local ret= timeout=
  if [[ $opt_timeout ]]; then
    ble/util/clock; local start_time=$ret
    ((start_time&&(start_time-=_ble_util_clock_reso-1)))
    if [[ $opt_timeout == *.* ]]; then
      local mantissa=${opt_timeout%%.*}
      local fraction=${opt_timeout##*.}000
      ((timeout=mantissa*1000+10#0${fraction::3}))
    else
      ((timeout=opt_timeout*1000))
    fi
    ((timeout<0)) && timeout=
  fi
  ble/application/render
  local _ble_decode_input_count=0
  local ble_decode_char_nest=
  local -a _ble_decode_char_buffer=()
  local char=
  local _ble_edit_read_accept=
  local _ble_edit_read_result=
  while [[ ! $_ble_edit_read_accept ]]; do
    local timeout_option=
    if [[ $timeout ]]; then
      if ((_ble_bash>=40000)); then
        local timeout_frac=000$((timeout%1000))
        timeout_option="-t $((timeout/1000)).${timeout_frac:${#timeout_frac}-3}"
      else
        timeout_option="-t $((timeout/1000))"
      fi
    fi
    local TMOUT= 2>/dev/null # #D1630 WA readonly TMOUT
    IFS= builtin read "${_ble_bash_tmout_wa[@]}" -r -d '' -n 1 $timeout_option char "${opts_in[@]}"; local ext=$?
    if ((ext>128)); then
      _ble_edit_read_accept=142
      break
    fi
    if [[ $timeout ]]; then
      ble/util/clock; local current_time=$ret
      ((timeout-=current_time-start_time))
      if ((timeout<=0)); then
        _ble_edit_read_accept=142
        break
      fi
      start_time=$current_time
    fi
    ble/util/s2c "$char"
    ble-decode-char "$ret"
    [[ $_ble_edit_read_accept ]] && break
    ble/util/is-stdin-ready && continue
    ble-edit/content/check-limit
    ble-decode/.hook/erase-progress
    ble/application/render
  done
  if [[ $_ble_edit_read_context == internal ]]; then
    local -a DRAW_BUFF=()
    ble/canvas/panel#set-height.draw "$_ble_textarea_panel" 0
    ble/canvas/panel/load-position.draw "$pos0"
    ble/canvas/bflush.draw
  else
    if ((_ble_edit_read_accept==1)); then
      ble/widget/.insert-newline # #D1800 (既に外部状態なのでOK)
    else
      _ble_edit_line_disabled=1 ble/widget/.insert-newline # #D1800 (既に外部状態なのでOK)
    fi
  fi
  ble/util/buffer.flush >&2
  if ((_ble_edit_read_accept==1)); then
    local q=\' Q="'\''"
    printf %s "__ble_input='${_ble_edit_read_result//$q/$Q}'"
  elif ((_ble_edit_read_accept==142)); then
    return "$ext"
  else
    return 1
  fi
}
function ble/builtin/read/.impl {
  local -a opts=() vars=() opts_in=()
  local opt_flags= opt_prompt= opt_default= opt_timeout= opt_fd=0
  local rex1='^[0-9]+(\.[0-9]*)?$|^\.[0-9]+$' rex2='^[0.]+$'
  [[ $TMOUT =~ $rex1 && ! ( $TMOUT =~ $rex2 ) ]] && opt_timeout=$TMOUT
  ble/builtin/read/.read-arguments "$@"
  if [[ $opt_flags == *[HE]* ]]; then
    if [[ $opt_flags == *H* ]]; then
      builtin read --help
    elif [[ $opt_flags == *E* ]]; then
      builtin read --usage 2>&1 1>/dev/null | ble/bin/grep ^read >&2
    fi
    return 2
  fi
  if ! [[ $opt_flags == *r* && -t $opt_fd ]]; then
    [[ $opt_prompt ]] && ble/array#push opts -p "$opt_prompt"
    [[ $opt_timeout ]] && ble/array#push opts -t "$opt_timeout"
    __ble_args=("${opts[@]}" "${opts_in[@]}" -- "${vars[@]}")
    __ble_command='builtin read "${__ble_args[@]}"'
    return 0
  fi
  ble/decode/keymap#load read
  local result _ble_edit_read_context=$_ble_term_state
  ble/util/buffer.flush >&2
  [[ $_ble_edit_read_context == external ]] && ble/term/enter # 外側にいたら入る
  result=$(ble/builtin/read/.loop); local ext=$?
  [[ $_ble_edit_read_context == external ]] && ble/term/leave # 元の状態に戻る
  [[ $_ble_edit_read_context == internal ]] && ((_ble_canvas_panel_height[1]=0))
  if ((ext==0)); then
    builtin eval -- "$result"
    __ble_args=("${opts[@]}" -- "${vars[@]}")
    __ble_command='builtin read "${__ble_args[@]}" <<< "$__ble_input"'
  fi
  return "$ext"
}
function ble/builtin/read {
  if [[ $_ble_decode_bind_state == none ]]; then
    builtin read "$@"
    return "$?"
  fi
  local _ble_local_set _ble_local_shopt
  ble/base/.adjust-bash-options _ble_local_set _ble_local_shopt
  [[ $_ble_builtin_read_hook ]] &&
    builtin eval -- "$_ble_builtin_read_hook"
  local __ble_command= __ble_args= __ble_input=
  [[ ! $_ble_attached || $_ble_edit_exec_inside_userspace ]] && ble/base/adjust-BASH_REMATCH
  ble/builtin/read/.impl "$@"; local __ble_ext=$?
  [[ ! $_ble_attached || $_ble_edit_exec_inside_userspace ]] && ble/base/restore-BASH_REMATCH
  ble/base/.restore-bash-options _ble_local_set _ble_local_shopt
  [[ $__ble_command ]] || return "$__ble_ext"
  builtin eval -- "$__ble_command"
}
function read { ble/builtin/read "$@"; }
function ble/widget/command-help/.read-man {
  local -x _ble_local_tmpfile; ble/util/assign/.mktmp
  local pager="sh -c 'cat >| \"\$_ble_local_tmpfile\"'"
  MANPAGER=$pager PAGER=$pager MANOPT= man "$@" 2>/dev/null; local ext=$? # 668ms
  ble/util/readfile man_content "$_ble_local_tmpfile" # 80ms
  return "$ext"
}
function ble/widget/command-help/.locate-in-man-bash {
  local command=$1
  local ret rex
  local rex_esc=$'(\e\\[[ -?]*[@-~]||.\b)' cr=$'\r'
  local pager; ble/util/get-pager pager
  local pager_cmd=${pager%%["$_ble_term_IFS"]*}
  [[ ${pager_cmd##*/} == less ]] || return 1
  local awk=ble/bin/awk; type -t gawk &>/dev/null && awk=gawk
  local man_content; ble/widget/command-help/.read-man bash || return 1 # 733ms (3 fork: man, sh, cat)
  local cmd_awk
  case $command in
  ('function')  cmd_awk='name () compound-command' ;;
  ('until')     cmd_awk=while ;;
  ('command')   cmd_awk='command [' ;;
  ('source')    cmd_awk=. ;;
  ('typeset')   cmd_awk=declare ;;
  ('readarray') cmd_awk=mapfile ;;
  ('[')         cmd_awk=test ;;
  (*)           cmd_awk=$command ;;
  esac
  ble/string#escape-for-awk-regex "$cmd_awk"; local rex_awk=$ret
  rex='\b$'; [[ $awk == gawk && $cmd_awk =~ $rex ]] && rex_awk=$rex_awk'\y'
  local awk_script='{
    gsub(/'"$rex_esc"'/, "");
    if (!par && $0 ~ /^[[:space:]]*'"$rex_awk"'/) { print NR; exit; }
    par = !($0 ~ /^[[:space:]]*$/);
  }'
  local awk_out; ble/util/assign awk_out '"$awk" "$awk_script" 2>/dev/null <<< "$man_content"' || return 1 # 206ms (1 fork)
  local iline=${awk_out%$'\n'}; [[ $iline ]] || return 1
  ble/string#escape-for-extended-regex "$command"; local rex_ext=$ret
  rex='\b$'; [[ $command =~ $rex ]] && rex_ext=$rex_ext'\b'
  rex='^\b'; [[ $command =~ $rex ]] && rex_ext="($rex_esc|\b)$rex_ext"
  local manpager="$pager -r +'/$rex_ext$cr$((iline-1))g'"
  builtin eval -- "$manpager" <<< "$man_content" # 1 fork
}
function ble/widget/command-help/.show-bash-script {
  local _ble_local_pipeline=$1
  local -x LESS="${LESS:+$LESS }-r" # Note: Bash のバグで tempenv builtin eval は消滅するので #D1438
  type -t source-highlight &>/dev/null &&
    _ble_local_pipeline='source-highlight -s sh -f esc | '$_ble_local_pipeline
  builtin eval -- "$_ble_local_pipeline"
}
function ble/widget/command-help/.locate-function-in-source {
  local func=$1 source lineno line
  ble/function#get-source-and-lineno "$func" || return 1
  [[ -f $source && -s $source ]] || return 1 # pipe 等は読み取らない
  local pager; ble/util/get-pager pager
  local pager_cmd=${pager%%["$_ble_term_IFS"]*}
  [[ ${pager_cmd##*/} == less ]] || return 1
  ble/util/assign line 'ble/bin/sed -n "${lineno}{p;q;}" "$source"'
  [[ $line == *"$func"* ]] || return 1
  ble/widget/command-help/.show-bash-script '"$pager" +"${lineno}g"' < "$source"
}
function ble/widget/command-help.core {
  ble/function#try ble/cmdinfo/help:"$command" && return 0
  ble/function#try ble/cmdinfo/help "$command" && return 0
  if [[ $type == builtin || $type == keyword ]]; then
    ble/widget/command-help/.locate-in-man-bash "$command" && return 0
  elif [[ $type == function ]]; then
    ble/widget/command-help/.locate-function-in-source "$command" && return 0
    local def; ble/function#getdef "$command"
    ble/widget/command-help/.show-bash-script ble/util/pager <<< "$def" && return 0
  fi
  if ble/is-function ble/bin/man; then
    MANOPT= ble/bin/man "${command##*/}" 2>/dev/null && return 0
  fi
  if local content; content=$("$command" --help 2>&1) && [[ $content ]]; then
    ble/util/print "$content" | ble/util/pager
    return 0
  fi
  ble/util/print "ble: help of \`$command' not found" >&2
  return 1
}
function ble/widget/command-help/.type/.resolve-alias {
  local literal=$1 command=$2 type=alias
  local last_literal=$1 last_command=$2
  while
    [[ $command == "$literal" ]] || break # Note: type=alias
    local alias_def
    ble/util/assign alias_def "alias $command"
    builtin unalias "$command"
    builtin eval "alias_def=${alias_def#*=}" # remove quote
    literal=${alias_def%%["$_ble_term_IFS"]*} command= type=
    ble/syntax:bash/simple-word/is-simple "$literal" || break # Note: type=
    local ret; ble/syntax:bash/simple-word/eval "$literal"; command=$ret
    ble/util/type type "$command"
    [[ $type ]] || break # Note: type=
    last_literal=$literal
    last_command=$command
    [[ $type == alias ]]
  do :; done
  if [[ ! $type || $type == alias ]]; then
    literal=$last_literal
    command=$last_command
    builtin unalias "$command" &>/dev/null
    ble/util/type type "$command"
  fi
  local q="'" Q="'\''"
  printf "type='%s'\n" "${type//$q/$Q}"
  printf "literal='%s'\n" "${literal//$q/$Q}"
  printf "command='%s'\n" "${command//$q/$Q}"
  return 0
} 2>/dev/null
function ble/widget/command-help/.type {
  local literal=$1
  type= command=
  ble/syntax:bash/simple-word/is-simple "$literal" || return 1
  local ret; ble/syntax:bash/simple-word/eval "$literal"; command=$ret
  ble/util/type type "$command"
  if [[ $type == alias ]]; then
    builtin eval -- "$(ble/widget/command-help/.type/.resolve-alias "$literal" "$command")"
  fi
  if [[ $type == keyword && $command != "$literal" ]]; then
    if [[ $command == %* ]] && jobs -- "$command" &>/dev/null; then
      type=jobs
    else
      type=${type[1]}
      [[ $type ]] || return 1
    fi
  fi
}
function ble/widget/command-help.impl {
  local literal=$1
  if [[ ! $literal ]]; then
    ble/widget/.bell
    return 1
  fi
  local type command; ble/widget/command-help/.type "$literal"
  if [[ ! $type ]]; then
    ble/widget/.bell "command \`$command' not found"
    return 1
  fi
  ble/widget/external-command ble/widget/command-help.core
}
function ble/widget/command-help {
  ble-edit/content/clear-arg
  local comp_cword comp_words comp_line comp_point
  if ble/syntax:bash/extract-command "$_ble_edit_ind"; then
    local cmd=${comp_words[0]}
  else
    local args; ble/string#split-words args "$_ble_edit_str"
    local cmd=${args[0]}
  fi
  ble/widget/command-help.impl "$cmd"
}
function ble-edit/bind/stdout.on { :;}
function ble-edit/bind/stdout.off { ble/util/buffer.flush >&2;}
function ble-edit/bind/stdout.finalize { :;}
if [[ $bleopt_internal_suppress_bash_output ]]; then
  _ble_edit_io_fname2=$_ble_base_run/$$.stderr
  function ble-edit/bind/stdout.on {
    exec 2>&$_ble_util_fd_stderr
  }
  function ble-edit/bind/stdout.off {
    ble/util/buffer.flush >&2
    ble-edit/io/check-stderr
    exec 2>>$_ble_edit_io_fname2
  }
  function ble-edit/bind/stdout.finalize {
    ble-edit/bind/stdout.on
    [[ -f $_ble_edit_io_fname2 ]] && : >| "$_ble_edit_io_fname2"
  }
  function ble-edit/io/check-stderr {
    local file=${1:-$_ble_edit_io_fname2}
    if ble/is-function ble/term/visible-bell; then
      if [[ -f $file && -s $file ]]; then
        local message= line TMOUT= 2>/dev/null # #D1630 WA readonly TMOUT
        while IFS= builtin read "${_ble_bash_tmout_wa[@]}" -r line || [[ $line ]]; do
          if [[ $line == 'bash: '* || $line == "${BASH##*/}: "* || $line == "ble.sh ("*"): "* ]]; then
            message="$message${message:+; }$line"
          fi
        done < "$file"
        [[ $message ]] && ble/term/visible-bell "$message"
        : >| "$file"
      fi
    fi
  }
  if ((_ble_bash<40000)); then
    function ble-edit/io/TRAPUSR1 {
      [[ $_ble_term_state == internal ]] || return 1
      local FUNCNEST=
      local IFS=$_ble_term_IFS
      local file=$_ble_edit_io_fname2.proc
      if [[ -s $file ]]; then
        local content cmd
        ble/util/readfile content "$file"
        : >| "$file"
        for cmd in $content; do
          case "$cmd" in
          (eof)
            ble-decode/.hook 4
            builtin eval -- "$_ble_decode_bind_hook" ;;
          esac
        done
      fi
      ble/builtin/trap/invoke USR1
    }
    blehook/declare USR1
    blehook USR1+=ble-edit/io/TRAPUSR1
    ble/builtin/trap/install-hook USR1
    function ble-edit/io/check-ignoreeof-message {
      local line=$1
      [[ ( $bleopt_internal_ignoreeof_trap && $line == *$bleopt_internal_ignoreeof_trap* ) ||
           $line == *'Use "exit" to leave the shell.'* ||
           $line == *'ログアウトする為には exit を入力して下さい'* ||
           $line == *'シェルから脱出するには "exit" を使用してください。'* ||
           $line == *'シェルから脱出するのに "exit" を使いなさい.'* ||
           $line == *'Gebruik Kaart na Los Tronk'* ]] && return 0
      [[ $line == *exit* ]] && ble/bin/grep -q -F "$line" "$_ble_base"/lib/core-edit.ignoreeof-messages.txt
    }
    function ble-edit/io/check-ignoreeof-loop {
      local line opts=:$1: TMOUT= 2>/dev/null # #D1630 WA readonly TMOUT
      while IFS= builtin read "${_ble_bash_tmout_wa[@]}" -r line; do
        if [[ $line == *[^$_ble_term_IFS]* ]]; then
          ble/util/print "$line" >> "$_ble_edit_io_fname2"
        fi
        if ble-edit/io/check-ignoreeof-message "$line"; then
          ble/util/print eof >> "$_ble_edit_io_fname2.proc"
          kill -USR1 $$
          ble/util/msleep 100 # 連続で送ると bash が落ちるかも (落ちた事はないが念の為)
        fi
      done
    } &>/dev/null
    ble/bin/rm -f "$_ble_edit_io_fname2.pipe"
    if ble/bin/mkfifo "$_ble_edit_io_fname2.pipe" 2>/dev/null; then
      {
        ble-edit/io/check-ignoreeof-loop fifo < "$_ble_edit_io_fname2.pipe" & disown
      } &>/dev/null
      ble/fd#alloc _ble_edit_io_fd2 '> "$_ble_edit_io_fname2.pipe"'
      function ble-edit/bind/stdout.off {
        ble/util/buffer.flush >&2
        ble-edit/io/check-stderr
        exec 2>&$_ble_edit_io_fd2
      }
    elif . "$_ble_base/lib/init-msys1.sh"; ble-edit/io:msys1/start-background; then
      function ble-edit/bind/stdout.off {
        ble/util/buffer.flush >&2
        ble-edit/io/check-stderr
        exec 2>/dev/null
        exec 2>>$_ble_edit_io_fname2.buff
      }
    fi
  fi
fi
[[ ${_ble_edit_detach_flag-} != reload ]] &&
  _ble_edit_detach_flag=
function ble-edit/bind/.exit-TRAPRTMAX {
  local FUNCNEST=
  ble/base/unload
  builtin exit 0
}
function ble-edit/bind/.check-detach {
  if [[ ! -o emacs && ! -o vi ]]; then
    ble/util/print "${_ble_term_setaf[9]}[ble: unsupported]$_ble_term_sgr0 Sorry, ble.sh is supported only with some editing mode (set -o emacs/vi)." 1>&2
    ble-detach
  fi
  [[ $_ble_edit_detach_flag == prompt-attach ]] && return 1
  if [[ $_ble_edit_detach_flag || ! $_ble_attached ]]; then
    type=$_ble_edit_detach_flag
    _ble_edit_detach_flag=
    local attached=$_ble_attached
    [[ $attached ]] && ble-detach/impl
    if [[ $type == exit ]]; then
      ble-detach/message "${_ble_term_setaf[12]}[ble: exit]$_ble_term_sgr0"
      builtin trap 'ble-edit/bind/.exit-TRAPRTMAX' RTMAX
      kill -RTMAX $$
    else
      ble-detach/message \
        "${_ble_term_setaf[12]}[ble: detached]$_ble_term_sgr0" \
        "Please run \`stty sane' to recover the correct TTY state."
      if ((_ble_bash>=40000)); then
        READLINE_LINE=' stty sane;' READLINE_POINT=11 READLINE_MARK=0
        printf %s "$READLINE_LINE"
      fi
    fi
    if [[ $attached ]]; then
      ble/base/restore-BASH_REMATCH
      ble/base/restore-bash-options
      ble/base/restore-POSIXLY_CORRECT
      ble/base/restore-builtin-wrappers
      builtin eval -- "$_ble_bash_FUNCNEST_restore" # これ以降関数は呼び出せない
    else
      ble-edit/exec:"$bleopt_internal_exec_type"/.prologue
      _ble_edit_exec_inside_prologue=
    fi
    return 0
  else
    local state=$_ble_decode_bind_state
    if [[ ( $state == emacs || $state == vi ) && ! -o $state ]]; then
      ble/decode/reset-default-keymap
      ble/decode/detach
      if ! ble/decode/attach; then
        ble-detach
        ble-edit/bind/.check-detach # 改めて終了処理
        return $?
      fi
    fi
    return 1
  fi
}
if ((_ble_bash>=40100)); then
  function ble-edit/bind/.head/adjust-bash-rendering {
    ble/textarea#redraw-cache
    ble/util/buffer.flush >&2
  }
else
  function ble-edit/bind/.head/adjust-bash-rendering {
    ((_ble_canvas_y++,_ble_canvas_x=0))
    local -a DRAW_BUFF=()
    ble/canvas/panel#goto.draw "$_ble_textarea_panel" "${_ble_textarea_cur[0]}" "${_ble_textarea_cur[1]}"
    ble/canvas/flush.draw
  }
fi
function ble-edit/bind/.head {
  ble-edit/bind/stdout.on
  ble/base/recover-bash-options
  [[ $bleopt_internal_suppress_bash_output ]] ||
    ble-edit/bind/.head/adjust-bash-rendering
}
function ble-edit/bind/.tail-without-draw {
  ble-edit/bind/stdout.off
}
if ((_ble_bash>=40000)); then
  function ble-edit/bind/.tail {
    ble/application/render
    ble/util/idle.do && ble/application/render
    ble/textarea#adjust-for-bash-bind # bash-4.0+
    ble-edit/bind/stdout.off
  }
else
  function ble-edit/bind/.tail {
    ble/application/render
    ble/util/idle.do && ble/application/render
    ble-edit/bind/stdout.off
  }
fi
function ble-decode/PROLOGUE {
  ble-edit/exec:gexec/restore-state
  ble-edit/bind/.head
  ble/decode/bind/adjust-uvw
  ble/term/enter
}
function ble-decode/EPILOGUE {
  if ((_ble_bash>=40000)); then
    if ble/decode/has-input && ! ble-edit/exec/has-pending-commands; then
      ble-edit/bind/.tail-without-draw
      return 0
    fi
  fi
  ble-edit/content/check-limit
  ble-edit/exec:"$bleopt_internal_exec_type"/process && return 0
  ble-edit/bind/.tail
  return 0
}
function ble/widget/.internal-print-command {
  local command=$1 opts=$2
  _ble_edit_line_disabled=1 ble/widget/.insert-newline # #D1800 pair=leave-command-layout
  [[ :$opts: != *:pre-flush:* ]] || ble/util/buffer.flush >&2
  BASH_COMMAND=$command builtin eval -- "$command"
  ble/edit/leave-command-layout # #D1800 pair=.insert-newline
  [[ :$opts: != *:post-flush:* ]] || ble/util/buffer.flush >&2
}
function ble/widget/print {
  ble-edit/content/clear-arg
  local message="$*" lines
  [[ ${message//["$_ble_term_IFS"]} ]] || return 1
  lines=("$@")
  ble/widget/.internal-print-command \
    'ble/util/print-lines "${lines[@]}" >&2' pre-flush
}
function ble/widget/internal-command {
  ble-edit/content/clear-arg
  local command=$1
  [[ ${command//[$_ble_term_IFS]} ]] || return 1
  ble/widget/.internal-print-command "$command"
}
function ble/widget/external-command {
  ble-edit/content/clear-arg
  local _ble_local_command=$1
  [[ ${_ble_local_command//[$_ble_term_IFS]} ]] || return 1
  ble/edit/enter-command-layout # #D1800 pair=leave-command-layout
  ble/textarea#invalidate
  local -a DRAW_BUFF=()
  ble/canvas/panel#set-height.draw "$_ble_textarea_panel" 0
  ble/canvas/panel#goto.draw "$_ble_textarea_panel" 0 0 sgr0
  ble/canvas/bflush.draw
  ble/term/leave
  ble/util/buffer.flush >&2
  BASH_COMMAND=$_ble_local_command builtin eval -- "$_ble_local_command"; local ext=$?
  ble/term/enter
  ble/edit/leave-command-layout # #D1800 pair=enter-command-layout
  return "$ext"
}
function ble/widget/execute-command {
  ble-edit/content/clear-arg
  local command=$1
  if [[ $command != *[!"$_ble_term_IFS"]* ]]; then
    _ble_edit_line_disabled=1 ble/widget/.insert-newline keep-info
    return 1
  fi
  _ble_edit_line_disabled=1 ble/widget/.insert-newline # #D1800 pair=exec/register
  ble-edit/exec/register "$command"
}
function ble/widget/.SHELL_COMMAND { ble/widget/execute-command "$@"; }
function ble/widget/.EDIT_COMMAND {
  local command=$1
  local -x READLINE_LINE=$_ble_edit_str
  local -x READLINE_POINT=$_ble_edit_ind
  local -x READLINE_MARK=$_ble_edit_mark
  [[ $_ble_edit_arg ]] &&
    local -x READLINE_ARGUMENT=$_ble_edit_arg
  ble/edit/enter-command-layout # #D1800 pair=leave-command-layout
  ble/widget/.hide-current-line keep-header
  ble/util/buffer.flush >&2
  builtin eval -- "$command"; local ext=$?
  ble-edit/content/clear-arg
  ble/edit/leave-command-layout # #D1800 pair=enter-command-layout
  [[ $READLINE_LINE != "$_ble_edit_str" ]] &&
    ble-edit/content/reset-and-check-dirty "$READLINE_LINE"
  ((_ble_edit_ind=READLINE_POINT))
  ((_ble_edit_mark=READLINE_MARK))
  local N=${#_ble_edit_str}
  ((_ble_edit_ind<0?_ble_edit_ind=0:(_ble_edit_ind>N&&(_ble_edit_ind=N))))
  ((_ble_edit_mark<0?_ble_edit_mark=0:(_ble_edit_mark>N&&(_ble_edit_mark=N))))
  return "$ext"
}
function ble-decode/INITIALIZE_DEFMAP {
  local ret
  bleopt/get:default_keymap; local defmap=$ret
  if ble-edit/bind/load-editing-mode "$defmap"; then
    local base_keymap=$defmap
    [[ $defmap == vi ]] && base_keymap=vi_imap
    builtin eval -- "$2=\$base_keymap"
    ble/decode/is-keymap "$base_keymap" && return 0
  fi
  ble/edit/enter-command-layout # #D1800 pair=leave-command-layout
  ble/widget/.hide-current-line
  local -a DRAW_BUFF=()
  ble/canvas/put.draw "$_ble_term_cr$_ble_term_el${_ble_term_setaf[9]}"
  ble/canvas/put.draw "[ble.sh: The definition of the default keymap \"$defmap\" is not found. ble.sh uses \"safe\" keymap instead.]"
  ble/canvas/put.draw "$_ble_term_sgr0$_ble_term_nl"
  ble/canvas/bflush.draw
  ble/util/buffer.flush >&2
  ble/edit/leave-command-layout # #D1800 pair=enter-command-layout
  ble-edit/bind/load-editing-mode safe &&
    ble/decode/keymap#load safe &&
    builtin eval -- "$2=safe" &&
    bleopt_default_keymap=safe
}
function ble-edit/bind/load-editing-mode {
  local name=$1
  if ble/is-function ble-edit/bind/load-editing-mode:"$name"; then
    ble-edit/bind/load-editing-mode:"$name"
  else
    ble/util/import "$_ble_base/keymap/$name.sh"
  fi
}
function ble-edit/bind/clear-keymap-definition-loader {
  builtin unset -f ble-edit/bind/load-editing-mode:safe
  builtin unset -f ble-edit/bind/load-editing-mode:emacs
  builtin unset -f ble-edit/bind/load-editing-mode:vi
}
function ble-edit/initialize {
  ble/prompt/initialize
}
function ble-edit/attach {
  _ble_builtin_trap_DEBUG__initialize
  [[ $_ble_builtin_trap_DEBUG_userTrapInitialized ]] &&
    _ble_edit_exec_gexec__TRAPDEBUG_adjust
  ble-edit/attach/.attach
  _ble_canvas_x=0 _ble_canvas_y=0
  ble/util/buffer "$_ble_term_cr"
}
function ble-edit/detach {
  ble-edit/bind/stdout.finalize
  ble-edit/attach/.detach
  ble-edit/exec:gexec/.TRAPDEBUG/restore
}
ble/function#trace ble-edit/attach
function ble/cmdspec/initialize { ble-import "$_ble_base/lib/core-cmdspec.sh"; }
ble/is-function ble/util/idle.push && ble-import -d "$_ble_base/lib/core-cmdspec.sh"
builtin eval -- "${_ble_util_gdict_declare//NAME/_ble_cmdspec_opts}"
function ble/cmdspec/opts {
  local spec=$1 command; shift
  for command; do
    ble/gdict#set _ble_cmdspec_opts "$command" "$spec"
  done
}
function ble/cmdspec/opts#load {
  cmdspec_opts=$2
  local ret=
  if ble/gdict#get _ble_cmdspec_opts "$1" ||
      { [[ $1 == */*[!/] ]] && ble/gdict#get _ble_cmdspec_opts "${1##*/}"; }
  then
    cmdspec_opts=$ret
  fi
}
_ble_syntax_VARNAMES=(
  _ble_syntax_text
  _ble_syntax_lang
  _ble_syntax_stat
  _ble_syntax_nest
  _ble_syntax_tree
  _ble_syntax_attr
  _ble_syntax_attr_umin
  _ble_syntax_attr_umax
  _ble_syntax_word_umin
  _ble_syntax_word_umax
  _ble_syntax_vanishing_word_umin
  _ble_syntax_vanishing_word_umax
  _ble_syntax_dbeg
  _ble_syntax_dend)
_ble_syntax_lang=bash
function ble/syntax/initialize-vars {
  _ble_syntax_text=
  _ble_syntax_lang=bash
  _ble_syntax_stat=()
  _ble_syntax_nest=()
  _ble_syntax_tree=()
  _ble_syntax_attr=()
  _ble_syntax_attr_umin=-1 _ble_syntax_attr_umax=-1
  _ble_syntax_word_umin=-1 _ble_syntax_word_umax=-1
  _ble_syntax_vanishing_word_umin=-1
  _ble_syntax_vanishing_word_umax=-1
  _ble_syntax_dbeg=-1 _ble_syntax_dend=-1
}
function ble/highlight/layer:syntax/update { true; }
function ble/highlight/layer:syntax/getg { true; }
function ble/syntax:bash/is-complete { true; }
ble/util/autoload "$_ble_base/lib/core-syntax.sh" \
             ble/syntax/parse \
             ble/syntax/highlight \
             ble/syntax/tree-enumerate \
             ble/syntax/tree-enumerate-children \
             ble/syntax/completion-context/generate \
             ble/syntax/highlight/cmdtype \
             ble/syntax/highlight/cmdtype1 \
             ble/syntax/highlight/filetype \
             ble/syntax/highlight/getg-from-filename \
             ble/syntax:bash/extract-command \
             ble/syntax:bash/simple-word/eval \
             ble/syntax:bash/simple-word/evaluate-path-spec \
             ble/syntax:bash/simple-word/is-never-word \
             ble/syntax:bash/simple-word/is-simple \
             ble/syntax:bash/simple-word/is-simple-or-open-simple \
             ble/syntax:bash/simple-word/reconstruct-incomplete-word
bleopt/declare -v syntax_debug ''
bleopt/declare -v filename_ls_colors ''
bleopt/declare -v highlight_syntax 1
bleopt/declare -v highlight_filename 1
bleopt/declare -v highlight_variable 1
bleopt/declare -v highlight_timeout_sync 50
bleopt/declare -v highlight_timeout_async 5000
bleopt/declare -v syntax_eval_polling_interval 50
builtin eval -- "${_ble_util_gdict_declare//NAME/_ble_syntax_highlight_filetype}"
builtin eval -- "${_ble_util_gdict_declare//NAME/_ble_syntax_highlight_lscolors_ext}"
builtin eval -- "${_ble_util_gdict_declare//NAME/_ble_syntax_bash_simple_eval}"
builtin eval -- "${_ble_util_gdict_declare//NAME/_ble_syntax_bash_simple_eval_full}"
function ble/syntax/attr2g { ble/color/initialize-faces && ble/syntax/attr2g "$@"; }
function ble/syntax/defface.onload {
  function ble/syntax/attr2g {
    local iface=${_ble_syntax_attr2iface[$1]:-_ble_faces__syntax_default}
    g=${_ble_faces[iface]}
  }
  ble/color/defface syntax_default           none
  ble/color/defface syntax_command           fg=brown
  ble/color/defface syntax_quoted            fg=green
  ble/color/defface syntax_quotation         fg=green,bold
  ble/color/defface syntax_escape            fg=magenta
  ble/color/defface syntax_expr              fg=26
  ble/color/defface syntax_error             bg=203,fg=231 # bg=224
  ble/color/defface syntax_varname           fg=202
  ble/color/defface syntax_delimiter         bold
  ble/color/defface syntax_param_expansion   fg=purple
  ble/color/defface syntax_history_expansion bg=94,fg=231
  ble/color/defface syntax_function_name     fg=92,bold # fg=purple
  ble/color/defface syntax_comment           fg=242
  ble/color/defface syntax_glob              fg=198,bold
  ble/color/defface syntax_brace             fg=37,bold
  ble/color/defface syntax_tilde             fg=navy,bold
  ble/color/defface syntax_document          fg=94
  ble/color/defface syntax_document_begin    fg=94,bold
  ble/color/defface command_builtin_dot fg=red,bold
  ble/color/defface command_builtin     fg=red
  ble/color/defface command_alias       fg=teal
  ble/color/defface command_function    fg=92 # fg=purple
  ble/color/defface command_file        fg=green
  ble/color/defface command_keyword     fg=blue
  ble/color/defface command_jobs        fg=red,bold
  ble/color/defface command_directory   fg=26,underline
  ble/color/defface filename_directory        underline,fg=26
  ble/color/defface filename_directory_sticky underline,fg=white,bg=26
  ble/color/defface filename_link             underline,fg=teal
  ble/color/defface filename_orphan           underline,fg=teal,bg=224
  ble/color/defface filename_setuid           underline,fg=black,bg=220
  ble/color/defface filename_setgid           underline,fg=black,bg=191
  ble/color/defface filename_executable       underline,fg=green
  ble/color/defface filename_other            underline
  ble/color/defface filename_socket           underline,fg=cyan,bg=black
  ble/color/defface filename_pipe             underline,fg=lime,bg=black
  ble/color/defface filename_character        underline,fg=white,bg=black
  ble/color/defface filename_block            underline,fg=yellow,bg=black
  ble/color/defface filename_warning          underline,fg=red
  ble/color/defface filename_url              underline,fg=blue
  ble/color/defface filename_ls_colors        underline
  ble/color/defface varname_unset     fg=124
  ble/color/defface varname_empty     fg=31
  ble/color/defface varname_number    fg=64
  ble/color/defface varname_expr      fg=92,bold
  ble/color/defface varname_array     fg=orange,bold
  ble/color/defface varname_hash      fg=70,bold
  ble/color/defface varname_readonly  fg=200
  ble/color/defface varname_transform fg=29,bold
  ble/color/defface varname_export    fg=200,bold
  ble/color/defface argument_option   fg=teal
  ble/color/defface argument_error    fg=black,bg=225
}
blehook/eval-after-load color_defface ble/syntax/defface.onload
function ble/syntax/import {
  ble/util/import "$_ble_base/lib/core-syntax.sh"
}
ble-import -d lib/core-syntax
ble/is-function ble/util/idle.push && ble-import -d "$_ble_base/lib/core-complete.sh"
ble/util/autoload "$_ble_base/lib/core-complete.sh" \
                  ble/widget/complete \
                  ble/widget/menu-complete \
                  ble/widget/auto-complete-enter \
                  ble/widget/sabbrev-expand \
                  ble/widget/dabbrev-expand
function ble-sabbrev {
  local arg print=
  for arg; do
    if [[ $arg != -* && $arg != *=* ]]; then
      print=1
      break
    fi
  done
  if (($#==0)) || [[ $print ]]; then
    ble-import lib/core-complete && ble-sabbrev "$@"
    return $?
  fi
  local ret; ble/string#quote-command "$FUNCNAME" "$@"
  blehook/eval-after-load complete "$ret"
}
if ! declare -p _ble_complete_sabbrev &>/dev/null; then # reload #D0875
  builtin eval -- "${_ble_util_gdict_declare//NAME/_ble_complete_sabbrev}"
fi
bleopt/declare -n complete_polling_cycle 50
bleopt/declare -o complete_stdin_frequency complete_polling_cycle
bleopt/declare -v complete_limit ''
bleopt/declare -v complete_limit_auto 2000
bleopt/declare -v complete_limit_auto_menu 100
bleopt/declare -v complete_timeout_auto 5000
bleopt/declare -v complete_timeout_compvar 200
bleopt/declare -v complete_ambiguous 1
bleopt/declare -v complete_contract_function_names 1
bleopt/declare -v complete_auto_complete 1
bleopt/declare -v complete_auto_history 1
bleopt/declare -n complete_auto_delay 1
bleopt/declare -v complete_auto_wordbreaks "$_ble_term_IFS"
bleopt/declare -v complete_auto_menu ''
bleopt/declare -v complete_allow_reduction ''
bleopt/declare -n complete_menu_style align-nowrap
function bleopt/check:complete_menu_style {
  [[ $value == desc-raw ]] && value=desc
  if ! ble/is-function "ble/complete/menu-style:$value/construct-page"; then
    ble/util/print-lines \
      "bleopt: Invalid value complete_menu_style='$value'." \
      "  A function 'ble/complete/menu-style:$value/construct-page' is not defined." >&2
    return 1
  fi
  return 0
}
ble/util/autoload "$_ble_base/lib/core-complete.sh" \
                  ble/complete/menu-style:{align,dense}{,-nowrap}/construct-page \
                  ble/complete/menu-style:linewise/construct-page \
                  ble/complete/menu-style:desc{,-raw}/construct-page
bleopt/declare -v menu_linewise_prefix ''
bleopt/declare -v menu_desc_multicolumn_width 65
bleopt/declare -v complete_menu_complete 1
bleopt/declare -v complete_menu_filter 1
bleopt/declare -v complete_menu_maxlines '-1'
bleopt/declare -n menu_align_min 4
bleopt/declare -n menu_align_max 20
bleopt/declare -o complete_menu_align menu_align_max
ble/util/autoload "$_ble_base/lib/core-complete.sh" \
                  ble/complete/menu#start \
                  ble-decode/keymap:menu/define \
                  ble-decode/keymap:auto_complete/define \
                  ble-decode/keymap:menu_complete/define \
                  ble-decode/keymap:dabbrev/define \
                  ble/complete/sabbrev/expand
ble/color/defface auto_complete bg=254,fg=238
ble/color/defface cmdinfo_cd_cdpath fg=26,bg=155
function ble/contrib/bash-preexec/loader {
  if [[ ${bp_imported-${__bp_imported}} ]]; then
    blehook ATTACH-=ble/contrib/bash-preexec/loader
    blehook POSTEXEC-=ble/contrib/bash-preexec/loader
    if ble/util/import/is-loaded contrib/bash-preexec; then
      ble/contrib/bash-preexec/attach.hook
    else
      ble-import contrib/bash-preexec
    fi
  fi
}
if [[ ${bp_imported-${__bp_imported}} ]]; then
  ble-import contrib/bash-preexec
else
  blehook ATTACH+=ble/contrib/bash-preexec/loader
  blehook POSTEXEC+=ble/contrib/bash-preexec/loader
fi
bleopt -I
ble/bin/.freeze-utility-path ble
function ble/dispatch/.help {
  ble/util/print-lines \
    'usage: ble [SUBCOMMAND [ARGS...]]' \
    '' \
    'SUBCOMMAND' \
    '  # Manage ble.sh' \
    '  attach  ... alias of ble-attach' \
    '  detach  ... alias of ble-detach'  \
    '  update  ... alias of ble-update' \
    '  reload  ... alias of ble-reload' \
    '  help    ... Show this help' \
    '  version ... Show version' \
    '  check   ... Run unit tests' \
    '' \
    '  # Configuration' \
    '  opt     ... alias of bleopt' \
    '  bind    ... alias of ble-bind' \
    '  face    ... alias of ble-face' \
    '  hook    ... alias of blehook' \
    '  sabbrev ... alias of ble-sabbrev' \
    '  palette ... alias of ble-color-show' \
    ''
}
function ble/dispatch {
  if (($#==0)); then
    [[ $_ble_attached && ! $_ble_edit_exec_inside_userspace ]]
    return $?
  fi
  local cmd=$1; shift
  case $cmd in
  (attach)  ble-attach "$@" ;;
  (detach)  ble-detach "$@" ;;
  (update)  ble-update "$@" ;;
  (reload)  ble-reload "$@" ;;
  (face)    ble-face "$@" ;;
  (bind)    ble-bind "$@" ;;
  (opt)     bleopt "$@" ;;
  (hook)    blehook "$@" ;;
  (sabbrev) ble-sabbrev "$@" ;;
  (palette) ble-color-show "$@" ;;
  (help|--help) ble/dispatch/.help "$@" ;;
  (version|--version) ble/util/print "ble.sh, version $BLE_VERSION (noarch)" ;;
  (check|--test) ble/base/sub:test "$@" ;;
  (*)
    if ble/is-function ble/bin/ble; then
      ble/bin/ble "$cmd" "$@"
    else
      ble/util/print "ble (ble.sh): unrecognized subcommand '$cmd'." >&2
      return 2
    fi
  esac
}
function ble { ble/dispatch "$@"; }
_ble_base_rcfile=
_ble_base_rcfile_initialized=
function ble/base/load-rcfile {
  [[ $_ble_base_rcfile_initialized ]] && return 0
  _ble_base_rcfile_initialized=1
  if [[ ! $_ble_base_rcfile ]]; then
    { _ble_base_rcfile=$HOME/.blerc; [[ -f $_ble_base_rcfile ]]; } ||
      { _ble_base_rcfile=${XDG_CONFIG_HOME:-$HOME/.config}/blesh/init.sh; [[ -f $_ble_base_rcfile ]]; } ||
      _ble_base_rcfile=$HOME/.blerc
  fi
  if [[ -s $_ble_base_rcfile ]]; then
    source "$_ble_base_rcfile"
    blehook/.compatibility-ble-0.3/check
  fi
}
function ble-attach {
  if (($# >= 2)); then
    ble/util/print-lines \
      'usage: ble-attach [opts]' \
      'Attach to ble.sh.' >&2
    [[ $1 != --help ]] && return 2
    return 0
  fi
  if [[ $_ble_edit_detach_flag ]]; then
    case $_ble_edit_detach_flag in
    (exit) return 0 ;;
    (*) _ble_edit_detach_flag= ;; # cancel "detach"
    esac
  fi
  [[ ! $_ble_attached ]] || return 0
  _ble_attached=1
  BLE_ATTACHED=1
  builtin eval -- "$_ble_bash_FUNCNEST_adjust"
  ble/base/adjust-builtin-wrappers-1
  ble/base/adjust-bash-options
  ble/base/adjust-POSIXLY_CORRECT
  ble/base/adjust-builtin-wrappers-2
  ble/base/adjust-BASH_REMATCH
  if [[ ${IN_NIX_SHELL-} ]]; then
    if [[ "${BASH_SOURCE[*]}" == */rc && $1 != *:force:* ]]; then
      ble/base/install-prompt-attach
      _ble_attached=
      BLE_ATTACHED=
      ble/base/restore-BASH_REMATCH
      ble/base/restore-bash-options
      ble/base/restore-POSIXLY_CORRECT
      ble/base/restore-builtin-wrappers
      builtin eval -- "$_ble_bash_FUNCNEST_restore"
      return 0
    fi
    local ret
    ble/util/readlink "/proc/$$/exe"
    [[ -x $ret ]] && BASH=$ret
  fi
  ble/canvas/attach
  ble/term/enter      # 3ms (起動時のずれ防止の為 stty)
  ble-edit/initialize # 3ms
  ble-edit/attach     # 0ms (_ble_edit_PS1 他の初期化)
  ble/canvas/panel/render # 37ms
  ble/util/buffer.flush >&2
  local IFS=$_ble_term_IFS
  ble/decode/initialize # 7ms
  ble/decode/reset-default-keymap # 264ms (keymap/vi.sh)
  if ! ble/decode/attach; then # 53ms
    _ble_attached=
    BLE_ATTACHED=
    ble-edit/detach
    ble/term/leave
    ble/base/restore-BASH_REMATCH
    ble/base/restore-bash-options
    ble/base/restore-POSIXLY_CORRECT
    ble/base/restore-builtin-wrappers
    builtin eval -- "$_ble_bash_FUNCNEST_restore"
    return 1
  fi
  ble/history:bash/reset # 27s for bash-3.0
  blehook/invoke ATTACH
  ble/textarea#redraw
  ble/edit/info/default
  ble-edit/bind/.tail
}
function ble-detach {
  if (($#)); then
    ble/base/print-usage-for-no-argument-command 'Detach from ble.sh.' "$@"
    return "$?"
  fi
  [[ $_ble_attached && ! $_ble_edit_detach_flag ]] || return 1
  _ble_edit_detach_flag=${1:-detach} # schedule detach
}
function ble-detach/impl {
  [[ $_ble_attached ]] || return 1
  _ble_attached=
  BLE_ATTACHED=
  blehook/invoke DETACH
  ble-edit/detach
  ble/decode/detach
  READLINE_LINE='' READLINE_POINT=0
}
function ble-detach/message {
  ble/util/buffer.flush >&2
  printf '%s\n' "$@" 1>&2
  ble/edit/info/clear
  ble/textarea#render
  ble/util/buffer.flush >&2
}
function ble/base/unload-for-reload {
  if [[ $_ble_attached ]]; then
    ble-detach/impl
    ble/util/print "${_ble_term_setaf[12]}[ble: reload]$_ble_term_sgr0" 1>&2
    [[ $_ble_edit_detach_flag ]] ||
      _ble_edit_detach_flag=reload
  fi
  ble/base/unload
  return 0
}
function ble/base/unload {
  ble/util/is-running-in-subshell && return 1
  local IFS=$_ble_term_IFS
  builtin unset -v _ble_bash BLE_VERSION BLE_VERSINFO
  ble/term/stty/TRAPEXIT
  ble/term/leave
  ble/util/buffer.flush >&2
  blehook/invoke unload
  ble/decode/keymap#unload
  ble-edit/bind/clear-keymap-definition-loader
  ble/builtin/trap/finalize
  ble/util/import/finalize
  ble/fd#finalize
  ble/bin/rm -rf "$_ble_base_run/$$".* 2>/dev/null
  return 0
}
_ble_base_attach_from_prompt=
_ble_base_attach_PROMPT_COMMAND=()
function ble/base/install-prompt-attach {
  [[ ! $_ble_base_attach_from_prompt ]] || return 0
  _ble_base_attach_from_prompt=1
  if ((_ble_bash>=50100)); then
    ((${#PROMPT_COMMAND[@]})) || PROMPT_COMMAND[0]=
    ble/array#push PROMPT_COMMAND ble/base/attach-from-PROMPT_COMMAND
    if [[ $_ble_edit_detach_flag == reload ]]; then
      _ble_edit_detach_flag=prompt-attach
      blehook PRECMD+=ble/base/attach-from-PROMPT_COMMAND
    fi
  else
    local save_index=${#_ble_base_attach_PROMPT_COMMAND[@]}
    _ble_base_attach_PROMPT_COMMAND[save_index]=${PROMPT_COMMAND-}
    ble/function#lambda PROMPT_COMMAND \
                        "ble/base/attach-from-PROMPT_COMMAND $save_index \"\$FUNCNAME\""
    ble/function#trace "$PROMPT_COMMAND"
    if [[ $_ble_edit_detach_flag == reload ]]; then
      _ble_edit_detach_flag=prompt-attach
      blehook PRECMD+="$PROMPT_COMMAND"
    fi
  fi
}
_ble_base_attach_from_prompt_lastexit=
_ble_base_attach_from_prompt_lastarg=
_ble_base_attach_from_prompt_PIPESTATUS=()
function ble/base/attach-from-PROMPT_COMMAND {
  {
    _ble_base_attach_from_prompt_lastexit=$? \
      _ble_base_attach_from_prompt_lastarg=$_ \
      _ble_base_attach_from_prompt_PIPESTATUS=("${PIPESTATUS[@]}")
    if ((BASH_LINENO[${#BASH_LINENO[@]}-1]>=1)); then
      _ble_edit_exec_lastexit=$_ble_base_attach_from_prompt_lastexit
      _ble_edit_exec_lastarg=$_ble_base_attach_from_prompt_lastarg
      _ble_edit_exec_PIPESTATUS=("${_ble_base_attach_from_prompt_PIPESTATUS[@]}")
      _ble_edit_exec_BASH_COMMAND=$FUNCNAME
    fi
    local is_last_PROMPT_COMMAND=1
    if (($#==0)); then
      if local ret; ble/array#index PROMPT_COMMAND ble/base/attach-from-PROMPT_COMMAND; then
        local keys; keys=("${!PROMPT_COMMAND[@]}")
        ((ret==keys[${#keys[@]}-1])) || is_last_PROMPT_COMMAND=
        ble/idict#replace PROMPT_COMMAND ble/base/attach-from-PROMPT_COMMAND
      fi
      blehook PRECMD-=ble/base/attach-from-PROMPT_COMMAND || ((1)) # set -e 対策
    else
      local save_index=$1 lambda=$2
      local PROMPT_COMMAND_local=
      [[ $PROMPT_COMMAND == "$lambda" ]] || local PROMPT_COMMAND is_last_PROMPT_COMMAND=
      PROMPT_COMMAND=${_ble_base_attach_PROMPT_COMMAND[save_index]}
      local ble_base_attach_from_prompt_command=processing
      ble/prompt/update/.eval-prompt_command 2>&3
      ble/util/unlocal ble_base_attach_from_prompt_command
      _ble_base_attach_PROMPT_COMMAND[save_index]=$PROMPT_COMMAND
      [[ $is_last_PROMPT_COMMAND ]] || ble/util/unlocal PROMPT_COMMAND
      blehook PRECMD-="$lambda" || ((1)) # set -e 対策
      [[ ${ble_base_attach_from_prompt_command-} != processing ]] || return
    fi
    [[ $_ble_base_attach_from_prompt ]] || return 0
    _ble_base_attach_from_prompt=
    if [[ $is_last_PROMPT_COMMAND ]]; then
      ble-edit/exec:gexec/invoke-hook-with-setexit PRECMD
      _ble_prompt_hash=$COLUMNS:$_ble_edit_lineno:prompt_attach
    fi
  } 3>&2 2>/dev/null # set -x 対策 #D0930
  ble-attach force
  ble/util/joblist.flush &>/dev/null
  ble/util/joblist.check
}
function ble/base/process-blesh-arguments {
  local opts=$_ble_base_arguments_opts
  local attach=$_ble_base_arguments_attach
  if [[ :$opts: == *:noinputrc:* ]]; then
    _ble_builtin_bind_user_settings_loaded=noinputrc
    _ble_builtin_bind_inputrc_done=noinputrc
  fi
  if [[ :$opts: != *:keep-rlvar:* ]]; then
    ((_ble_bash>=40100)) && builtin bind 'set skip-completed-text on'
    ((_ble_bash>=40300)) && builtin bind 'set colored-stats on'
    ((_ble_bash>=40400)) && builtin bind 'set colored-completion-prefix on'
  fi
  _ble_base_rcfile=$_ble_base_arguments_rcfile
  ble/base/load-rcfile # blerc
  ble/util/invoke-hook BLE_ONLOAD
  case $attach in
  (attach) ble-attach ;;
  (prompt) ble/base/install-prompt-attach ;;
  (none) ;;
  (*) ble/util/print "ble.sh: unrecognized attach method --attach='$attach'." ;;
  esac
}
function ble/base/sub:test {
  local error= logfile=
  ble-import lib/core-test
  if (($#==0)); then
    set -- main util canvas decode edit syntax complete
    logfile=$_ble_base_cache/test.$(date +'%Y%m%d.%H%M%S').log
    : >| "$logfile"
    ble/test/log#open "$logfile"
  fi
  if ((!_ble_make_command_check_count)); then
    ble/test/log "MACHTYPE: $MACHTYPE"
    ble/test/log "BLE_VERSION: $BLE_VERSION"
  fi
  ble/test/log "BASH_VERSION: $BASH_VERSION"
  local section
  for section; do
    local file=$_ble_base/lib/test-$section.sh
    if [[ -f $file ]]; then
      source "$file" || error=1
    else
      ble/test/log "ERROR: Test '$section' is not defined."
      error=1
    fi
  done
  if [[ $logfile ]]; then
    ble/test/log#close
    ble/util/print "ble: The test log was saved to '${_ble_term_setaf[4]}$logfile$_ble_term_sgr0'."
  fi
  [[ ! $error ]]
}
function ble/base/sub:update { ble-update; }
function ble/base/sub:clear-cache {
  (shopt -u failglob; ble/bin/rm -rf "$_ble_base_cache"/*)
}
ble/function#trace ble-attach
ble/function#trace ble
ble/function#trace ble/dispatch
ble/function#trace ble/base/attach-from-PROMPT_COMMAND
ble/function#trace ble/base/unload
ble/function#trace ble/builtin/trap/finalize
ble-import -f lib/_package
if [[ $_ble_init_command ]]; then
  ble/base/sub:"$_ble_init_command"; _ble_init_exit=$?
  [[ $_ble_init_attached ]] && ble-attach
  ble/util/setexit "$_ble_init_exit"
else
  ble/base/process-blesh-arguments "$@"
fi
ble/init/clean-up check-attach 2>/dev/null # set -x 対策 #D0930
{ builtin eval "return $? || exit $?"; } 2>/dev/null # set -x 対策 #D0930
