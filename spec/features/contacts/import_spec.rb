# frozen_string_literal: false

require 'rails_helper'

Capybara.current_driver = :apparition

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

  it 'detects File headers, shows the user the options and performs the import' do
    select_file
    click_button 'Import'

    ['Name', 'Date of Birth', 'Phone', 'Address', 'Credit Card', 'Email'].each do |file_column|
      expect(page).to have_content(file_column)
    end

    %w[name date_of_birth phone address creditcard email].each_with_index do |option, index|
      select option, from: "config-mapping-column-#{index}", visible: false
    end

    click_button 'Finish Import'
    expect(page).to have_content('Your import is in queue!')
  end
end
