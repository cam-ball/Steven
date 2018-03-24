module Steven
  module Retaliator
    extend Discordrb::EventContainer

    message do |event|
      if event.content.downcase.include?('dum bitch')
        user = event.author
        event.respond("#{user.mention} *ur* a dum bitch")
      end
    end
  end
end
