class AddBooleanToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :extra, :boolean, default: true
  end
end
