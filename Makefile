run:
	pulp run

node: build
	node index.js

build:
	pulp build
