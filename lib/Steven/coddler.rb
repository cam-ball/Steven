module Steven
  module Coddler
    extend Discordrb::EventContainer

    @affirmations = YAML.load_file("#{Dir.pwd}/data/affirmations.yml")

    message do |event|
      if event.author.id == VARS.downtrodden_user.to_i
        VARS.current_counter += 1

        if VARS.current_counter == VARS.current_message_seed
          event.respond(@affirmations.sample)

          VARS.create_message_seed
        end
      end
    end

  end
end
