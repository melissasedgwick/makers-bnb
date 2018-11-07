class Booking

  attr_reader :id, :date, :property_id, :renter_id, :letter_id, :approved

  def initialize(id:, date:, property_id:, renter_id: nil, letter_id: nil, approved: false)
    @id = id
    @date = date
    @property_id = property_id
    @renter_id = renter_id
    @letter_id = letter_id
    @approved = approved
  end

  def self.submit_availability(date:, property_id:)
    result = DatabaseConnection.query("INSERT INTO bookings (date, property_id)
    VALUES('#{date}', '#{property_id}')
    RETURNING id, date, property_id;")
    Booking.new(id: result[0]['id'],
      date: result[0]['date'],
      property_id: result[0]['property_id'],
    )
  end

  def self.check_availability(property_id:)
    dates = []
    result = DatabaseConnection.query("SELECT date FROM bookings WHERE property_id = #{property_id};")
    return nil unless result.any?
    result.each do |date|
      dates << date['date']
    end
    return dates
  end

  def self.request_booking(date:, property_id:, renter_id:)
    date.gsub!('/', '-')
    raise "Date unavailable" if Booking.check_availability(property_id: property_id) == nil
    raise "Date unavailable" if !Booking.check_availability(property_id: property_id).include?(date)
    result = DatabaseConnection.query("UPDATE bookings SET renter_id = #{renter_id} WHERE property_id = #{property_id} AND date = '#{date}'
      RETURNING id, date, property_id, renter_id;")
    Booking.new(id: result[0]['id'],
      date: result[0]['date'],
      property_id: result[0]['property_id'],
      renter_id: result[0]['renter_id']
    )
  end

end
