feature 'User can update a property' do
  scenario 'Updating a property' do
    letter = User.register(name: "Name", username: "username", email: "test@test.com", password: "password")
    Property.create(name: 'Cottage 1', description: 'A lovely place', ppn: 15, letter_id: letter.id)
    Property.create(name: 'Cottage 2', description: 'A lovelier place', ppn: 20, letter_id: letter.id)
    Property.create(name: 'Cottage 3', description: 'The loveliest place', ppn: 25, letter_id: letter.id)

    visit('/')
    click_button 'login'
    fill_in :username, with: 'username'
    fill_in :password, with: 'password'
    click_button('submit')
    click_button('account_page')


    expect(page).to have_content('Cottage 1')
    first('.property').click_button 'Update'

    fill_in :name, with: "Flat"
    fill_in :description, with: 'tiny'
    fill_in :ppn, with: '20'

    click_button 'save'

    expect(page).to have_content('Flat')
    expect(page).to_not have_content('Cottage 1')
  end

  scenario 'letter can specify when their property is available' do
    letter = User.register(name: "Name", username: "username", email: "test@test.com", password: "password")
    property = Property.create(name: 'Cottage 1', description: 'A lovely place', ppn: 15, letter_id: letter.id)

    visit('/')
    click_button 'login'
    fill_in :username, with: 'username'
    fill_in :password, with: 'password'
    click_button('submit')
    click_button('account_page')
    first('.property').click_button 'update'

    fill_in :day, with: 06
    # select :name => 'jan', :from => 'months'


    page.select 'January', from: 'months'
    fill_in :year, with: 2019

    click_button('add')

    page.within('.table') do
      find('.property:nth-child(1)').click_button('View More')
    end

    expect(page).to have_content('2019-01-06')
  end
end
