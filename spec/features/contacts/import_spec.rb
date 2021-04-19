# frozen_string_literal: true

require 'rails_helper'

describe 'Importing contacts' do
  before do
    # Background jobs testing setup

    Sidekiq::Testing.inline!
  end

  def select_file(fixture = 'basic.csv')
    visit '/import-contacts'
    fixture_path = "#{Rails.root}/spec/fixtures"
    attach_file('Upload your CSV file', "#{fixture_path}/#{fixture}")
  end

  it 'detects File headers and shows the user the options' do
    select_file
    click_button 'Import'
    ['Name', 'Date of Birth', 'Phone', 'Address', 'Credit Card', 'Email'].each do |file_column|
      expect(find(:table, 'Map CSV fields to Contacts')).to have_table_row('Column' => file_column)
    end
    # within('select#detected_headers') do
    #   ['Name', 'Date of Birth', 'Phone', 'Address', 'Credit Card', 'Email'].each do |option|
    #     expect(find("option[value=#{option}]").text).to eq(option)
    #   end
    # end
  end

  it 'maps file headers correctly with the selections of the user after import' do
    select_file
    click_button 'Import'

    %w[name date-of-birth phone address credit-card email].each_with_index do |option, index|
      select option, from: "config-mapping-column-#{index}"
    end

    click_button 'Finish Import'
    expect(page).to have_content('Import Started!')

    visit '/contacts'
    expect(page).to have_content('Carlos Andres')
  end
end
