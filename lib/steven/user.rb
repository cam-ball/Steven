module Steven
  # User class containing all data for any individual configured by owner
  class User
    attr_accessor :actions, :server_id, :user_id, :username, :nickname, :last_triggered

    ALLOWED_ACTIONS = %i[affirm haze].freeze

    def initialize(params = {})
      @user_id = params[:user_id]
      @username = params[:username]
      @nickname = params[:nickname]
      @server_id = params[:server_id]
      @actions = []
      @last_triggered = nil
    end

    def complete?
      @user_id && @username && @server_id
    end

    def action_list_s
      return if @actions.empty?

      @actions.join(", ")
    end

    def add_action(action)
      action = action.to_sym

      return "Requested action '#{action}' not defined" unless ALLOWED_ACTIONS.include?(action)

      unless action_permitted?(action)
        @actions << action
        previous_trigger = update_trigger_timestamp
        initialize_action(action, previous_trigger)
      end

      "Action added"
    end

    def remove_action(action)
      action = action.to_sym

      return "Requested action '#{action}' not defined" unless ALLOWED_ACTIONS.include?(action)

      if action_permitted?(action)
        @actions.delete(action)
        remove_instance_variable(counter(action))
        remove_instance_variable(trigger(action))
      end

      "Action removed"
    end

    def increment(action)
      return unless action_permitted?(action)

      val = instance_variable_get(counter(action)) || 0
      instance_variable_set(counter(action), val + 1)
    end

    def trigger?(action)
      instance_variable_get(counter(action)) ==
        instance_variable_get(trigger(action))
    end

    def reset_action(action)
      unless ALLOWED_ACTIONS.include?(action) && action_permitted?(action)
        return "Requested action '#{action}' not defined"
      end

      previous_trigger = update_trigger_timestamp
      initialize_action(action, previous_trigger)
    end

    def action_permitted?(action)
      @actions.include?(action)
    end

    def messages_until?(action)
      return unless action_permitted?(action)

      instance_variable_get(trigger(action)) -
        instance_variable_get(counter(action))
    end

    private

    def update_trigger_timestamp
      previous_trigger = @last_triggered
      @last_triggered = Time.now
      previous_trigger || Time.now
    end

    def initialize_action(action, previous_trigger_timestamp)
      instance_variable_set(counter(action), 0)
      instance_variable_set(trigger(action), seeded_trigger(previous_trigger_timestamp))
    end

    def counter(action)
      "@#{action}_counter"
    end

    def trigger(action)
      "@#{action}_trigger"
    end

    def seeded_trigger(previous_trigger_timestamp)
      return random_trigger unless previous_trigger_timestamp

      new_seed = trigger_seed(previous_trigger_timestamp)
      variance = new_seed * 0.15
      minimum = new_seed - variance
      maximum = new_seed + variance

      Random.rand(minimum..maximum)
    end

    def random_trigger
      Random.rand(10..40)
    end

    def trigger_seed(previous_trigger_timestamp)
      messages_per_day = average_messages_per_day(previous_trigger_timestamp)
      messages_to_trigger = largest_trigger

      [messages_to_trigger * 2, messages_per_day].min
    end

    def average_messages_per_day(previous_trigger_timestamp)
      messages_to_trigger = largest_trigger
      time_between_triggers = @last_triggered - previous_trigger_timestamp
      # 86400 seconds in a day
      triggers_per_day = 86400 / time_between_triggers.to_f

      (triggers_per_day * messages_to_trigger).round
    end

    def largest_trigger
      @actions.map do |action|
        instance_variable_get(trigger(action)) || 0
      end.max
    end
  end
end
