# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Steven::UserManager do
  subject(:user_manager) do
    Steven::UserManager.new('spec/support/test_user_data.yml')
  end

  describe '#add_user' do
    let(:existing_user) { user_manager.find_user_by_id_and_server(1, 1) }
    let!(:new_user) do
      Steven::User.new(
        user_id: existing_user.user_id,
        server_id: server_id_val,
        username: existing_user.username,
        nickname: 'gremlinEnergy',
      )
    end

    context 'when the user does not already exist for a server' do
      let!(:server_id_val) { 3 }

      it 'adds a new user entry' do
        expect { user_manager.add_user(new_user) }
          .to change { user_manager.users.count }
          .from(3).to(4)
      end
    end

    context 'when the user already exists for a server' do
      let!(:server_id_val) { existing_user.server_id }

      it 'adds a new user entry' do
        expect { user_manager.add_user(new_user) }
          .to_not change { user_manager.users.count }
      end
    end
  end

  describe '#find_user_by_id_and_server' do
    it do
      user = user_manager.find_user_by_id_and_server(1, 2)
      expect(user.username).to eq('jeffy')
      expect(user.nickname).to eq('just a bastard')
    end
  end
end
