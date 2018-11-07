require 'booking'
require 'property'

describe Booking do

  describe '#submit_availability' do
    it 'adds availability for property to database' do
      property = Property.create(name: 'Fancy Place', description: 'A fancy place', ppn: 20)
      booking = Booking.submit_availability(date: "2018/10/15", property_id: property.id)

      expect(booking.date).to eq("2018-10-15")
      expect(booking.property_id).to eq(property.id)
    end
  end

end
