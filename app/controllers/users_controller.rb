class UsersController < ApplicationController

  def index
    @top = top_posters
  end


  def top_posters
    User.preload(:comments).joins(:comments).group('users.id').where('comments.created_at >= ?', 1.week.ago.utc).order(Arel.sql('count(comments.id) desc')).limit(10)
  end

end
