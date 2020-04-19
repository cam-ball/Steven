# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Steven::Hazer do
  let(:event) { message_event(content: 'any ole thing') }
  let(:hazes) do
    YAML.load_file("#{Dir.pwd}/data/hazes.yml")
  end

  before { allow(Steven::Responder).to receive(:call) }

  it do
    dispatch(Discordrb::Events::MessageEvent, event)

    expect(Steven::Responder).to have_received(:call).once
      .with(event, :haze, hazes)
  end
end
