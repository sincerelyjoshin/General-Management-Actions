#!/bin/sh

if [[ -e /Library/Java/Home ]]
then
echo "<result>$(java -version 2>&1 | awk '/version/{print $3}' | sed 's/"//g')</result>"
else
echo "<result>Java runtime not installed</result>"
fi

exit 0
