# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Steven::Config, skip: 'grimacing emoji' do
  describe '#initialize' do
    before do
      allow_any_instance_of(Steven::Config)
        .to receive(:read_user_input).and_return('12345')
    end

    subject { described_class.new }

    it do
      expect(subject.discord_token).to eq('12345')
      expect(subject.client_id).to eq('12345')
      expect(subject.discord_token).to eq('12345')
    end
  end
end
