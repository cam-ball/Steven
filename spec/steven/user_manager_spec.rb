# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Steven::UserManager do
  subject(:user_manager) do
    Steven::UserManager.new('spec/support/test_user_data.yml')
  end

  describe '#find_user_by_id_and_server' do
    it do
    end
  end
end
