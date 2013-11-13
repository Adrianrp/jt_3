require 'spec_helper'

describe "products/new" do
  before(:each) do
    assign(:product, stub_model(Product,
      :image_id => 1,
      :title => "MyString",
      :description => "MyText",
      :price => "9.99",
      :category_id => 1
    ).as_new_record)
  end

  it "renders new product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", products_path, "post" do
      assert_select "input#product_image_id[name=?]", "product[image_id]"
      assert_select "input#product_title[name=?]", "product[title]"
      assert_select "textarea#product_description[name=?]", "product[description]"
      assert_select "input#product_price[name=?]", "product[price]"
      assert_select "input#product_category_id[name=?]", "product[category_id]"
    end
  end
end
