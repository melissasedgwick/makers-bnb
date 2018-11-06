feature 'Displaying properties' do
  it 'lists properties from the database' do
    visit('/')
    click_button('display_properties')
    expect(page).to have_content('Cottage')
    expect(page).to have_content('A lovely place')
    expect(page).to have_content('£15 per night')
  end
end
