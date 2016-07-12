class Song < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  validates :author, presence: true
  validates :title, presence: true, uniqueness: {
    scope: :author, message: "This song has already been added" }
end