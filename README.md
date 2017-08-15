# `encrypt.sh`

To encrypt a file or directory:

```
# Encrypt
encrypt.sh file 

# Encrypt and compress
encrypt.sh directory --tar
```

This creates a pair of files `*.aes256` and `*.sha256`.
To decrypt them and verify the result, use:

```
# Decrypt
decrypt.sh directory.tgz output/directory

# In-place decryption
decrypt.sh directory.tgz
```
