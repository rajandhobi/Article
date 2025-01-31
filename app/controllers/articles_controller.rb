class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @articles = Article.all
    if params[:q] && params[:q][:created_at_gteq].present?
      params[:q][:created_at_gteq] = params[:q][:created_at_gteq].to_date.beginning_of_day
    end
    @q = Article.ransack(params[:q])
    @articles = @q.result(distinct: true)
    
  end

  def show;     

  end

  def new
    @article = current_user.articles.build
    authorize @article
  end

  def create
    @article = current_user.articles.build(article_params)
    authorize @article

    if @article.save
      # ArticleMailer.article_created(@article).deliver_now

      respond_to do |format|
        format.html { redirect_to articles_path, notice: "Article was successfully created." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    authorize @article
    if @article.update(article_params)
      respond_to do |format|
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @article
      @article = Article.find(params[:id])
      if @article.destroy
        respond_to do |format|
          format.html { redirect_to articles_path, notice: "Article was deleted." }
          format.turbo_stream
        end
      else
        redirect_to articles_path, alert: 'Article could not be deleted.'
      end
    end

  
    
  

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body,:image,:video, documents: [])
  end

  def authorize_user!
    return if @article.user == current_user

    redirect_to articles_path, alert: 'You are not authorized to perform this action.'
  end
end

  
  

 

