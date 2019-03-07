module CommentsHelper
  def is_signed_in_and_author_of(comment)
    user_signed_in? && comment.user_id == current_user.id
  end
end
