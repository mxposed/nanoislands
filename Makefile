NPM_BIN=$(CURDIR)/node_modules/.bin
export NPM_BIN

MAKEFLAGS+=-j 4

all: node_modules demo/demo.yate.js demo/demo.jst.js nanoislands.css nanoislands.ie.css nanoislands.js

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

nanoislands.ie.css: $(shell find . -name '*.styl') node_modules
	node build/build-styl.js ie > $@

nanoislands.js: $(CURDIR)/blocks/nanoislands.js $(shell find $(CURDIR)/blocks -name '*.js') node_modules
	$(NPM_BIN)/borschik --input=blocks/nanoislands.js --minimize=no --output=nanoislands.js

node_modules:
	npm install

clean:
	rm -rf demo/demo.yate.js nanoislands.css nanoislands.ie.css nanoislands.js

.PHONY: all clean
