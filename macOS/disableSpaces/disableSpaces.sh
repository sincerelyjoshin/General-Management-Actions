#!/bin/bash

#ladmin exclusion specific to my environment
loggedInUser=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u"", u"ladmin"]]; sys.stdout.write(username + "\n");'`

if [ -z loggedInUser ]
  then
    echo "logged in user does not meet criteria"; exit 1
fi

sudo -u $loggedInUser defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 79 "{ enabled = 0; }"

sudo -u $loggedInUser defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 80 "{ enabled = 0; }"

sudo -u $loggedInUser defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 81 "{ enabled = 0; }"

sudo -u $loggedInUser defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 82 "{ enabled = 0; }"

exit 0
