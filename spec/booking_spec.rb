require 'booking'
require 'property'
require 'user'

describe Booking do

  before :each do
    @letter = User.register(name: 'Name', username: 'username', email: 'name@test.com', password: 'password123')
    @property = Property.create(name: 'Fancy Place', description: 'A fancy place', ppn: 20, letter_id: @letter.id)
    @user = User.register(name: 'Test', username: 'tester', email: 'test@test.com', password: 'testpass')
  end

  describe '#submit_availability' do
    it 'adds availability for property to database' do
      booking = Booking.submit_availability(date: "2018/10/15", property_id: @property.id)
      booking = Booking.submit_availability(date: "2018/10/15", property_id: @property.id, letter_id: @letter.id)

      expect(booking.date).to eq("2018-10-15")
      expect(booking.property_id).to eq(@property.id)
    end
  end

  describe '#check_availability' do
    it 'returns dates a property is available' do
      Booking.submit_availability(date: "2018/10/15", property_id: @property.id)
      Booking.submit_availability(date: "2018/10/17", property_id: @property.id)
      Booking.submit_availability(date: "2018/11/18", property_id: @property.id)
      Booking.submit_availability(date: "2018/10/15", property_id: @property.id, letter_id: @letter.id)
      Booking.submit_availability(date: "2018/10/17", property_id: @property.id, letter_id: @letter.id)
      Booking.submit_availability(date: "2018/11/18", property_id: @property.id, letter_id: @letter.id)

      expect(Booking.check_availability(property_id: @property.id)).to eq(["2018-10-15", "2018-10-17", "2018-11-18"])
    end

    it 'returns nil if no dates' do
      expect(Booking.check_availability(property_id: @property.id)).to eq nil
    end
  end

  describe '#request_booking' do
    it 'raises error if requesting unavailable date for property' do
      Booking.submit_availability(date: "2018/10/15", property_id: @property.id)
      Booking.submit_availability(date: "2018/10/15", property_id: @property.id, letter_id: @letter.id)
      expect{Booking.request_booking(date: "2018/09/01", property_id: @property.id, renter_id: @user.id)}.to raise_error("Date unavailable")
    end

    it 'raises error if no dates available' do
      expect{Booking.request_booking(date: "2018/09/01", property_id: @property.id, renter_id: @user.id)}.to raise_error("Date unavailable")
    end

    it 'adds request to bookings table if date and property is available' do
      Booking.submit_availability(date: "2018/10/15", property_id: @property.id)
      Booking.submit_availability(date: "2018/10/15", property_id: @property.id, letter_id: @letter.id)
      booking = Booking.request_booking(date: "2018/10/15", property_id: @property.id, renter_id: @user.id)

      expect(booking.date).to eq "2018-10-15"
      expect(booking.property_id).to eq @property.id
      expect(booking.renter_id).to eq @user.id
      expect(booking.approved).to eq "f"
    end
  end

  describe '#confirm_booking' do
    it 'adds true to booking approval' do
      Booking.submit_availability(date: "2018/10/15", property_id: @property.id)
      Booking.submit_availability(date: "2018/10/15", property_id: @property.id, letter_id: @letter.id)
      request = Booking.request_booking(date: "2018/10/15", property_id: @property.id, renter_id: @user.id)
      booking = Booking.confirm_booking(id: request.id)

      expect(booking.date).to eq "2018-10-15"
      expect(booking.property_id).to eq @property.id
      expect(booking.renter_id).to eq @user.id
      expect(booking.approved).to eq "t"
    end
  end

  describe '#deny_booking' do
    it 'adds false to booking approval' do
      Booking.submit_availability(date: "2018/10/15", property_id: @property.id)
      Booking.submit_availability(date: "2018/10/15", property_id: @property.id, letter_id: @letter.id)
      request = Booking.request_booking(date: "2018/10/15", property_id: @property.id, renter_id: @user.id)
      booking = Booking.deny_booking(id: request.id)

      expect(booking.date).to eq "2018-10-15"
      expect(booking.property_id).to eq @property.id
      expect(booking.renter_id).to eq @user.id
      expect(booking.approved).to eq "f"
    end
  end

  describe '#find_by_property' do
    it 'returns an array of bookings per property' do
      booking = Booking.submit_availability(date: "2018/10/15", property_id: @property.id)
      request = Booking.request_booking(date: "2018/10/15", property_id: @property.id, renter_id: @user.id)
      result = Booking.list_by_property(property_id: @property.id)
      expect(result[0].property_id).to eq @property.id
      expect(result[0].date).to eq booking.date
      expect(result).to be_a(Array)
    end
  end
end
