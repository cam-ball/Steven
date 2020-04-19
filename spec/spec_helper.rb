ENV['test'] = 'true'

require "bundler/setup"
require "Steven"
require 'support/discord_helpers'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include(DiscordHelper)

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
