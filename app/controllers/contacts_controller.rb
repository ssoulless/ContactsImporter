# frozen_string_literal: true

# Contacts Controller
class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show edit update destroy]

  # GET /contacts or /contacts.json
  def index
    @contacts = Contact.all
  end

  def import_contacts; end

  def pre_parse_contacts
    @headers = params[:file_headers].split(',')
    @contacts_columns = Contact.column_names.dup # We need to duplicate to avoid frozen array error

    # Delete unwanted columns
    @contacts_columns.delete('id')
    @contacts_columns.delete('created_at')
    @contacts_columns.delete('updated_at')
    @contacts_columns.delete('franchise')

    respond_to do |format|
      format.js
    end
  end

  def import_contacts_submit
    @new_file = ContactsFile.new(contacts_file_params)
    respond_to do |format|
      @new_file.save
      format.js
      format.json { render json: @new_file.errors, status: :unprocessable_entity } if @new_file.has_errors?
    end
  end

  # GET /contacts/1 or /contacts/1.json
  def show; end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit; end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contact_params
    params.require(:contact).permit(:name, :date_of_birth, :phone, :address, :creditcard, :franchise, :email)
  end

  def contacts_file_params
    params.permit(:file, :mapping_config)
  end
end
