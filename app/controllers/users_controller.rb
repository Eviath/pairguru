class UsersController < ApplicationController
  def index

    @top = top_posters

  end


  def top_posters
    User.joins(:comments).group('users.id').where('comments.created_at >= ?', 1.week.ago.utc).order('count(comments.id) desc').limit(10)
  end

end
