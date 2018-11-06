require 'property'

describe Property do

  it 'knows its name' do
    property = Property.new(name: 'Cottage')
    expect(property.name).to eq('Cottage')
  end

  it 'knows its description' do
    property = Property.new(description: 'A lovely place')
    expect(property.description).to eq('A lovely place')
  end

  it 'knows its price per night' do
    property = Property.new(ppn: 15)
    expect(property.ppn).to eq(15)
  end

end
