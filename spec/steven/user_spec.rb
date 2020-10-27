# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Steven::User do
  let(:user) do
    Steven::User.new(
      user_id: 1,
      server_id: 1,
      username: 'mighty big boy',
      nickname: 'o hewwo',
    )
  end

  describe '#complete?' do
    let(:user) do
      Steven::User.new(
        user_id: user_id_val,
        server_id: server_id_val,
        username: username_val,
        nickname: 'o hewwo',
      )
    end
    let(:user_id_val) { nil }
    let(:username_val) { nil }
    let(:server_id_val) { nil }

    subject { user.complete? }

    it { is_expected.to eq(nil) }

    context 'when all pieces are present' do
      let(:user_id_val) { 1 }
      let(:username_val) { 'theImpaler' }
      let(:server_id_val) { 1 }

      it { is_expected.to eq(1) }
    end
  end

  describe '#action_list_s' do
    subject { user.action_list_s }

    it { is_expected.to be_nil }

    context 'when there is one action' do
      before { user.add_action(:affirm) }

      it { is_expected.to eq('affirm') }

      context 'and another action is added' do
        before { user.add_action(:haze) }

        it { is_expected.to eq('affirm, haze') }
      end
    end
  end

  describe '#add_action' do
    Steven::User::ALLOWED_ACTIONS.each do |action_val|
      context do
        let(:counter_symbol) { "@#{action_val}_counter".to_sym }
        let(:trigger_symbol) { "@#{action_val}_trigger".to_sym }

        it action_val do
          expect(user.actions).to be_empty
          user.add_action(action_val)
          expect(user.actions).to contain_exactly(action_val)
        end

        it 'adds the corresponding trigger and counter variables' do
          expect(user.instance_variable_get(counter_symbol)).to be_nil
          expect(user.instance_variable_get(trigger_symbol)).to be_nil
          user.add_action(action_val)
          expect(user.instance_variable_get(counter_symbol)).to_not be_nil
          expect(user.instance_variable_get(trigger_symbol)).to_not be_nil
        end
      end
    end

    context 'when the action is not allowed' do
      let(:action_val) { :scream }

      it do
        expect(user.actions).to be_empty
        user.add_action(action_val)
        expect(user.actions).to be_empty
      end
    end
  end

  describe '#remove_action' do
    Steven::User::ALLOWED_ACTIONS.each do |action_val|
      context "when the user is configured for #{action_val}" do
        before { user.add_action(action_val) }

        let(:counter_symbol) { "@#{action_val}_counter".to_sym }
        let(:trigger_symbol) { "@#{action_val}_trigger".to_sym }

        it do
          expect(user.actions).to contain_exactly(action_val)
          user.remove_action(action_val)
          expect(user.actions).to be_empty
        end

        it 'removes the corresponding trigger and counter variables' do
          expect(user.instance_variable_get(counter_symbol)).to_not be_nil
          expect(user.instance_variable_get(trigger_symbol)).to_not be_nil
          user.remove_action(action_val)
          expect(user.instance_variable_get(counter_symbol)).to be_nil
          expect(user.instance_variable_get(trigger_symbol)).to be_nil
        end
      end

      context "when the user is not configured for #{action_val}" do
        it do
          expect(user.actions).to be_empty
          user.remove_action(action_val)
          expect(user.actions).to be_empty
        end
      end
    end

    context 'when the action is not allowed' do
      let(:action_val) { :scream }

      it do
        expect(user.actions).to be_empty
        user.remove_action(action_val)
        expect(user.actions).to be_empty
      end
    end
  end

  describe '#increment' do
    Steven::User::ALLOWED_ACTIONS.each do |action_val|
      context "when the user is configured for #{action_val}" do
        before { user.add_action(action_val) }

        let(:counter_symbol) { "@#{action_val}_counter".to_sym }

        it "increments the #{action_val} counter" do
          expect { user.increment(action_val) }
            .to change { user.instance_variable_get(counter_symbol) }.by(1)
        end
      end

      context "when the user is not configured for #{action_val}" do
        let(:counter_symbol) { "@#{action_val}_counter".to_sym }

        it "increments the #{action_val} counter" do
          expect { user.increment(action_val) }
            .to_not change { user.instance_variable_get(counter_symbol) }
          expect(user.instance_variable_get(counter_symbol)).to be_nil
        end
      end
    end
  end

  describe '#reset_action' do
    Steven::User::ALLOWED_ACTIONS.each do |action_val|
      context "when the user is configured for #{action_val}" do
        before do
          user.add_action(action_val)
          user.increment(action_val)
        end

        let(:counter_symbol) { "@#{action_val}_counter".to_sym }

        it 'resets the counter back to 0' do
          expect(user.instance_variable_get(counter_symbol)).to_not eq(0)
          user.reset_action(action_val)
          expect(user.instance_variable_get(counter_symbol)).to eq(0)
        end

        it 'resets the `last_triggered` timestamp' do
          expect { user.reset_action(action_val) }.to change { user.last_triggered }
        end
      end

      context "when the user is not configured for #{action_val}" do
        it do
          expect(user.reset_action(action_val))
            .to eq("Requested action '#{action_val}' not defined")
        end
      end
    end

    context 'when the action is not allowed' do
      let(:action_val) { :scream }

      it do
        expect(user.reset_action(action_val))
          .to eq("Requested action '#{action_val}' not defined")
      end

      it 'does not reset the `last_triggered` timestamp' do
        user.reset_action(action_val)
        expect(user.last_triggered).to eq(nil)
      end
    end
  end

  describe '#action_permitted?' do
    let(:action_val) { Steven::User::ALLOWED_ACTIONS.sample }
    subject { user.action_permitted?(action_val) }

    it { is_expected.to eq(false) }

    context 'when the action exists on the user' do
      before { user.add_action(action_val) }

      it { is_expected.to eq(true) }
    end
  end
end
