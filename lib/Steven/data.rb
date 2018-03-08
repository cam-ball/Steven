module Steven
  class Data

    def initialize
      @data_file = "#{Dir.pwd}/config/data.yml"
      file_contents = YAML.load_file(@data_file) if File.exist?(@data_file)

      if file_contents.is_a?(Hash) && !file_contents.empty?
        @data = file_contents
      else
        seed_data
      end
    end

    def current_counter= (val)
      @data[:current_counter] = val
      save_configurations
    end

    def current_message_seed
      @data[:current_message_seed]
    end

    def current_counter
      @data[:current_counter]
    end

    def downtrodden_user
      @data[:downtrodden_user]
    end

    def create_message_seed
      @data[:current_message_seed] = Random.rand(1..5)
      @data[:current_counter] = 0

      save_configurations
      reload_datafile
    end

    private

    def seed_data
      @data = {}

      @data[:current_counter] = 0

      @data[:current_message_seed] = Random.rand(1..5)
      puts "No configuration file found in #{Dir.pwd}/config/config.yml"
      puts 'Creating file now...'

      puts 'Which user needs a pick-me-up? '
      @data[:downtrodden_user] = gets.chomp
      @data[:downtrodden_user] = 221687578997424129 if @data[:downtrodden_user].empty?

      save_configurations
    end

    def save_configurations
      File.open(@data_file, 'w') do |f|
        f.write YAML.dump(@data)
      end
    end

    def reload_datafile
      @data_file = "#{Dir.pwd}/config/data.yml"
      file_contents = YAML.load_file(@data_file) if File.exist?(@data_file)

      @data = file_contents
    end
  end
end
