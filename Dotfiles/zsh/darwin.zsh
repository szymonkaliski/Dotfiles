# make completion /Applications aware
compctl -f \
  -x 'p[2]' \
  -s "$(/bin/ls -d1 /Applications/*/*.app /Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g')" \
  -- open
alias run="open -a"
alias qopen="qlmanage -p "$@" >& /dev/null"

alias clear-logs="sudo rm -rfv /private/var/log/asl/*.asl"
alias clear-tmp="sudo rm -rfv /private/var/tmp/Xcode/ /private/var/tmp/Processing/"
alias clear-dsstore="find . -name '.DS_Store' -depth -exec rm {} \;"

alias flush="dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias purge="sudo purge"

alias localip="ipconfig getifaddr en0"
alias opened-ports="sudo lsof -i -P | grep -i 'listen'"
alias stroke="/System/Library/CoreServices/Applications/Network\ Utility.app/Contents/Resources/stroke"
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

alias chrome-kill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

alias clout="fc -e - | pbcopy"
alias cpwd="pwd | pbcopy"

# fix for xterm-256color-italic on osx
alias ssh="TERM=xterm-256color ssh"

# fixes for processess getting stuck
alias fix-camera="sudo killall VDCAssistant"
alias fix-icloud="sudo killall cloudd bird"

# ethereum
alias geth="$HOME/Library/Application\ Support/Ethereum\ Wallet/binaries/Geth/unpacked/geth"

# hammerspoon
alias hs="/usr/local/bin/hs"

# nice markdown files in cli using markdown-pdf from npm
if hash markdown-pdf 2> /dev/null; then
  alias markdown-pdf-nice="markdown-pdf --css-path ~/Documents/Code/Markdown/Byword.css --render-delay 50 --paper-border 2cm"
fi

# local projects
# alias timav="(cd $HOME/Documents/Projects/Timav && NODE_ENV=production npm start) > /dev/null &"
alias neutron="~/Documents/Projects/neutron/node_modules/.bin/electron ~/Documents/Projects/neutron/src/index.js"

# taskpaper
if [ -d ~/Documents/Dropbox/Tasks/ ]; then
  alias tasks="node ~/Documents/Projects/taskpaper-next/app.js --path ~/Documents/Dropbox/Tasks/Todo.taskpaper"
fi

# cd to currently open dir in finder
cdf() {
  local dir="$(osascript -e 'try' \
    -e 'tell application "Finder" to get POSIX path of (target of front Finder window as text)' \
    -e 'end try')"
  cd "$dir"
}

# shorter open
o() {
  if [ "$#" -ne 0 ]; then
    ARG="${1:+"$@"}"
  else
    ARG="."
  fi

  open $ARG
}

# dash
dash() {
  open "dash://$*"
}
