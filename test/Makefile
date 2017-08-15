all: clean test_dir test_file 

test_dir:
	../encrypt.sh dir --tar
	../decrypt.sh dir.tgz result/dir
	
test_file:
	../encrypt.sh file
	../decrypt.sh file result/file

clean:
	rm -rf [a-z]*.* result/**
