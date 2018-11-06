require 'pg'

p "Setting up test database..."

def setup_test_database
  connection = PG.connect(dbname: 'bnb_test')
  connection.exec("TRUNCATE users, bookings, properties;")

  connection2 = PG.connect(dbname: 'bnb')
  connection2.exec("TRUNCATE users, bookings, properties;")
end
