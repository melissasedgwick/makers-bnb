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

  describe '#check_availability' do
    it 'returns dates a property is available' do
      property = Property.create(name: 'Fancy Place', description: 'A fancy place', ppn: 20)
      Booking.submit_availability(date: "2018/10/15", property_id: property.id)
      Booking.submit_availability(date: "2018/10/17", property_id: property.id)
      Booking.submit_availability(date: "2018/11/18", property_id: property.id)

      expect(Booking.check_availability(property_id: property.id)).to eq(["2018-10-15", "2018-10-17", "2018-11-18"])
    end

    it 'returns nil if no dates' do
      property = Property.create(name: 'Fancy Place', description: 'A fancy place', ppn: 20)

      expect(Booking.check_availability(property_id: property.id)).to eq nil
    end
  end

end
