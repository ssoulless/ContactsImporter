# frozen_string_literal: false

require 'rails_helper'

describe 'Importing contacts' do
  before do
    # Background jobs testing setup
    Sidekiq::Testing.inline!
  end

  def select_file(fixture = 'basic.csv')
    visit '/import-contacts'
    fixture_path = "#{Rails.root}/spec/fixtures"
    attach_file('file', "#{fixture_path}/#{fixture}")
  end

  it 'detects File headers and shows the user the options' do
    select_file
    click_button 'Import'

    ['Name', 'Date of Birth', 'Phone', 'Address', 'Credit Card', 'Email'].each do |file_column|
      expect(page).to have_content(file_column)
    end
  end

  it 'maps file headers correctly with the selections of the user after import' do
    select_file
    click_button 'Import'
    %w[name date_of_birth phone address creditcard email].each_with_index do |option, index|
      select option, from: "config-mapping-column-#{index}"
    end

    click_button 'Finish Import'
    expect(page).to have_content('Your import is in queue!')

    visit '/contacts'
    expect(page).to have_content('Carlos Andres')
  end

  it 'does not allow dupplicated column mapping' do
    select_file
    click_button 'Import'
    # Skip the selection step since all options have the same default
    click_button 'Finish Import'
    expect(page).to have_content('duplicated mapping')
  end

  it 'shows failed row when name column is missing' do
    select_file('name_required.csv')
    click_button 'Import'

    %w[name date_of_birth phone address creditcard email].each_with_index do |option, index|
      select option, from: "config-mapping-column-#{index}"
    end

    click_button 'Finish Import'
    expect(page).to have_content('Your import is in queue!')

    visit_contacts_file ContactsFile.last
    expect(page).to have_content('Some rows have errors')
    within('.error-rows') do
      expect(page).to have_content('Name is required')
    end
  end

  it 'shows failed row for name with special characters and ensures the contact is not saved' do
    select_file('name_validation.csv')
    click_button 'Import'

    %w[name date_of_birth phone address creditcard email].each_with_index do |option, index|
      select option, from: "config-mapping-column-#{index}"
    end

    click_button 'Finish Import'
    expect(page).to have_content('Your import is in queue!')

    visit '/contacts'
    expect(page).not_to have_content('Sebas Gir@ldo')
    expect(Contact.count).to eq(2)

    visit_contacts_file ContactsFile.last
    expect(page).to have_content('Some rows have errors')
    within('.error-rows') do
      expect(page).to have_content('Sebas Gir@ldo')
      expect(page).to have_content('special characters not allowed')
    end
  end
end
