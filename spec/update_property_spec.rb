require './lib/property.rb'

describe Property do

  describe '.update' do
  it 'updates the property with the given data' do
    property = Property.create(name: 'Apartment', description: 'Swanky', ppn: 50 )
    updated_property = Property.update(id: property.id, name: 'Apartment', description: 'Really swanky', ppn: 100)

    expect(updated_property).to be_a Property
    expect(updated_property.id).to eq property.id
    expect(updated_property.name).to eq 'Apartment'
    expect(updated_property.description).to eq 'Really swanky'
    expect(updated_property.ppn).to eq(100)
  end
end
end
