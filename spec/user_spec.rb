require './lib/user.rb'
require 'spec_helper'

describe User do
  # before(:each) do
  #   user = User.new
  # end
  it 'adds a user to the database' do
    user = User.register(name: 'Lucas', username: 'sacullezzar', email: 'lucas.razzell@gmail.com', password: 'pass123')
    result = find_by_id(id: user.id)
    expect(user.name).to eq(result['name'])
  end


end
