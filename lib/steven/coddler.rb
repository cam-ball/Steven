module Steven
  # Responds positively to mesasges from users with the :affirm configuration
  module Coddler
    extend Discordrb::EventContainer

    affirmations = YAML.load_file("#{Dir.pwd}/data/affirmations.yml")

    message do |event|
      Steven::Responder.call(event, :affirm, affirmations)
    end
  end
end
