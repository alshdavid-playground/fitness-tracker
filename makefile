.PHONY: build
default: clean build

dev:
	npx concurrently \
		"npx http-server public -s -c-1" \
		"npx webpack --watch --es2015"

dev-cli:
	npx concurrently \
		"npx http-server public -s -c-1" \
		"npx webpack --watch --es2015 --cli"

build: 
	make build-es2015 
	make build-es5

build-es2015:
	npx webpack --prod --es2015

build-es2015-stats: 
	npx webpack --prod --stats --es2015

build-es5: 
	npx webpack --prod

build-es5-stats: 
	npx webpack --prod --stats

build-stats: 
	make build-es2015-stats

watch: build-watch
build-watch: 
	npx webpack --watch --es2015

build-watch-prod: 
	npx webpack --watch --es2015 --prod

clean: 
	npx webpack --clean

lint:
	npx tslint  "src/**/*.{ts,tsx}"

lint-fix:
	npx tslint --fix "src/**/*.{ts,tsx}"

test:
	npx jest --passWithNoTests

test-watch:
	npx jest --watch --passWithNoTests