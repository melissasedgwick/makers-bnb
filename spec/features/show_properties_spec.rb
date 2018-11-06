feature 'Displaying properties' do
  it 'lists properties from the database' do
    Property.create(name: 'Cottage 1', description: 'A lovely place', ppn: 15)

    visit('/')

    expect(page).to have_content('Cottage 1')
    expect(page).to have_content('£15 per night')

    click_button 'View More'

    # expect(page).to have_content('Cottage 1')
    # expect(page).to have_content('A lovely place')
    # expect(page).to have_content('£15 per night')
  end
end
