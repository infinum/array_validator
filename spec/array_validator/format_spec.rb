require 'spec_helper'

describe 'array_validator#format' do
  plant_class = Class.new do
    include ActiveModel::Validations
    HH_MM_REGEX = /(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]/

    attr_accessor :watering_times
    validates :watering_times, array: { format: HH_MM_REGEX }
  end

  let(:plant) { plant_class.new }

  it 'returns true for valid format' do
    plant.watering_times = ['01:00', '21:00']
    expect(plant.valid?).to eq(true)
  end

  it 'returns false for invalid value' do
    plant.watering_times = ['01:00', '31:00']
    expect(plant.valid?).to eq(false)
    expect(plant.errors[:watering_times].first).to eq('not in a valid format: 31:00')
  end

  it 'returns false for invalid value' do
    plant.watering_times = ['31:00', 'abc']
    expect(plant.valid?).to eq(false)
    expect(plant.errors[:watering_times].first).to eq('not in a valid format: 31:00, abc')
  end
end
