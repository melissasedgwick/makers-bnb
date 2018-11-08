class Booking

  attr_reader :id, :date, :property_id, :renter_id, :letter_id, :approved, :property_name, :ppn

  def initialize(id:, date:, property_id:, renter_id: nil, letter_id: nil, approved: nil, property_name: nil, ppn: nil)
    @id = id
    @date = date
    @property_id = property_id
    @renter_id = renter_id
    @letter_id = letter_id
    @approved = approved
    @property_name = property_name
    @ppn = ppn
  end

  def self.submit_availability(date:, property_id:, letter_id:)
    result = DatabaseConnection.query("INSERT INTO bookings (date, property_id, letter_id)
    VALUES('#{date}', '#{property_id}', '#{letter_id}')
    RETURNING id, date, property_id, letter_id;")
    Booking.new(id: result[0]['id'],
      date: result[0]['date'],
      property_id: result[0]['property_id'],
      letter_id: result[0]['letter_id']
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
      RETURNING id, date, property_id, renter_id, approved;")
    Booking.new(id: result[0]['id'],
      date: result[0]['date'],
      property_id: result[0]['property_id'],
      renter_id: result[0]['renter_id'],
      approved: result[0]['approved']
    )
  end

  def self.confirm_booking(id:)
    result = DatabaseConnection.query("UPDATE bookings SET approved = true WHERE id = #{id}
      RETURNING id, date, property_id, renter_id, approved;")
    Booking.new(id: result[0]['id'],
      date: result[0]['date'],
      property_id: result[0]['property_id'],
      renter_id: result[0]['renter_id'],
      approved: result[0]['approved']
    )
  end

  def self.deny_booking(id:)
    result = DatabaseConnection.query("UPDATE bookings SET approved = false WHERE id = #{id}
      RETURNING id, date, property_id, renter_id, approved;")
    Booking.new(id: result[0]['id'],
      date: result[0]['date'],
      property_id: result[0]['property_id'],
      renter_id: result[0]['renter_id'],
      approved: result[0]['approved']
    )
  end

  def self.list_my_bookings(id:)
    result = DatabaseConnection.query("SELECT bookings.id, bookings.date, bookings.property_id, bookings.renter_id, bookings.letter_id, bookings.approved, properties.name, properties.price_per_night FROM bookings INNER JOIN properties ON bookings.property_id = properties.id WHERE renter_id = #{id}")
    output = []

    result.each do |booking|
      output.push(Booking.new(id: booking['id'],
      date: booking['date'],
      property_id: booking['property_id'],
      renter_id: booking['renter_id'],
      approved: booking['approved'],
      property_name: booking['name'],
      ppn: booking['price_per_night'],
      letter_id: booking['letter_id']
    )
  )
    return output
    end
  end

  def self.list_by_property(property_id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE property_id = #{property_id};")
    output = []
    result.each do |booking|
      output << Booking.new(id: booking['id'],
      date: booking['date'],
      property_id: booking['property_id'],
      renter_id: booking['renter_id'],
      approved: booking['approved'],
      property_name: booking['name'],
      ppn: booking['price_per_night'],
      letter_id: booking['letter_id']
    )
    return output
    end
  end
end
