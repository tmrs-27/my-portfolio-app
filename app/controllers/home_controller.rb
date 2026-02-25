class HomeController < ApplicationController
  def index
    @recent_posts = Post.includes(:categories).order(created_at: :desc).limit(6)
  end

  def about
  end
end
