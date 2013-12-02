require 'spec_helper'

describe "orders/edit" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :name => "MyString",
      :address => "MyString",
      :post_nr => 1,
      :city => "MyString",
      :tlf => 1,
      :email => "MyString",
      :pay_type => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", order_path(@order), "post" do
      assert_select "input#order_name[name=?]", "order[name]"
      assert_select "input#order_address[name=?]", "order[address]"
      assert_select "input#order_post_nr[name=?]", "order[post_nr]"
      assert_select "input#order_city[name=?]", "order[city]"
      assert_select "input#order_tlf[name=?]", "order[tlf]"
      assert_select "input#order_email[name=?]", "order[email]"
      assert_select "input#order_pay_type[name=?]", "order[pay_type]"
    end
  end
end
