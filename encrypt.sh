#!/bin/bash
if [ "$#" -ne 2 ] && [ "$#" -ne 1 ] ; then 
    echo Usage: $0 FILENAME [--tar]
    exit 0
fi

# set -x
if [ "$#" -eq 2 ]; then
    TAR=$1.tgz
fi

if [[ $TAR == *.tgz ]] || [[ $TAR == *.tar.gz ]]; then
    tar czf $TAR $1
    IN=$TAR
else
    IN=$1
fi

OUT=$IN.aes256
SIGN=$IN.sha256

if [ -f $OUT ]; then
    rm -i $OUT
fi
if [ -f $SIGN ]; then
    rm -i $SIGN
fi

gpg --output $OUT --symmetric --cipher-algo AES256 $IN

BYTES=`wc -c $OUT | cut -d' ' -f1`
SHA256=`sha256sum $OUT | cut -d' ' -f1`
printf "%s %s\n" "$BYTES" "$SHA256" >> $SIGN

set +x
gpg --version >> $SIGN

echo Output: $OUT
echo Verification: $SIGN
