#!/bin/bash
if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]; then
    echo Usage: $0 FILE.sha256 [OUTPUT]
    exit 0
fi

IN=$1
NAME=`basename $1 .aes256`
SIGN=$NAME.sha256

if [ "$#" -eq 2 ]; then
OUT=$2
else
OUT=$NAME
fi

if [ -f $SIGN ]; then
	BYTES=`wc -c $IN | cut -d' ' -f1`
	BYTES_KNOWN=`head $SIGN -n1 | cut -d' ' -f1`
	if [ "$BYTES" != "$BYTES_KNOWN" ]; then
		echo -------------- FILE DAMAGED. INCORRECT SIZE -------------- 
		exit 1
	fi

	SHA256=`sha256sum $IN | cut -d' ' -f1`
	SHA256_KNOWN=`head $SIGN -n1 | cut -d' ' -f2`
	if [ "$SHA256" != "$SHA256_KNOWN" ]; then
		echo -------------- FILE DAMAGED. INCORRECT SIGNATURE -------------- 
		exit 1
	fi

else
	echo No signature file $SIGN found. Cannot verify file.
fi

gpg --output $OUT --decrypt $IN

if [ "$OUT" == "*.tgz" ]; then
    tar xzf $OUT
fi
