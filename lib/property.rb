class Property

  attr_reader :id, :name, :description, :ppn, :letter_id

  def initialize(id:, name:, description:, ppn:, letter_id:)
    @id = id
    @name = name
    @description = description
    @ppn = ppn
    @letter_id = letter_id
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM properties;")
    result.map do |property|
      Property.new(id: property['id'],
        name: property['name'],
        description: property['description'],
        ppn: property['price_per_night'].to_i,
        letter_id: property['letter.id']
      )
    end
  end

  def self.create(name:, description:, ppn:, letter_id:)
    result = DatabaseConnection.query("INSERT INTO properties (name,
      description, price_per_night, letter_id)
    VALUES('#{name}', '#{description}', '#{ppn}', '#{letter_id}')
    RETURNING id, name, description, price_per_night, letter_id;")
    Property.new(id: result[0]['id'],
      name: result[0]['name'],
      description: result[0]['description'],
      ppn: result[0]['price_per_night'].to_i,
      letter_id: result[0]['letter_id']
    )
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM properties WHERE id = #{id};")
    Property.new(id: result[0]['id'],
      name: result[0]['name'],
      description: result[0]['description'],
      ppn: result[0]['price_per_night'].to_i,
      letter_id: result[0]['letter_id']
    )
  end
end
