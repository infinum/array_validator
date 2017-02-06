require 'spec_helper'

# Length should come out of box with Rails.
describe 'array_validator#length' do
  class Plant
    include ActiveModel::Validations

    attr_accessor :watering_times
    validates :watering_times, length: { minimum: 2, maximum: 3 }
  end

  let(:plant) { Plant.new }

  it 'returns true for valid minimum size' do
    plant.watering_times = ['01:00', '21:00']
    expect(plant.valid?).to eq(true)
  end

  xit 'returns false for invalid minimum size' do
    plant.watering_times = ['01:00']
    expect(plant.valid?).to eq(false)
    expect(plant.errors[:watering_times].first).to eq('31:00 is not in a valid format')
  end

  xit 'returns false for invalid maximum size' do
    plant.watering_times = ['01:00', '02:00', '03:00', '04:00']
    expect(plant.valid?).to eq(false)
    expect(plant.errors[:watering_times].first).to eq('31:00, abc are not in a valid format')
  end
end
