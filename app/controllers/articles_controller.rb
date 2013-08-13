class ArticlesController < ApplicationController

  def index
    @articles = Article.limit(100).order('created_at DESC')
  end

end