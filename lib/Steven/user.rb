module Steven
  # User class containing all data for any individual configured by owner
  class User
    attr_reader :user_id, :username
    attr_accessor :actions

    ALLOWED_ACTIONS = %i[affirm haze].freeze

    def initialize(user_id, username)
      @user_id = user_id.to_i
      @username = username
      @actions = []
    end

    def add_action(action)
      action = action.to_sym

      unless ALLOWED_ACTIONS.include?(action)
        return "Requested action '#{action}' not defined"
      end

      unless action_exists?(action)
        @actions << action
        initialize_action(action)
      end

      "Action added"
    end

    def increment_affirmation
      @affirmation_counter += 1
    end

    def trigger_affirmation?
      @affirmation_counter == @affirmation_trigger
    end

    def increment_haze
      @haze_counter += 1
    end

    def trigger_haze?
      @haze_counter == @haze_trigger
    end

    def reset_action(action)
      action = action.to_sym

      unless ALLOWED_ACTIONS.include?(action) && action_exists?(action)
        return "Requested action '#{action}' not defined"
      end

      initialize_action(action)
    end

    def action_exists?(action)
      @actions.include?(action)
    end

    private

    def initialize_action(action)
      case action
      when :affirm
        @affirmation_counter = 0
        @affirmation_trigger = random_trigger
      when :haze
        @haze_counter = 0
        @haze_trigger = random_trigger
      end
    end

    def random_trigger
      Random.rand(10..30)
    end
  end
end
