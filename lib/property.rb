require_relative '../database_connection_setup'

class Property

  attr_reader :name, :description, :ppn

  def initialize(name: 'default name', description: 'default description', ppn: 10)
    @name = name
    @description = description
    @ppn = ppn
  end

end
