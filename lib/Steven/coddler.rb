module Steven
  module Coddler
    extend Discordrb::EventContainer

    message do |event|
      if event.author.id == VARS.downtrodden_user
        VARS.current_counter += 1

        if VARS.current_counter == VARS.current_message_seed
          event.respond("shut up!")

          VARS.create_message_seed
        end
      end
    end
  end
end
