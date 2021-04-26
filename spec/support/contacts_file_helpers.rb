# frozen_string_literal: true

# Spec Helpers for ContactsFile model
module ContactsFileHelpers
  def visit_contacts_file(contacts_file)
    visit '/contacts_files'
    within dom_id_for(contacts_file) do
      click_link contacts_file.file_identifier
    end
  end
end
