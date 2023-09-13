# frozen-string-literal: true

require 'rails_helper'

describe 'ModelFactories' do
  FactoryBot.factories.map(&:name).each do |factory_name|
    describe "the #{factory_name} factory" do
      it 'is valid' do
        expect(FactoryBot.build(factory_name)).to be_valid
      end
    end
  end
end
