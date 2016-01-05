#!/bin/bash

# Copyright (C) 2015 Open GApps
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# Parts of this script are taken from the Open GApps project

# Define paths && variables
TOOLSDIR=$(realpath .)/tools
GAPPSDIR=$(realpath .)/files
FINALDIR=$(realpath .)/out
ZIPNAME1TITLE=BaNkS_Dynamic_GApps
ZIPNAME1VERSION=6.x.x
ZIPNAME1DATE=$(date +%-m-%-e-%-y)_$(date +%H:%M)
ZIPNAME2TITLE=BANKS_GAPPS
ZIPNAME2VERSION=6.XX
ZIPNAME1="$ZIPNAME1TITLE"_"$ZIPNAME1VERSION"_"$ZIPNAME1DATE".zip
ZIPNAME2="$ZIPNAME2TITLE"_"$ZIPNAME2VERSION".zip
 
dcapk() {
export PATH=$TOOLSDIR:$PATH
TARGETDIR=$(realpath .)
TARGETAPK=$TARGETDIR/$(basename "$TARGETDIR").apk
  unzip -q -o "$TARGETAPK" -d "$TARGETDIR" "lib/*"
  zip -q -d "$TARGETAPK" "lib/*"
  cd "$TARGETDIR"
  zip -q -r -D -Z store -b "$TARGETDIR" "$TARGETAPK" "lib/"
  rm -rf "${TARGETDIR:?}"/lib/
  mv -f "$TARGETAPK" "$TARGETAPK".orig
  zipalign -f -p 4 "$TARGETAPK".orig "$TARGETAPK"
  rm -rf "$TARGETAPK".orig
}
   
cd "$GAPPSDIR/dynamic/FaceLock/arm/app/FaceLock"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/dynamic/FaceLock/arm64/app/FaceLock"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/dynamic/PrebuiltGmsCore/430/priv-app/PrebuiltGmsCore"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/dynamic/PrebuiltGmsCore/434/priv-app/PrebuiltGmsCore"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/dynamic/PrebuiltGmsCore/436/priv-app/PrebuiltGmsCore"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/dynamic/PrebuiltGmsCore/438/priv-app/PrebuiltGmsCore"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/dynamic/PrebuiltGmsCore/440/priv-app/PrebuiltGmsCore"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/dynamic/PrebuiltGmsCore/446/priv-app/PrebuiltGmsCore"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/dynamic/SetupWizard/phone/priv-app/SetupWizard"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/dynamic/SetupWizard/tablet/priv-app/SetupWizard"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/dynamic/Velvet/arm/priv-app/Velvet"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/dynamic/Velvet/arm64/priv-app/Velvet"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/system/app/GoogleCalendarSyncAdapter"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/system/app/GoogleContactsSyncAdapter"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/system/app/GoogleTTS"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/system/priv-app/GoogleBackupTransport"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/system/priv-app/GoogleFeedback"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/system/priv-app/GoogleLoginService"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/system/priv-app/GoogleOneTimeInitializer"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/system/priv-app/GooglePartnerSetup"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/system/priv-app/GoogleServicesFramework"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/system/priv-app/HotwordEnrollment"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR/system/priv-app/Phonesky"
dcapk 1> /dev/null 2>&1
cd "$GAPPSDIR"
zip -q -r -9 "$ZIPNAME1" ./*
mv -f "$ZIPNAME1" "$TOOLSDIR"
cd "$TOOLSDIR"
java -Xmx2048m -jar signapk.jar -w testkey.x509.pem testkey.pk8 "$ZIPNAME1" "$ZIPNAME1"
mv -f "$ZIPNAME1" "$FINALDIR"
cp -f "$FINALDIR"/"$ZIPNAME1" "$FINALDIR"/"$ZIPNAME2"
cd

clear
sleep 2
echo "All done creating GApps!"
echo "You can find the completed GApp zips in the '$(realpath .)/out' directory"
echo "Now flash dat ish"

exit 0
