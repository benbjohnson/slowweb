Slow Web - An HTTP Request Governor
===================================

## DESCRIPTION

Slow Web is a way to limit the number of requests to a domain within a certain
period of time. It is inspired by Chris Kampmeier's
[FakeWeb](https://github.com/chrisk/fakeweb).

For example, the GitHub API only allows for 60 requests per minute. Slow Web can
monitor the number of calls to that domain and will sleep on the next request
that is over the limit.

Slow Web follows the rules of [Semantic Versioning](http://semver.org/).


## RUNNING

To install Slow Web, simply install the gem:

	$ [sudo] gem install slowweb

And specify the domain to limit.

	require 'slowweb'
	SlowWeb.limit('example.com', 10, 60)

This restricts the `example.com` domain to only allowing `10` requests every
`60` seconds.


## EXAMPLE

Because SlowWeb attaches to the low-level Net::HTTP class, all API gems should
work. For example, you can use the [Octopi](https://github.com/fcoury/octopi)
API to access GitHub information and use SlowWeb to restrict calls
automatically.

	require 'slowweb'
	SlowWeb.limit('github.com', 60, 60)  # 60 requests per minute
	
	# Use up all the API requests for this minute
	60.times do |i|
	  tpw = Octopi::User.find('mojombo')
	end
	
	# This request will wait until a minute after the first request was sent
	wanstrath = Octopi::User.find('defunkt')

This code will retrieve user information on
[Tom Preston-Warner (mojombo)](https://github.com/mojombo) sixty times and then
attempts to access user information for
[Chris Wanstrath (defunkt)](https://github.com/defunkt). However when the API
call is made to view `defunkt`, SlowWeb will cause your application sleep until
a minute has passed since your first request to mojombo.


## CONTRIBUTE

If you'd like to contribute to SlowWeb, start by forking the repository
on GitHub:

http://github.com/benbjohnson/slowweb

Then follow these steps to send your changes:

1. Clone down your fork
1. Create a topic branch to contain your change
1. Code
1. All code must have MiniTest::Unit test coverage.
1. If you are adding new functionality, document it in the README
1. If necessary, rebase your commits into logical chunks, without errors
1. Push the branch up to GitHub
1. Send me a pull request for your branch