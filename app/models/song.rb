class Song < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  has_many :reviews
  
  validates :author, presence: true
  validates :title, presence: true, uniqueness: {
    scope: :author, message: "This song has already been added" }
end