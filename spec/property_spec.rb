require 'property'
require 'user'

describe Property do

  before :each do
    @letter = User.register(name: "name", username: "username", email: "test@test.com", password: "password123")
  end

  describe '#all' do
    it 'returns all properties' do
      Property.create(name: 'Cottage', description: 'A lovely place', ppn: 15, letter_id: @letter.id)
      Property.create(name: 'Castle Hotel', description: 'A grand place', ppn: 25, letter_id: @letter.id)

      properties = Property.all

      expect(properties.length).to eq 2
      expect(properties[0].name).to eq('Cottage')
      expect(properties[0].description).to eq('A lovely place')
      expect(properties[0].ppn).to eq(15)
    end
  end

  describe '#create' do
    it 'creates a new property' do
      property = Property.create(name: 'Daisy Cottage', description: 'A flowery place',
        ppn: 20, letter_id: @letter.id)

      expect(property.name).to eq 'Daisy Cottage'
      expect(property.description).to eq 'A flowery place'
      expect(property.ppn).to eq 20
    end
  end

  describe '#find' do
    it 'returns the requested property object' do
      property = Property.create(name: 'Daisy Cottage', description: 'A flowery place',
        ppn: 20, letter_id: @letter.id)

      result = Property.find(id: property.id)

      expect(result).to be_a Property
      expect(result.id).to eq property.id
      expect(result.name).to eq 'Daisy Cottage'
      expect(result.description).to eq 'A flowery place'
      expect(result.ppn).to eq 20
    end
  end

  describe '#update' do
    it 'updates the property with the given data' do
      property = Property.create(name: 'Apartment', description: 'Swanky', ppn: 50, letter_id: @letter.id )
      updated_property = Property.update(id: property.id, name: 'Apartment', description: 'Really swanky', ppn: 100)

      expect(updated_property).to be_a Property
      expect(updated_property.id).to eq property.id
      expect(updated_property.name).to eq 'Apartment'
      expect(updated_property.description).to eq 'Really swanky'
      expect(updated_property.ppn).to eq(100)
    end
  end
end
