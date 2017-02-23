require 'spec_helper'

describe 'array_validator#length' do
  class Plant
    include ActiveModel::Validations
    attr_accessor :intake_times
  end

  let(:plant) { Plant.new }

  context 'ascending' do
    before { plant.class_eval { validates :intake_times, array: { sorted: :asc } } }

    it 'returns true for valid order' do
      plant.intake_times = [2, 4, 6, 8]
      expect(plant.valid?).to eq(true)
    end

    it 'returns false for invalid order' do
      plant.intake_times = [2, 6, 4, 8]
      expect(plant.valid?).to eq(false)
      expect(plant.errors.full_messages.first).to eq 'Intake times is not sorted in ascending order'
    end
  end

  context 'descending' do
    before { plant.class_eval { validates :intake_times, array: { sorted: :desc } } }

    it 'returns true for valid order' do
      plant.intake_times = [8, 6, 4, 2]
      expect(plant.valid?).to eq(true)
    end

    it 'returns false for invalid order' do
      plant.intake_times = [8, 4, 6, 2]
      expect(plant.valid?).to eq(false)
      expect(plant.errors.full_messages.first).to eq 'Intake times is not sorted in descending order'
    end
  end

  context 'unsupported order' do
    before { plant.class_eval { validates :intake_times, array: { sorted: :jibberish } } }

    it 'returns true for valid order' do
      plant.intake_times = [8, 6, 4, 2]
      expect { plant.valid? }.to raise_error(ArgumentError, 'Not a supported sorting option')
    end
  end
end
