module Steven
  module Coddler
    extend Discordrb::EventContainer

    message do |event|
      if event.author.id == DATA.downtrodden_user
        DATA.current_counter += 1

        if DATA.current_counter == DATA.current_message_seed
          event.respond("shut up!")

          DATA.create_message_seed
        end
      end
    end
  end
end
