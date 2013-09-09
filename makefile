all:
	./node_modules/.bin/mesh build-src;

all-watch:
	./node_modules/.bin/mesh build-src --watch;


clean:
	rm -rf lib;