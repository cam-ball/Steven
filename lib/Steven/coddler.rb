module Steven
  # Responds positively to mesasges from users with the :affirm configuration
  module Coddler
    extend Discordrb::EventContainer

    @affirmations = YAML.load_file("#{Dir.pwd}/data/affirmations.yml")

    message do |event|
      author_id = event.author.id

      user = USER_MANAGEMENT.find_user(author_id)

      if user
        if user.action_exists?(:affirm)
          user.increment_affirmation

          if user.trigger_affirmation?
            user.reset_action(:affirm)
            event.respond @affirmations.sample
          end
        end
      end
    end
  end
end
