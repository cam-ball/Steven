require 'discordrb'
require 'yaml'
require 'pry'

module Steven
  require_relative 'Steven/config'
  require_relative 'Steven/data'
  require_relative 'Steven/greeter'
  require_relative 'Steven/coddler'

  CONFIG = Config.new
  DATA = Data.new

  BOT = Discordrb::Bot.new(
    token: CONFIG.discord_token,
    client_id: CONFIG.client_id,
    parse_self: false,
  )

  # Here we output the invite URL to the console so the bot account can be invited to the channel. This only has to be
  # done once, afterwards, you can remove this part if you want
  puts "This bot's invite URL is #{BOT.invite_url}."
  puts 'Click on it to invite it to your server.'

  BOT.include!(Coddler)
  # BOT.include!(Greeter)

  BOT.run
end
