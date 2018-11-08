require './lib/user.rb'

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

  it 'raises error if email in use' do
    user = User.register(name: 'Test', username: 'tester', email: 'test@test.com', password: 'testpass')
    expect{User.register(
      name: 'Test',
      username: 'test',
      email: 'test@test.com',
      password: 'testpass')}.to raise_error('Email already in use!')
  end

  it 'raises error if username in use' do
    user = User.register(name: 'Test', username: 'tester', email: 'test@test.com', password: 'testpass')
    expect{User.register(
      name: 'Test',
      username: 'tester',
      email: 'test@test.co.uk',
      password: 'testpass')}.to raise_error('Username already in use!')
  end
end
