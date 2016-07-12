class AddColumnToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :content, :string
  end
end
