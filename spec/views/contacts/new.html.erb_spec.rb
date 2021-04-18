require 'rails_helper'

RSpec.describe "contacts/new", type: :view do
  before(:each) do
    assign(:contact, Contact.new(
      name: "MyString",
      date_of_birth: "MyString",
      phone: "MyString",
      address: "MyString",
      creditcard: "MyString",
      franchise: "MyString",
      email: "MyString"
    ))
  end

  it "renders new contact form" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do

      assert_select "input[name=?]", "contact[name]"

      assert_select "input[name=?]", "contact[date_of_birth]"

      assert_select "input[name=?]", "contact[phone]"

      assert_select "input[name=?]", "contact[address]"

      assert_select "input[name=?]", "contact[creditcard]"

      assert_select "input[name=?]", "contact[franchise]"

      assert_select "input[name=?]", "contact[email]"
    end
  end
end
