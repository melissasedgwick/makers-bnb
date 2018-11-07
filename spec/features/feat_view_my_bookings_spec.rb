feature 'User can view all approved bookings' do
  it 'lists approved bookings for the logged in user' do
    user = User.register(name: 'Lucas', username: 'sacullezzar', email: 'lucas.razzell@gmail.com', password: 'pass123')
    property = Property.create(name: 'Cottage 1', description: 'A lovely place', ppn: 15)

    Booking.submit_availability(date: "2018/06/06", property_id: property.id)
    request = Booking.request_booking(date: "2018/06/06", property_id: property.id, renter_id: user.id)
    Booking.confirm_booking(id: request.id)



    visit ('/')
    click_button 'login'

    fill_in :username, with: 'sacullezzar'
    fill_in :password, with: 'pass123'

    click_button 'submit'

    click_button 'view_bookings'

    expect(page).to have_content('2018-06-06')
    expect(page).to have_content('Cottage 1')
    expect(page).to have_content('15')
  end
end
