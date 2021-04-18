require 'rails_helper'

RSpec.describe "contacts/show", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      name: "Name",
      date_of_birth: "Date Of Birth",
      phone: "Phone",
      address: "Address",
      creditcard: "Creditcard",
      franchise: "Franchise",
      email: "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Date Of Birth/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/Creditcard/)
    expect(rendered).to match(/Franchise/)
    expect(rendered).to match(/Email/)
  end
end
