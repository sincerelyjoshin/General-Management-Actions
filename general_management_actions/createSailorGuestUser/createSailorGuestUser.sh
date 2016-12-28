#!/bin/bash

# Original script by Noel B. Alonso: https://gist.github.com/nbalonso/5696340
# Aditional scripting by Rich Trouton

# Variables
DSCL="/usr/bin/dscl"
SECURITY="/usr/bin/security"
LOGGER="/usr/bin/logger"

# Determine OS version
OSVERS=$(sw_vers -productVersion | awk -F. '{print $2}')

# Set the account shortname
USERNAME="sailor"

# Set the name which is displayed in System Preferences for the account
DISPLAYNAME="Sailor User"

# Set the account's UID
GUESTUID="600"

# Set the account's GID
GUESTGROUPID="600"

if [[ ${OSVERS} -lt 6 ]]
  then
    ${LOGGER} -s -t create"${USERNAME}".sh "ERROR: The version of OS X running on this Mac is not supported by this script. User account not created."
fi

if [[ ${OSVERS} -eq 6 ]]
  then
    ${LOGGER} -s -t create"${USERNAME}".sh "INFO: Creating the "${USERNAME}" user account on Mac OS X 10.${OSVERS}.x"
    ${DSCL} . -create /Users/"${USERNAME}"
    ${DSCL} . -create /Users/"${USERNAME}" UserShell /bin/bash
    ${DSCL} . -create /Users/"${USERNAME}" RealName "${DISPLAYNAME}"
    ${DSCL} . -create /Users/"${USERNAME}" UniqueID "${GUESTUID}"
    ${DSCL} . -create /Users/"${USERNAME}" PrimaryGroupID "${GUESTGROUPID}"
    ${DSCL} . -create /Users/"${USERNAME}" NFSHomeDirectory /Users/"${USERNAME}"
    ${DSCL} . -create /Users/"${USERNAME}" RecordType dsRecTypeStandard:Users
    ${DSCL} . -create /Users/"${USERNAME}" dsAttrTypeNative:_defaultLanguage en
    ${DSCL} . -create /Users/"${USERNAME}" dsAttrTypeNative:_guest true
    ${DSCL} . -create /Users/"${USERNAME}" dsAttrTypeNative:_writers__defaultLanguage "${USERNAME}"
    ${DSCL} . -create /Users/"${USERNAME}" dsAttrTypeNative:_writers_jpegphoto "${USERNAME}"
    ${DSCL} . -create /Users/"${USERNAME}" dsAttrTypeNative:_writers_LinkedIdentity "${USERNAME}"
    ${DSCL} . -create /Users/"${USERNAME}" dsAttrTypeNative:_writers_picture "${USERNAME}"
    ${DSCL} . -create /Users/"${USERNAME}" dsAttrTypeNative:_writers_UserCertificate "${USERNAME}"
    ${DSCL} . -create /Users/"${USERNAME}" AppleMetaNodeLocation /Local/Default
    ${DSCL} . -passwd /Users/"${USERNAME}" "${USERNAME}"
    sleep 2
fi

if [[ ${OSVERS} -ge 7 ]]
  then
		${LOGGER} -s -t create"${USERNAME}".sh "INFO: Creating the "${USERNAME}" user account on Mac OS X 10.${OSVERS}.x"
		${DSCL} . -create /Users/"${USERNAME}"
		${DSCL} . -create /Users/"${USERNAME}" dsAttrTypeNative:_defaultLanguage en
		${DSCL} . -create /Users/"${USERNAME}" dsAttrTypeNative:_guest true
		${DSCL} . -create /Users/"${USERNAME}" dsAttrTypeNative:_writers__defaultLanguage "${USERNAME}"
		if [[ ${OSVERS} -eq 7 ]]
      then
        ${DSCL} . -create /Users/"${USERNAME}" dsAttrTypeNative:_writers_LinkedIdentity "${USERNAME}"
		fi
		${DSCL} . -create /Users/"${USERNAME}" dsAttrTypeNative:_writers_UserCertificate "${USERNAME}"
		${DSCL} . -create /Users/"${USERNAME}" AuthenticationHint ''
		${DSCL} . -create /Users/"${USERNAME}" NFSHomeDirectory /Users/"${USERNAME}"
		${DSCL} . -passwd /Users/"${USERNAME}" ""${USERNAME}""
		sleep 2
		${DSCL} . -create /Users/"${USERNAME}" Picture "/Library/User Pictures/Nature/Leaf.tif"
		${DSCL} . -create /Users/"${USERNAME}" PrimaryGroupID "${GUESTGROUPID}"
		${DSCL} . -create /Users/"${USERNAME}" RealName "${DISPLAYNAME}"
		${DSCL} . -create /Users/"${USERNAME}" RecordName "${USERNAME}"
		${DSCL} . -create /Users/"${USERNAME}" UniqueID "${GUESTUID}"
		${DSCL} . -create /Users/"${USERNAME}" UserShell /bin/bash
		${SECURITY} add-generic-password -a "${USERNAME}" -s com.apple.loginwindow.guest-account -A -w "${USERNAME}" -D "application password" /Library/Keychains/System.keychain
fi

${LOGGER} -s -t create"${USERNAME}".sh "INFO: Exiting"

exit 0
