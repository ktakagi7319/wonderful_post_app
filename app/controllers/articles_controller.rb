class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update ]
  def index
    @articles = Article.all
  end

  def show
  end

  def edit
  end


  def new
    @article = Article.new
  end

  def create

    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end

  end

  def update
    @article.update!(article_params)

    if @article.save
      redirect_to @article, notice: "Article was successfully updated."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy!
    redirect_to @article, notice: "Article was successfully destroyed."
  end

  private
    def before_action
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content)
    end
end
