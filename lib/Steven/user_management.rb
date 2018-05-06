module Steven
  # Wrapper class for general user management
  class UserManagement
    def initialize
      @users = []
      @user_data_file = "#{Dir.pwd}/data/user_data.yml"

      if File.exist?(@user_data_file)
        file_contents = YAML.load_file(@user_data_file)
      end

      return unless file_contents.is_a?(Array) && !file_contents.empty?

      @users = file_contents
    end

    def add_user(user)
      @users << user
    end

    def find_user(user_id)
      @users.select { |usr| usr.user_id == user_id }.first
    end

    def add_action(user_id, action)
      user = @users.select { |usr| usr.user_id == user_id }.first

      return unless user

      user.add_action(action)
    end

    def user_exists?(user_id)
      @users.select { |usr| usr.user_id == user_id }.any?
    end

    def save_user_data
      File.open(@user_data_file, 'w') do |f|
        f.write YAML.dump(@users)
      end
    end
  end
end
