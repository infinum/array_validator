require 'spec_helper'

describe 'array_validator#duplicates' do
  plant_class = Class.new do
    include ActiveModel::Validations

    attr_accessor :watering_times
    validates :watering_times, array: { duplicates: false }
  end

  let(:plant) { plant_class.new }

  it 'returns true for valid format' do
    plant.watering_times = ['01:00', '21:00']
    expect(plant.valid?).to eq(true)
  end

  it 'returns false for duplicates' do
    plant.watering_times = ['01:00', '01:00', '03:00', '04:00', '03:00']
    expect(plant.valid?).to eq(false)
    expect(plant.errors[:watering_times].first).to eq('has duplicates: 01:00, 03:00')
  end
end
