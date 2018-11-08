require 'bcrypt'

class User

  attr_reader :id, :name, :username, :email, :password

  def initialize(id:, name:, username:, email:, password:)
    @id = id
    @name = name
    @username = username
    @email = email
    @password = password
  end

  def self.register(name:, username:, email:, password:)
    raise('Email already in use!') if User.email_exists?(email)
    raise('Username already in use!') if User.username_exists?(username)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (name, username, email, password) VALUES ('#{name}', '#{username}', '#{email}', '#{encrypted_password}')RETURNING id, name, username, email, password;")
    result.map { |user| User.new(id: user['id'], name: user['name'], username: user['username'], email: user['email'], password: user['password'])  } [0]
  end

  def self.auth(username, password)
    query = "SELECT * FROM users WHERE username = '#{username}'"
    result = DatabaseConnection.query(query)
    return nil unless result.any?
    return nil unless BCrypt::Password.new(result[0]['password']) == password
    User.new(id: result[0]['id'], name: result[0]['name'], username: result[0]['username'], email: result[0]['email'], password: result[0]['password'])
  end

  def self.email_exists?(email)
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}';")
    result.any? ? true : false
  end

  def self.username_exists?(username)
    result = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{username}';")
    result.any? ? true : false
  end
end
