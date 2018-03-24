require 'discordrb'
require 'yaml'
require 'pry'

module Steven
  Dir["#{File.dirname(__FILE__)}/steven/*.rb"].each { |file| require file }

  CONFIG = Config.new
  USERS = UserManagement.new

  BOT = Discordrb::Commands::CommandBot.new(token: CONFIG.discord_token, client_id: CONFIG.client_id, prefix: '!')

  # Here we output the invite URL to the console so the bot account can be invited to the channel. This only has to be
  # done once, afterwards, you can remove this part if you want
  puts "This bot's invite URL is #{BOT.invite_url}."
  puts 'Click on it to invite it to your server.'

  BOT.include!(Admin)
  BOT.include!(Coddler)
  BOT.include!(Greeter)
  BOT.include!(Retaliator)

  at_exit do
    USERS.save_user_data
  end

  BOT.run
end
