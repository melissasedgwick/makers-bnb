require './lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  p 'Using test database!'
  DatabaseConnection.setup('bnb_test')
else
  p 'Using live database!'
  DatabaseConnection.setup('bnb')
end
