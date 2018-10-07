#!/bin/bash
if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]; then
    echo "Usage: $0 FILE.aes256 [OUTPUT]"
    echo ""
    echo "This script verifies the encrypted file FILE.aes256 and decrypts it."
    echo "Verification is done by using filesize and sha256 hash in the FILE.sha256 file."
    echo "If verification is not desired, make sure FILE.aes256 is not present."
    exit 0
fi

IN="$1"
NAME=$(basename "$1" .aes256)
SIGN="$NAME.sha256"

if [ "$#" -eq 2 ]; then
OUT="$2"
else
OUT="$NAME"
fi

if [ -f "$SIGN" ]; then
    echo "Verifying content integrity using $SIGN"
    BYTES=$(wc -c "$IN" | cut -d' ' -f1)
    BYTES_KNOWN=$(head "$SIGN" -n1 | cut -d' ' -f1)
	if [ "$BYTES" != "$BYTES_KNOWN" ]; then
		echo -------------- FILE DAMAGED. INCORRECT SIZE -------------- 
        echo "size $BYTES != known size $BYTES_KNOWN"
		exit 1
	fi

    SHA256=$(sha256sum "$IN" | cut -d' ' -f1)
    SHA256_KNOWN=$(head "$SIGN" -n1 | cut -d' ' -f2)
	if [ "$SHA256" != "$SHA256_KNOWN" ]; then
		echo -------------- FILE DAMAGED. INCORRECT SIGNATURE -------------- 
        echo "hash $SHA256 != known hash $SHA256_KNOWN"
		exit 1
	fi

else
	echo "No signature file $SIGN found. Cannot verify file."
fi

echo Decrypting file $IN to output $OUT
gpg --output "$OUT" --decrypt "$IN"

if [ "$OUT" == "*.tgz" ]; then
    echo "Decompressing tgz archive"
    tar xzf "$OUT"
fi
