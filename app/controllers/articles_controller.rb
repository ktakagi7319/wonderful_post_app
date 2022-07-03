class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index show ]
  before_action :set_article, only: %i[ edit update destroy ]

  def index
    #@articles = Article.all.page params[:page]
    articles = Article.all.includes(:tags)
    articles = articles.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    @articles = articles.page params[:page]
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
  end


  def new
    @article = Article.new
  end

  def create

    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article, notice: "#{t('activerecord.models.article')}を作成しました。"
    else
      render :new, status: :unprocessable_entity
    end

  end

  def update
    @article.update!(article_params)

    if @articles.save
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
      params.require(:article).permit(:title, :content, tag_ids:[])
    end

    def set_article
      @article = current_user.articles.find(params[:id])
    end

end
