class Reviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :song
      t.timestamps
    end
  end
end
