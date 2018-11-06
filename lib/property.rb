# require_relative '../database_connection_setup'

class Property

  attr_reader :id, :name, :description, :ppn

  def initialize(id:, name:, description:, ppn:)
    @name = name
    @description = description
    @ppn = ppn
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM properties;")
    result.map do |property|
      Property.new(id: property['id'],
        name: property['name'],
        description: property['description'],
        ppn: property['price_per_night'].to_i,
      )
    end
  end

  def self.create(name: 'default name', description: 'default description', ppn: 10)
    result = DatabaseConnection.query("INSERT INTO properties (name,
      description, price_per_night)
    VALUES('#{name}', '#{description}', '#{ppn}')
    RETURNING id, name, description, price_per_night;")
    Property.new(id: result[0]['id'],
      name: result[0]['name'],
      description: result[0]['description'],
      ppn: result[0]['price_per_night'].to_i,
    )
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM properties WHERE id = #{id};")
    Property.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], ppn: result[0]['price_per_night'])
  end
end
