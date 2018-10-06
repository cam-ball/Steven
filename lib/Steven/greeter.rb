module Steven
  # Responds directly to messages
  module Greeter
    extend Discordrb::EventContainer

    message do |event|
      if event.content.downcase.include?('hello')
        event.respond 'Greetings!'
      elsif event.content.downcase.include?('bye')
        event.respond 'I suppose this is good-bye for now.'
      end
    end
  end
end
