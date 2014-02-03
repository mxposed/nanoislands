NPM_BIN=$(CURDIR)/node_modules/.bin
NPM=$(CURDIR)/node_modules/
export NPM_BIN
export NPM

MAKEFLAGS+=-j 4

#all: node_modules demo/demo.yate.js demo/demo.jst.js nanoislands.css nanoislands.ie.css nanoislands.js unittests/tests.yate.js
all: node_modules demo/demo.yate.js nanoislands.css nanoislands.ie.css nanoislands.js unittests/tests.yate.js

nanoislands.css: $(shell find . -name '*.styl') node_modules
	node build/build-styl.js > $@

demo/demo.yate.js: $(shell find . -name '*.yate') node_modules
	$(NPM_BIN)/yate $(CURDIR)/demo/nanoislands.yate > $@

demo/blocks.jst.js: $(shell find ./blocks -name '*.jst') node_modules
	$(NPM_BIN)/jst --template=lodash --include=blocks/*/*.jst --variable=data --output=demo/tmp.jst.js
	cat demo/tmp.jst.js | sed -e 's/window\.JST\["blocks\/[^\/]*\//window.JST["/g' > demo/blocks.jst.js
	rm demo/tmp.jst.js

demo/demo.jst.js: $(shell find ./demo -name '*.jst') demo/blocks.jst.js
	$(NPM_BIN)/jst --template=lodash --include=demo/*.jst --variable=data --output=demo/tmp.jst.js
	cat demo/tmp.jst.js | sed -e 's/window\.JST\["demo\//window.JST["/g' > demo/demo.jst.js
	rm demo/tmp.jst.js

unittests/tests.yate.js: $(shell find $(CURDIR)/unittests -name '*.yate') node_modules
	$(NPM_BIN)/yate $(CURDIR)/unittests/tests.yate > $@

nanoislands.ie.css: $(shell find . -name '*.styl') node_modules
	node build/build-styl.js ie > $@

nanoislands.js: $(CURDIR)/blocks/nanoislands.js $(shell find $(CURDIR)/blocks -name '*.js') node_modules
	$(NPM_BIN)/borschik --input=blocks/nanoislands.js --minimize=no --output=nanoislands.js

node_modules:
	npm install

watch: node_modules
	$(NPM)/grunt-cli/bin/grunt watch

publish:
	rm -rf node_modules
	make clean
	npm test
	npm publish

grunt: node_modules
	$(NPM_BIN)/grunt

clean:
	rm -rf demo/demo.yate.js nanoislands.css nanoislands.ie.css nanoislands.js unittests/tests.yate.js grunt

.PHONY: all publish clean watch
