# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Steven do
  it "has a version number" do
    expect(Steven::VERSION).to eq('0.3.0')
  end

  it { expect(Steven::BOT).to be_a Discordrb::Commands::CommandBot }
end
