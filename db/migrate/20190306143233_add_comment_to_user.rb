class AddCommentToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :comment, foreign_key: true
  end
end
