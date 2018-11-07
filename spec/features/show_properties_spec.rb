feature 'Displaying properties' do
  it 'lists properties from the database' do
    property = Property.create(name: 'Cottage 1', description: 'A lovely place', ppn: 15)
    visit('/')

    expect(page).to have_content('Cottage 1')
    expect(page).to have_content('£15 per night')

    click_button 'View More'

    expect(page).to have_content('Cottage 1')
    expect(page).to have_content('A lovely place')
    expect(page).to have_content('£15 per night')
  end

  it 'shows dates available when it is available' do
    property = Property.create(name: 'Cottage 1', description: 'A lovely place', ppn: 15)
    Booking.submit_availability(date: "2018/10/15", property_id: property.id)
    Booking.submit_availability(date: "2018/10/17", property_id: property.id)
    Booking.submit_availability(date: "2018/11/18", property_id: property.id)

    visit('/')
    click_button 'View More'

    expect(page).to have_content('Dates available:')
    expect(page).to have_content('2018-10-15')
    expect(page).to have_content('2018-10-17')
    expect(page).to have_content('2018-11-18')
  end

  it 'does not show dates available when not available' do
    property = Property.create(name: 'Cottage 1', description: 'A lovely place', ppn: 15)
    visit('/')
    click_button 'View More'

    expect(page).to_not have_content('Dates available:')
  end
end
