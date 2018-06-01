require 'discordrb'
require 'yaml'
require 'pry'

# Base class housing all data and modules for Steven
module Steven
  Dir["#{File.dirname(__FILE__)}/steven/*.rb"].each { |file| require file }

  CONFIG = Config.new
  USERS = UserManagement.new

  BOT = Discordrb::Commands::CommandBot.new(token: CONFIG.discord_token,
                                            client_id: CONFIG.client_id,
                                            prefix: '!')

  puts "This bot's invite URL is #{BOT.invite_url}."
  puts 'Click on it to invite it to your server.'

  BOT.include!(Admin)
  BOT.include!(Coddler)
  BOT.include!(Greeter)
  BOT.include!(Hazer)
  BOT.include!(Retaliator)

  at_exit do
    USERS.save_user_data
  end

  BOT.run
end
