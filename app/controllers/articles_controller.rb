class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index  
    @articles = Article.paginate(page: params[:page], per_page: 10, ).order('id DESC')

  end


  def new
      @article = Article.new
  end

    def edit
  end

    def create
    @article = Article.new(article_params)
    @article.user = User.last
    if @article.save
      flash[:success] = "Article was succesfully created"
      redirect_to article_path(@article)
    else
      render "new"
    end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was succesfully updated"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  end

  def show
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was succesfully deleted"
    redirect_to articles_path
  end


  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def set_article
      @article = Article.find(params[:id])
    end


end