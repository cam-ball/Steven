require 'discordrb'
require 'yaml'
require 'pry'

# Base class housing all data and modules for Steven
module Steven
  require_relative 'Steven/admin'
  require_relative 'Steven/coddler'
  require_relative 'Steven/config'
  require_relative 'Steven/greeter'
  require_relative 'Steven/hazer'
  require_relative 'Steven/info'
  require_relative 'Steven/retaliator'
  require_relative 'Steven/user_management'
  require_relative 'Steven/user'

  CONFIG = Config.new
  USER_LIST = UserManagement.new

  BOT = Discordrb::Commands::CommandBot.new(token: CONFIG.discord_token,
                                            client_id: CONFIG.client_id,
                                            prefix: '!')

  puts "This bot's invite URL is #{BOT.invite_url}."
  puts 'Click on it to invite it to your server.'

  BOT.include!(Admin)
  BOT.include!(Coddler)
  BOT.include!(Greeter)
  BOT.include!(Hazer)
  BOT.include!(Info)
  BOT.include!(Retaliator)

  at_exit do
    USER_LIST.save_user_data
  end

  BOT.run
end
