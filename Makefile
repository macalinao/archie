REPORTER = spec

test:
	@NODE_ENV=test ./node_modules/.bin/mocha \
		--reporter $(REPORTER) \
		test/*.coffee

	rm -rf test/sandbox/

.PHONY: test
