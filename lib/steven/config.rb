module Steven
  # Initial configuration for new install
  class Config
    attr_reader :discord_token, :client_id, :owner_id

    def initialize
      self.discord_token = ENV['DISCORD_TOKEN']
      self.client_id = ENV['CLIENT_ID']
      self.owner_id = ENV['OWNER_ID']
      return if discord_token && client_id && owner_id

      read_discord_configurations
    end

    private

    attr_writer :discord_token, :client_id, :owner_id

    def read_discord_configurations
      puts 'Enter Discord application token '
      self.discord_token = gets.chomp

      puts 'Enter Discord Client ID '
      self.client_id = gets.chomp

      puts 'Enter owner\'s user ID (press enter for default) '
      self.owner_id = gets.chomp
      self.owner_id = owner_id.empty? ? 221687578997424129 : owner_id.to_i
    end
  end
end
