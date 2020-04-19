# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Steven::Greeter do
  it { expect(described_class).to be_a Discordrb::EventContainer }

  context 'event response' do
    let(:event) { message_event(content: message_val) }

    context 'hello' do
      let(:message_val) { 'hello' }

      it do
        expect(event).to receive(:respond).with 'Greetings!'
        dispatch(Discordrb::Events::MessageEvent, event)
      end

      context 'case-agnostic substring' do
        let(:message_val) { '~HELLO~' }

        it 'is case-agnostic' do
          expect(event).to receive(:respond).with 'Greetings!'
          dispatch(Discordrb::Events::MessageEvent, event)
        end
      end
    end

    context 'bye' do
      let(:message_val) { 'bye' }
      it do
        expect(event).to receive(:respond)
          .with('I suppose this is good-bye for now.')

        dispatch(Discordrb::Events::MessageEvent, event)
      end

      context 'case-agnostic substring' do
        let(:message_val) { 'BYE~' }

        it 'is case-agnostic' do
          expect(event).to receive(:respond)
            .with('I suppose this is good-bye for now.')

          dispatch(Discordrb::Events::MessageEvent, event)
        end
      end
    end
  end
end
