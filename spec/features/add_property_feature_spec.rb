feature 'User can add a property' do
  it 'Allows user to add a property' do

    visit ('/')

    click_button 'Add property'

    fill_in :name, with: 'Cottage'
    fill_in :description, with: 'Test description'
    fill_in :ppn, with: '10'

    click_button 'Submit'

    expect(page).to have_content 'Cottage'
    expect(page).to have_content '£10 per night'

  end
end
