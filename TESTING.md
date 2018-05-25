When contributing to this cookbook, ensure that all tests are run and can pass. We use Test Kitchen, Inspec, ChefSpec, rubocop, and foodcritic to execute integration, functional, and style tests. Using the Rakefile contained in this cookbook, these tasks are much simplified by running `rake -A` to execute all tests.

These tasks are available (a more detailed list can be had by running `rake -T -A`):
- `rake integration` - Run Test Kitchen integration tests
- `rake kitchen:all` - Run all Test Kitchen instances
- `rake spec` - Run ChefSpec unit tests
- `rake style` - Run all style checks
