module Steven
  # Responds negatively to mesasges from users with the :haze configuration
  module Hazer
    extend Discordrb::EventContainer

    hazes = YAML.load_file("#{Dir.pwd}/data/hazes.yml")

    message do |event|
      Steven::Responder.call(event, :haze, hazes)
    end
  end
end
