module Steven
  module Greeter
    extend Discordrb::EventContainer

    message do |event|
      if event.content.downcase.include?('hello')
        event.respond 'hiya!'
      end

      if event.content.downcase.include?('bye')
        event.respond 'http://media.riffsy.com/images/378a40831d1001c96af434aa24b6dd97/tenor.gif'
      end
    end
  end
end
