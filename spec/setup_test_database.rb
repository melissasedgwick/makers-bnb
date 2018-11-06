require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'bnb_test')

  # Clears the peeps table
  connection.exec("TRUNCATE users, bookings, properties;")

  connection_2 = PG.connect(dbname: 'bnb')
  connection_2.exec("TRUNCATE users, bookings, properties;")
end
