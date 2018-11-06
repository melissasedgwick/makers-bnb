describe('User', function() {
  var user;

  beforeEach(function() {
    user = new User();
  });

  it('creates a user', function() {
    expect(user).toBeDefined();
  });

});
