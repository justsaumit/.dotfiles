# this script is a part of blesh (https://github.com/akinomyoga/ble.sh) under BSD-3-Clause license
function ble/init:bind/append {
  local xarg="\"$1\":ble-decode/.hook $2; builtin eval -- \"\$_ble_decode_bind_hook\""
  local rarg=$1 condition=$3${3:+' && '}
  ble/util/print "${condition}builtin bind -x '${xarg//$q/$Q}'" >> "$fbind1"
  ble/util/print "${condition}builtin bind -r '${rarg//$q/$Q}'" >> "$fbind2"
}
function ble/init:bind/append-macro {
  local kseq1=$1 kseq2=$2 condition=$3${3:+' && '}
  local sarg="\"$kseq1\":\"$kseq2\"" rarg=$kseq1
  ble/util/print "${condition}builtin bind    '${sarg//$q/$Q}'" >> "$fbind1"
  ble/util/print "${condition}builtin bind -r '${rarg//$q/$Q}'" >> "$fbind2"
}
function ble/init:bind/generate-binder {
  local fbind1=$_ble_base_cache/decode.bind.$_ble_bash.$bleopt_input_encoding.bind
  local fbind2=$_ble_base_cache/decode.bind.$_ble_bash.$bleopt_input_encoding.unbind
  ble/edit/info/show text "ble.sh: updating binders..."
  : >| "$fbind1"
  : >| "$fbind2"
  local q=\' Q="'\\''"
  local altdqs24='\xC0\x98'
  local altdqs27='\xC0\x9B'
  local esc00=$((40300<=_ble_bash&&_ble_bash<50000))
  local bind18XX=0
  if ((40400<=_ble_bash&&_ble_bash<50000)); then
    ble/util/print "[[ -o emacs ]] && builtin bind 'set keyseq-timeout 1'" >> "$fbind1"
    fbind2=$fbind1 ble/init:bind/append '\C-x\C-x' 24 '[[ -o emacs ]]'
  elif ((_ble_bash<40300)); then
    bind18XX=1
  fi
  local esc1B=3
  local esc1B5B=1 bindAllSeq=0
  local esc1B1B=$((40100<=_ble_bash&&_ble_bash<40300))
  local i
  for i in {128..255} {0..127}; do
    local ret; ble/decode/c2dqs "$i"
    if ((i==0)); then
      if ((esc00)); then
        ble/init:bind/append-macro '\C-@' '\xC0\x80'
      else
        ble/init:bind/append "$ret" "$i"
      fi
    elif ((i==24)); then
      if ((bind18XX)); then
        ble/init:bind/append "$ret" "$i" '[[ ! -o emacs ]]'
      else
        ble/init:bind/append "$ret" "$i"
      fi
    elif ((i==27)); then
      if ((esc1B==0)); then
        ble/init:bind/append "$ret" "$i"
      elif ((esc1B==2)); then
        ble/init:bind/append-macro '\e' "$altdqs27"
      elif ((esc1B==3)); then
        ble/init:bind/append-macro '\e' '\xDF\xBF' # C-[
      fi
    else
      ((i==28&&_ble_bash>=50000)) && ret='\x1C'
      ble/init:bind/append "$ret" "$i"
    fi
    if ((bind18XX)); then
      if ((i==24)); then
        ble/init:bind/append-macro "\C-x$ret" "$altdqs24$altdqs24" '[[ -o emacs ]]'
      else
        ble/init:bind/append-macro "\C-x$ret" "$altdqs24$ret"      '[[ -o emacs ]]'
      fi
    fi
    if ((esc1B==3)); then
      ble/init:bind/append-macro '\e'"$ret" "$altdqs27$ret"
    else
      if ((esc1B==1)); then
        if ((i==91&&esc1B5B)); then
          ble/init:bind/append-macro '\e[' "$altdqs27["
        else
          ble/init:bind/append "\\e$ret" "27 $i"
        fi
      fi
      if ((i==27&&esc1B1B)); then
        ble/init:bind/append-macro '\e\e' '\e[^'
        ble/util/print "ble-bind -k 'ESC [ ^' __esc__"      >> "$fbind1"
        ble/util/print "ble-bind -f __esc__ '.CHARS 27 27'" >> "$fbind1"
      fi
    fi
  done
  if ((bindAllSeq)); then
    ble/util/print 'source "$_ble_decode_bind_fbinder.bind"' >> "$fbind1"
    ble/util/print 'source "$_ble_decode_bind_fbinder.unbind"' >> "$fbind2"
  fi
  ble/function#try ble/encoding:"$bleopt_input_encoding"/generate-binder
  ble/edit/info/immediate-show text "ble.sh: updating binders... done"
}
ble/init:bind/generate-binder
