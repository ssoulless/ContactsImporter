# frozen_string_literal: true

# Controller of the ContactsFile model
class ContactsFilesController < ApplicationController
  def index
    @contacts_files = ContactsFile.all
  end

  def show
    @contacts_file = ContactsFile.find(params[:id])
    @error_rows = @contacts_file.batch_rows.where(has_errors: true)
  end
end
