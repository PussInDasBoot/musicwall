class VoteTable < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :song
      t.references :user
      t.timestamps
    end
  end
end

