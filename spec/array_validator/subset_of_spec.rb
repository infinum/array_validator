require 'spec_helper'

describe 'array_validator#subset_of' do
  let(:plant_class) do
    Class.new do
      include ActiveModel::Validations

      attr_accessor :categories
      validates :categories, array: { subset_of: ['trees', 'flowers'] }
    end
  end

  let(:plant) { plant_class.new }

  it 'returns true for subset' do
    plant.categories = ['trees', 'flowers']
    expect(plant.valid?).to eq(true)
  end

  it 'returns false for non-array value' do
    plant.categories = 'trees'
    expect(plant.valid?).to eq(false)
    expect(plant.errors[:categories].first).to match(/not an array/)
  end

  it 'returns false for value not in list' do
    plant.categories = ['weed']
    expect(plant.valid?).to eq(false)
    expect(plant.errors[:categories].first).to eq('has invalid values: weed')
  end

  it 'returns false for values not in list' do
    plant.categories = ['weed', 'bushes']
    expect(plant.valid?).to eq(false)
    expect(plant.errors[:categories].first).to match('has invalid values: weed, bushes')
  end
end
