feature 'Request booking' do
  scenario 'User can request booking' do
    letter = User.register(name: "name", username: "username", email: "test@test.com", password: "password123")
    renter = User.register(name: "bob", username: "coolbob", email: "bob@test.com", password: "password1234")
    property = Property.create(name: 'Cottage 1', description: 'A lovely place', ppn: 15, letter_id: letter.id)
    Booking.submit_availability(date: "2018/06/06", property_id: property.id, letter_id: letter.id)


    visit('/')
    click_button 'login'
    fill_in :username, with: 'coolbob'
    fill_in :password, with: 'password1234'
    click_button('submit')
    click_button('View More')

    expect(page).to have_content('Cottage 1')
    expect(page).to have_content('2018-06-06')

    click_button('Request Booking')

    expect(page).to have_content('Your request has been submitted!')

    click_button('OK')

    expect(page).to have_content('Welcome')
  end

  scenario 'User cannot request already approved booking' do
    letter = User.register(name: "name", username: "username", email: "test@test.com", password: "password123")
    renter = User.register(name: "bob", username: "coolbob", email: "bob@test.com", password: "password1234")
    renter2 = User.register(name: "bill", username: "coolbill", email: "bill@test.com", password: "password")
    property = Property.create(name: 'Cottage 1', description: 'A lovely place', ppn: 15, letter_id: letter.id)
    Booking.submit_availability(date: "2018/06/06", property_id: property.id, letter_id: letter.id)
    booking = Booking.request_booking(date: "2018/06/06", property_id: property.id, renter_id: renter.id)
    Booking.confirm_booking(id: booking.id)

    visit('/')
    click_button 'login'
    fill_in :username, with: 'coolbill'
    fill_in :password, with: 'password'
    click_button('submit')
    click_button('View More')

    expect(page).to have_content('Cottage 1')
    expect(page).not_to have_content('2018-06-06')
    expect(page).not_to have_button('Request Booking')
  end
end
