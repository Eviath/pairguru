class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates_presence_of :content, :movie_id, :user_id

  validates :user_id, uniqueness: { scope: :movie_id, message: "You've already made a comment!" }
end
