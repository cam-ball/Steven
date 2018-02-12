require 'discordrb'
require 'yaml'
require 'pry'

module Steven
  require_relative 'Steven/config'

  CONFIG = Config.new

  bot = Discordrb::Bot.new token: CONFIG.discord_token, client_id: CONFIG.client_id

  # Here we output the invite URL to the console so the bot account can be invited to the channel. This only has to be
  # done once, afterwards, you can remove this part if you want
  puts "This bot's invite URL is #{bot.invite_url}."
  puts 'Click on it to invite it to your server.'

  # This method call adds an event handler that will be called on any message that exactly contains the string "Ping!".
  # The code inside it will be executed, and a "Pong!" response will be sent to the channel.
  bot.message do |event|
    if event.content.include?('hello')
      event.respond 'hiya!'
    end

    if event.content.include?('bye')
      event.respond 'http://media.riffsy.com/images/378a40831d1001c96af434aa24b6dd97/tenor.gif'
    end
  end

  bot.run
end
