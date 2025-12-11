class ArticlesController < ApplicationController
  def create
    @article = Article.new(article_params)

    if @article.save
      SummarizeArticleJob.perform_async(@article.id)
      redirect_to @article
    else
      render :home, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:url)
  end
end
