require 'rails_helper'

RSpec.describe "contacts/index", type: :view do
  before(:each) do
    assign(:contacts, [
      Contact.create!(
        name: "Name",
        date_of_birth: "Date Of Birth",
        phone: "Phone",
        address: "Address",
        creditcard: "Creditcard",
        franchise: "Franchise",
        email: "Email"
      ),
      Contact.create!(
        name: "Name",
        date_of_birth: "Date Of Birth",
        phone: "Phone",
        address: "Address",
        creditcard: "Creditcard",
        franchise: "Franchise",
        email: "Email"
      )
    ])
  end

  it "renders a list of contacts" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Date Of Birth".to_s, count: 2
    assert_select "tr>td", text: "Phone".to_s, count: 2
    assert_select "tr>td", text: "Address".to_s, count: 2
    assert_select "tr>td", text: "Creditcard".to_s, count: 2
    assert_select "tr>td", text: "Franchise".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
  end
end
