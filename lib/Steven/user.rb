module Steven
  class User
    attr_reader :user_id
    attr_accessor :actions


    ALLOWED_ACTIONS = [:affirm, :haze]

    def initialize(user_id)
      @user_id = user_id.to_i
      @actions = []
    end

    def add_action(action)
      action = action.to_sym
      return "Requested action #{action} not defined" unless ALLOWED_ACTIONS.include?(action) && !action_exists?(action)

      @actions << action

      initialize_action(action)
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
      return "Requested action #{action} not defined" unless ALLOWED_ACTIONS.include?(action) && action_exists?(action)

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
