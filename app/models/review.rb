class Review < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, presence: true
end