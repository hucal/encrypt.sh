# `encrypt.sh`

To encrypt a file or directory:

```
# Encrypt a file
> encrypt.sh file 

# Encrypt and compress
> encrypt.sh directory --tar

> ls
file file.aes256 file.sha256
directory directory.tgz.aes256 directory.tgz.sha256
```

`encrypt.sh` creates a pair of files `*.aes256` and `*.sha256`.

# `decrypt.sh`

To decrypt the file and verify the result, use `decrypt.sh`.

```
# Decrypt
decrypt.sh directory.tgz.sha256 output/directory

# In-place decryption
# Same as
# decrypt.sh directory.tgz.sha256 directory.tgz
decrypt.sh directory.tgz.sha256
```
