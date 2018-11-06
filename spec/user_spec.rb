require './lib/user.rb'
require 'spec_helper'

describe User do

  it 'adds a user to the database' do
    user = User.register(name: 'Lucas', username: 'sacullezzar', email: 'lucas.razzell@gmail.com', password: 'pass123')
    result = find_by_id(id: user.id)
    expect(user.name).to eq(result['name'])
  end

  it 'can authenticate a user' do
    user = User.register(name: 'Test', username: 'tester', email: 'test@test.com', password: 'testpass')
    authenticated_user = User.auth('tester', 'testpass')
    expect(user.id).to eq(authenticated_user.id)
  end
end
