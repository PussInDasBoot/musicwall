class Tables < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string   :title
      t.string   :author
      t.string   :url
      t.timestamps
      t.references :user
    end

    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.timestamps
    end

    create_table :votes do |t|
      t.references :song
      t.references :user
      t.timestamps
    end
  end
end