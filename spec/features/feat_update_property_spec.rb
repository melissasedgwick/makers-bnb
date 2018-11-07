feature 'User can update a property' do
  scenario 'Updating a property' do
    property = Property.create(name: 'House', description: 'a small house', ppn: 5)
    visit('/')

    expect(page).to have_content('House')
    click_button 'update'

    fill_in :name, with: "Flat"
    fill_in :description, with: 'tiny'
    fill_in :ppn, with: '20'

    click_button 'save'

    expect(page).to have_content('Flat')
    expect(page).to have_content('£20 per night')
  end
end
