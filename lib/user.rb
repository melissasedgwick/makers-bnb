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
    result = DatabaseConnection.query("INSERT INTO users (name, username, email, password) VALUES ('#{name}', '#{username}', '#{email}', '#{password}')RETURNING id, name, username, email, password;")
    result.map { |user| User.new(id: user['id'], name: user['name'], username: user['username'], email: user['email'], password: user['password'])  } [0]
  end

end
