# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Steven::Coddler do
  it { expect(described_class).to be_a Discordrb::EventContainer }

  context 'event response' do
    let(:event) { message_event(content: 'any ole thing') }
    let(:affirmations) do
      YAML.load_file("#{Dir.pwd}/data/affirmations.yml")
    end

    before { allow(Steven::Responder).to receive(:call) }

    it do
      dispatch(Discordrb::Events::MessageEvent, event)

      expect(Steven::Responder).to have_received(:call).once
        .with(event, :affirm, affirmations)
    end
  end
end
