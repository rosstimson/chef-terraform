### Contributing

Pull requests are very welcome! Ideally create a topic branch for every
separate change you make.

This cookbook uses [ChefSpec][chefspec] for unit tests. I also use [Food
Critic][foodcritic] and [RuboCop][rubocop] to check for style issues.
When contributing it would be very helpful if you could run these via
`bundle exec spec` and `bundle exec style`.

Lastly, there are [Inspec][inspec] integration tests for
use with [Test Kitchen][testkitchen]. To see all of the available
integration test suites just check `bundle exec rake T` or `bundle exec
kitchen list`. It would be great if you could run these tests too, you
may however leave out the Amazon Linux test suite if you do not have
an AWS account as it runs on an EC2 instance (you will be billed for
running this).

