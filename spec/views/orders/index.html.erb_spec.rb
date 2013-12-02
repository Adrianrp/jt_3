require 'spec_helper'

describe "orders/index" do
  before(:each) do
    assign(:orders, [
      stub_model(Order,
        :name => "Name",
        :address => "Address",
        :post_nr => 1,
        :city => "City",
        :tlf => 2,
        :email => "Email",
        :pay_type => "Pay Type"
      ),
      stub_model(Order,
        :name => "Name",
        :address => "Address",
        :post_nr => 1,
        :city => "City",
        :tlf => 2,
        :email => "Email",
        :pay_type => "Pay Type"
      )
    ])
  end

  it "renders a list of orders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Pay Type".to_s, :count => 2
  end
end
