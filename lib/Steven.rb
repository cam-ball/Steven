require 'discordrb'
require 'yaml'
require 'pry'
require 'i18n'

# Base class housing all data and modules for Steven
module Steven
  I18n.config.available_locales = :en
  I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]

  Dir.glob('Steven/**/*.rb', base: 'lib').each do |file|
    require_relative file.gsub("\.rb", "")
  end

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
  BOT.include!(Reply_To_Mention)
  BOT.include!(Info)
  BOT.include!(Retaliator)

  at_exit do
    USER_LIST.save_user_data
  end

  BOT.run
end
