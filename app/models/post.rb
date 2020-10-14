# Post model

class Post < ApplicationRecord
  acts_as_votable
  has_many :comments, dependent: :destroy
  belongs_to :user
  
  validates :title, presence: true
  validates :body, presence: true
end
