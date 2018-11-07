require 'property'

describe Property do

  describe '#all' do
    it 'returns all properties' do
      Property.create(name: 'Cottage', description: 'A lovely place', ppn: 15)
      Property.create(name: 'Castle Hotel', description: 'A grand place', ppn: 25)

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
        ppn: 20)

      expect(property.name).to eq 'Daisy Cottage'
      expect(property.description).to eq 'A flowery place'
      expect(property.ppn).to eq 20
    end
  end

  describe '#find' do
    it 'returns the requested property object' do
      property = Property.create(name: 'Daisy Cottage', description: 'A flowery place',
        ppn: 20)

      result = Property.find(id: property.id)

      expect(result).to be_a Property
      expect(result.id).to eq property.id
      expect(result.name).to eq 'Daisy Cottage'
      expect(result.description).to eq 'A flowery place'
      expect(result.ppn).to eq 20
    end
  end
end
