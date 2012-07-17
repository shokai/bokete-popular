#!/bin/sh
TMP=/var/tmp/bokete.jpg

cd `dirname $0`
bundle exec ruby bin/capture_and_upload.rb $TMP
rm -f $TMP
