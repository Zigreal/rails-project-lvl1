install: # install dependencies
	bundle install
lint: # run rubocop checking
	rubocop
run-tests: # run test
	ruby test/test_hexlet_code.rb
